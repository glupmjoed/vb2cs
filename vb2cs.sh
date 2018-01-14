#!/bin/bash

# Parse flags
while getopts ":r" opt; do
    case ${opt} in
        r ) rflag=1 ;;
        \? ) echo "Usage: $0 [-r]" ;;
    esac
done
shift $((OPTIND - 1))

# Locate CodeConverterCLI binary
# Exit if the command wasn't found
CCCLI=$(find CodeConverterCLI/bin/Debug/ | grep 'CodeConverterCLI$' | head -1)
if [ -z $CCCLI ]
then
    echo "Couldn't find command CodeConverterCLI" 1>&2
    exit 1
fi

if [ $1 ]; then ./pre.sed $1; else ./pre.sed; fi |

    ./$CCCLI |

    # Postprocess generated code. Change newlines to \r\n if -r flag is set
    if [ $rflag ]; then ./post.sed | sed 's/$/\r/g'; else ./post.sed; fi
