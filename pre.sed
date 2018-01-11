#!/bin/sed -Ef

# Remove byte order mark:

1 s/^\xef\xbb\xbf//

# Remove trailing carriage returns:

s/\r$//

# The rewrite rule below is part of an attempt at fixing the CodeConverter
# library's handling of one-dimensional array declarations in VB.NET.
#
# We rewrite the statement
#     Dim <ARRAY>(<UPPER>) As <TYPE>
# to
#     Dim <ARRAY>__<UPPER> As <TYPE>() = New <TYPE>() {}
# and transform the generated C# code further at a later stage (see post.sed)

s/Dim (\w+)\((\w+)\) [aA]s (\w+)$/Dim \1__\2 As \3() = New \3() {}/g
