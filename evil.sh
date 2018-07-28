#!/bin/bash
# For Alpine Linux
# GREP returns exit code 0 if line found and 1 for no line found
out=0
grep -r "^\s*create_resources" /var/tmp/site/profile/manifests/
if [ $? -eq 0 ]; then
  out=`expr $out + 1`
  echo "Found 'create_resources' in site/profile/manifests/"
fi
grep -r "^\s*create_resources" /var/tmp/site/role/manifests/
if [ $? -eq 0 ]; then
  out=`expr $out + 1`
  echo "Found 'create_resources' in site/role/manifests/"
fi
egrep -r "^.*file\s*\(.*\)" /var/tmp/site/profile/manifests/
if [ $? -eq 0 ]; then
  out=`expr $out + 1`
  echo "Found 'file' function in site/profile/manifests/"
fi
egrep -r "^.*file\s*\(.*\)" /var/tmp/site/role/manifests/
if [ $? -eq 0 ]; then
  out=`expr $out + 1`
  echo "Found 'file' function in site/role/manifests/"
fi
if [ $out -gt 0 ]; then
  exit 1
else
  echo 'Security tests passed'
  exit 0
fi
