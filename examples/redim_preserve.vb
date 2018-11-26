Imports System

Class Foo
    Shared Sub Main()
        Dim x(9) as String
        Dim y as String() = x

        Redim Preserve x(19)
        Console.WriteLine(x.Length)
        Console.WriteLine(y.Length)
    End Sub
End Class
