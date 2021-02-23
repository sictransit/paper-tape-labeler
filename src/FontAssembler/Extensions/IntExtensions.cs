using System;

namespace FontAssembler.Extensions
{
    public static class IntExtensions
    {
        public static int ToDecimal(this string hex)
        {
            return Convert.ToInt32(hex, 16);
        }

        public static int ToOctal(this int dec)
        {
            return dec == 0 ? 0 : dec % 8 + 10 * (dec / 8).ToOctal();
        }

        public static string ToOctalString(this int dec, int digits = 4)
        {
            return dec.ToOctal().ToString($"d{digits}");
        }
    }
}
