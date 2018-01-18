#!/bin/bash

# This file contains a sed script for translating commonly used VB functions
# that aren't handled by the CodeConverter library.

# Translation variables for the "My" namespace:

CREAT_DIR_I="My.Computer.FileSystem.CreateDirectory"
CREAT_DIR_O="System.IO.Directory.CreateDirectory"

DEL_FILE_I="My.Computer.FileSystem.DeleteFile"
DEL_FILE_O="System.IO.File.Delete"

DIR_PATH_I="My.Application.Info.DirectoryPath"
DIR_PATH_O="Assembly.GetExecutingAssembly().Location"

FILE_EXISTS_I="My.Computer.FileSystem.FileExists"
FILE_EXISTS_O="System.IO.File.Exists"

sed -E "
s/\b$CREAT_DIR_I\b/$CREAT_DIR_O/g
s/\b$DEL_FILE_I\b/$DEL_FILE_O/g
s/\b$DIR_PATH_I\b/$DIR_PATH_O/g
s/\b$FILE_EXISTS_I\b/$FILE_EXISTS_O/g
"
