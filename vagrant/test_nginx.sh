#!/bin/bash

# Test we get a 200 repsonse from localhost:80
curl -vs -o /dev/null http://localhost:80 2>&1 | grep '< HTTP' | grep '200 OK' > /dev/null
if [ $? -eq 0 ]; then
  echo "Got a 200 response from localhost:80"
else
  echo "Did not get a 200 response from localhost:80"
  exit 1
fi

# Test that the server responding on localhost:80 is Nginx
curl -vs -o /dev/null http://localhost:80 2>&1 | grep '< Server:' | grep 'nginx' > /dev/null
if [ $? -eq 0 ]; then
  echo "Got 'nginx' in the Server response header"
else
  echo "Did not get 'nginx' in the Server response header"
  exit 2
fi
