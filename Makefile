#
# Copyright (c) 2014-2015 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

all: rpm

PWD=$(shell bash -c "pwd -P")
pomversion=$(shell $(PWD)/version.py --pom)
rpmversion=$(shell $(PWD)/version.py --rpm)
rpmdist=$(shell rpm --eval '%dist')
rpmrelease=0.1$(rpmsuffix)$(rpmdist)

RPMTOP=$(PWD)/rpmtop
NAME=ovirt-jboss-modules-maven-plugin
SPEC=$(NAME).spec

TARBALL=$(NAME)-$(pomversion).tar.gz
SRPM=$(RPMTOP)/SRPMS/$(NAME)-$(rpmversion)-$(rpmrelease).src.rpm

.PHONY:
spec: spec$(rpmdist).in
	sed \
		-e 's/@POM_VERSION@/$(pomversion)/g' \
		-e 's/@RPM_VERSION@/$(rpmversion)/g' \
		-e 's/@RPM_RELEASE@/$(rpmrelease)/g' \
		-e 's/@TARBALL@/$(TARBALL)/g' \
		< $< \
		> $(SPEC)

.PHONY: tarball
tarball: spec
	git ls-files | tar --transform='s|^|$(NAME)/|' --files-from /proc/self/fd/0 -czf $(TARBALL) $(SPEC)

.PHONY: srpm
srpm: tarball
	rpmbuild \
		--define="_topdir $(RPMTOP)" \
		-ts $(TARBALL)

.PHONY: rpm
rpm: srpm
	rpmbuild \
	--define="_topdir $(RPMTOP)" \
	--rebuild $(SRPM)

.PHONY: clean
clean:
	$(RM) $(NAME)*.tar.gz $(SPEC)
	$(RM) -r rpmtop
