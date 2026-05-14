# 一加 Ace 6 性能优化模块
# OnePlus Ace 6 Performance Tuning Module

---

<div align="center">
  <button onclick="document.getElementById('en').style.display='block'; document.getElementById('zh').style.display='none'">English</button>
  <button onclick="document.getElementById('zh').style.display='block'; document.getElementById('en').style.display='none'">中文</button>
</div>

---

<div id="zh">

## 🚀 模块介绍
这是为 **一加 Ace 6** 打造的终极性能与体验优化 Magisk 模块，不修改CPU调度，通过底层参数调校实现全局流畅度、触控响应与屏幕表现的全面提升，同时保留风驰游戏内核的全部功能。

### ✨ 核心功能
- **180Hz 屏幕解锁**：刷入定制DTBO解除官方165Hz限制，支持180Hz高刷，不刷则自动锁165Hz
- **全局330Hz触控采样**：日常/游戏全场景触控采样率拉满，降低操作延迟，提升跟手度
- **后台保活增强**：系统缓存进程上限提升至64，锁定常驻后台25个APP，告别频繁杀后台
- **渲染与流畅优化**：强制GPU合成、硬件加速，拉满滚动缓存，关闭冗余日志IO
- **低延迟模式**：触控响应、Fling惯性滑动优化，日常操作更丝滑

### 📥 下载方式
- [GitHub Release](https://github.com/MineACEx/mine_ace6_perf/releases)
- [国内镜像下载](http://www.cccimg.com/down.php/bd84fbfc7f2e64646e28cf3625622a1a.zip)

### 📋 安装步骤
1.  确保你的一加 Ace 6 已解锁Bootloader并刷入Magisk
2.  下载模块压缩包，在Magisk中安装
3.  安装时按提示选择是否刷入180Hz DTBO镜像（音量上键=刷入，下键=跳过）
4.  重启手机，模块自动生效
5.  可选：安装根目录下的`sxl.apk`，自定义屏幕刷新率

### ⚠️ 注意事项
- 刷入DTBO前，模块会自动备份原厂DTBO分区至`/sdcard/ModBackdtbo/`，出现异常可通过TWRP刷回恢复
- 模块仅适用于一加 Ace 6，其他机型请勿刷入
- 升级ColorOS系统可能会还原DTBO分区，需重新安装模块

### 🙏 免责声明
本模块仅为个人爱好者制作，使用过程中出现的任何问题（如变砖、数据丢失）均由用户自行承担，作者不承担任何责任。

</div>

---

<div id="en" style="display: none;">

## 🚀 Module Introduction
This is the ultimate performance and experience optimization Magisk module for the **OnePlus Ace 6**. Without modifying CPU scheduling, it achieves comprehensive improvements in global fluency, touch response, and display performance through low-level parameter tuning, while retaining all functions of the Phoenix Game Engine.

### ✨ Core Features
- **180Hz Display Unlock**: Flashes a custom DTBO to remove the official 165Hz limit, supporting 180Hz high refresh rate. Automatically locks to 165Hz if skipped.
- **Global 330Hz Touch Sampling**: Full-scene touch sampling rate boosted to the max for daily use and gaming, reducing operation latency and improving responsiveness.
- **Background Process Enhancement**: System cached process limit increased to 64, with 25 permanently resident apps locked to prevent frequent background kills.
- **Rendering & Smoothness Optimization**: Forces GPU composition and hardware acceleration, maximizes scrolling cache, and disables redundant log I/O.
- **Low Latency Mode**: Optimized touch response and fling inertia sliding for smoother daily operations.

### 📥 Download Options
- [GitHub Release](https://github.com/your-username/your-repo-name/releases)
- [Domestic Mirror Download](https://your-china-mirror-link)

### 📋 Installation Steps
1.  Ensure your OnePlus Ace 6 has an unlocked bootloader and Magisk installed.
2.  Download the module zip file and install it via Magisk.
3.  Follow the prompts during installation to choose whether to flash the 180Hz DTBO image (Volume Up = Flash, Volume Down = Skip).
4.  Reboot your device for the module to take effect automatically.
5.  Optional: Install `sxl.apk` in the root directory to customize the screen refresh rate.

### ⚠️ Notes
- Before flashing the DTBO, the module will automatically back up the original DTBO partition to `/sdcard/ModBackdtbo/`. If issues occur, you can restore it via TWRP.
- This module is only for the OnePlus Ace 6. Do not flash it on other devices.
- Updating ColorOS may restore the DTBO partition, requiring you to reinstall the module.

### 🙏 Disclaimer
This module is made by a personal enthusiast. The author is not responsible for any issues (such as bricked devices or data loss) that occur during use. All risks are borne by the user.

</div>

---

## 📜 License
MIT License

