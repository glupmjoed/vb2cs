using System;
using ICSharpCode.CodeConverter;

namespace CodeConverterCLI
{
    class CLI
    {
        static void Main(string[] args)
        {
			var result = CodeConverter.Convert(
				new CodeWithOptions(Console.In.ReadToEnd())
				.WithDefaultReferences()
				.SetFromLanguage("Visual Basic", 14)
				.SetToLanguage("C#", 6));

			if (result.Success) {
				Console.WriteLine(result.ConvertedCode);
			} else {
				Console.Error.WriteLine("Error:");
				Console.Error.WriteLine(result.GetExceptionsAsString());
			}
        }
    }
}
