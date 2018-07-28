#!/bin/bash

out=0
echo 'Checking Puppetfile ...'
/bin/bash /root/puppetfile.sh
if [ $? -ne 0 ]; then
  out=`expr $out + 1`
  echo 'Puppetfile tests failed'
fi
echo 'Checking Hiera ...'
/usr/bin/ruby /root/check_hiera.rb
if [ $? -ne 0 ]; then
  out=`expr $out + 1`
  echo 'Hiera tests failed!'
fi
echo 'Checking security ...'
/bin/bash /root/evil.sh
if [ $? -ne 0 ]; then
  out=`expr $out + 1`
  echo 'Security tests failed!'
fi
echo 'Linting ...'
/bin/bash /root/lint.sh
if [ $? -ne 0 ]; then
  out=`expr $out + 1`
  echo 'Lint tests failed!'
fi
echo 'Starting onceover tests ...'
/usr/bin/onceover run spec
if [ $? -ne 0 ]; then
  out=`expr $out + 1`
  echo 'Onceover tests failed!'
fi
if [ $out -gt 0 ]; then
  echo 'Tests failed!'
  exit 1
else
  echo 'Tests Passed!'
  exit 0
fi
