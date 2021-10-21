#!/bin/bash -xe

# Ensure needed packages are available
readarray -t pkgs < automation/build-artifacts.packages
dnf install -y "${pkgs[@]}"

# Set the location of the JDK that will be used for maven
export JAVA_HOME="${JAVA_HOME:=/usr/lib/jvm/java-11}"

# Build RPMs
mvn help:evaluate -Dexpression=project.version # downloads and installs the necessary jars

# Prepare the version string (with support for SNAPSHOT versioning)
VERSION=$(mvn help:evaluate -Dexpression=project.version  2>/dev/null| grep -v "^\[")
VERSION=${VERSION/-SNAPSHOT/-0.$(git rev-list HEAD | wc -l).$(date +%04Y%02m%02d%02H%02M)}
IFS='-' read -ra VERSION <<< "$VERSION"
RELEASE=${VERSION[1]-1}

# Prepare source archive
[ -d rpmbuild/SOURCES ] || mkdir -p rpmbuild/SOURCES
git archive --format=tar HEAD | gzip -9 > "rpmbuild/SOURCES/ovirt-jboss-modules-maven-plugin-${VERSION[0]}.tar.gz"

# Set version and release
sed \
    -e "s|@VERSION@|${VERSION[0]}|g" \
    -e "s|@RELEASE@|${RELEASE}|g" \
    < ovirt-jboss-modules-maven-plugin.spec.in \
    > ovirt-jboss-modules-maven-plugin.spec

# Ensure build dependencies are installed
dnf builddep -y ovirt-jboss-modules-maven-plugin.spec

rpmbuild \
    --define "_topdir rpmbuild" \
    --define "_rpmdir rpmbuild" \
    -bs --nodeps ovirt-jboss-modules-maven-plugin.spec
