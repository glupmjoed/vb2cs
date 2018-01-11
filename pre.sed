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

s/\bDim (\w+)\((\w+)\) [aA]s (\w+)$/Dim \1__\2 As \3() = New \3() {}/g

# The rewrite rule below is an attempt at implementing code conversion for the
# ReDim statement (which is not supported by the CodeConverter library). For
# now, the workaround only targets one-dimensional arrays.
#
# We rewrite the statement
#     ReDim <ARRAY>(<UPPER>)
# to
#     System.Array.Resize(ref <ARRAY>, <UPPER>+1)
#     System.Array.Clear(<ARRAY>, 0, <ARRAY>.Length)

s/([\t ]*)Re[dD]im (\w+)\((\w+)\)$/\1System.Array.Resize(ref \2, \3+1)\
\1System.Array.Clear(\2, 0, \2.Length)/g
