#!/bin/bash 

function PrintHelp
{
	echo " + ----- SYMBOLICATION iOS CRASH LOGS ----- +"
	echo " + -h prints this help                      +"
	echo " + -v verbose mode                          +"
	echo " + -d [PATH_TO_DIR] symbolicate crashlogs   +"
	echo " +                  in folder. Folder have  +"
	echo " +                  to contain crash logs,  +"
	echo " +                  .dSYM file and .app     +"
	echo " +                  binary                  +"
	echo " + ---------------------------------------- +"
}


function SymbolicateRoutine
{
	verbose=$1
	path="$2"
	
	app_found=0
	dSYM_found=0
	crash_found=0
	
	app_path=()
	dSYM_path=()
	crash_path=()
	
	if [ -d "$path" ] ; then
		for app in $(find "$path" -name "*.app" -mindepth 1 -maxdepth 1 -type d) ; do
		    #echo $app
			app_path[$app_found]=$app
			((app_found++))
		done
		
		for dSYM in $(find "$path" -name "*.dSYM" -mindepth 1 -maxdepth 1 -type d) ; do
			#echo $dSYM
			dSYM_path[dSYM_found]=$dSYN
			((dSYM_found++))
		done
		
		for crash_log in $(find "$path" -name "*.crash" -mindepth 1 -maxdepth 1 -type f) ; do
			#echo $crash_log
			crash_path[$crash_found]=$crash_log
			((crash_found++))
		done
		
		if [ $app_found -lt 1 ] ; then
			echo "Error, .app package not found in source directory '$path'"
			exit 0
		elif [ $dSYM_found -lt 1 ] ; then
			echo "Error, .dSYM package not found in source directory '$path'"
			exit 0
		elif [ 	$crash_found -lt 1 ] ; then
			echo "Error, .crash file not found in source directory '$path'"
			exit 0
		fi
		
		SetDeveloperDirectory
		
		i=0
		xcode_symbolication_script_path=$(find "/Applications/Xcode.app" -name symbolicatecrash -type f)
		resymbolicated="resymbolicated_"
		crash=".crash"
		for crash_p in ${crash_path[*]} ; do
			resymb_path=$path$resymbolicated$i$crash
			
			if [ $verbose -eq 1 ] ; then
				"$xcode_symbolication_script_path" -v -o $resymb_path $crash_p $dSYM_path[0] > /dev/null
			else	
				"$xcode_symbolication_script_path" -o $resymb_path $crash_p $dSYM_path[0] > /dev/null
			fi
			((i++))
		done
	else
		echo "'$path' is not a directory"
		echo ""
		PrintHelp
		exit 0
	fi
}

function SetDeveloperDirectory
{
	dev_dir_already_set=${#DEVELOPER_DIR}
	if [ $dev_dir_already_set -eq 0 ] ; then
		export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"
	fi
}

# ---- RUN ROUTINE ---- #
verbose=0
dir_path=""

while getopts "h?vd:" opt; do
    case "$opt" in
	    h|\?)
			PrintHelp
			exit 0
		    ;;

	    v)  
			verbose=1
			;;
		
		d)
			dir_path="$OPTARG"
			;;
    esac
done

SymbolicateRoutine $verbose "$dir_path"