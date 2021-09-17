#!/bin/bash -e

echo "#######################################################################"
echo "# Installation tests"
"${0%/*}"/build-artifacts.sh
shopt -s extglob
pushd exported-artifacts
    rm -f /etc/yum.conf
    dnf reinstall -y system-release dnf
    [[ -d /etc/dnf ]] && [[ -x /usr/bin/dnf ]] && dnf -y reinstall dnf-conf
    [[ -d /etc/dnf ]] && sed -i -re 's#^(reposdir *= *).*$#\1/etc/yum.repos.d#' '/etc/dnf/dnf.conf'
    [[ -e /etc/dnf/dnf.conf ]] && echo "deltarpm=False" >> /etc/dnf/dnf.conf
    rm -f /etc/yum/yum.conf

    dnf repolist enabled
    dnf clean all
    dnf install -y http://resources.ovirt.org/pub/yum-repo/ovirt-release-master.rpm

    if [[ "$(rpm --eval "%dist")" == ".el8" ]]; then
        dnf module enable pki-deps javapackages-tools
    fi
    dnf --downloadonly install *noarch.rpm

popd
echo "#######################################################################"

