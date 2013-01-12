<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="data" mode="js">
  <script src="{$scripts}modernizr.js"></script>
  <xsl:call-template name="add-js" />
</xsl:template>

<xsl:template name="add-js" />

</xsl:stylesheet>