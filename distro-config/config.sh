#!/bin/bash
set -euo pipefail

# Load KIWI helper functions
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

echo "==> Running post-build customization..."

# ============================================================
# SYSTEM SERVICES
# ============================================================

systemctl enable NetworkManager
systemctl enable sddm
systemctl enable firewalld
systemctl enable fstrim.timer
systemctl enable livesys.service
systemctl enable livesys-late.service
# Add a desktop shortcut for Calamares
cat > /usr/share/applications/calamares.desktop << 'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Install to Hard Drive
GenericName=System Installer
Exec=calamares
Icon=calamares
Terminal=false
Categories=System;
EOF

# ============================================================
# LIVE USER
# ============================================================

useradd -m -G wheel,audio,video,input,disk live
passwd -d live

cat > /etc/sudoers.d/live << 'EOF'
%wheel ALL=(ALL) NOPASSWD: ALL
EOF
chmod 440 /etc/sudoers.d/live

mkdir -p /etc/sddm.conf.d
cat > /etc/sddm.conf.d/autologin.conf << 'EOF'
[Autologin]
User=live
Session=plasma.desktop
Relogin=false
EOF

cat > /etc/sddm.conf.d/theme.conf << 'EOF'
[Theme]
Current=breeze
EOF

# ============================================================
# DEFAULT KDE CONFIGURATION FOR NEW USERS
# ============================================================

mkdir -p /etc/skel/.config
mkdir -p /etc/skel/.local/share

cat > /etc/skel/.config/kdeglobals << 'EOF'
[General]
ColorScheme=BreezeDark
fixed=Noto Sans Mono,10,-1,5,50,0,0,0,0,0
font=Noto Sans,10,-1,5,50,0,0,0,0,0
menuFont=Noto Sans,10,-1,5,50,0,0,0,0,0
smallestReadableFont=Noto Sans,8,-1,5,50,0,0,0,0,0
toolBarFont=Noto Sans,10,-1,5,50,0,0,0,0,0

[KDE]
LookAndFeelPackage=com.prtgn-linux.xenia-dark
widgetStyle=Breeze
EOF

cat > /etc/skel/.config/plasmarc << 'EOF'
[Theme]
name=breeze-dark
EOF

cat > /etc/skel/.config/kwinrc << 'EOF'
[Compositing]
Enabled=true
Backend=OpenGL
GLCore=true

[Effect-overview]
BorderActivate=7

[org.kde.kdecoration2]
library=org.kde.breeze
theme=Breeze
EOF

cat > /etc/skel/.config/plasma-org.kde.plasma.desktop-appletsrc << 'EOF'
[Containments][1][Wallpaper][org.kde.image][General]
Image=file:///usr/share/wallpapers/xenia-fox-dark/contents/images/1366x768.jpg
EOF

cat > /etc/skel/.config/plasmashellrc << 'EOF'
[PlasmaViews][Panel 2][Defaults]
thickness=44
EOF

mkdir -p /etc/skel/.config/gtk-3.0
cat > /etc/skel/.config/gtk-3.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=Breeze-Dark
gtk-icon-theme-name=breeze-dark
gtk-font-name=Noto Sans 10
gtk-cursor-theme-name=breeze_cursors
gtk-cursor-theme-size=24
EOF

mkdir -p /etc/skel/.config/gtk-4.0
cat > /etc/skel/.config/gtk-4.0/settings.ini << 'EOF'
[Settings]
gtk-theme-name=Breeze-Dark
gtk-icon-theme-name=breeze-dark
gtk-font-name=Noto Sans 10
gtk-cursor-theme-name=breeze_cursors
gtk-cursor-theme-size=24
EOF

cat > /etc/skel/.config/kcminputrc << 'EOF'
[Mouse]
cursorTheme=breeze_cursors
cursorSize=24
EOF

# ============================================================
# HOSTNAME
# ============================================================

echo "prtgn-linux" > /etc/hostname

cat > /etc/hosts << 'EOF'
127.0.0.1   localhost
127.0.1.1   prtgn-linux
::1         localhost ip6-localhost ip6-loopback
EOF

# ============================================================
# SYSTEM BRANDING
# ============================================================

cat > /etc/os-release << 'EOF'
NAME="PRTGN Linux"
VERSION="1.0"
ID=prtgn-linux
ID_LIKE=fedora
VERSION_ID=1.0
PRETTY_NAME="PRTGN Linux 1.0"
HOME_URL="https://github.com/PRTGN-Development-Team/PRTGN_Linux"
EOF

# ============================================================
# CLEANUP
# ============================================================

dnf5 clean all
rm -rf /var/cache/dnf
rm -rf /tmp/*

echo "==> Done."