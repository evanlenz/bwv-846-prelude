<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:functx="http://www.functx.com"
  xmlns:v="http://lenzconsulting.com/balisage2021/visualizer"
  expand-text="yes"
  exclude-result-prefixes="xs functx v">

  <!-- By default, copy everything -->
  <xsl:import href="identity.xsl"/>

  <xsl:include href="functx-1.0.1-nodoc.xsl"/>

  <!-- This can be optionally overridden by the importing module (or a supplied stylesheet parameter) -->
  <xsl:param name="insert-note-tracking-ids" select="false()"/>

  <!-- Delete all these, at least by default -->
  <xsl:template match="note | backup | notations | dot | comment()"/>

  <!-- Force all the preserved notes to be whole notes -->
  <xsl:template mode="content" match="note/type">whole</xsl:template>
  <xsl:template mode="content" match="duration">16</xsl:template>

  <!-- Speed up the tempo -->
  <xsl:template mode="att-value" match="@tempo">{8 * .}</xsl:template>

  <!-- When enabled, insert a tracking ID for notes that we preserve (to support downstream visualizations) -->
  <xsl:template mode="insert" match="note[$insert-note-tracking-ids]">
    <xsl:attribute name="v:id" select="functx:path-to-node-with-pos(.)"/>
  </xsl:template>

</xsl:stylesheet>
