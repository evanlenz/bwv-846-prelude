<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:my="http://localhost"
  exclude-result-prefixes="xs my">

  <xsl:output indent="yes"/>

  <xsl:variable name="root" select="."/>

  <!-- Generate the treble and bass summaries -->
  <xsl:variable name="summaries" as="element(result)+">
    <xsl:for-each select="1 to 3">
      <result href="output/summary-treble-{.}.musicxml">
        <xsl:sequence select="my:transform(
                                'treble-summary.xsl',
                                map{ xs:QName('note-position'):. }
                              )"/>
      </result>
    </xsl:for-each>
    <xsl:for-each select="1 to 2">
      <result href="output/summary-bass-{.}.musicxml">
        <xsl:sequence select="my:transform(
                                'bass-summary.xsl',
                                map{ xs:QName('backup-position'):. }
                              )"/>
      </result>
    </xsl:for-each>
  </xsl:variable>

  <xsl:template match="/">
    <!-- Output the treble and bass summaries -->
    <xsl:for-each select="$summaries">
      <xsl:result-document href="{@href}">
        <xsl:sequence select="node()"/>
      </xsl:result-document>
    </xsl:for-each>
    <!-- Process the treble and bass summaries to produce the chord summary -->
    <xsl:result-document href="output/summary-chords.musicxml">
      <xsl:sequence select="my:transform(
                              'chord-summary.xsl',
                              map{ xs:QName('summaries'):$summaries }
                            )"/>
    </xsl:result-document>
  </xsl:template>

  <!-- Get the result of an XSLT transformation against the source document -->
  <xsl:function name="my:transform" as="document-node()">
    <xsl:param name="stylesheet"/>
    <xsl:param name="params"/>
    <xsl:sequence select="transform(
                            map{
                              'stylesheet-location':$stylesheet,
                              'stylesheet-params':$params,
                              'source-node':$root
                            }
                          )?output"/>
  </xsl:function>

</xsl:stylesheet>
