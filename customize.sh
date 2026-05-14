#!/sbin/sh
#=============================================================================
# 一加 Ace 6 性能优化模块 - 安装脚本 v1.2
# 功能：
#   1. 备份原始 Settings
#   2. 音量键选择是否刷入 DTBO
#   3. 刷入 DTBO 时自动备份原分区、下载镜像、释放 sxl.apk、取消 165Hz 锁定
#=============================================================================

MODPATH=${0%/*}
BACKUP_DIR="$MODPATH/backup"
mkdir -p "$BACKUP_DIR"

DTBO_URL="http://www.cccimg.com/down.php/c506685fcfb118e8b36f60f1e9182c57.img"
#------------------------------------------

BUSYBOX="$MODPATH/bin/busy"
chmod 755 "$BUSYBOX" 2>/dev/null

ui_print() { echo "$1"; }
abort() { ui_print "$1"; exit 1; }

# 在 customize.sh 末尾或开头加入
rm -f /data/adb/modules/ace6_perf/run_done

# ---------- 备份当前系统设置 ----------
ui_print "- 正在备份当前系统设置..."
peak=$(settings get system peak_refresh_rate)
[ -z "$peak" ] && peak="NONE"
echo "peak_refresh_rate=$peak" > "$BACKUP_DIR/settings_backup.prop"

min=$(settings get system min_refresh_rate)
[ -z "$min" ] && min="NONE"
echo "min_refresh_rate=$min" >> "$BACKUP_DIR/settings_backup.prop"

smart=$(settings get system smart_refresh_switch)
[ -z "$smart" ] && smart="NONE"
echo "smart_refresh_switch=$smart" >> "$BACKUP_DIR/settings_backup.prop"

orig_constants=$(settings get global activity_manager_constants)
[ -z "$orig_constants" ] && orig_constants="NONE"
echo "activity_manager_constants=$orig_constants" >> "$BACKUP_DIR/settings_backup.prop"

lock_num=$(settings get system max_lock_apps)
[ -z "$lock_num" ] && lock_num="NONE"
echo "max_lock_apps=$lock_num" >> "$BACKUP_DIR/settings_backup.prop"

# ---------- DTBO 选择与刷入 ----------
ui_print " "
ui_print "========================================"
ui_print " 是否刷入定制 180hz DTBO 镜像？"
ui_print " 音量上键 = 是，下键 = 否"
ui_print " 10秒内无操作则跳过"
ui_print "========================================"

volume_key_choose() {
    timeout=10
    start_time=$(date +%s)
    while true; do
        current_time=$(date +%s)
        if [ $((current_time - start_time)) -gt $timeout ]; then
            return 1
        fi
        key=$(getevent -qlc 1 2>/dev/null | grep -oE 'KEY_VOLUME(UP|DOWN)')
        case "$key" in
            KEY_VOLUMEUP)   return 0;;
            KEY_VOLUMEDOWN) return 1;;
        esac
    done
}

if volume_key_choose; then
    ui_print "→ 你选择了 刷入 DTBO"
    ui_print "提示; 造成的任何后果请自行承担"

    # 确定 DTBO 分区
    slot=$(getprop ro.boot.slot_suffix)
    if [ -n "$slot" ]; then
        DTBO_PART="/dev/block/by-name/dtbo$slot"
    else
        DTBO_PART="/dev/block/by-name/dtbo"
    fi

    if [ ! -e "$DTBO_PART" ]; then
        ui_print "! 未找到 DTBO 分区：$DTBO_PART，跳过刷写"
    else
        # 创建目录
        DOWNLOAD_DIR="/data/ModDowdtbo"
        BACKUP_DTBO_DIR="/sdcard/ModBackdtbo"
        mkdir -p "$DOWNLOAD_DIR" "$BACKUP_DTBO_DIR"

        # 备份原分区
        BACKUP_FILE="$BACKUP_DTBO_DIR/dtbo_backup_$(date +%Y%m%d_%H%M%S).img"
        ui_print "→ 正在备份原 DTBO 到 $BACKUP_FILE"
        dd if="$DTBO_PART" of="$BACKUP_FILE" bs=4096
        if [ $? -ne 0 ]; then
            ui_print "! 备份失败，终止操作"
            abort "刷入中断"
        fi
        ui_print "✓ 备份完成，位置：/sdcard/ModBackdtbo/"

        # 下载新镜像
        TARGET_IMG="$DOWNLOAD_DIR/dtbo_new.img"
        ui_print "→ 正在下载 DTBO 镜像..."
        if [ -x "$BUSYBOX" ]; then
            "$BUSYBOX" wget -O "$TARGET_IMG" "$DTBO_URL"
        elif command -v curl >/dev/null; then
            curl -L -o "$TARGET_IMG" "$DTBO_URL"
        else
            ui_print "! 没有可用的下载工具，跳过刷入"
            abort "下载失败"
        fi

        if [ ! -f "$TARGET_IMG" ] || [ ! -s "$TARGET_IMG" ]; then
            ui_print "! 下载文件无效或为空，保留备份，退出"
            abort "下载失败"
        fi
        ui_print "✓ 下载完成"

        # 刷入分区
        ui_print "→ 正在刷入 DTBO 到 $DTBO_PART ..."
        dd if="$TARGET_IMG" of="$DTBO_PART" bs=4096
        if [ $? -eq 0 ]; then
            ui_print "✓ DTBO 刷写成功！"
            ui_print "! 如果出现问题请自行使用TWRP刷回原厂DTBO"
        else
            ui_print "! 刷写失败，请检查分区状态"
            abort "刷写失败"
        fi
    fi

    # ---- DTBO 联动：取消 165Hz 锁定 + 释放屏幕助手 ----
    # 创建标记文件，service.sh 检测后将跳过 165Hz 设置
    touch "$MODPATH/disable_165hz"
    ui_print "→ 已创建标记，开机后将不再锁定 165Hz 刷新率"

    # 复制自定义刷新率 APK 到 /sdcard
    APK_SRC="$MODPATH/apk/sxl.apk"
    APK_DST="/sdcard/sxl.apk"
    if [ -f "$APK_SRC" ]; then
        cp "$APK_SRC" "$APK_DST"
        if [ $? -eq 0 ]; then
            ui_print "→ 屏幕助手已复制到 /sdcard/sxl.apk，请手动安装"
        else
            ui_print "! 屏幕助手复制失败，请手动从模块包提取"
        fi
    else
        ui_print "! 未找到 sxl.apk，模块包可能不完整"
    fi
else
    ui_print "→ 已跳过 DTBO 刷入，将启用 165Hz 全局锁定"
fi

# 安装完成提示
ui_print " "
ui_print "========================================"
ui_print " 一加 Ace 6 性能优化模块安装完毕！"
ui_print " DTBO 备份位于 /sdcard/ModBackdtbo/"
ui_print " 重启手机后所有优化生效"
ui_print "========================================"