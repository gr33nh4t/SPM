#!/bin/bash

SPM_HOME="$HOME/spm"
BIN_DIR="$SPM_HOME/bin"
SRC_DIR="$SPM_HOME/src"
DB_DIR="$SPM_HOME/db"
LOCAL_BIN="$HOME/.local/bin"
JSON_FILE="$SPM_HOME/packages.json"


# Functions
spm_install(){
	local pkg_name="$1"

	cd "$SRC_DIR"
	local pkg_url=$(grep "github" "$JSON_FILE"| grep "$pkg_name.git" | sed 's/"repo" : " / / ; s/", //')

}

spm_query(){
	# taking info from JSON file 
	local pkg_name="$2"
	local details=$(grep -A 3 "\"$pkg_name\"" "$JSON_FILE")
	local version=$(grep "version" "$details" | sed 's/"version": "//; s/".//') 
	local desc=$(grep "desc" "$details" | sed 's/"version": "//; s/".//')

	# Displaying the details
	printf "[-] %s  - %s | %s\n" "$pkg_name" "$version" "$desc"

}

	
	






case "$1" in 
	install|i)
		spm_install "$2"
		;;
	query|q)
		spm_query "$2"
		;;
	remove|r|delete|d)
		spm_remove "$2"
		;;
	*)
		echo "USE: spm (install\i) or (query\q) or (remove\delete\r\d)"
		;;
	esac	
	

