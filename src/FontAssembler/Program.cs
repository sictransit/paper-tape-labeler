using FontAssembler.Extensions;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace FontAssembler
{
    public static class Program
    {
        public static void Main()
        {
            const string asmFile = @"../../../asm/glyphs.asm";
            const string fontFile = @"font/dec_5_bit.txt";

            if (!File.Exists(asmFile))
            {
                throw new FileNotFoundException(asmFile);
            }

            if (!File.Exists(fontFile))
            {
                throw new FileNotFoundException(fontFile);
            }

            var lines = File.ReadAllLines(fontFile);

            var glyphs = lines.Select(x => ParseLine(x)).OrderBy(x => (int)x.Character).ToArray();

            var code = File.ReadAllLines(asmFile).Reverse().SkipWhile(x => !x.Contains("BEWARE!")).Reverse();

            var asm = new List<string>();

            asm.AddRange(code);
            asm.Add(string.Empty);
            asm.Add("\t*300");
            asm.Add(string.Empty);
            asm.AddRange(glyphs.Select(Pack).SelectMany(x => x).ToArray());
            asm.Add(string.Empty);
            asm.Add("\t*500");
            asm.Add(string.Empty);            
            asm.AddRange(CreateLookup(glyphs));
            asm.Add(string.Empty);
            asm.Add("$");

            File.WriteAllLines(asmFile, asm);
        }

        private static IEnumerable<string> CreateLookup(Glyph[] glyphs)
        {
            const string label = "LOOKUP,";
            const string indent = "       ";

            for (var c = 32; c < 96; c++)
            {
                var glyph = glyphs.Single(x => x.Character == (char)c);

                yield return $"{(c == 32 ? label : indent)}\t{glyph.Label}";
            }            
        }

        private static Glyph ParseLine(string line, char delimiter = '|')
        {
            var parts = line.Split(delimiter, StringSplitOptions.RemoveEmptyEntries);

            if (parts.Length != 3)
            {
                throw new ArgumentOutOfRangeException(nameof(line));
            }

            return new Glyph(
                parts[0].Single(),
                parts[1].Trim(),
                parts[2].Split(',').Select(x => x.ToDecimal()).ToArray()
                );
        }

        private static IEnumerable<string> Pack(Glyph glyph)
        {
            var word = 0;

            var lines = new List<string>();

            for (var i = 0; i < glyph.Definition.Length; i++)
            {
                if (i % 2 == 0)
                {
                    word |= (glyph.Definition[i] & 0b_1111_1100) << 4;
                }
                else
                {
                    word |= (glyph.Definition[i] & 0b_1111_1100) >> 2;

                    var line = lines.Count == 0
                        ? $"{glyph.Label},{new string(' ', 6 - glyph.Label.Length)}\t{word.ToOctalString()}"
                        : $"      \t{word.ToOctalString()}";

                    lines.Add(line);

                    word = 0;
                }
            }

            if (glyph.Character == '8')
            {
                lines.Add("\t*400");
            }


            return lines;
        }

    }
}
