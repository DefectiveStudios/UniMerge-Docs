///Matt Schoen
///5-29-2013
///
///In the absence of a legitimate license (that I know of) that fits my needs, here goes:  This software is the 
///copyrighted material of its author, Matt Schoen, and his comapny Defective Studios.  It is available for sale on 
///the Unity Asset store and is subject to their restrictions and limitations, as well as the following: You shall not
///reproduce or re-distribute this software with the express written (e-mail is fine) permission of the author. If 
///permission is granted, the code (this file and related files) must bear this license in its entirety.  Anyone who 
///purchases the script is welcome to modify end re-use the code at their personal risk and under the condition that 
///it not be included in any disribution builds.  The software is provided as-is without warranty and the author bears 
///no responsiblity for damages or losses caused by the software.  Enjoy it, it's yours, but just don't try to profit 
///from it, OK?

var objArgs,num,sBaseDoc,sMergedDoc,sTheirDoc,sMyDoc,objShell

objArgs = WScript.Arguments;
num = objArgs.length;
if (num < 4)
{
    WScript.Echo("Usage: [CScript | WScript] merge-doc.js merged.doc theirs.doc mine.doc base.doc");
    WScript.Quit(1);
}

sMergedDoc = objArgs(0);
sTheirDoc = objArgs(1);
sMyDoc = objArgs(2);
sBaseDoc = objArgs(3);

// Thanks to http://crimsonshift.com/scripting-check-if-process-or-program-is-running-and-start-it/
var strComputer = ".";
var objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\\\" + strComputer + "\\root\\cimv2");
var colProcesses = objWMIService.ExecQuery("Select * from Win32_Process Where Name = 'unity.exe'");
if(colProcesses.Count > 0){
	var FSObj = new ActiveXObject("Scripting.FileSystemObject");
	var FileObj = FSObj.CreateTextFile(".\\Assets\\merges.txt");
	// var tst = {"one": 1};
	// WScript.Echo(tst.toString());
	// if(!this.JSON){
		// WScript.Echo("Blah");
	// }
	// FileObj.WriteLine(JSON.stringify(merges));
	FileObj.WriteLine(sMyDoc);
	FileObj.WriteLine(sTheirDoc);
	
	FileObj.Close();
	
} else {
	objShell = WScript.CreateObject ("WScript.shell");
	objShell.Run("\"C:\\Program Files (x86)\\Unity\\Editor\\Unity.exe\" -executeMethod SceneMerge.CLIIn \"" + sMyDoc + "\" \"" + sTheirDoc + "\"");
	objShell = null;
}