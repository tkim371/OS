#!bin/bash

qemu-system-i386 -L . -boot c -m 256 -hda $1 -soundhw all -localtime -M pc
