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

if [[ $EUID -ne 0 ]]; then
    echo "[ERROR] This script must be run as root."
    echo
    exit 1
fi

if [ -z "${macinbox}" ]; then
    echo "[ERROR] Could not find macinbox."
    echo "[ERROR] Please install macinbox and ensure it is in your PATH."
    echo
    echo "To install macinbox, run:"
    echo
    echo "    gem install macinbox"
    echo
    exit 1
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

macinbox \
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
