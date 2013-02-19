<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="header">
  <header class="site-header centered">
    <h1>
      <span>Symphony</span>
      <xsl:if test="$site != 'Community'">
        <xsl:text> </xsl:text>
        <xsl:value-of select="$site" />
      </xsl:if>
    </h1>
    <xsl:apply-templates select="$navigation/data" mode="navigation" />
  </header>
</xsl:template>

</xsl:stylesheet>