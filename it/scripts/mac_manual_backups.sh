#!/usr/bin/env bash

declare -a paths=("/Volumes/WD Passport Data" "/Volumes/Seagate Backup/manual")

for externalpath in "${paths[@]}"; do
    [ -d "${externalpath}" ] && \
        echo "manually backing up to ${externalpath}" || continue

    # local encrypted disk image
    rsync -axvP --force --delete --ignore-errors \
          /Users/benkirk/Documents/Personal.dmg \
          "${externalpath}"/Personal.dmg

    # local Photos library to external disk, if one already exists
    [ -d  /Volumes/LocalNoRemoteBackup/Photos\ Library.photoslibrary/ ] && \
        rsync -axvP --force --delete --ignore-errors \
              /Volumes/LocalNoRemoteBackup/Photos\ Library.photoslibrary/ \
              "${externalpath}"/Photos\ Library.photoslibrary/
done
