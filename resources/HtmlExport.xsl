<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

<!--========================================================================-->
<!--
$Id: HtmlExport.xsl,v 1.1 2004/04/21 00:12:40 slide Exp $

Description:

HTML search result export XSL stylesheet for the Amazon Product Finder.

The initial developer of the original code is slide@users.sourceforge.net.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General public License for more details.

You should have received a copy of the GNU General public
License along with this program; if not, write to the Free
Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
MA  02111-1307, USA.
-->
<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" standalone="no"/>
<!--
TODO: these parameters are read from the ExportConfig.xml configuration that
seller (user) has defined. These values are here just for testing purposes.
-->

	<xsl:param name="SearchName" select="asfd"/>
	<xsl:param name="LowSalesRank" select="200"/>
	<xsl:param name="HighSalesRank" select="50"/>
	<xsl:param name="HighRating" select="4"/>
	<xsl:param name="LowRating" select="2"/>

	<xsl:template match="/ProductInfo">
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
			<head>
				<title>Amazon Product Finder - Search Results</title>
				<meta http-equiv="content-type" content="text/html; charset=iso-8859-1"/>
				<style type="text/css" title="currentStyle">/*<![CDATA[*/@import "styles.css";/*]]>*/</style>
			</head>
			<body>
				<h1>Amazon Product Finder - Search Results</h1>
				<h3>Result Pages <xsl:value-of select="TotalPages"/></h3>
				<table border="0" width="100%">
					<tr style="background-color: #cde; text-align=center;" id="sarakkeet">
						<td>#</td>
						<td>Thumb</td>
						<td>Author/Artist</td>
						<td>Product Name</td>
						<td>Catalog</td>
						<td>Our Price</td>
						<td>Sales Rank</td>
						<td>Average Customer Rating</td>
					</tr>
					<xsl:for-each select="Details">
						<tr>
							<td>
								<xsl:value-of select="position()"/>
							</td>
							<td>
								<xsl:text disable-output-escaping="yes">&lt;</xsl:text>a href="<xsl:value-of select="url"/>"&gt;<xsl:text disable-output-escaping="yes">&lt;</xsl:text>img src="<xsl:value-of select="ImageUrlSmall"/>" border="0"<xsl:text disable-output-escaping="yes">/&gt;</xsl:text><xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text></td>
							<td>
								<xsl:value-of select="Artists"/>
							</td>
							<td>
								<xsl:value-of select="ProductName"/>
							</td>
							<td>
								<xsl:value-of select="Catalog"/>
							</td>
							<td>
								<xsl:value-of select="OurPrice"/>
							</td>
							<td>
								<xsl:attribute name="style">
									<xsl:choose>
										<xsl:when test="number(SalesRank &gt; $LowSalesRank)">
											<!-- color: red; -->
										</xsl:when>
										<xsl:otherwise>
											<!-- color: green; -->
										</xsl:otherwise>
									</xsl:choose>
								</xsl:attribute>
								<xsl:choose>
									<xsl:when test="string-length(SalesRank)=0">No Sales Rank</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="SalesRank"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="string-length(Reviews/AvgCustomerRating)=0">No Customer Rating</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="Reviews/AvgCustomerRating"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
						</tr>
					</xsl:for-each>
					<tr>
						<td colspan="6">Average Sales Rank for the Author/Artist</td>
						<td>
							<xsl:value-of select="count(SalesRank)"/>
						</td>
					</tr>
				</table>
				<!-- TODO: Previous Result Page link - conditional checking here -->
				<table border="0" width="100%">
					<tr>
						<td>
							<h5>Exporting provided by <a href="http://amazonfinder.sourceforge.net/">http://amazonfinder.sourceforge.net/</a></h5>
						</td>
						<td align="right">
							<a href="search_$SearchName_$Page.html">Next Result Page &gt;</a>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
