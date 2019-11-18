#!/bin/bash

vm_name="$1"
installer_path="$2"

macinbox=$(which macinbox)
format="virtualbox"
disk=64
memory=4096
cpu=2
filesystem="APFS"
username="vagrant"
fullname="Vagrant"
password="vagrant"

echo

if [ -z "${macinbox}" ]; then
    echo "[WARNING] Could not find macinbox. Attempting to install with Bundler."

    bundle=$(which bundle)
    if [ -z "${bundle}" ]; then
        echo "[ERROR] Could not find bundle. Install macinbox using:"
        echo
        echo "    gem install macinbox"
        echo
        exit 1
    fi

    bundle install
fi

if [ ! -d "${installer_path}" ]; then
    echo "[ERROR] Could find installer at ${installer_path}."
    exit 1
fi

echo "VM Name:    ${vm_name}"
echo "Installer:  ${installer_path}"

echo
read -p "Are these values correct? (y/N) " proceed
echo

if [[ "${proceed}" != "y" && "${proceed}" != "Y" ]]; then
    echo "Exiting, since you indicated the values are incorrect."
    exit 1
fi

echo "Proceeding..."
echo

sudo macinbox \
    --box-format "${format}" \
    --name "${vm_name}" \
    --disk "${disk}" \
    --memory "${memory}" \
    --fstype "${filesystem}" \
    --cpu "${cpu}" \
    --full "${fullname}" \
    --short "${username}" \
    --password "${password}" \
    --no-gui \
    --no-auto-login \
    --installer "${installer_path}"
