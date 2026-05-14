#!/system/bin/sh
# 一加Ace6 性能+全局330Hz触控 终极常驻服务
sleep 15

# 防重复执行
[ -f /data/adb/modules/ace6_perf/run_done ] && exit 0
touch /data/adb/modules/ace6_perf/run_done

# 检测是否刷180Hz DTBO（不锁165Hz）
if [ -f "/data/adb/modules/ace6_perf/disable_165hz" ]; then
    SKIP_165=1
else
    SKIP_165=0
fi

# ========== 刷新率控制（165Hz/180Hz自适应） ==========
if [ "$SKIP_165" -eq 0 ]; then
    settings put system peak_refresh_rate 165
    settings put system min_refresh_rate 165
    settings put system smart_refresh_switch 0
    resetprop ro.vendor.dfps.level 165
    resetprop persist.vendor.dfps.level 165
fi

# ========== 全局330Hz触控采样率（核心新增） ==========
resetprop persist.vendor.touch.sampling_rate 330
resetprop persist.vendor.touch.game.sampling_rate 330
resetprop persist.vendor.touch.report_rate 330
resetprop ro.vendor.touch.max_rate 330

# 触控响应/跟手度拉满
resetprop persist.sys.touch.boost 1
resetprop persist.vendor.touch.latency.mode 1
resetprop persist.vendor.touch.response.level 2
resetprop debug.touch.fling 1

# ========== 后台保活优化 ==========
orig_constants=$(settings get global activity_manager_constants)
if [ -z "$orig_constants" ]; then
    new_constants="max_cached_processes=64"
else
    if echo "$orig_constants" | grep -q "max_cached_processes"; then
        new_constants=$(echo "$orig_constants" | sed 's/max_cached_processes=[0-9]*/max_cached_processes=64/')
    else
        new_constants="${orig_constants},max_cached_processes=64"
    fi
fi
settings put global activity_manager_constants "$new_constants"
settings put system max_lock_apps 25
resetprop ro.sys.fw.bg_apps_limit 64
resetprop persist.sys.fw.bg_apps_limit 64

# ========== 渲染+性能+流畅度 ==========
settings put global force_gpu_rendering 1
settings put global high_performance_mode 1
settings put global activity_starts_logging_enabled 0

resetprop debug.performance.tuning 1
resetprop persist.sys.ui.hw 1
resetprop debug.composition.type gpu
resetprop persist.sys.scrollingcache 4
resetprop ro.logd.kernel false
