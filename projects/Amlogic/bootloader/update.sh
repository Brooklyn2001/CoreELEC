#!/bin/sh
################################################################################
#      This file is part of Alex@ELEC - http://www.alexelec.in.ua
#      Copyright (C) 2011-present Alexandr Zuyev (alex@alexelec.in.ua)
################################################################################

[ -z "$SYSTEM_ROOT" ] && SYSTEM_ROOT=""
[ -z "$BOOT_ROOT" ] && BOOT_ROOT="/flash"
[ -z "$UPDATE_DIR" ] && UPDATE_DIR="/storage/.update"
UPDATE_DTB_IMG="$UPDATE_DIR/dtb.img"
UPDATE_DTB=`ls -1 "$UPDATE_DIR"/*.dtb 2>/dev/null | head -n 1`
UPDATE_DTB_OVERRIDE_IMG="$UPDATE_DIR/dtb.override.img"
[ -z "$BOOT_PART" ] && BOOT_PART=$(df "$BOOT_ROOT" | tail -1 | awk {' print $1 '})
if [ -z "$BOOT_DISK" ]; then
  case $BOOT_PART in
    /dev/sd[a-z][0-9]*)
      BOOT_DISK=$(echo $BOOT_PART | sed -e "s,[0-9]*,,g")
      ;;
    /dev/mmcblk*)
      BOOT_DISK=$(echo $BOOT_PART | sed -e "s,p[0-9]*,,g")
      ;;
  esac
fi

mount -o rw,remount $BOOT_ROOT

for arg in $(cat /proc/cmdline); do
  case $arg in
    boot=*)
      echo "Updating BOOT partition label..."
      boot="${arg#*=}"
      case $boot in
        /dev/mmc*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/fatlabel $boot "@BOOT_LABEL@"
          ;;
        LABEL=*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/fatlabel $($SYSTEM_ROOT/usr/sbin/findfs $boot) "@BOOT_LABEL@"
          ;;
      esac

      if [ -f "/proc/device-tree/le-dt-id" ] ; then
        LE_DT_ID=$(cat /proc/device-tree/le-dt-id)
      fi

      if [ -f "$UPDATE_DTB_OVERRIDE_IMG" ] ; then
        UPDATE_DTB_SOURCE="$UPDATE_DTB_OVERRIDE_IMG"
      elif [ -n "$LE_DT_ID" -a -f "$SYSTEM_ROOT/usr/share/bootloader/device_trees/$LE_DT_ID.dtb" ] ; then
        UPDATE_DTB_SOURCE="$SYSTEM_ROOT/usr/share/bootloader/device_trees/$LE_DT_ID.dtb"
      elif [ -f "$UPDATE_DTB_IMG" ] ; then
        UPDATE_DTB_SOURCE="$UPDATE_DTB_IMG"
      elif [ -f "$UPDATE_DTB" ] ; then
        UPDATE_DTB_SOURCE="$UPDATE_DTB"
      fi

      if [ -f "$UPDATE_DTB_SOURCE" ] ; then
        echo "Updating device tree from $UPDATE_DTB_SOURCE..."
        case $boot in
          /dev/system)
            dd if=/dev/zero of=/dev/dtb bs=256k count=1 status=none
            dd if="$UPDATE_DTB_SOURCE" of=/dev/dtb bs=256k status=none
            ;;
          /dev/mmc*|LABEL=*)
            cp -f "$UPDATE_DTB_SOURCE" "$BOOT_ROOT/dtb.img"
            ;;
        esac
      fi

      for all_dtb in /flash/*.dtb ; do
        if [ -f $all_dtb ] ; then
          dtb=$(basename $all_dtb)
          if [ -f $SYSTEM_ROOT/usr/share/bootloader/$dtb ]; then
            echo "Updating $dtb..."
            cp -p $SYSTEM_ROOT/usr/share/bootloader/$dtb $BOOT_ROOT
          fi
        fi
      done
      ;;
    disk=*)
      echo "Updating DISK partition label..."
      disk="${arg#*=}"
      case $disk in
        /dev/mmc*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/e2label $disk "@DISK_LABEL@"
          ;;
        LABEL=*)
          LD_LIBRARY_PATH="$SYSTEM_ROOT/lib" $SYSTEM_ROOT/usr/sbin/e2label $($SYSTEM_ROOT/usr/sbin/findfs $disk) "@DISK_LABEL@"
          ;;
      esac
      ;;
  esac
done

if [ -d $BOOT_ROOT/device_trees ]; then
  rm $BOOT_ROOT/device_trees/*.dtb
  cp -p $SYSTEM_ROOT/usr/share/bootloader/device_trees/*.dtb $BOOT_ROOT/device_trees/
fi

if [ -f $BOOT_ROOT/aml_autoscript ]; then
  if [ -f $SYSTEM_ROOT/usr/share/bootloader/aml_autoscript ]; then
    echo "Updating aml_autoscript..."
    cp -p $SYSTEM_ROOT/usr/share/bootloader/aml_autoscript $BOOT_ROOT
  fi
fi

mount -o ro,remount $BOOT_ROOT
