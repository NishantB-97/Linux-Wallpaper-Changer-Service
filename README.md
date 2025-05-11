# 🖼️ GNOME Wallpaper Changer (with systemd)

A lightweight and customizable solution to periodically change your **GNOME desktop wallpaper** using a `Bash script` and `systemd` user `timer`.  
Perfect for learning Linux scripting, DBus, and systemd automation!

---

## ✨ Features

- 🔀 Randomly selects a wallpaper from a specified directory every 1 minute  
- 💻 Designed specifically for **GNOME** desktop environments  
- 🪶 Lightweight with no third-party dependencies  
- 💡 Great for learning about `gsettings`, DBus, and systemd user services

---

## 🛠️ How It Works

- `wallpaper_changer.sh`: Bash script that picks a random image and applies it as the desktop background using `gsettings`.  
- `wallpaper-changer.service` + `wallpaper-changer.timer`: systemd user service and timer that runs the script every minute.

---

## 🚀 Setup Instructions

### 1. Prepare Your Wallpaper Directory

Choose or create a directory for your wallpapers, for example:

`/home/yourusername/Pictures/Wallpapers`

Update the script with your actual path.

---

### 2. Create the Script

Save this file as `~/wallpaper_changer.sh`:

```bash
#!/bin/bash

WALLPAPER_DIR="/home/yourusername/Pictures/Wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"
```

gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER"
gsettings set org.gnome.desktop.background picture-options 'zoom'
Make it executable:

```bash

chmod +x ~/wallpaper_changer.sh
```
📌 Replace /home/yourusername/ with your actual username and ensure the directory exists.

### 3. Create the systemd Service and Timer
Navigate to the user systemd directory:

```bash

mkdir -p ~/.config/systemd/user
```
wallpaper-changer.service
Create `~/.config/systemd/user/wallpaper-changer.service`:

```ini

[Unit]
Description=Change GNOME wallpaper every minute
After=graphical-session.target

[Service]
Type=oneshot
ExecStart=/home/yourusername/wallpaper_changer.sh
Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus
wallpaper-changer.timer
Create ~/.config/systemd/user/wallpaper-changer.timer:
```
Create `~/.config/systemd/user/wallpaper-changer.timer`:
```ini

[Unit]
Description=Run GNOME wallpaper changer every 1 minute

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
Unit=wallpaper-changer.service
Persistent=true

[Install]
WantedBy=timers.target
```
🛠️ Update the paths in ExecStart to match your script location.


### 4. Enable the Timer
Reload and enable the timer:

```bash

systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now wallpaper-changer.timer
```

### 5. Check Status
Verify that the timer is active:

```bash
systemctl --user status wallpaper-changer.timer
```
You should see something like:

Active: `active (waiting)`


![SystemctlStatusSS](https://github.com/user-attachments/assets/6abdaeee-5abe-4042-a621-6f5ab6b840bd)
