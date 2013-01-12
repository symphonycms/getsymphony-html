<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/master.xsl" />
<xsl:import href="../utilities/main.xsl" />
<xsl:import href="../utilities/overview.xsl" />
<xsl:import href="../utilities/supplementary.xsl" />
<xsl:import href="../utilities/secondary.xsl" />

<xsl:template match="data">
  <xsl:call-template name="main" />
  <xsl:call-template name="overview" />
  <xsl:call-template name="supplementary" />
  <xsl:call-template name="secondary" />
</xsl:template>

</xsl:stylesheet>