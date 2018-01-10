#!/bin/sed -Ef

# remove byte order mark
1 s/^\xef\xbb\xbf//
