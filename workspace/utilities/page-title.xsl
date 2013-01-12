<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="page-title">
  <xsl:param name="root-page" select="/data/params/root-page" />
  <xsl:param name="href">
    <xsl:value-of select="$root" />
    <xsl:if test="$root-page">
      <xsl:value-of select="$root-page" />
      <xsl:text>/</xsl:text>
    </xsl:if>
    <xsl:if test="$section-page">
      <xsl:value-of select="$section-page" />
      <xsl:text>/</xsl:text>
    </xsl:if>
    <xsl:if test="$subsection-page">
      <xsl:value-of select="$subsection-page" />
      <xsl:text>/</xsl:text>
    </xsl:if>
    <xsl:if test="$parent-page">
      <xsl:value-of select="$parent-page" />
      <xsl:text>/</xsl:text>
    </xsl:if>
    <xsl:value-of select="$current-page" />
    <xsl:text>/</xsl:text>
  </xsl:param>
  <h1 class="page-title">
    <a href="{$href}">
      <xsl:value-of select="$page-title" />
    </a>
  </h1>
</xsl:template>

</xsl:stylesheet>