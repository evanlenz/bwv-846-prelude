<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:import href="common.xsl"/>

  <xsl:param name="backup-position"/>

  <!-- Preserve just the first note of each voice (signified by following a <backup> element) -->
  <xsl:template match="note[pitch][preceding-sibling::*[not(self::note/rest)][1][self::backup]][$backup-position]">
    <xsl:apply-templates mode="copy" select="."/>
  </xsl:template>

  <!-- The last measure uses chords and just one backup, so use different rules to get the bass notes for it -->
  <xsl:template match="measure[last()]/note[preceding-sibling::backup][position() eq $backup-position]" priority="1"/>
  <xsl:template match="measure[last()]/note[preceding-sibling::backup][position() ne $backup-position]" priority="1">
    <xsl:apply-templates mode="copy" select="."/>
  </xsl:template>

</xsl:stylesheet>
