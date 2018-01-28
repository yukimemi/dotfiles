#!/bin/bash

set -eu

arch=${1:-32}
url="https://github.com/git-for-windows/git/releases"

getUrl() {
	curl -L ${url} | grep href | grep windows.1 | grep -i portable | grep -v rc |
		grep ${arch} |
		sed -r 's@.*href="([^"]*)".*@https://github.com\1@'
}

url=$(getUrl)

echo "Download ${url} ..."

curl -L -O $url
