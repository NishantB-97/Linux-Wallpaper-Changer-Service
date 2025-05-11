Wallpaper Changer for GNOME on Linux
A simple script and systemd timer to automatically change your GNOME desktop wallpaper every minute.
Perfect for anyone who wants to personalize their Linux desktop and learn more about scripting, automation, and systemd services.

Features
Randomly selects a wallpaper from your chosen directory every minute

Works seamlessly with GNOME desktop environments

Uses a lightweight Bash script and systemd user service/timer

Great way to learn about DBus, GNOME settings, and Linux automation

How It Works
wallpaper_changer.sh: Bash script that picks a random image from your wallpaper folder and sets it as the desktop background using gsettings.

systemd user service: Runs the script as a one-shot service.

systemd timer: Triggers the service every minute.

Setup Instructions
1. Place Your Wallpapers
Put all your desired wallpapers into a single directory, e.g.:

text
/home/yourusername/Pictures/Wallpapers
Update the WALLPAPER_DIR variable in wallpaper_changer.sh if you use a different path.

2. Copy the Script
Save the following as ~/wallpaper_changer.sh and make it executable:

bash
chmod +x ~/wallpaper_changer.sh
3. Set Up systemd User Service and Timer
Create the following files in ~/.config/systemd/user/:

wallpaper-changer.service

text
[Unit]
Description=Change wallpaper every minute
After=graphical-session.target

[Service]
ExecStart=/home/yourusername/wallpaper_changer.sh
Type=oneshot
Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%U/bus
wallpaper-changer.timer

text
[Unit]
Description=Run wallpaper changer every 1 minute

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
Unit=wallpaper-changer.service
Persistent=true

[Install]
WantedBy=timers.target
Replace /home/yourusername/ with your actual username and path.

4. Enable and Start the Timer
Open a terminal and run:

bash
systemctl --user daemon-reexec
systemctl --user daemon-reload
systemctl --user enable --now wallpaper-changer.timer
5. Confirm It's Running
Check the timer status:

bash
systemctl --user status wallpaper-changer.timer
You should see:
Active: active (waiting)

Notes
This script is designed for GNOME and may not work with other desktop environments.

Make sure gsettings and shuf are installed.

The script sets the wallpaper for dark mode (picture-uri-dark). You can modify it for light mode if needed.

Screenshot
![Wallpaper Changer Output](Screenshot-from-2025-05-01-20-43-21.jpgnse

MIT

Credits
Created by [Your Name]
Feel free to fork, modify, and share!

Enjoy your ever-changing Linux desktop!
