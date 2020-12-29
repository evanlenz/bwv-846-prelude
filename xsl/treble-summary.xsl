<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:import href="common.xsl"/>

  <xsl:param name="note-position"/>

  <!-- Preserve just the nth note of each measure -->
  <xsl:template match="note[pitch][$note-position]">
    <xsl:apply-templates mode="copy" select="."/>
  </xsl:template>

</xsl:stylesheet>
