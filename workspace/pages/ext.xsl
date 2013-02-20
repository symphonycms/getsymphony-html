<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />
<xsl:import href="../utilities/ninja.xsl" />

<xsl:template match="data">
	<xsl:apply-templates select="content/*" mode="ninja" />
</xsl:template>

</xsl:stylesheet>