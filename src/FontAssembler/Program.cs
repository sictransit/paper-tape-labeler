﻿using FontAssembler.Extensions;
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

            var digits = glyphs.Where(x => char.IsDigit(x.Character)).ToArray();
            var letters = glyphs.Where(x => char.IsLetter(x.Character)).ToArray();
            var symbols = glyphs.Except(digits).Except(letters).ToArray();

            var glyphTable = glyphs.Select(Pack).SelectMany(x => x);
            var lookup = CreateLookup(glyphs);

            var code = File.ReadAllLines(asmFile).Reverse().SkipWhile(x => !x.Contains("BEWARE!")).Reverse();

            var asm = new List<string>();

            asm.AddRange(code);

            void Locate(int address)
            {
                asm.Add(string.Empty);
                asm.Add($"\t*{address}");
                asm.Add(string.Empty);
            }

            Locate(300);
            asm.AddRange(digits.Select(Pack).SelectMany(x => x));

            Locate(400);
            asm.AddRange(letters.Select(Pack).SelectMany(x => x));

            Locate(500);
            asm.AddRange(symbols.Select(Pack).SelectMany(x => x));

            Locate(600);
            asm.AddRange(lookup);

            asm.Add(string.Empty);
            asm.Add("$");

            File.WriteAllLines(asmFile, asm);
        }

        private static IEnumerable<string> CreateLookup(Glyph[] glyphs)
        {
            for (var c = 32; c < 96; c++)
            {
                var glyph = glyphs.Single(x => x.Character == (char)c);

                var label = c == 32 ? "LOOKUP," : "       ";

                yield return $"{label}\t{glyph.Label}";
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

            var definition = glyph.Definition.ToList();

            definition[^1] |= 0b_0000_0100;
            if (definition.Count % 2 != 0)
            {
                definition.Add(0);
            }

            for (var i = 0; i < definition.Count; i++)
            {
                var def = definition[i];

                if (i % 2 == 0)
                {
                    word |= (def & 0b_1111_1100) << 4;
                }
                else
                {
                    word |= (def & 0b_1111_1100) >> 2;

                    var line = lines.Count == 0
                        ? $"{glyph.Label},{new string(' ', 6 - glyph.Label.Length)}\t{word.ToOctalString()}"
                        : $"      \t{word.ToOctalString()}";

                    lines.Add(line);

                    word = 0;
                }
            }

            return lines;
        }

    }
}
