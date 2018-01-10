#!/bin/sed -Ef

# Remove byte order mark:

1 s/^\xef\xbb\xbf//
