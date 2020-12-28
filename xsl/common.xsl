<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  expand-text="yes"
  exclude-result-prefixes="xs">

  <!-- By default, copy everything -->
  <xsl:import href="identity.xsl"/>

  <!-- Delete all these, at least by default -->
  <xsl:template match="note | backup | tied | dot | comment()"/>

  <!-- Force all the preserved notes to be whole notes -->
  <xsl:template mode="content" match="note/type">whole</xsl:template>
  <xsl:template mode="content" match="duration">16</xsl:template>

  <!-- Speed up the tempo -->
  <xsl:template mode="att-value" match="@tempo">{8 * .}</xsl:template>

</xsl:stylesheet>
