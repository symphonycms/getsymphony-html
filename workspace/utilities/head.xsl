<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/js.xsl" />

<xsl:template match="/" mode="head">
  <head>
    <meta name="description" content="{$website-name}" />
    <meta name="author" content="{$website-name}" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <xsl:apply-templates mode="page-title" />
    <xsl:apply-templates mode="css" />
    <xsl:apply-templates mode="js" />
  </head>
</xsl:template>

<xsl:template match="data" mode="page-title">
  <title>
    <xsl:value-of select="$page-title" />
    <xsl:text> | </xsl:text>
    <xsl:value-of select="$website-name"/>
  </title>
</xsl:template>

<xsl:template match="data" mode="css">
	<link rel="stylesheet" href="{$css}screen.css" />
  <xsl:comment><![CDATA[[if IE]> <link href="]]><xsl:value-of select="$css" /><![CDATA[ie.css" media="screen, projection" rel="stylesheet" type="text/css" /> <![endif]]]></xsl:comment>
</xsl:template>

</xsl:stylesheet>