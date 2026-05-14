#!/system/bin/sh
# 卸载模块时执行，还原所有备份的 Settings

MODDIR=${0%/*}
BACKUP_DIR="$MODDIR/backup"
BACKUP_FILE="$BACKUP_DIR/settings_backup.prop"

if [ -f "$BACKUP_FILE" ]; then
  while IFS='=' read -r key value; do
    case "$key" in
      peak_refresh_rate)
        if [ "$value" = "NONE" ]; then
          settings delete system peak_refresh_rate
        else
          settings put system peak_refresh_rate "$value"
        fi
        ;;
      min_refresh_rate)
        if [ "$value" = "NONE" ]; then
          settings delete system min_refresh_rate
        else
          settings put system min_refresh_rate "$value"
        fi
        ;;
      smart_refresh_switch)
        if [ "$value" = "NONE" ]; then
          settings delete system smart_refresh_switch
        else
          settings put system smart_refresh_switch "$value"
        fi
        ;;
      activity_manager_constants)
        if [ "$value" = "NONE" ]; then
          settings delete global activity_manager_constants
        else
          settings put global activity_manager_constants "$value"
        fi
        ;;
      max_lock_apps)
        if [ "$value" = "NONE" ]; then
          settings delete system max_lock_apps
        else
          settings put system max_lock_apps "$value"
        fi
        ;;
    esac
  done < "$BACKUP_FILE"
fi

# 清理可能残留的调试设置
settings delete global force_gpu_rendering
settings delete global high_performance_mode
settings delete global activity_starts_logging_enabled

# 删除备份文件夹自身
rm -rf "$BACKUP_DIR"