#!/bin/bash
CHROME_BIN=$(which google-chrome)
CHROMIUM_BIN=$(which chromium-browser)

if [ "$1" != "" ]; then
    URL_TO_OPEN=$1;
else
    echo -e "An URL is required"
fi

if [ -f $CHROME_BIN ] ;then
	BROWSER_BIN=$CHROME_BIN
elif [ -f $CHROMIUM_BIN ] ; then
	BROWSER_BIN=$CHROMIUM_BIN
else
	echo -e "You have neither Chrome nor Chromium."
	exit
fi

$BROWSER_BIN --start-maximized --app="data:text/html,<html><body><script>window.location='$URL_TO_OPEN';</script></body></html>"
