using FontAssembler.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FontAssembler
{
    internal class Glyph
    {
        public Glyph(char c, string label, int[] definition)
        {
            Character = c;
            Label = label;
            Definition = definition.Length % 2 == 0 ? definition : definition.Concat(new[] { 0 }).ToArray();
        }

        public char Character { get; set; }

        public string Label { get; set; }

        public int[] Definition { get; set; }

        public override string ToString()
        {
            return $"{Character}: {Label} {string.Join(',', Definition)}";
        }
    }
}
