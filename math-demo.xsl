<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:m="http://www.w3.org/1998/Math/MathML"
                version="1.0">
  
  <xsl:import href="mathml-to-xhtml.xsl"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>
          <xsl:value-of select=".//xhtml:h1[1]"/>
        </title>
        <link rel="stylesheet" type="text/css" href="math.css"/>
        <style type="text/css">
.comparison-table > tbody > tr > th,
.comparison-table > tbody > tr > td
{
  padding: 1em 2em 1em 0.5em;
  text-align: left;
}
.comparison-table > tbody > tr:nth-child(odd)
{
  background-color: #EEE;
}
.comparison-table
{
  border-collapse: collapse;
  border: 1px solid;
  width: 100%;
}
html
{
  background-color: #BCD;
}
body
{
 margin: 1em auto;
 padding: 1em 3em;
 max-width: 44em;
   font-family: Charis SIL, Georgia, Times, Verdana, Arial, serif;
   font-size: 1em;
   font-size-adjust: 0.49;
   font-weight: normal;
   background: white;
   line-height: 1.5;
}
.github-banner
{
  position: absolute;
  top: 0;
  right: 0;
  overflow: hidden;
  width: 15em;
  height: 15em;
}
.github-banner p
{
  position: absolute;
  top: 3em;
  right: -5em;
  background: #CA0002;
  color: white;
  font-weight: bold;
  -webkit-transform: rotate(45deg);
  -moz-transform: rotate(45deg);
  -o-transform: rotate(45deg);
  width: 20em;
  text-align: center;
  overflow: hidden;
  font-family: "Arial", sans-serif;
}
.github-banner a
{
  color: inherit;
  text-decoration: none;
  display: block;
}
</style>
      </head>
      <body>
        <div class="github-banner"><p><a href="http://github.com/xslt/math">XSLT on GitHub</a></p></div>
        <div class="article">
          <xsl:apply-templates/>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="xhtml:*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="m:math" priority="0.5">
    <table class="comparison-table">
      <tbody>
        <tr>
          <th width="25%">MathML</th>
          <td width="75%">
            <xsl:copy-of select="."/>
          </td>
        </tr>
        <tr>
          <th>HTML + CSS</th>
          <td>
            <div class="math-block" style="text-align: center;">
              <div style="display: inline-block; ">
                <xsl:apply-templates/>
              </div>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </xsl:template>

</xsl:stylesheet>