<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" />

	<xsl:template match="/ProductInfo"> 		
	
		<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
		<head>
		<title>Amazon Product Finder - Search Results</title>
		<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
		<style type="text/css" title="currentStyle">
			/*<![CDATA[*/
				@import "styles.css";
			/*]]>*/
		</style>		
		</head>
  		<body> 
  		<h1>Amazon Product Finder - Search Results</h1>
  		<h3>Result Pages <xsl:value-of select="TotalPages" /></h3>
  		<table border="1"> 
    		<tr>
	    	<td>Product Name</td><td>Catalog</td><td>Price</td><td>Availability</td>
	    	<xsl:for-each select="Details"> 
	    	<tr>
	    		<td><xsl:value-of select="ProductName" /></td> 
	    		<td><xsl:value-of select="Catalog" /></td> 
	    		<td><xsl:value-of select="OurPrice" /></td> 
	    		<td><xsl:value-of select="Availability" /></td>
    		</tr> 
    		</xsl:for-each> 
    		</tr>
    	</table> 
    	
    	<table border="0" width="100%">
    	<tr>
    	<td><h5>Transformer provided by <a href="http://amazonfinder.sourceforge.net/">http://amazonfinder.sourceforge.net/</a></h5></td>
  		<td align="right"><a href="">Next Result Page &gt;</a></td>
  		</tr></table>
  		</body> 
  		</html> 
  		
  	</xsl:template> 
  	
</xsl:stylesheet>
