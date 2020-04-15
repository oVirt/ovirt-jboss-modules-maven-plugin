#!/bin/bash -xe

rm -rf exported-artifacts
mkdir -p exported-artifacts
git_head=$(git log -1 --pretty=format:%h)
GIT_RELEASE=$(date --utc +%Y%m%d).git${git_head}
make  spec
yum-builddep -y ovirt-jboss-modules-maven-plugin.spec
make rpm
find rpmtop/RPMS rpmtop/SRPMS -name '*rpm' -exec mv {} exported-artifacts \;
mv *.tar.gz exported-artifacts/
