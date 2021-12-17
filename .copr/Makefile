installdeps:
	dnf -y install git gzip java-11-openjdk-devel maven rpm-build sed

srpm:
	./.automation/build-srpm.sh
	cp rpmbuild/SRPMS/*.src.rpm $(outdir)
