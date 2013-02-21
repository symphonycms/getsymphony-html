<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:import href="../utilities/network.xsl" />
<xsl:import href="../utilities/header.xsl" />
<xsl:import href="../utilities/navigation.xsl" />
<xsl:import href="../utilities/footer.xsl" />

<xsl:template match="/" mode="body">
  <body>
    <!-- Symphony Network -->
    <xsl:call-template name="network" />
    <!-- Current page -->
    <div id="site">
      <xsl:call-template name="header" />
      <xsl:apply-templates />
    </div>
    <xsl:call-template name="footer" />
  </body>
</xsl:template>

</xsl:stylesheet>