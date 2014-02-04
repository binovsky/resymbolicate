<h1>resymbolicate</h1>
=============

<p>
Bash shell script to simplyfy resymbolication of chunk of iOS crash log files. To correct working of script you have to place in the same directory correct .app and .dSYM files and of course .crash files.
</p>

Script take as parameter: <br />
<lu>
	
	-h prints help
	-? prints help
	-d [PATH_TO_DIR_WITH_CRASH_FILES]
	-v verbose mode
<lu>
	
<p>
Output of script are files store in [PATH_TO_DIR_WITH_CRASH_FILES] named 'resymbolicated_XY.crash' where XY is number of crash log file.
</p>
