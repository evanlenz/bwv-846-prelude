<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:import href="common.xsl"/>

  <xsl:param name="one-voice-summaries"/>

  <xsl:template mode="append" match="measure">
    <!-- Grab the note from each one-voice summary corresponding to the current measure -->
    <xsl:for-each select="$one-voice-summaries/score-partwise/part/measure[@number eq current()/@number]/note">
      <xsl:copy-of select="."/>
      <xsl:if test="position() ne last()">
        <!-- Make them all sound at the beginning of the measure -->
        <backup>
          <duration>16</duration>
        </backup>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
