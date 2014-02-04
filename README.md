resymbolicate
=============

Bash shell script to simplyfy resymbolication of chunk of iOS crash log files. To correct working of script you have to place in the same directory correct .app and .dSYM files and of course .crash files.

Script take as parameter
	-h prints help
	-? prints help
	-d [PATH_TO_DIR_WITH_CRASH_FILES]
	-v verbose mode
	
Output of script are files store in [PATH_TO_DIR_WITH_CRASH_FILES] named 'resymbolicated_XY.crash' where XY is number of crash log file.
