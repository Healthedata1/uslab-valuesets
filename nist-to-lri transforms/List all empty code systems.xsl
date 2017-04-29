<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">
	<xsl:output method="text" omit-xml-declaration="no" indent="yes"/>
	<xsl:strip-space elements="*"></xsl:strip-space>
	<xsl:template match="/ValueSetLibrary/ValueSetDefinitions/ValueSetDefinition">
		<xsl:apply-templates select="ValueElement[string-length(@CodeSystem)=0]">
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match="ValueElement[string-length(@CodeSystem)=0]">
	<xsl:text>
		</xsl:text>
		<xsl:value-of select="concat(../@BindingIdentifier, ':  ',@Value, '  ' , @DisplayName,'  (', ../MessageLocation,')')"> </xsl:value-of>
		<xsl:text>
		</xsl:text>
	</xsl:template>
</xsl:stylesheet>
