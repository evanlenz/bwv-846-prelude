# An experiment in musical transformations

This little project is an attempt to automate some analysis I was doing of Bach's
[Prelude in C Major (BWV 846)](https://musescore.com/martindeboer/preludebach)
by transforming a MusicXML representation of the piece into separate summary documents,
each of which is itself a MusicXML file.

These musical transformations represent a simple *ad hoc* example of the kinds of
automated transformations I am interested in exploring for purposes of progressively
teaching a piece of music to a piano student (such as myself). For example, a practice
plan could exist entirely of extractions from a piece of music and put in order.

This particular analysis takes advantage of the Prelude's simple structure: a series of
broken chords, each repeated in its measure. Each chord consists of five notes. The bass
line is probably the most important, but the resulting analysis extracts all five "lines"
as if they were separate voices. Each roughly corresponds to a finger, generally two
fingers of the left hand (bass clef) and three of the right hand (treble clef).

I use [MuseScore](https://musescore.org) to aurally render the resulting summaries
so I can get each of them into my ear for purposes of grokking the musical information.

In addition, after generating the individual "voice" summaries, I combine them into a
chord summary, which consists simply of the unbroken chords, one per measure (an obvious
way to practice the piece). Thus a total of six summaries are generated, each of which
can be opened and listened to in MuseScore (or presumably any other MusicXML reader).

## How it works
The XSLT code for each transformation is quite small. The rules for stripping out notes
(and turning all the preserved notes into whole notes) are in [common.xsl](xsl/common.xsl),
whereas the rules for selectively preserving some notes for the treble and bass summaries are
in [treble-summary.xsl](xsl/treble-summary.xsl) and [bass-summary.xsl](xsl/bass-summary.xsl),
respectively. Finally, [chord-summary.xsl](xsl/chord-summary.xsl) combines the results of the
other summaries.

## Generating the results
To generate the results, invoke run.sh or run.bat after putting the
[Saxon-HE](https://sourceforge.net/projects/saxon/files/Saxon-HE/10/Java/) jar file in
your CLASSPATH environment variable. The results will appear in an "output" subdirectory.
