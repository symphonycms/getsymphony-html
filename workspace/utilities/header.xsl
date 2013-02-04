<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="header">
  <header class="site-header centered">
    <h1>
      <span>Symphony</span>
    </h1>
    <xsl:apply-templates select="$navigation/data" mode="navigation" />
  </header>
</xsl:template>

<xsl:template match="data" mode="navigation">
  <nav>
    <xsl:apply-templates select="navigation/page" />
  </nav>
</xsl:template>

<xsl:template match="navigation/page">
  <a href="{$root}{@handle}/">
    <xsl:if test="@handle = $root-page or (@type = 'index')">
      <xsl:attribute name="class">active</xsl:attribute>
    </xsl:if>
    <xsl:if test="@type = 'index'">
      <xsl:attribute name="href"><xsl:value-of select="$root" /></xsl:attribute>
    </xsl:if>
    <xsl:value-of select="name" />
  </a>
</xsl:template>

</xsl:stylesheet>