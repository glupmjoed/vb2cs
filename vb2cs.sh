#!/bin/bash

BNAME=CodeConverterCLI

# Parse flags
while getopts ":b:pr" opt; do
    case ${opt} in
        b ) CCCLI=$OPTARG ;;
        p ) pflag=1 ;;
        r ) rflag=1 ;;
        \? ) echo "Usage: $0 [-b FILE] [-r]" 1>&2
             exit 1 ;;
    esac
done
shift $((OPTIND - 1))

# Locate CodeConverterCLI binary
if [ -z $CCCLI ]
then
    # Search for a code converter binary with the right name in a subfolder
    # where C# toolchain builds are typically found
    CCCLI=$(find $BNAME/bin/Debug/ |grep "$BNAME\$" | head -1)

    # Exit if the binary wasn't found
    if [ -z $CCCLI ]
    then
        echo "Couldn't find command $BNAME" 1>&2
        exit 1
    fi
fi

# Apply preprocessing script to either stdin or a file name, depending on $1
if [ $1 ]; then ./pre.sed $1; else ./pre.sed; fi |

    # Pipe preprocessed code to main binary
    $CCCLI |

    # Postprocess generated code. Change newlines to \r\n if -r flag is set
    if [ $rflag ]; then ./post.sed | sed 's/$/\r/g'; else ./post.sed; fi |

    if [ $pflag ]; then cat; else ./func_conv.sh; fi
