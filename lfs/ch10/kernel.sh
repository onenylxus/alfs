#!/bin/bash

set -e

echo "Building linux..."
echo "Approximate build time: 0.4 - 32 SBU (typically about 2.5 SBU)"
echo "Required disk space: 1.7 - 14 GB (typically about 2.3 GB)"

tar -xf /sources/linux-*.tar.xz -C /tmp/
mv /tmp/linux-* /tmp/linux

pushd /tmp/linux > /dev/null

make mrproper

# The book uses the interactive `make menuconfig` here. This build is
# unattended, so start from the architecture default configuration and then
# apply the required settings from Section 10.3.1 by their configuration
# symbols.
make defconfig

scripts/config --disable WERROR
scripts/config --enable PSI
scripts/config --disable PSI_DEFAULT_DISABLED
scripts/config --disable IKHEADERS
scripts/config --enable CGROUPS
scripts/config --enable MEMCG
scripts/config --disable EXPERT
scripts/config --enable RELOCATABLE
scripts/config --enable RANDOMIZE_BASE
scripts/config --enable STACKPROTECTOR
scripts/config --enable STACKPROTECTOR_STRONG
scripts/config --disable UEVENT_HELPER
scripts/config --enable DEVTMPFS
scripts/config --enable DEVTMPFS_MOUNT
scripts/config --enable SYSFB_SIMPLEFB
scripts/config --enable DRM
scripts/config --enable DRM_PANIC
scripts/config --set-str DRM_PANIC_SCREEN "kmsg"
scripts/config --enable DRM_FBDEV_EMULATION
scripts/config --enable DRM_SIMPLEDRM
scripts/config --enable FRAMEBUFFER_CONSOLE
scripts/config --enable PCI
scripts/config --enable PCI_MSI
scripts/config --enable IOMMU_SUPPORT
scripts/config --enable IRQ_REMAP
scripts/config --enable X86_X2APIC
scripts/config --enable BLK_DEV_NVME

make olddefconfig

make

make modules_install

# The LFS system built in Docker has no separate /boot partition, so the
# optional `mount /boot` from the book is not needed.
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-6.16.1-lfs-12.4

cp -iv System.map /boot/System.map-6.16.1

cp -iv .config /boot/config-6.16.1

cp -r Documentation -T /usr/share/doc/linux-6.16.1

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

popd > /dev/null
rm -rf /tmp/linux
