#!/bin/sed -Ef

# Remove carriage returns from generated C# code:

s/\r$//

# The rewrite rule below is part of an attempt at fixing the CodeConverter
# library's handling of one-dimensional array declarations in VB.NET.
#
# We rewrite generated C# code of the form
#
#     <TYPE>[] <ARRAY>__<UPPER> = new <TYPE>[];
#
# to
#
#     <TYPE>[] <ARRAY> = new <TYPE>[<UPPER> + 1];
#
# as the second and final stage of the workaround (see also pre.sed)

s/\b(\w+)\[\] (\w+)__(\w+) = new \1\[\];$/\1[] \2 = new \1[\3 + 1];/g
