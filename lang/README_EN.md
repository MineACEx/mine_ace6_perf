# OnePlus Ace 6 Performance Tuning Module

> A Magisk module for global smoothness, touch, and display enhancement on the **OnePlus Ace 6**.

[返回中文版本](../README.md)

---

## 🚀 Introduction
This is a performance and experience optimization module made exclusively for the **OnePlus Ace 6**. Without modifying CPU scheduling, it uses low-level parameter tuning to improve overall smoothness, touch response, and display performance, while keeping all features of the Phoenix Game Engine intact.

### ✨ Core Features
- **180Hz Display Unlock**
  Flashes a custom DTBO to remove the official 165Hz limit, enabling 180Hz high refresh rate. If skipped, the module will automatically lock to 165Hz for compatibility.
- **Global 330Hz Touch Sampling**
  Boosts touch sampling rate to 330Hz in all scenarios (daily use & gaming), reducing latency and improving responsiveness for multi-finger operations.
- **Background Process Enhancement**
  Raises the system cached process limit to 64 and locks 25 apps in memory, preventing frequent background kills and making multitasking smoother.
- **Rendering & Smoothness Optimization**
  Forces GPU composition and hardware acceleration, maximizes scrolling cache, and disables redundant log I/O to reduce background resource usage.
- **Low Latency Mode**
  Optimizes touch response and fling inertia for more fluid daily operations and smoother animations.

### 🌐 Official Website
All links are synced automatically, so you only need to update `index.html` once to deploy changes to all platforms.

- ✅ **Primary (Recommended for China)**：[ace6perf.netlify.app](https://ace6perf.netlify.app)
- 📌 **Alternative 1**：[mine-ace6-perf.vercel.app](https://mine-ace6-perf.vercel.app)
- 📌 **Alternative 2**：[mineaceex.github.io/mine_ace6_perf](https://mineacex.github.io/mine_ace6_perf/)

### 📥 Download Options
- [GitHub Release](https://github.com/MineACEx/mine_ace6_perf/releases)
- [Domestic Mirror Download](http://www.cccimg.com/down.php/bd84fbfc7f2e64646e28cf3625622a1a.zip)

### 📋 Installation Steps
1.  Ensure your OnePlus Ace 6 has an unlocked bootloader and Magisk installed.
2.  Download the module zip and install it via Magisk.
3.  During installation, follow the prompt to choose whether to flash the 180Hz DTBO image:
    - Volume Up: Flash DTBO to unlock 180Hz
    - Volume Down: Skip and keep 165Hz
4.  Reboot your device. The module will take effect automatically.
5.  Optional: Install `sxl.apk` in the root directory to customize the screen refresh rate.

### ⚠️ Notes
- Before flashing the DTBO, the module will automatically back up the original DTBO partition to `/sdcard/ModBackdtbo/`. If issues occur, you can restore it via TWRP.
- This module is only for the OnePlus Ace 6. Do not flash it on other devices.
- Updating ColorOS may restore the DTBO partition, requiring you to reinstall the module.

### 🙏 Disclaimer
This module is made by a personal enthusiast. The author is not responsible for any issues (such as bricked devices or data loss) that occur during use. All risks are borne by the user.

---

## 📜 License
This project is licensed under the [MIT License](../LICENSE).
