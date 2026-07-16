#!/bin/bash -xe

# Directory where build artifacts will be stored, passed as 1st parameter
ARTIFACTS_DIR=${1:-exported-artifacts}

# Get the version from pom.xml, strip -SNAPSHOT suffix
VERSION=$(mvn help:evaluate -q -DforceStdout -Dexpression=project.version)
VERSION=${VERSION%-SNAPSHOT}

# Use PACKAGE_RPM_RELEASE env var, default to 0.master
RELEASE=${PACKAGE_RPM_RELEASE:-0.master}

# Prepare source archive
[[ -d rpmbuild/SOURCES ]] || mkdir -p rpmbuild/SOURCES
git archive --format=tar HEAD | gzip -9 > rpmbuild/SOURCES/ovirt-jboss-modules-maven-plugin-${VERSION}.tar.gz

# Set version and release in spec
sed \
    -e "s|@VERSION@|${VERSION}|g" \
    -e "s|@RELEASE@|${RELEASE}|g" \
    < ovirt-jboss-modules-maven-plugin.spec.in \
    > ovirt-jboss-modules-maven-plugin.spec

# Build source package
rpmbuild \
    -D "_topdir $(pwd)/rpmbuild" \
    --define="release_suffix ${RELEASE_SUFFIX:-}" \
    -bs ovirt-jboss-modules-maven-plugin.spec
