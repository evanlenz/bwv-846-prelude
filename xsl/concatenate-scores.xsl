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

  <!-- Annotate where it came from -->
  <xsl:template mode="before" match="measure[1]">
    <xsl:comment>
      <xsl:value-of select="ancestor::result/@file-stem"/>
    </xsl:comment>
  </xsl:template>

  <!-- Add a silent measure at the end of each summary -->
  <xsl:template mode="after" match="measure[last()]">
    <measure number="{@number + 1}">
      <note>
        <rest/>
        <duration>16</duration>
        <type>whole</type>
        <staff>1</staff>
      </note>
      <backup>
        <duration>16</duration>
      </backup>
      <note>
        <rest/>
        <duration>16</duration>
        <type>whole</type>
        <staff>2</staff>
      </note>
    </measure>
  </xsl:template>

</xsl:stylesheet>
