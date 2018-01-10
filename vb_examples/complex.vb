Imports System.Console

Module Program

    Sub Main()
        Dim rows As Integer

        ' Input validation.
        Do Until Integer.TryParse(ReadLine("Enter a value for how many rows to be displayed: "), rows) AndAlso rows >= 1
            WriteLine("Allowed range is 1 and {0}", Integer.MaxValue)
        Loop

        ' Output of Floyd's Triangle
        Dim current = 1

        For row = 1 To rows
            For column = 1 To row
                Write("{0,-2} ", current)
                current += 1
            Next

            WriteLine()
        Next
    End Sub

    ''' <summary>
    ''' Shadows Console.ReadLine with a version which takes a prompt string.
    ''' </summary>
    Function ReadLine(Optional prompt As String = Nothing) As String
        If prompt IsNot Nothing Then
            Write(prompt)
        End If

        Return Console.ReadLine()
    End Function

End Module
