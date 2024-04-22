# (c) Copyright 2022 by Coinkite Inc. This file is covered by license found in COPYING-CC.
#
# Using "mtools" here. A weapon from a more civilized age...
#

# NOTE: mtools.conf in current directory maps z: to ./output.img
export MTOOLSRC=mtools.conf
MFORMAT=mformat
MCOPY=mcopy

RELEASES ?= $(wildcard ./releases/*.dfu)

OUTPUT ?= output/cc-recovery-$(shell date +%F).img.xz

all: output.img

flist.txt: Makefile $(RELEASES)
	ls -1 $(RELEASES) | sort -rn > flist.txt

output.img: $(RELEASES) Makefile flist.txt
	dd if=/dev/zero of=output.img bs=1024 count=160 status=none
	$(MFORMAT) -v CCRECOVER -f 160 -N 2022 -C z:
	cat internal-readme.txt flist.txt | sed  -e 's/.\/releases\///' > tmp.txt
	$(MCOPY) -bsmp tmp.txt z:README.TXT
	for f in $(shell cat flist.txt); do \
		echo $$f ; \
		dd if=$$f obs=512 conv=osync status=none >> output.img; \
	done
	xz -cv9 < output.img > $(OUTPUT)
	cat tmp.txt > $(OUTPUT:.img.xz=.txt)
	git add $(OUTPUT:.img.xz=.*)
	rm flist.txt
	ls -l $(OUTPUT)
	
dev:
	$(MAKE) RELEASES=../*/stm32/dev.dfu OUTPUT=dev-recovery.img.xz

# EOF
