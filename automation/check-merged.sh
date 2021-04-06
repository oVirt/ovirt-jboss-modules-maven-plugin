#!/bin/bash -e

echo "#######################################################################"
echo "# Installation tests"
"${0%/*}"/build-artifacts.sh
shopt -s extglob
dnf install -y exported-artifacts/!(*src).rpm
echo "#######################################################################"

