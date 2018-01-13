#!/bin/bash

cli=$(find CodeConverterCLI/bin/Debug/ | grep 'CodeConverterCLI$' | head -1)

if [ $1 ]; then ./pre.sed $1; else ./pre.sed; fi |

    ./$cli | ./post.sed
