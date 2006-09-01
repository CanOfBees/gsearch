<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:zs="http://www.loc.gov/zing/srw/"
		xmlns:z="http://indexdata.dk/zebra/xslt/1"
		xmlns:foxml="info:fedora/fedora-system:def/foxml#"
		xmlns:dc="http://purl.org/dc/elements/1.1/">
		
<!-- This xslt stylesheet generates the resultPage
     from a Zebra search.
-->
	
	<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
	
	<xsl:param name="QUERY" select="query"/>
	<xsl:param name="INDEXNAME" select="indexName"/>
	<xsl:param name="HITPAGESTART" select="1"/>
	<xsl:param name="HITPAGESIZE" select="10"/>
	<xsl:param name="RESULTPAGEXSLT" select="resultPageXslt"/>
	<xsl:param name="DATETIME" select="none"/>

	<xsl:template match="zs:searchRetrieveResponse">
		<xsl:variable name="HITTOTAL" select="zs:numberOfRecords"/>
	 	<resultPage dateTime="{$DATETIME}"
	 				indexName="{$INDEXNAME}">
	 		<gfindObjects 	query="{$QUERY}"
	 						hitPageStart="{$HITPAGESTART}"
	 						hitPageSize="{$HITPAGESIZE}"
	 						resultPageXslt="{$RESULTPAGEXSLT}"
	 						hitTotal="{$HITTOTAL}">
				<objects>
				  <xsl:for-each select="zs:records/zs:record">
					<object>
						<xsl:attribute name="no">
							<xsl:value-of select="zs:recordPosition"/>
						</xsl:attribute>
						<xsl:attribute name="score">
							<xsl:value-of select="@rank"/>
						</xsl:attribute>
						<xsl:for-each select="zs:recordData/z:record/z:index">
							<field>
								<xsl:attribute name="name">
									<xsl:value-of select="@name"/>
								</xsl:attribute>
								<xsl:value-of select="text()"/>
							</field>
						</xsl:for-each>
					</object>
				  </xsl:for-each>
				</objects>
			</gfindObjects>
	 	</resultPage>
	</xsl:template>
	
</xsl:stylesheet>	




				



