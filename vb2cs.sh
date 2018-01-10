#!/bin/bash

cli=$(find CodeConverterCLI/bin/Debug/ | grep 'CodeConverterCLI$' | head -1)

./$cli
