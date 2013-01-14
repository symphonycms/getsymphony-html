<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="data" mode="js">
	<script type="text/javascript" src="{$theme}/js/jquery.js"></script>
	<script type="text/javascript" src="{$theme}/js/modernizr.js"></script>
	<script type="text/javascript" src="{$theme}/js/codemirror.js"></script>
	<script type="text/javascript" src="{$theme}/js/factory.js"></script>
	<script type="text/javascript" src="{$theme}/js/factory.grid.js"></script>
  <xsl:call-template name="add-js" />
</xsl:template>

<xsl:template name="add-js" />

</xsl:stylesheet>