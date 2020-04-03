# Welcome to ChartMaker

ChartMaker transforms  MusicXML files exported from   [iReal Pro](https://irealpro.com) into nicely formatted braille chord charts known as JAM Braille. The system adds notation to the minimal guidance found in the [BANA braille music standards](http://www.brailleauthority.org/music/music.html) to make braille chord charts intuitive, compact, and easy to read. JAM Braille  is designed specifically to work with MusicXML files exported from iReal Pro and is unlikely to work properly with other musicXML files.
The [iReal Pro iOS app](https://apps.apple.com/us/app/ireal-pro/id298206806) is reasonably usable with VoiceOver. You need to buy the app in order to use ChartMaker.

## Downloading and Using ChartMaker
ChartMaker is a Windows-based stopgap utility for converting MusicXML into JAM Braille. It is far from ideal, but is intended to make it relatively straight forward for motivated blind musicians to easily produce braille chord charts from iReal Pro MusicXML files.
To install ChartMaker, download the ChartMaker ZIP file, unzip it, and put the ChartMaker folder in a convenient location on your Windows machine -- it doesn't need to be in any special location to work.
To make beautiful braille chord charts  with ChartMaker follow these steps:
1. Using the iReal Pro app, open any song and select Share. Select the "Export as XML" option and use email, dropbox, or some other method to get the XML file onto your Windows machine. Save   it in the XMLCharts directory of the ChartMaker folder.
1. You can repeat the previous step as many times as you want -- ChartMaker can convert one or more  MusicXML files in a single shot.
1. When you are ready to make your JAM Braille chord charts, select the MakeCharts.bat file in the ChartMaker folder and press return. After a few seconds (more if you are converting a lot of files at once) you will find your  new HTM files in the HTMCharts directory of the ChartMaker folder. 

## Displaying or Embossing JAM Braille
JAM Braille  HTM files  can be viewed using a refreshable braille display or embossed. To view with a braille display, open the HTM file in your browser of choice and make sure your screen reader has translation turned off and that you are using 6-dot computer braille. 

The easiest way to emboss the JAM Braille chord charts is with a [ViewPlus](https://viewplus.com) embosser. Simply open the HTM file in your browser of choice and use the print command. Make sure your ViewPlus embosser is selected and press OK. 

For other embossers, it is best to use the [Duxbury Braille Translator](http://www.duxburysystems.com). The HTM files can be imported directly into Duxbury and should have their formatting preserved. From there you can use the command to tell Duxbury  to format only (do not translate), then translate the file and emboss it.

## Reading JAM Braille 
JAM Braille builds on BANA's guidelines for chord charts, but incorporates other sensible patterns from Braille Music, literary braille, and Nemeth code. It uses formatting to enhance readability	 and prioritizes clarity and ease of use. Where text appears, such as in titles and composers, uncontracted English braille is used.

### Chord Roots
The root of each chord is written using capital literary letters. For example, a C chord is written as a dot 6 followed by dots 14. Although this is different from standard braille music score notation, it is in keeping with the braille music standards for writing chord charts. 

### Chord Duration
As in standard braille music, combinations of dots 3 and 6 below the note are used to indicate chord duration. The JAM Braille code is slightly different from that of braille music in order to improve clarity, but context  makes note durations quite clear. In JAM Braille, whole notes have no extra dots, while half notes, quarter notes, and eighth notes have dots 3, 6, and 36 respectively. In other words, a whole note C chord is dot 6 followed by dots 14, a half note C chord is dot 6 followed by dots 134, a quarter note C chord is dot 6 followed by dots 136, and an eighth note C chord is dot 6 followed by dots 1346. 
A dot 3 immediately following any chord designation indicates a dotted chord (the duration is extended by 50%). 

### Chord Types and Bass Notes
Lower-case letters and dropped numbers following a chord root indicate chord type. The letter m indicates minor, maj = major, dim = diminished, aug = augmented, dom = dominant, sus = suspended, etc. As in braille music, flats and sharps are indicated by dots 126 and dots 146 respectively. Dropped numbers indicate notes in the scale to be included. For example, a whole note C major 7 flat 5 chord is written as dot 6 followed by dots 14 (the C chord), followed by the letters maj (major), followed by dots 2356 (a dropped number 7), followed by dots 126 (flat), followed by dots 26 (a dropped number 5).
When a chord specifies a specific bass note to be played, the chord is followed by a slash (dots 34)then the bass note .

### Measures, Lines, and Sections
Measures are separated by single spaces, and lines are skipped between sections. Lines that are too long to fit on a single braille line are continued on subsequent  indented lines. When this happens, line breaks only happen in between measures.
Note that skipped lines and indentation appear on embossed braille, but not when viewing in a browser with refreshable braille. This is a screen reader/browser issue, not a shortcoming of JAM Braille.

### Chart and Section Titles
The top of each chart includes the title of the piece, the composer, the key, and the time signature. The time signature is consistent with braille music, using a number sign followed by a number in the top of the cell followed by a number in the bottom of the cell. For example, a piece in ¾ time is written as dots 3456 (number sign), followed by dots 14 (number 3 in the top of the cell), followed by dots 256 (number 4 in the bottom of the cell).
Section names are indented 3 spaces from the left margin above the section to which they apply. 
If no section breaks appear in a piece, the format defaults to 8-bar sections for readability. 

### Repeats and Alternate Endings
Repeats and alternate endings are indicated using notation consistent with standard braille music. The beginning of a repeat (dots 126 followed by dots 2356)is placed at the beginning of the first line of the repeat, and is outdented by 3 characters. The end repeat symbol (dots 126 followed by dots 23) is placed after the final measure of the repeated section. 
Alternate endings follow the repeated section and are indented by 5 spaces from the left margin. They begin with a number sign followed by a dropped number 1, 2, etc. to indicate the ending.

## Credits and Contacts
JAM Braille is a collaboration between Josh Miele and Roberto Gonzalez -- two blind musicians who realized in 2018 that they were dissatisfied with their level of access to braille chord charts. We have plans to build a much more convenient cloud-based method for producing JAM Braille charts, but we were urged to offer access to this resource in the meantime. If you or someone you know would like to contribute knowledge or resources to the project, [please get in touch](mailto://jambrl@gmail.com).
If you have feedback or want to report a problem, please [file an issue](https://github.com/JoshMiele/ChartMaker/issues/new/choose).
Thanks  to iReal Pro for making this amazing resource possible.

