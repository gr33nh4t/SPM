#!/bin/bash

SPM_HOME="$HOME/SPM"
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
	local pkg_name="$1"
	local details=$(grep -A 3 "\"$pkg_name\"" "$JSON_FILE")
	# Make every thing before version: a group and catch after it only, to avoid beginner indenation
	local version=$(grep "version" <<< "$details" | sed -E 's/[^0-9]+//g') #take only the numbers of the version???
	local desc=$(grep "desc" <<< "$details" | sed  's/(*"desc": ")//; s/"//')

	# Displaying the details
	printf "[-] %s - %s | %s\n" "$pkg_name" "$version" "$desc"
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
	

