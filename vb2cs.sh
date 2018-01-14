#!/bin/bash

cli=$(find CodeConverterCLI/bin/Debug/ | grep 'CodeConverterCLI$' | head -1)

# Parse flags
while getopts ":r" opt; do
    case ${opt} in
        r ) rflag=1 ;;
        \? ) echo "Usage: $0 [-r]" ;;
    esac
done
shift $((OPTIND - 1))

if [ $1 ]; then ./pre.sed $1; else ./pre.sed; fi |

    ./$cli |

    # Postprocess generated code. Change newlines to \r\n if -r flag is set
    if [ $rflag ]; then ./post.sed | sed 's/$/\r/g'; else ./post.sed; fi
