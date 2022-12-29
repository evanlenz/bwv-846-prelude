<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:param name="input-scores"/>

  <!-- By default, copy everything -->
  <xsl:import href="identity.xsl"/>

  <xsl:template mode="content" match="part">
    <xsl:apply-templates select="$input-scores ! score-partwise/part/measure"/>
  </xsl:template>

  <!--
  <xsl:template match="measure/@number"/>
  -->

</xsl:stylesheet>
