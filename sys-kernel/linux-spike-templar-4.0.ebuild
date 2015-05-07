# Copyright 2004-2014 Spike Linux
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator

K_SPIKETEMPLARKERNEL_SELF_TARBALL_NAME="spike"
K_REQUIRED_LINUX_FIRMWARE_VER="20150320"
K_SPIKETEMPLARKERNEL_FORCE_SUBLEVEL="0"
K_SPIKETEMPLARKERNEL_PATCH_UPSTREAM_TARBALL="1"
K_KERNEL_NEW_VERSIONING="1"
K_KERNEL_PATCH_HOTFIXES="${FILESDIR}/001-vgaarb_controller.patch"

inherit spike-templar-kernel

KEYWORDS="~amd64"
DESCRIPTION="Official Spike Linux Grsecuity enhanced kernel image"
RESTRICT="mirror"

DEPEND="${DEPEND}    
    sys-apps/v86d
    sys-apps/gradm
    app-admin/grsecurity-scripts
    sys-kernel/dracut
    sys-fs/zfs-kmod"
    
IUSE="abi_x86_64 amd64 btrfs -build iscsi symlink kernel_linux userland_GNU plymouth splash elibc_glibc dracut lvm dmraid mdadm luks grsecurity"

#I hate dracut at times but for ZFS use.... injection  not quite done or may not be neaded anyhow,
