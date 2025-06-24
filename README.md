# oVirt JBoss Modules Maven Plugin

[![Copr build status](https://copr.fedorainfracloud.org/coprs/ovirt/ovirt-master-snapshot/package/ovirt-jboss-modules-maven-plugin/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/ovirt/ovirt-master-snapshot/package/ovirt-jboss-modules-maven-plugin/)

Welcome to the oVirt JBoss Modules Maven Plugin source repository.
This repository is hosted on [GitHub:ovirt-jboss-modules-maven-plugin](https://github.com/oVirt/ovirt-jboss-modules-maven-plugin)

This plugin is intended to simplify the creation of JBoss Modules in
Maven projects.

## How to contribute

All contributions are welcome - patches, bug reports, and documentation issues.

### Submitting patches

Please submit patches to [GitHub:ovirt-jboss-modules-maven-plugin](https://github.com/oVirt/ovirt-jboss-modules-maven-plugin)
 If you are not familiar with the process, you can read about [collaborating with pull requests](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests) on the GitHub website.

### Found a bug or documentation issue?
To submit a bug or suggest an enhancement for oVirt JBoss Modules Maven Plugin please use [issues](https://github.com/oVirt/ovirt-jboss-modules-maven-plugin/issues).

## Still need help?

If you have any other questions or suggestions, you can join and contact us on the [oVirt Users forum / mailing list](https://lists.ovirt.org/admin/lists/users.ovirt.org/).

## Release to Maven Central

To deploy a new release to [Maven Central](https://central.sonatype.com/artifact/org.ovirt.maven.plugins/ovirt-jboss-modules-maven-plugin), bump the release version in the `pom.xml` run the following command:

```bash
mvn deploy -Psign
```
After this command has succesfully run, the next step is to manually deploy this release on the maven central website itself.
