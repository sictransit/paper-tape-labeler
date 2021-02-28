using System.Linq;

namespace FontAssembler
{
    internal class Glyph
    {
        public Glyph(char c, string label, int[] definition)
        {
            Character = c;
            Label = label;
            Definition = definition;
        }

        public char Character { get; }

        public string Label { get; }

        public int[] Definition { get; }

        public override string ToString()
        {
            return $"{Character}: {Label} {string.Join(',', Definition)}";
        }
    }
}
