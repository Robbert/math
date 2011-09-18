<?xml version="1.0" encoding="utf-8"?>
<!-- © 2011, Robbert Broersma. -->
<!-- http://www.gnu.org/licenses/lgpl-3.0.txt -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:m="http://www.w3.org/1998/Math/MathML"
                version="1.0">
  
  <xsl:strip-space elements="m:*"/>
  
  <xsl:output method="xml" indent="no"/>
  
  <xsl:template match="m:math">
    <span class="math-inline">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="m:mrow">
    <span>
      <xsl:attribute name="style">
        <xsl:text>style="display: inline-block;</xsl:text>
        <xsl:apply-templates select="@*" mode="style"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="m:mstyle | m:mspace">
    <span>
      <xsl:attribute name="style">
        <xsl:apply-templates select="@*" mode="style"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="m:mfrac">
    <span class="mfrac" style="display: inline-table; vertical-align: middle;">
      <span style="display: table-row">
        <span style="display: table-cell;">
          <xsl:apply-templates select="@numalign" mode="style"/>
          <xsl:apply-templates select="m:mrow[1]"/>
        </span>
      </span>
      <span style="display: table-row;">
        <span style="display: table-cell;">
          <xsl:apply-templates select="@denumalign" mode="style"/>
          <xsl:apply-templates select="m:mrow[2]"/>
        </span>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="m:mrow">
    <span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="m:msup">
    <xsl:apply-templates select="*[1]"/>
    <sup style="font-size: 0.7em;">
      <xsl:apply-templates select="*[2]"/>
    </sup>
  </xsl:template>
  
  <xsl:template match="m:msub">
    <xsl:apply-templates select="*[1]"/>
    <sub style="font-size: 0.7em;">
      <xsl:apply-templates select="*[2]"/>
    </sub>
  </xsl:template>
  
  <xsl:template match="m:msubsup">
    <xsl:apply-templates select="*[1]"/>
    <table style="display: inline-table; font-size: 0.75em; line-height: 1em;">
      <tr>
        <td>
          <xsl:apply-templates select="*[3]"/>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:apply-templates select="*[2]"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template match="m:msqrt">
    <span>
      <span style="font-style: italic;">&#x23b7;</span>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="m:mover">
    <!-- Read about @accent on the following page: http://www.w3.org/TR/2010/REC-MathML3-20101021/chapter3.html#id.3.4.5.2 -->
    <xsl:variable name="accent" select="@accent = 'true' or *[2][self::m:mo]"/>
    <xsl:variable name="top">
      <xsl:choose>
        <xsl:when test="$accent">-0.6em</xsl:when>
        <xsl:otherwise>-1em</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <span style="position: relative;">
      <span style="position: absolute; top: {$top};">
        <xsl:apply-templates select="*[2]"/>
      </span>
      <xsl:apply-templates select="*[1]"/>
    </span>
  </xsl:template>

  <xsl:template match="m:munderover">
    <span style="display: inline-table;">
      <span style="display: table-row; font-size: 0.75em;">
        <span style="position: table-cell">
          <xsl:apply-templates select="*[3]"/>
        </span>
      </span>
      <span style="display: table-row;">
        <span style="position: table-cell;">
          <xsl:apply-templates select="*[1]"/>
        </span>
      </span>
      <span style="position: table-row; font-size: 0.75em;">
        <span style="position: table-cell">
          <xsl:apply-templates select="*[2]"/>
        </span>
      </span>
    </span>
  </xsl:template>

  <xsl:template match="m:mn">
    <span class="math-var">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <xsl:template match="m:mi">
    <i class="math-var">
      <xsl:apply-templates/>
    </i>
  </xsl:template>

  <xsl:template match="m:mo">
    <span class="math-var math-operator">
      <xsl:attribute name="style">
        <xsl:if test=". = '&#x222E;' or . = '&#x2211;' or . = '&#x222B;'">
          <xsl:text>font-size: 1.7em;</xsl:text>
        </xsl:if>
        <xsl:if test=". = '+' or . = '=' or . = '-' or . = '−' or . = '×' or . = '↔' or . = '→' or . = '∈' or . = '⊕' or . = '≡' or . = '≠'">
          <xsl:if test="preceding-sibling::*">margin-left: 0.2em;</xsl:if>
          <xsl:if test="following-sibling::*">margin-right: 0.2em;</xsl:if>
        </xsl:if>
        <xsl:if test=". = ',' or . = '∗'">
          <xsl:if test="preceding-sibling::*">margin-left: 0.1em;</xsl:if>
          <xsl:if test="following-sibling::*">margin-right: 0.2em;</xsl:if>
        </xsl:if>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="m:mtable">
    <table style="display: inline-table;">
      <tbody>
        <xsl:apply-templates/>
      </tbody>
    </table>
  </xsl:template>

  <xsl:template match="m:mtr">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="m:mtd">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template match="m:mfenced">
    <xsl:value-of select="@open"/>
    <xsl:apply-templates/>
    <xsl:value-of select="@close"/>
  </xsl:template>

  <xsl:template match="m:mfrac[@bevelled='true']">
    <span class="math-error">bevelled mfenced is not supported</span>
  </xsl:template>
  
  <xsl:template match="m:annotation | m:annotation-xml"/>
  
  <xsl:template match="@*" mode="style"/>
  <xsl:template match="@mathvariant[.='bold']" mode="style">font-weight: bold;</xsl:template>
  
  <xsl:template match="@denumalign" mode="style">text-align: <xsl:value-of select="."/>;</xsl:template>
  
  <xsl:template match="@width[. ='verythinmathspace']" mode="style">padding-right: 0.05em; padding-left: 0.05em;</xsl:template>
  
  <xsl:template match="@width[. ='thinmathspace']" mode="style">padding-right: 0.08em; padding-left: 0.08em;</xsl:template>

  <xsl:template match="@width[. ='mediummathspace']" mode="style">padding-right: 0.11em; padding-left: 0.11em;</xsl:template>

  <xsl:template match="@width[. = 'thickmathspace']" mode="style">padding-right: 0.14em; padding-left: 0.14em;</xsl:template>

  <xsl:template match="@width[. = 'verythickmathspace']" mode="style">padding-right: 0.17em; padding-left: 0.17em;</xsl:template>
  
</xsl:stylesheet>