#!/bin/bash

set -eu

arch=${1:-32}

getUrl() {
	curl -sL "http://vim-jp.org/redirects/koron/vim-kaoriya/latest/win${arch}/" |
		grep location |
		sed -r 's/.*"(.*)".*/\1/'
}

url=$(getUrl)

echo "Download ${url} ..."

curl -L -O $url
