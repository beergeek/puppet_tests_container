#!/bin/bash
# For Alpine Linux
# GREP returns exit code 0 if line found and 1 for no line found

shopt -s globstar
out=0

for f in site/profile/**/**.pp; do
   [[ $f =~ plans/ ]] && continue

   if ! grep "^\s*create_resources" "$f"; then
      echo "SUCCESS: $f"
   else
      echo "FAILED: $f"
      failures_secruity+=("$f")
   fi

   if ! egrep "^.*file\s*\(.*\)" "$f"; then
      echo "SUCCESS: $f"
   else
      echo "FAILED: $f"
      failures_security+=("$f")
   fi
done

for f in site/role/**/**.pp; do
   [[ $f =~ plans/ ]] && continue

   if ! grep "^\s*create_resources" "$f"; then
      echo "SUCCESS: $f"
   else
      echo "FAILED: $f"
      failures_security+=("$f")
   fi

   if ! egrep "^.*file\s*\(.*\)" "$f"; then
      echo "SUCCESS: $f"
   else
      echo "FAILED: $f"
      failures_security+=("$f")
   fi
done

if (( ${#failures_security[@]} > 0 )); then
   echo "Security validation on the Control Repo has failed in the following manifests:"
   echo -e "\t ${failures_security[@]}"
   exit 1
else
   echo "Syntax validation on the Control Repo has succeeded."
   exit 0
fi
