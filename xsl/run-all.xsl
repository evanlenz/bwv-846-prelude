<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:array="http://www.w3.org/2005/xpath-functions/array"
  xmlns:my="http://localhost"
  exclude-result-prefixes="xs my array">

  <xsl:output indent="yes"/>

  <xsl:variable name="root" select="."/>

  <xsl:variable name="output-dir" select="'output'"/>

  <!-- Generate the treble and bass summaries -->
  <xsl:variable name="one-voice-summaries" as="element(result)+">
    <xsl:for-each select="1 to 2">
      <result file-stem="summary-{.}">
        <xsl:sequence select="my:transform(
                                'bass-summary.xsl',
                                map{ xs:QName('backup-position'):(if (. eq 1) then 2 else 1) }
                              )"/>
      </result>
    </xsl:for-each>
    <xsl:for-each select="1 to 3">
      <result file-stem="summary-{. + 2}">
        <xsl:sequence select="my:transform(
                                'treble-summary.xsl',
                                map{ xs:QName('note-position'):. }
                              )"/>
      </result>
    </xsl:for-each>
  </xsl:variable>

  <!-- Process the treble and bass summaries to produce all possible chord-summary combinations -->
  <xsl:variable name="chord-summaries" as="element(result)+">
    <xsl:for-each select="(2 to count($one-voice-summaries)) ! my:combinations($one-voice-summaries, .)">
      <xsl:variable name="voices-string"
                    select="string-join(
                              array:for-each(
                                .,
                                function($results) { $results ! substring-after(@file-stem, 'summary-') }
                              ),
                              ''
                            )"/>
      <result file-stem="summary-{$voices-string}">
        <xsl:sequence select="my:transform(
                                'chord-summary.xsl',
                                map{ xs:QName('one-voice-summaries'):array:flatten(.) }
                              )"/>
      </result>
    </xsl:for-each>
  </xsl:variable>

  <!-- Process each of the one-voice and chord summaries to produce the pitch-changes summaries -->
  <xsl:variable name="pitch-changes-summaries" as="element(result)+">
    <xsl:for-each select="$one-voice-summaries, $chord-summaries">
      <result file-stem="{@file-stem}.pitch-changes">
        <xsl:variable name="source-doc" as="document-node()">
          <xsl:document>
            <xsl:sequence select="node()"/>
          </xsl:document>
        </xsl:variable>
        <xsl:sequence select="transform(
                                map{
                                  'stylesheet-location':'pitch-changes-summary.xsl',
                                  'source-node':$source-doc
                                }
                              )?output"/>
      </result>
    </xsl:for-each>
  </xsl:variable>

  <xsl:template match="/">
    <!-- Output the result of every transformation -->
    <xsl:for-each select="$one-voice-summaries, $chord-summaries, $pitch-changes-summaries">
      <xsl:result-document href="{$output-dir}/{@file-stem}.musicxml">
        <xsl:sequence select="node()"/>
      </xsl:result-document>
    </xsl:for-each>
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

  <!-- Select every k-combination from $items, returning each as an array of items -->
  <xsl:function name="my:combinations" as="array(item()*)*">
    <xsl:param name="items"/>
    <xsl:param name="k"/>
    <!--
    <xsl:message>Calling my:combinations with <xsl:value-of select="$items/@file-stem" separator=","/> and $k set to <xsl:value-of select="$k"/></xsl:message>
    -->
    <xsl:choose>
      <xsl:when test="$k eq 0 or empty($items)">
        <xsl:sequence select="()"/>
      </xsl:when>
      <!-- Optimization -->
      <xsl:when test="$k eq count($items)">
        <xsl:sequence select="[$items]"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="first-item" select="$items[1]"/>
        <xsl:variable name="rest" select="$items[position() gt 1]"/>
        <!--
        <xsl:message>First item is: <xsl:value-of select="$first-item/@file-stem"/>;
        Rest of the items are: <xsl:value-of select="$rest/@file-stem" separator=","/></xsl:message>
        -->
        <xsl:for-each select="my:combinations($rest, $k - 1)">
          <xsl:sequence select="array:join(([$first-item], .))"/>
        </xsl:for-each>
        <xsl:sequence select="my:combinations($rest, $k)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

</xsl:stylesheet>
