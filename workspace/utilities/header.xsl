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