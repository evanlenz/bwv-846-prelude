<!-- If a note was already present in the immediately preceding measure, tie it -->
<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:my="http://localhost"
  exclude-result-prefixes="xs my"
  expand-text="yes">

  <xsl:import href="identity.xsl"/>

  <xsl:template match="note">
    <xsl:next-match>
      <xsl:with-param name="is-continued"
                      tunnel="yes"
                      select="exists(../preceding-sibling::measure[1]/note/pitch[my:is-same-pitch(., current()/pitch)])"/>
      <xsl:with-param name="continues"
                      tunnel="yes"
                      select="exists(../following-sibling::measure[1]/note/pitch[my:is-same-pitch(., current()/pitch)])"/>
    </xsl:next-match>
  </xsl:template>

  <xsl:template mode="after" match="durations">
    <xsl:param name="continues" tunnel="yes"/>
    <xsl:param name="is-continued" tunnel="yes"/>
    <xsl:if test="$is-continued">
      <tie type="stop"/>
    </xsl:if>
    <xsl:if test="$continues">
      <tie type="start"/>
    </xsl:if>
  </xsl:template>

  <xsl:template mode="append" match="note">
    <xsl:param name="continues" tunnel="yes"/>
    <xsl:param name="is-continued" tunnel="yes"/>
    <xsl:if test="$is-continued or $continues">
      <notations>
        <xsl:if test="$is-continued">
          <tied type="stop"/>
        </xsl:if>
        <xsl:if test="$continues">
          <tied type="start"/>
        </xsl:if>
      </notations>
    </xsl:if>
  </xsl:template>

  <xsl:function name="my:is-same-pitch">
    <xsl:param name="pitch1" as="element(pitch)"/>
    <xsl:param name="pitch2" as="element(pitch)"/>
    <xsl:sequence select="deep-equal($pitch1!(step,alter,octave), $pitch2!(step,alter,octave))"/>
  </xsl:function>

</xsl:stylesheet>
