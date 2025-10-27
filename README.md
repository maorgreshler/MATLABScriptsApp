# 🚀 MATLAB Scripts App

**A customizable template for managing your personal MATLAB scripts collection**

[![MATLAB](https://img.shields.io/badge/MATLAB-R2019b%2B-orange.svg)](https://www.mathworks.com/products/matlab.html)

---

## 📋 Overview

MATLAB Scripts App is a **ready-to-use template** that helps you organize and execute your MATLAB scripts through a clean GUI interface. Start with an empty framework and populate it with your own scripts!

---

## ✨ Features

- 🎨 **Empty Template** - Build your personal script library
- 🔍 **Search Functionality** - Find scripts instantly
- ⚡ **One-Click Execution** - Run, open, or view script info
- 📊 **Custom Thumbnails** - Add visual previews
- 🏷️ **Tab Organization** - Categorize scripts (All/Important/Others)
- 📝 **Excel-Based** - Simple configuration via spreadsheet

---

## 🔧 Quick Start

**Prerequisites:** MATLAB R2019b or later

### File Structure
```
matlab-scripts-app/
├── MATLABScriptsApp.m
├── scripts_registry.xlsx
└── Figures/
    ├── AppIcon.png
    └── [your thumbnails]
```

### Setup Steps

1. **Add your scripts to `scripts_registry.xlsx`:**

   | ScriptName | Path | About |
   |------------|------|-------|
   | MyScript | C:\Scripts\script.m | Script description |

2. **Add thumbnails (optional):**
   - Create `ScriptName.png` images
   - Place in `Figures/` folder

3. **Launch:**
   ```matlab
   MATLABScriptsApp
   ```

---

## 📖 Usage

### Adding Scripts
1. Click **"+ Add"** button (opens Excel)
2. Add row: ScriptName | Path | About
3. Save and restart app

### Running Scripts
1. Select action: **Run** / **Open** / **About**
2. Click script thumbnail

### Search
- Type in search bar
- Click matching script

---

## 🐛 Troubleshooting

| Problem | Solution |
|---------|----------|
| No scripts showing | Add scripts to Excel and restart app |
| File not found | Check script paths are correct |
| Thumbnails missing | Ensure image names match script names |
| Changes not appearing | Always restart app after editing Excel |

---

## 📝 Example Registry

| ScriptName | Path | About |
|------------|------|-------|
| ImageHistogram | C:\Scripts\img_histogram.m | Display RGB histograms |
| DataCleaner | C:\Utils\clean_data.m | Remove outliers |
| FFT_Analysis | D:\DSP\fft_analyzer.m | Frequency analysis |

---

## 📄 License

MIT License - Free to use and modify

---

⭐ **Start organizing your MATLAB scripts today!**
