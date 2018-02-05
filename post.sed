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

# The rewrite rule below is part of an attempt at notifying the consumer of the
# generated code that the VB-specific "Handles" keyword has been removed by the
# CodeConverter library.
#
# We rewrite statements of the form
#
#     <...> <FUNCTION_PREFIX>__HDL_<OBJECT>__<EVENT>(...<EVENTTYPE>EventArgs...)
#
# to
#
#     // TODO (vb2cs):
#     //
#     // Prior to code conversion, the following function used the VB-specific
#     // Handles keyword to handle the event "<OBJECT>.<EVENT>".
#     // Try adding the following line in this class' constructor (or elsewhere)
#     // to make sure the event is still handled correctly:
#     //
#     // <OBJECT>.<EVENT> += <EVENTTYPE>EventHandler(<FUNCTION_PREFIX>)
#     //
#     <...> <FUNCTION_PREFIX>(...<EVENTTYPE>EventArgs...)
#
# as the second and final stage of the workaround (see also pre.sed)

s/([ \t]*)(.*)(\b\w+)__HDL_(\w+)__(\w+)(\(.*)(\b\w*)(EventArgs \w+\))/\
\1\/\/ TODO (vb2cs):\
\1\/\/\
\1\/\/ Prior to code conversion, the following function used the VB-specific\
\1\/\/ Handles keyword to handle the event "\4.\5".\
\1\/\/ Try adding the following line in this class' constructor (or elsewhere)\
\1\/\/ to make sure the event is still handled correctly:\
\1\/\/\
\1\/\/ \4.\5 += \7EventHandler(\3)\
\1\/\/\
\1\2\3\6\7\8/g
