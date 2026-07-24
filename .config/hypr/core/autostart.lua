require("core.common")

hl.on("hyprland.start", function()
	hl.exec_cmd(launchprefix .. " /usr/bin/dunst") -- Notification manager
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- Updates the list of environment variables
	hl.exec_cmd(
		'systemd-inhibit --who="Hyprland config" --why="wlogout keybind" --what=handle-power-key --mode=block sleep infinity & echo $! > /tmp/.hyprland-systemd-inhibit'
	) -- Inhibit shutdown when pressing the power off key, instead run wlogout
	hl.exec_cmd("bluetoothctl power off")
	hl.exec_cmd("~/scripts/hypr/idleInhibitManager.fish")
	hl.exec_cmd(launchprefix .. " ~/.local/bin/clipse -listen") -- Clipboard mangaer
	hl.exec_cmd("brightnessctl --restore")
	-- hl.exec_cmd(launchprefix .. " " .. hyprnim .. " watch")
	-- hl.exec_cmd(hyprnim .. " monitors")
	hl.exec_cmd(
		launchprefix
			.. " kitty --single-instance --class=nvim --hold --override confirm_os_window_close=0 -- fish -c orgfiles",
		{ workspace = "special silent" }
	)

	-- To fix waybar not showing system tray after using kde apps
	-- By tomektom from https://github.com/Alexays/Waybar/issues/3468#issuecomment-2445419416
	hl.exec_cmd(
		'printf "[D-BUS Service]\\nName=org.kde.kded6\\nExec=/bin/false" > ~/.local/share/dbus-1/services/org.kde.kded6.service'
	)

	-- Ensure dark theme is on
	h.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"')
	h.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')

	hl.exec_cmd(launchprefix .. " waybar") -- status bar
	hl.exec_cmd("~/scripts/hypr/events/onUnlock.sh")
	hl.exec_cmd("aw-qt") -- Activity watcher
end)

hl.on("hyprland.shutdown", function()
	hl.exec_cmd('kill -9 "$(cat /tmp/.hyprland-systemd-inhibit)')
end) -- Remove shutdown inhibiter

hl.on("hyprland.shutdown", function()
	hl.exec_cmd("rm ~/.local/share/dbus-1/services/org.kde.kded6.service")
end) -- Clean waybar fix
