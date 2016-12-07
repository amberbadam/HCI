<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
	
	<xsl:param name="TargetNamespace"/>

	<!-- Identity transform -->
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- Add <cac:Signature> element before <cac:AccountingSupplierParty> element -->
	<xsl:template match="soap:Envelope">
	 		<xsl:apply-templates select="@* | node()" />
	</xsl:template>
	
	<xsl:template match="soap:Body">
	
	 		<xsl:apply-templates select="@* | node()" />
	 		
	
	</xsl:template>
	
	<xsl:template match="soap:Header">

	</xsl:template>
	
	
	
	
	
</xsl:stylesheet>