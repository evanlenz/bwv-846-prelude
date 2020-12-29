<!-- Boilerplate utility for customized identity transforms -->
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xs">

  <xsl:template match="@*">
    <xsl:attribute name="{name()}" namespace="{namespace-uri()}">
      <xsl:apply-templates mode="att-value" select="."/>
    </xsl:attribute>
  </xsl:template>

          <xsl:template mode="att-value" match="@*">
            <xsl:sequence select="string(.)"/>
          </xsl:template>

  <xsl:template match="node()">
    <xsl:apply-templates mode="before" select="."/>
    <xsl:apply-templates mode="copy" select="."/>
    <xsl:apply-templates mode="after" select="."/>
  </xsl:template>

          <xsl:template mode="before after" match="node()"/>

  <xsl:template mode="copy" match="node()">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates mode="insert" select="."/>
      <xsl:apply-templates mode="content" select="."/>
      <xsl:apply-templates mode="append" select="."/>
    </xsl:copy>
  </xsl:template>

          <xsl:template mode="content" match="*">
            <xsl:apply-templates mode="#default"/>
          </xsl:template>

          <xsl:template mode="insert append" match="*"/>

</xsl:stylesheet>
