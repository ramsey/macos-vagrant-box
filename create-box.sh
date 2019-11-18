#!/bin/bash

box="$1"
vm_name="${box}"
version="$2"
description="$3"

org="ramsey"
org_box="${org}/${box}"
provider="virtualbox"
box_file="$(pwd)/package.box"

echo
echo "VM:           ${vm_name}"
echo "Box:          ${org_box}"
echo "Provider:     ${provider}"
echo "Version:      ${version}"
echo "Description:  ${description}"

echo
read -p "Are these values correct? (y/N) " proceed
echo

if [[ "${proceed}" != "y" && "${proceed}" != "Y" ]]; then
    echo "Exiting, since you indicated the values are incorrect."
    exit 1
fi

echo "Proceeding..."
echo

cp Vagrantfile.template Vagrantfile
sed -i -e "s|{{ box }}|${box}|g;s|{{ vm_name }}|${vm_name}|g" Vagrantfile

vagrant up

vagrant package --base "${vm_name}"

if [ ! -f "${box_file}" ]; then
    echo "[ERROR] Could not find the packaged box at ${box_file}."
    exit 1
fi

sha256=$(sha256sum -b -z "${box_file}")
checksum=$(cut -d' ' -f1 <<< "${sha256}")

vagrant cloud version create \
    -d "${description}" \
    "${org_box}" \
    "${version}"

vagrant cloud provider create \
    --checksum "${checksum}" \
    --checksum-type "sha256" \
    "${org_box}" \
    "${provider}" \
    "${version}"

vagrant cloud provider upload \
    "${org_box}" \
    "${provider}" \
    "${version}" \
    "${box_file}"
