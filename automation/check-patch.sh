#!/bin/bash -e

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "~ Installation tests"
"${0%/*}"/build-artifacts.sh
shopt -s extglob
if which dnf &>/dev/null; then
    dnf install -y exported-artifacts/!(*src).rpm
else
    yum install -y exported-artifacts/!(*src).rpm
fi
echo "~ Installation tests PASSED"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

