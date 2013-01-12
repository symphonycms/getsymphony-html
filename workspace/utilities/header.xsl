<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template name="header">
  <header class="main-header">
    <h1 class="branding"><a href="{$root}"><xsl:value-of select="$website-name" /></a></h1>
    <xsl:apply-templates select="$navigation/data" mode="navigation" />
  </header>
  <xsl:if test="$has-section-nav = true()">
    <a class="skip-link" href="#section-nav">Skip To Page Navigation</a>	
  </xsl:if>
</xsl:template>

<xsl:template match="data" mode="navigation">
  <nav role="navigation" class="main-nav">
    <ul class="menu">
      <xsl:apply-templates select="navigation/page[@handle != 'home']" />
    </ul>
  </nav>
</xsl:template>

<xsl:template match="navigation/page">
	<li id="nav-{@handle}">
		<xsl:if test="@handle = $root-page">
			<xsl:attribute name="class">current</xsl:attribute>
		</xsl:if>
		<a href="{$root}{@handle}/">
			<xsl:value-of select="name" />
		</a>
	</li>
</xsl:template>

</xsl:stylesheet>