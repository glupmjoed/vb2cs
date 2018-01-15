#!/bin/bash

BNAME=CodeConverterCLI

# Parse flags
while getopts ":b:r" opt; do
    case ${opt} in
        b ) CCCLI=$OPTARG ;;
        r ) rflag=1 ;;
        \? ) echo "Usage: $0 [-b FILE] [-r]" 1>&2
             exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# Locate CodeConverterCLI binary
if [ -z $CCCLI ]
then
    CCCLI=$(find $BNAME/bin/Debug/ |grep "$BNAME\$" | head -1)

    # Exit if the binary wasn't found
    if [ -z $CCCLI ]
    then
        echo "Couldn't find command $BNAME" 1>&2
        exit 1
    fi
fi

if [ $1 ]; then ./pre.sed $1; else ./pre.sed; fi |

    $CCCLI |

    # Postprocess generated code. Change newlines to \r\n if -r flag is set
    if [ $rflag ]; then ./post.sed | sed 's/$/\r/g'; else ./post.sed; fi
