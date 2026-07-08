#!/bin/bash
# Определить список оболочек в системе

echo '--cat /etc/shells--'
cat /etc/shells

echo '--ls -l /bin/bash--'
ls -l /bin/bash

echo '--readlink -e /bin/bash--'
readlink -e /bin/bash

echo '--type type--'
type type

echo '--type dmesg--'
type dmesg

echo '--type ls--'
type ls

echo '--type -a test--'
type -a test