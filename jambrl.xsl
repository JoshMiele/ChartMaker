<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" version="4.0"
	 encoding="UTF-8" indent="yes"/>

  <!-- By Josh Miele <joshua.a.miele@gmail.com> 2018-2020 -->
  <!-- Transforms MusicXML from iReal Pro into braille chord charts -->

<xsl:variable name="version">0.07</xsl:variable>
<xsl:variable name="numbers">1234567</xsl:variable>
<xsl:variable name="numbers-traditional" select="8903456712"/>
<xsl:variable name="apostrophe">'</xsl:variable>
<xsl:variable name="whole-notes">abcdefghij</xsl:variable>
<xsl:variable name="traditional-whole-notes">uvxyz&amp;&#61;&#40;&#33;&#41;</xsl:variable>
<xsl:variable name="half-notes">klmnopqrst</xsl:variable>
<xsl:variable name="quarter-notes">&#42;&lt;&#37;&#63;&#58;&#36;&#125;&#124;&#91;w</xsl:variable>
<xsl:variable name="eighth-notes">abcdefghij</xsl:variable>
<xsl:variable name="sharps">&#37;&#37;&#37;&#37;&#37;&#37;</xsl:variable>
<xsl:variable name="flats">&lt;&lt;&lt;&lt;&lt;&lt;</xsl:variable>
<xsl:variable name="lower-alphabet">abcdefghijklmnopqrstuvwxyz</xsl:variable>
<xsl:variable name="upper-alphabet">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
<xsl:variable name="fifths-root">gdaebfcgdaebf</xsl:variable>
<xsl:variable name="fifths-alter">&lt;&lt;&lt;&lt;&lt;       &#37;</xsl:variable>


<xsl:template match="/">
<html>
	<head>
			<style type="text/css">
			h1, h2, p {
				font-family: Braille29 ;
				font-size: 28pt;
				margin-top: 0in;
				margin-bottom: 0in
				}
		.center {text-align: center;
			margin-top: 0.3in;
			margin-bottom: 0.3in
			}
		.left { text-align: left }
		.sec {
				margin-left: 0.75in ;
				margin-top: 0.3in ;
				}
		.start-repeat {
				margin-left: 0.5in ;
				text-indent: -1in ;
				}
		.line {
				margin-left: 0.5in ;
				text-indent: -0.5in ;
				}
		.ending {
				margin-left: 1.5in ;
				text-indent: -0.5in ;
				}
		</style>
		</head>
		<body>
			<!-- Add a heading to the chart -->
			<h1 class="center"><xsl:call-template name="title-caps">
				<xsl:with-param name="title-str" select="/score-partwise/movement-title"/>
			</xsl:call-template><br/>
				
			<!-- Composer -->
			<xsl:apply-templates select="score-partwise/identification/creator"/></h1>
			
			<!--key -->
			<p class="left"><xsl:apply-templates select="score-partwise/part/measure[@number=1]/attributes/key"/></p>
			
			<!--  time signature  -->
			<p class="left">
				<xsl:value-of select="concat(',time3 #', 
					translate( score-partwise/part/measure/attributes/time/beats, '1234567890', 'abcdefghij'),
					score-partwise/part/measure/attributes/time/beat-type)"/>
			</p>
			
			
			<xsl:call-template name="chart">
				<xsl:with-param  name="measure-number" select="1"/>
			</xsl:call-template>
			<p class="center"><xsl:value-of select="concat('i,real ,pro &amp; ,,jambrl ', $version)"/></p>
		</body>
	</html>
</xsl:template>

<!-- This is the main routine  that formats the chart -->
<xsl:template name="chart">
	<xsl:param name="measure-number"/>
	<!-- print section name -->
	<xsl:if test="/score-partwise/part/measure[$measure-number]/direction/direction-type/rehearsal">
		<h2 class="sec"><xsl:value-of select="concat(',sec ,', translate(/score-partwise/part/measure[$measure-number]/direction/direction-type/rehearsal, $upper-alphabet, $lower-alphabet))"/></h2>
	</xsl:if>	
	
	<xsl:variable name="current-line">
		<xsl:apply-templates select="score-partwise/part/measure[$measure-number]"/>
	</xsl:variable>
	<xsl:variable name="measure-count">
		<xsl:call-template name="count-measures" >
			<xsl:with-param name="line" select="$current-line"/>
			<xsl:with-param name="i" select="0"/>
		</xsl:call-template>
	</xsl:variable>
	
	<!-- specify class -->
	<xsl:variable name="para-class">
		<xsl:choose>
			<xsl:when test="/score-partwise/part/measure[$measure-number]/barline/ending/@number">
				<xsl:value-of select="string('ending')"/>
			</xsl:when>
			<xsl:when test="/score-partwise/part/measure[$measure-number]/barline/repeat/@direction='forward'">
				<xsl:value-of select="string('start-repeat')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="string('line')"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="prefix">
		<xsl:choose>
			<xsl:when test="/score-partwise/part/measure[$measure-number]/barline/ending/@number">
				<xsl:value-of select="concat('#', /score-partwise/part/measure[$measure-number]/barline/ending/@number, ' ')"/>
			</xsl:when>
			<xsl:when test="/score-partwise/part/measure[$measure-number]/barline/repeat/@direction='forward'">
				<xsl:value-of select="string('&lt;7 ')"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="suffix">
		<xsl:choose>
			<xsl:when test="/score-partwise/part/measure[$measure-number + $measure-count - 1]/barline/repeat/@direction='backward'">
				<xsl:value-of select="string(' &lt;2')"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>
	
	<!-- print line with para class, prefix, and suffix -->
	<xsl:element name="p">
		<xsl:attribute name="class">
			<xsl:value-of select="string($para-class)"/>
		</xsl:attribute>
		<xsl:value-of select="concat($prefix, normalize-space($current-line), $suffix)"/>
	</xsl:element>

	<!-- Decide if there are mor lines to get -->
	<xsl:choose>
		<xsl:when test="($measure-number + $measure-count) &gt; count(/score-partwise/part/measure)">
			<!-- no next line so exit -->
		</xsl:when>
		<xsl:otherwise>
			<!-- get next line -->
			<xsl:call-template name="chart">
				<xsl:with-param  name="measure-number" select="$measure-number + $measure-count"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
	<!-- end of main chart template -->
</xsl:template>

<xsl:template name="line" match="measure">
	<!--  builds each line of measures -->
	<xsl:call-template name="chord"/>
		<xsl:choose>
			<xsl:when test="following-sibling::measure[1]/direction/direction-type/rehearsal">
				<!-- The next measure has a  title  so exit -->
			</xsl:when>
			<xsl:when test="following-sibling::measure[1]/barline/ending/@number">
				<!-- Next  measure is an alternate ending  so exit -->
			</xsl:when>
			<xsl:when test="((@number - preceding-sibling::measure[direction/direction-type/rehearsal][1]/@number +1) mod 4) = 0">
				<!-- Multiple of 4 bars since  last section title so exit -->
			</xsl:when>
			<xsl:when test="(count(preceding-sibling::measure[direction/direction-type/rehearsal][1]) = 0) and (((@number ) mod 4) = 0)">
				<!--  no sections, and multiple of 4 bars since   top so exit -->
			</xsl:when>
			<xsl:otherwise>
				<!-- Get the next measure  and add it to the current line -->
					<xsl:apply-templates select="following-sibling::measure[1]"/>
			</xsl:otherwise>
		</xsl:choose>	
	<!-- end of template that builds lines -->
</xsl:template>

<xsl:template name="count-measures">
	<!-- Counts number of spaces in a line and returns the count as a number -->
	<xsl:param name="line"/>
	<xsl:param name="i"/>
	
	<xsl:choose>
		<xsl:when test="contains($line, ' ')">
			<!-- there is a space, so break it off and pass it back in -->
			<xsl:call-template name="count-measures">
				<xsl:with-param name="line" select="substring-after($line, ' ')"/>
				<xsl:with-param name="i" select="$i+1"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- no more spaces, so return count and exit -->
			<xsl:value-of select="string($i)"/>
		</xsl:otherwise>
	</xsl:choose>
	<!-- end of count measures -->
</xsl:template>

<xsl:template name="chord">
	<!-- Steps through each harmony element and does magic -->
					<xsl:for-each select="harmony">
				<xsl:variable name="chord-index" select="translate(root/root-step, 'ABCDEFG', $numbers)"/>
				<xsl:variable name="chord-number" select="count(preceding-sibling::harmony)+1"/>
				<xsl:variable name="duration" select="../note[$chord-number]/type"/>

				<!-- Chord names and durations in a variable-->
			<xsl:variable name="chord">
				<xsl:choose>
					<xsl:when test="$duration='whole'">
						<xsl:value-of select="concat(',', translate($chord-index, $numbers, $whole-notes))"/>
					</xsl:when>
					<xsl:when test="$duration='half'">
						<xsl:value-of select="concat(',', translate($chord-index, $numbers, $half-notes))"/>		   
					</xsl:when>
					<xsl:when test="$duration='quarter'">
						<xsl:value-of select="concat(',', translate($chord-index, $numbers, $quarter-notes))"/>
					</xsl:when>
					<xsl:when test="$duration='eighth'">
						<xsl:value-of select="concat(',', translate($chord-index, $numbers, $eighth-notes))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="string('help')"/>
					</xsl:otherwise>
				</xsl:choose>

				<!-- Check for sharps and flats for the chord -->
				<xsl:choose>
					<xsl:when test="root/root-alter &lt; 0">
						<xsl:value-of select="substring($flats, 1, -1* root/root-alter)"/>
					</xsl:when>
					<xsl:when test="root/root-alter &gt; 0">
						<xsl:value-of select="substring($sharps, 1, root/root-alter)"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>

				<!-- check for dotted notes  -->
				<xsl:if test="../note[$chord-number]/dot">
					<xsl:value-of select="$apostrophe"/>
				</xsl:if>
			</xsl:variable>
			
			<!-- put chord kind into a variable -->	
			<xsl:variable name="kind">
				<!-- What kind (maj, minor)  -->
				<xsl:choose>
					<xsl:when test="kind='diminished-seventh'">
						<xsl:value-of select="string('dim7')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="kind/@text"/>
					</xsl:otherwise>
				</xsl:choose>
	
				<!-- Chord alterations -->
				<xsl:choose>
					<xsl:when test="degree/degree-alter &lt; 0">
						<xsl:value-of select="concat( substring($flats, 1, -1* degree/degree-alter), degree/degree-value)"/>
					</xsl:when>
					<xsl:when test="root/root-alter &gt; 0">
						<xsl:value-of select="concat( substring($sharps, 1, degree/degree-alter), degree/degree-value)"/>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:variable>
			
			<!-- Check to see if chord and kind need to be sepparated
		<xsl:variable name="sep">
			<xsl:choose>
				<xsl:when test="contains(chord, $apostrophe)"/>
				<xsl:when test="contains('md', substring($kind, 1,1))"/>
				<xsl:when test="contains('#b', substring($chord, string-length($chord), 1))">
					<xsl:text>"</xsl:text>
				</xsl:when>
				<xsl:when test="contains('#b', substring($kind, 1, 1))">
					<xsl:text>"</xsl:text>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
	-->

			<xsl:value-of select="concat($chord, $kind)"/>
		
				<!-- bass notes -->
				<xsl:if test="count(bass) &gt; 0">
					<xsl:value-of select="concat('/,', translate(bass/bass-step, $upper-alphabet,$lower-alphabet))"/>
						<xsl:choose>
							<xsl:when test="bass/bass-alter &lt; 0">
								<xsl:value-of select="substring($flats, 1, -1* bass/bass-alter)"/>
							</xsl:when>
							<xsl:when test="bass/bass-alter &gt; 0">
								<xsl:value-of select="substring($sharps, 1, bass/bass-alter)"/>
							</xsl:when>
							<xsl:otherwise/>
						</xsl:choose>
					</xsl:if>
			</xsl:for-each>
			<xsl:value-of select="string(' ')"/>
			<!-- end of building chords for each measure -->
</xsl:template>

		
<!-- title Caps in braille -->
<xsl:template name="title-caps">
	<xsl:param name="title-str"/>
	<xsl:choose>
		<xsl:when test="not(contains($title-str, ' '))">
			<!-- Only one word, so  check for cap  and return -->
			<xsl:choose>
				<xsl:when test="contains($upper-alphabet, substring($title-str, 1, 1))">
					<!-- has a cap -->
					<xsl:value-of select="concat(',', translate($title-str, $upper-alphabet, $lower-alphabet))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="string($title-str)"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<!-- Has multiple words -->
			<xsl:choose>
				<xsl:when test="contains($upper-alphabet, substring($title-str, 1, 1))">
					<!-- First word is cap -->
					<xsl:value-of select="concat(',', translate(substring-before($title-str, ' '), $upper-alphabet, $lower-alphabet), ' ')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="substring-before($title-str, ' ')"/>
				</xsl:otherwise>
			</xsl:choose>
			<!-- Hand rest of string back to template to continue -->
			<xsl:call-template name="title-caps">
				<xsl:with-param name="title-str" select="substring-after($title-str, ' ')"/>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
	<!-- end of title caps -->
</xsl:template>

<xsl:template match="identification/creator">
	<xsl:if test="@type='composer'">
		<xsl:variable name="str">
			<xsl:call-template name="title-caps">
				<xsl:with-param name="title-str" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="$str"/>
	</xsl:if>
</xsl:template>


<xsl:template match="key">
	<xsl:variable name="mode-offset">
		<xsl:choose>
				<xsl:when test="contains('major ionian none', mode)">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="mode='dorian'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:when test="mode='phrygian'">
					<xsl:value-of select="4"/>
				</xsl:when>
				<xsl:when test="mode='lydian'">
					<xsl:value-of select="11"/>
				</xsl:when>
				<xsl:when test="mode='mixolydian'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:when test="contains('minor aeolian', mode)">
					<xsl:value-of select="3"/>
				</xsl:when>
				<xsl:when test="mode='locrian'">
					<xsl:value-of select="5"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="fifths-root-offset" 
			select="concat( substring($fifths-root, 1+$mode-offset), substring($fifths-root, 2, $mode-offset) )"/>
		<xsl:variable name="fifths-alter-offset"
			select="concat( substring($fifths-alter, 1+$mode-offset), substring($fifths-alter, 2, $mode-offset) )"/>
		
		<xsl:value-of 
			select="concat( ',key3 ,', substring($fifths-root-offset, fifths+7, 1),
			substring($fifths-alter-offset, fifths+7, 1),
			' ,', mode)"/>
		</xsl:template>

</xsl:stylesheet>