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

GET_OBJECT_I="GetObject"
GET_OBJECT_O="Microsoft.VisualBasic.GetObject"

# Translation variables for libraries with ambiguous import paths

XDOC_I="XDocument"
XDOC_O="System.Xml.Linq.XDocument"

XELEM_I="XElement"
XELEM_O="System.Xml.Linq.XElement"

# Replace all occurences of *_I names with *_O:

sed -E "

s/\b$CREAT_DIR_I\b/$CREAT_DIR_O/g
s/\b$DEL_FILE_I\b/$DEL_FILE_O/g
s/\b$DIR_PATH_I\b/$DIR_PATH_O/g
s/\b$FILE_EXISTS_I\b/$FILE_EXISTS_O/g
s/\b$GET_OBJECT_I\b/$GET_OBJECT_O/g

s/\b$XDOC_I\b/$XDOC_O/g
s/\b$XELEM_I\b/$XELEM_O/g

"
