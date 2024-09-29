#!/bin/bash

nativefier --name "Twitter" --icon icon.png --width 1200 --height 800 --user-agent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.114 Safari/537.36" --external-links --disable-old-build-warning-yesiknowitisinsecure --ignore-certificate --ignore-gpu-blacklist --enable-es3-apis --single-instance --enable-notifications --notification-polling-interval 30 --counter --counter-path ".notification-indicator .notification-count" "https://twitter.com"
