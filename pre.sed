#!/bin/sed -Ef

# Remove byte order mark:

1 s/^\xef\xbb\xbf//

# Remove trailing carriage returns:

s/\r$//

# The rewrite rule below is part of an attempt at fixing the CodeConverter
# library's handling of one-dimensional array declarations in VB.NET.
#
# We rewrite statements of the form
#
#     Dim <ARRAY>(<UPPER>) As <TYPE>
#
# to
#
#     Dim <ARRAY>__<UPPER> As <TYPE>() = New <TYPE>() {}
#
# and transform the generated C# code further at a later stage (see post.sed)

s/\b[dD]im (\w+)\((\w+)\) [aA]s (\w+)$/Dim \1__\2 As \3() = New \3() {}/g

# The rewrite rules below are an attempt at implementing code conversion for the
# ReDim statement (which is not supported by the CodeConverter library). For
# now, the workaround only targets one-dimensional arrays.
#
# ReDim rewrite rule 1:
#
# Rewrite statements of the form
#
#     ReDim <ARRAY>(<UPPER>)
#
# to
#
#     System.Array.Resize(<ARRAY>, <UPPER>+1)
#     System.Array.Clear(<ARRAY>, 0, <ARRAY>.Length)

s/([\t ]*)[rR]e[dD]im (\w+)\((\w+)\)$/\1System.Array.Resize(\2, \3+1)\
\1System.Array.Clear(\2, 0, \2.Length)/g

# ReDim rewrite rule 2:
#
# Rewrite statements of the form
#
#     ReDim Preserve <ARRAY>(<UPPER>)
#
# to
#
#     System.Array.Resize(<ARRAY>, <UPPER>+1)

s/\b[rR]e[dD]im [pP]reserve (\w+)\((\w+)\)$/System.Array.Resize(\1, \2+1)/g

# The rewrite rule below is part of an attempt at notifying the consumer of the
# generated code that the VB-specific "Handles" keyword has been removed by the
# CodeConverter library.
#
# We rewrite statements of the form
#
#     Sub <FUNCTION>(<ARGS>) Handles <OBJECT>.<EVENT>
#
# to
#
#     Sub <FUNCTION>__HDL_<OBJECT>__<EVENT>(<ARGS>)
#
# and transform the generated C# code further at a later stage (see post.sed)

s/\b([sS]ub \w+)(\(.*\)) [hH]andles (\w+)\.(\w+)\b/\1__HDL_\3__\4\2/g
