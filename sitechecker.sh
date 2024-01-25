#!/bin/bash

sleep 2

echo "Enter the website URL: "
read url

sleep 2

echo "Checking availability and response time for $url..."

# Measure response time with curl
response_time=$(curl -s -o /dev/null -w "%{time_total}" $url)

if [ $? -eq 0 ]; then
    echo "Website is reachable. Response time: ${response_time}s"

sleep 1
echo "Performing additional checks:"
sleep 3

    if curl --output /dev/null --silent --head --fail -I "$url" | grep -i "https"; then
        echo "HTTPS is supported."
    else
        echo "HTTPS is not supported."
    fi

sleep 3

    redirected_url=$(curl -s -o /dev/null -w "%{url_effective}" $url)
    if [ "$redirected_url" != "$url" ]; then
        echo "The website is redirected to: $redirected_url"
    fi
else
    echo "Website is unreachable."
fi
