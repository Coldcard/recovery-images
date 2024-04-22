# Recovery Disk Images

## Background

If a COLDCARD is powered down during the firmware update process,
the intended (new) firmware image has been lost because it it held
in PSRAM (volatile memory) during the flash writing process.
The COLDCARD bootloader is smart enough to detect this specific case,
and read an SD card to recover and avoid becoming a brick.

The bootloader will only install an image of _exactly_ the same
version as was being installed when interrupted. This is done by
verifying the checksum vs. the value that had been set in SE1 by
the PIN holder. This prevents side-loading or up/downgrade attacks.

This projects holds data and code to build a special SD card disk
image with all possible releases. The goal is a single disk image that
can be used restore a COLDCARD of any (intended) version.

We may not update this every single release, but if you have a need,
please contact support and we are happy to update it!

## How to use.

Take a file from [outputs](outputs) and image it onto an SD Card,
uncompressed. We recommend Balena Etcher to do this in one step on
MacOS.  Turn on the COLDCARD with the card inserted and the rest
is automatic (although not fast).

## Building Yourself

Release files you want to build go in [releases](releases). You can
include as many or as few as you wish, since the bootloader will
try each one in sequence until it finds a working checksum.

You will need `mtools` installed and basic Unix utilities in your path.

Type `make` to run the Makefile and construct a new file in `output`.

# Hardware Supported

- COLDCARD Mk4
- COLDCARD Q


