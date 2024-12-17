#!/usr/bin/env bash

declare -a paths=("/Volumes/WD Passport Data" "/Volumes/Seagate Backup/manual")

topdir="$(pwd)"

for externalpath in "${paths[@]}"; do

    [ -d "${externalpath}" ] && \
        echo "manually backing up to ${externalpath}" || continue

    # local encrypted disk image
    rsync -axvP --force --delete --ignore-errors \
          /Users/benkirk/Documents/Personal.dmg \
          "${externalpath}"/Personal.dmg

    # local Photos library to external disk, if one already exists
    [ -d  /Volumes/LocalNoRemoteBackup/Photos\ Library.photoslibrary/ ] && \
        echo "Backing Up Photos..." && \
        rsync -axvHP --force --delete --ignore-errors \
              /Volumes/LocalNoRemoteBackup/Photos\ Library.photoslibrary/ \
              "${externalpath}"/Photos\ Library.photoslibrary/

    mkdir -p "${externalpath}/home_backup/" && cd "${externalpath}/home_backup/" || continue
    pwd
    [ -w "$(pwd)" ] || continue
    echo "Backing up ${HOME}..."
    rsync -axvHP --force --delete --ignore-errors \
          --exclude 'Docker.raw' \
          --exclude '.conda/' \
          --exclude '.docker/' \
          --exclude '.tmp/' \
          "${HOME}"/ \
          "$(pwd)"/

    cd ${topdir}
done
