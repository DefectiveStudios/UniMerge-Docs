#!/bin/sh
#
#
#  Copyright [2014] [Prateek Gupte]
# 
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#
# Paste this file in the root Folder and make sure Assets Folder is also available in the Root Folder
#
# <Local .git folder>/config needs a custom git driver
#[merge "unity"]
#	name = Unity merge
#	driver = ../merge-unity.sh %A %B 
#
#


#Check number of arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: [ShellScript] mine.doc theirs.doc"
  exit 1
fi

sMyDoc=$1
sTheirDoc=$2

# Absolute path to this script, e.g. /home/user/bin/foo.sh
Script=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
ScriptPath=$(dirname "$Script")
ProjectPath="${ScriptPath}/../"


#If my doc is not in project path, copy to project
if ["$sMyDoc" != "$ProjectPath*"]; then
	if[-f "$sMyDoc"]; then
		IFS='/' read -a sourceArray <<< "$sMyDoc"
		if [-f "$ProjectPath${sourceArray[-1]}"]; then
			echo "Cannot copy  $sMyDoc  to  $ProjectPath ${sourceArray[-1]}  because the destination file exists."
		else
			mv "$sMyDoc" "$ProjectPath${sourceArray[-1]}"
		fi
	fi
fi


#If their doc is not in project path, copy to project
if ["$sTheirDoc" != "$ProjectPath*"]; then
	if[-f "$sTheirDoc"]; then
		IFS='/' read -a sourceArray <<< "$sTheirDoc"
		if [-f "$ProjectPath${sourceArray[-1]}"]; then
			echo "Cannot copy  $sTheirDoc  to  $ProjectPath ${sourceArray[-1]}  because the destination file exists."
		else
			mv "$sTheirDoc" "$ProjectPath${sourceArray[-1]}"
		fi
	fi
fi

PROCESSNAME="Unity"

#Check if Unity is Running

#Todo launch Unity and SceneMerge tool if Unity is not running
case "$(ps aux | grep $PROCESSNAME | wc -l)" in

0)  echo "Unity is not Running"
    ;;
*)  echo "Unity is Running"
    ;;

esac

echo "$sMyDoc\n$sTheirDoc" > ..//Assets//merges.txt