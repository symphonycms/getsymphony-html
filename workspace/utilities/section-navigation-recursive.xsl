<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Import XML data for section navigation -->
<xsl:param name="section-navigation" />

<!-- Add "Skip to Page Navigation" link -->
<xsl:param name="has-section-nav" select="true()" />

<xsl:template name="section-navigation">
  <xsl:apply-templates select="$section-navigation/data" mode="section-navigation" />
</xsl:template>

<xsl:template match="data" mode="section-navigation">
  <nav role="navigation" class="section-nav" id="section-nav">
    <xsl:apply-templates select="section-navigation/page" mode="section-navigation" />
  </nav>
</xsl:template>

<xsl:template match="section-navigation/page" mode="section-navigation">
  <xsl:param name="section-handle" select="@handle" />
  <h3 class="box-title"><a href="{$root}{@handle}/"><xsl:value-of select="name" /></a></h3>
  <ul class="section-menu">
    <xsl:apply-templates select="page" mode="navigation">
      <xsl:with-param name="root-url" select="concat($root, @handle)" />
    </xsl:apply-templates>
  </ul>
</xsl:template>

<xsl:template match="page" mode="navigation">
  <xsl:param name="levels" select="999"/>
  <xsl:param name="sub-level" select="4" />
  <xsl:param name="root-url" select="$root" />
  <xsl:param name="is-current">
    <xsl:call-template name="is-current" />
  </xsl:param>
  <xsl:if test="not(types/type = 'hidden')">
    <li>
      <!-- Set the class name: -->
      <xsl:choose>
        <xsl:when test="$is-current = 'true'">
          <xsl:attribute name="class">current</xsl:attribute>
        </xsl:when>
      </xsl:choose>

      <!-- Set the link: -->
      <xsl:apply-templates select="." mode="current-link">
        <xsl:with-param name="root-url" select="$root-url" />
      </xsl:apply-templates>

      <!-- Get subpages: -->
      <xsl:if test="$levels &gt; 0 and count(page) &gt; 0 and $is-current = 'true'">
        <ul>
          <xsl:attribute name="class">
            <xsl:value-of select="concat('level-', $sub-level)" />
          </xsl:attribute>
          <xsl:apply-templates select="page" mode="navigation">
            <xsl:with-param name="levels" select="$levels - 1"/>
            <xsl:with-param name="sub-level" select="$sub-level + 1" />
            <xsl:with-param name="root-url" select="concat($root-url, '/', @handle)"/>
          </xsl:apply-templates>
        </ul>
      </xsl:if>
    </li>
  </xsl:if>
</xsl:template>

<!-- Set the link -->
<xsl:template match="page" mode="link">
  <xsl:param name="root-url" />
  <a href="{$root-url}/{@handle}/">
    <xsl:value-of select="name"/>
  </a>
</xsl:template>

<xsl:template match="page" mode="current-link">
  <xsl:param name="root-url" />
  <xsl:param name="page-url">
    <xsl:choose>
      <xsl:when test="@handle">
        <xsl:value-of select="concat($root-url, '/', @handle, '/')" />
      </xsl:when>
      <xsl:otherwise>#</xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="is-current">
    <xsl:call-template name="is-current" />
  </xsl:param>
  <xsl:if test="@handle">
    <xsl:attribute name="id">item-<xsl:value-of select="@handle" /></xsl:attribute>
  </xsl:if>
  <xsl:if test="$is-current = 'true'">
    <xsl:attribute name="class">current</xsl:attribute>
  </xsl:if>
  <a href="{$page-url}">
    <xsl:if test="$is-current = 'true'">
      <xsl:attribute name="class">current</xsl:attribute>
    </xsl:if>
    <xsl:value-of select="name" />
  </a>
</xsl:template>

<xsl:template name="is-current">
  <xsl:choose>
    <xsl:when test="$subsection-page">
      <xsl:if
        test="
          (@handle = $current-page and ../../../@handle = $section-page)
          or
          (page/@handle = $current-page and @handle = $parent-page)
          or
          (page/page/@handle = $current-page and @handle = $subsection-page)
          or
          (page/page/page/@handle = $current-page and @handle = $section-page)
        ">
        <xsl:value-of select="'true'" />
      </xsl:if>
    </xsl:when>
    <xsl:when test="$section-page">
      <xsl:if
        test="
          (@handle = $current-page and ../../@handle = $section-page)
          or
          (page/@handle = $current-page and @handle = $parent-page)
          or
          (page/page/@handle = $current-page and @handle = $section-page)
        ">
        <xsl:value-of select="'true'" />
      </xsl:if>
    </xsl:when>
    <xsl:when test="$parent-page">
      <xsl:if
        test="
          (@handle = $current-page and ../@handle = $parent-page)
          or
          (page/@handle = $current-page and @handle = $parent-page)
        ">
        <xsl:value-of select="'true'" />
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:if test="@handle = $current-page">
        <xsl:value-of select="'true'" />
      </xsl:if>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>