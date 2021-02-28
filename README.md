# Paper Tape Labeler

This is an attempt to create a paper tape labeler for the PDP-8: 
 * Input: a glyph definition for 5-bit/pixel chars
 * Output: assembler to punch letters on paper tape, given keyboard input

## Demo

All supported letters displayed using [Core8](https://github.com/sictransit/core8) and the built-it SVG image punch.

![Image of Yaktocat](https://github.com/sictransit/paper-tape-labeler/blob/main/src/FontAssembler/demo/label.svg)

# Credit

The DEC 5-bit font was borrowed from [@MattisLind](https://github.com/MattisLind/papertapetext) and adapted to use bit 2 as terminator instead of a zero value. This saved a few precious words of memory and simplified the handling of the whitespace character.
