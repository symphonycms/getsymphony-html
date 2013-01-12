<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/global-nav.xsl" />
<xsl:import href="../utilities/header.xsl" />
<xsl:import href="../utilities/sub-nav.xsl" />
<xsl:import href="../utilities/footer.xsl" />

<xsl:template match="/" mode="body">
  <body class="section-{$root-page}">
    <div class="page" id="{$current-page}-page">
      <xsl:call-template name="global-nav" />
      <xsl:call-template name="header" />
      <xsl:apply-templates />
      <xsl:call-template name="sub-nav" />
      <xsl:call-template name="footer" />
    </div>
  </body>
</xsl:template>

</xsl:stylesheet>