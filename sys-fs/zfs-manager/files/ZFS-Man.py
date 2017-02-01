import os
print ""
print "ZFS Manager 1.0"
print "Written by: Edward Koch"

exitcode = 0
while exitcode < 1:
    print ""
    print "1. ZPOOL Options"
    print "2. ZFS Options"
    print "3. Exit"
    print ""
    main_select = raw_input("ZFS-MAN>")

    if main_select == "1":
        zpoolexit = 0
        while zpoolexit < 1:
            print ""
            print "1. View Hard Disks"
            print "2. Add/Remove/Edit ZPOOLs"
            print "3. View ZPOOLs"
            print "4. View ZPOOL IOSTATs"
            print "5. Return"
            print ""
            zpool_select = raw_input("ZFS-MAN>")

            if zpool_select == "1":
                print ""
                os.system("egrep 'ad[0-9]|da[0-9]' /var/run/dmesg.boot | less")
                print ""

            if zpool_select == "2":
                arzpoolexit = 0
                while arzpoolexit < 1:
                    print ""
                    print "1. Add Mirrored ZPOOL"
                    print "2. Add RaidZ ZPOOL"
                    print "3. Add RaidZ2 ZPOOL"
                    print "4. Add RaidZ3 ZPOOL"
                    print "5. Replace Failed Disk in ZPOOL"
                    print "6. Add Cache Device"
                    print "7. Add ZIL Device"
                    print "8. Add a mirrored ZIL Device"
                    print "9. Remove Cache Device"
                    print "10. Remove ZIL Device"
                    print "11. Remove ZPOOL"
                    print "12. Return"
                    print ""
                    arzpool_select = raw_input("ZFS-MAN>")

                    if arzpool_select == "1":
                        print ""
                        print "Input the name of the ZPOOL you would like to create:"
                        zpoolname = raw_input("ZPOOL Name:")
                        print "Input the hard disks you would like to add to the mirrored array:"
                        zpoolc = raw_input("Hard Disks Seperated By Spaces *two drives*:")
                        os.system("zpool create %s mirror %s" % (zpoolname, zpoolc))

                    if arzpool_select == "2":
                        print ""
                        print "Input the name of the ZPOOL you would like to create:"
                        zpoolname2 = raw_input("ZPOOL Name:")
                        print "Input the hard disks you would like to add to the RaidZ array:"
                        zpoolc2 = raw_input("Hard Disks Seperated By Spaces *three drives minimum*:")
                        os.system("zpool create %s raidz %s" % (zpoolname2, zpoolc2))

                    if arzpool_select == "3":
                        print ""
                        print "Input the name of the ZPOOL you would like to create:"
                        zpoolname3 = raw_input("ZPOOL Name:")
                        print "Input the hard disks you would like to add to the RaidZ2 array:"
                        zpoolc3 = raw_input("Hard Disks Seperated By Spaces *four drives minimum*:")
                        os.system("zpool create %s raidz2 %s" % (zpoolname3, zpoolc3))

                    if arzpool_select == "4":
                        print ""
                        print "Input the name of the ZPOOL you would like to create:"
                        zpoolname4 = raw_input("ZPOOL Name:")
                        print "Input the hard disks you would like to add to the RaidZ3 array:"
                        zpoolc4 = raw_input("Hard Disks Seperated By Spaces *five drives minimum*:")
                        os.system("zpool create %s raidz3 %s" % (zpoolname4, zpoolc4))

                    if arzpool_select == "5":
                        print ""
                        print "Notice: Please have the failed hard disk removed and replaced before"
                        print "this procedure."
                        print "Input the name of the ZPOOL that contains the failed disk:"
                        zpoolname5 = raw_input("ZPOOL Name:")
                        print "Input the hard disk you would replace the failed drive with:"
                        zpoolc5 = raw_input("Hard Disk:")
                        os.system("zpool replace %s %s" % (zpoolname5, zpoolc5))

                    if arzpool_select == "6":
                        print ""
                        print "Input the name of the ZPOOL you would like to add a Cache to:"
                        zpoolname6 = raw_input("ZPOOL Name:")
                        print "Input the hard disks you would like to add as a cache device:"
                        zpoolc6 = raw_input("Hard Disks Seperated By Spaces *one drive minimum*:")
                        os.system("zpool add %s cache %s" % (zpoolname6, zpoolc6))

                    if arzpool_select == "7":
                        print ""
                        print "Input the name of the ZPOOL you would like to add a ZIL to:"
                        zpoolname7 = raw_input("ZPOOL Name:")
                        print "Input the hards disks you would like to add as a ZIL device:"
                        zpoolc7 = raw_input("Hard Disks Seperated By Spaces *one drive minimum*:")
                        os.system("zpool add %s log %s" % (zpoolname7, zpoolc7))
                        
                    if arzpool_select == "8":
                        print ""
                        print "Input the name of the ZPOOL you would like to add a mirrored ZIL to:"
                        zpoolname7 = raw_input("ZPOOL Name:")
                        print "Input the hards disks you would like to add as a ZIL device:"
                        zpoolc7 = raw_input("Hard Disks Seperated By Spaces *two drives minimum*:")
                        os.system("zpool add %s log mirror %s" % (zpoolname7, zpoolc7))

                    if arzpool_select == "9":
                        print ""
                        print "Input the name of the ZPOOL you would like to remove a cache from:"
                        zpoolname8 = raw_input("ZPOOL Name:")
                        print "Input the hard disks you would like to remove:"
                        zpoolc8 = raw_input("Hard Disks Seperated By Spaces *one drive minimum*:")
                        os.system("zpool remove %s %s" % (zpoolname8, zpoolc8))

                    if arzpool_select == "10":
                        print ""
                        print "Input the name of the ZPOOL you would like to remove a ZIL from:"
                        zpoolname9 = raw_input("ZPOOL Name:")
                        print "Input the hard disks you would like to remove:"
                        zpoolc9 = raw_input("Hard Disks Seperated By Spaces *one drive minimum*:")
                        os.system("zpool remove %s %s" % (zpoolname9, zpoolc9))

                    if arzpool_select == "11":
                        print ""
                        print "Input the ZPOOL you would like to remove:"
                        zpoolr = raw_input("ZPOOL:")
                        os.system("zpool destroy %s" % (zpoolr))

                    if arzpool_select == "12":
                        print ""
                        arzpoolexit = 1

            if zpool_select == "3":
                print ""
                os.system("zpool status | less")
                print ""

            if zpool_select == "4":
                print ""
                os.system("zpool iostat -v")
                print ""

            if zpool_select == "5":
                zpoolexit = 1


    if main_select == "2":
        zfsexit = 0
        while zfsexit < 1:
            print ""
            print "1. List ZFS Filesystem"
            print "2. Create ZFS Filesystem"
            print "3. Destroy ZFS Filesystem"
            print "4. ZFS Snapshots"
            print "5. ZFS Options"
            print "6. Return"
            print ""
            zfs_select = raw_input("ZFS-MAN>")

            if zfs_select == "1":
                print ""
                os.system("zfs list | less")
                print ""

            if zfs_select == "2":
                print ""
                print "Input the file system path you would like to create:"
                zfscpath = raw_input("Filesystem Path>")
                os.system("zfs create %r" % (zfscpath))

            if zfs_select == "3":
                print ""
                print "Input the file system path you would like to destroy:"
                zfsdpath = raw_input("Filesystem Path>")
                os.system("zfs destroy %r" % (zfsdpath))

            if zfs_select == "4":
                snapshotexit = 0
                while snapshotexit < 1:
                    print ""
                    print "1. Create Manual Snapshot"
                    print "2. Delete Snapshot"
                    print "3. Restore Snapshot"
                    print "4. View Snapshots"
                    print "5. Return "
                    print ""
                    snapshot_select = raw_input("ZFS-MAN>")



                    if snapshot_select == "1":
                        print ""
                        print "Which volume/path would you like to snapshot?"
                        snapvol1 = raw_input("Volume Name/path>")
                        print "What would you like to name the snapshot?"
                        snapname1 = raw_input("Snapshot Name>")
                        os.system("zfs snapshot %r@%r" % (snapvol1, snapname1))

                    if snapshot_select == "2":
                        print ""
                        print "Which volume/path does the snapshot reside on?"
                        snapvol2 = raw_input("Volume Name/path>")
                        print "What is the name of the snapshot you would like to delete?"
                        snapname2 = raw_input("Snapshot Name>")
                        os.system("zfs destroy %r@%r" % (snapvol2, snapname2))

                    if snapshot_select == "3":
                        print ""
                        print "Which volume/path does the snapshot reside on?"
                        rollvol = raw_input("Volume Name/path>")
                        print "What is the name of the snapshot you would like to restore?"
                        rollname = raw_input("Snapshot Name>")
                        os.system("zfs rollback -r %r@%r" % (rollvol, rollname))
                        print ""

                    if snapshot_select == "4":
                        print ""
                        os.system("zfs list -t snapshot | less")
                        print ""

                    if snapshot_select == "5":
                        snapshotexit = 1

            if zfs_select == "5":
                zfsoptionsexit = 0
                while zfsoptionsexit < 1:
                    print ""
                    print "1. Display ZFS Compression"
                    print "2. Display NFS Sharing"
                    print "3. Enable ZFS Compression"
                    print "4. Disable ZFS Compression"
                    print "5. Enable NFS Sharing"
                    print "6. Disable NFS Sharing"
                    print "7. Return"
                    print ""
                    zfsoptions_select = raw_input("ZFS-MAN>")

                    if zfsoptions_select == "1":
                        print ""
                        os.system("zfs get compression | less")
                        print ""

                    if zfsoptions_select == "2":
                        print ""
                        os.system("zfs get sharenfs | less")
                        print ""

                    if zfsoptions_select == "3":
                        print ""
                        print "Input the file system path you would like to enable compression on:"
                        zfscompenable = raw_input("Filesystem Path>")
                        os.system("zfs set compression=lz4 %r" % (zfscompenable))

                    if zfsoptions_select == "4":
                        print ""
                        print "Input the file system path you would like to disable compression on:"
                        zfscompdisable = raw_input("Filesystem Path>")
                        os.system("zfs set compression=off %r" % (zfscompdisable))

                    if zfsoptions_select == "5":
                        print ""
                        print "Input the file system path you would like to enable NFS Sharing on:"
                        zfsnfsshareenable = raw_input("Filesystem Path>")
                        os.system("zfs set sharenfs=on %r" % (zfsnfsshareenable))

                    if zfsoptions_select == "6":
                        print ""
                        print "Input the file system path you would like to disable NFS Sharing on:"
                        zfsnfssharedisable = raw_input("Filesystem Path>")
                        os.system("zfs set sharenfs=off %r" % (zfsnfssharedisable))

                    if zfsoptions_select == "7":
                        print ""
                        zfsoptionsexit = 1

            if zfs_select == "6":
                print ""
                zfsexit = 1

    if main_select == "3":
        exitcode = 1

