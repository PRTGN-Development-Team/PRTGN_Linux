 #!/bin/bash
 set -euo pipefail

 # Load Kiwi helper functions
 test -f /.kconfig && . /.kconfig
 test -f /.profile && . /.profile

 echo "==> Running post-build customization..."

 # Enable essential services
 systemctl enable NetworkManager
 systemctl enable sddm          # KDE login manager
 systemctl enable firewalld
 systemctl enable fstrim.timer

 # Set default KDE theme to dark for all new users
 mkdir -p /etc/skel/.config
 cat > /etc/skel/.config/kdeglobals << 'EOF'
 [General]
 ColorScheme=BreezeDark

 [KDE]
 LookAndFeelPackage=org.kde.breezedark.desktop
 EOF

 # Set hostname
 echo "myfedorakde" > /etc/hostname

 # Clean up
 dnf clean all
 rm -rf /var/cache/dnf

 echo "==> Done."