# StretchReminder

## TODO

- [ ] Use https://github.com/Windos/PoshNotify for non-windows systems
- [ ] Consider starting as background job instead of leaving terminal open

## Installation (on Windows)

This module requires the BurntToast module for displaying notifications on Windows. You can install it from the PowershellGallery.

```powershell
Install-Module -Name BurntToast -Scope CurrentUser
Install-Module -Name StretchReminder -Scope CurrentUser
```

## Installation (macOS / Linux)

Notifications are not supported for macOS/Linux at the moment (working on it), and therefor no point in installing it for these operating systems.

## How To Use

```powershell
# Will notify you every 15 minutes and count down from 15 seconds each time.
Start-StretchReminder

# Will notify you every 30 minutes and count down from 15 seconds each time.
Start-StretchReminder -Interval 30 -Duration 15
```

NOTE: Currently, the terminal must be left open when you run this module.
