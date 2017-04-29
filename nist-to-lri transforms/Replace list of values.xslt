<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir">
    <xsl:output indent="yes" cdata-section-elements="command"/>
   
    <xsl:strip-space elements="*"/>

<xsl:param name="oldNames" select="
(
'Administrative Sex',
'Patient Class',
'Race',
'Acknowledgment Code',
'Courtesy Code',
'Diagnosis Type',
'Relationship',
'Financial Class',
'Specimen Action Code',
'Insurance Plan ID',
'Diagnostic Service Section ID',
'Interpretation Codes',
'Observation Result Status Codes Interpretation',
'Procedure Code',
'Type of Agreement',
'Processing ID',
'Source of Comment',
'Order Control Codes',
'Result Status',
'Value Type',
'Contact Role',
'Yes/no Indicator',
'Accept/Application Acknowledgment Conditions',
'Nature of Service/Test/Observation',
'Master File Identifier Code',
'File Level Event Code',
'Response Level',
'Record-level Event Code',
'Ethnic Group',
'Address Type',
'Type of Referenced Data',
'Name Type',
'Telecommunication Equipment Type',
'Identifier Type',
'Segment Action Code',
'Subtype of Referenced Data',
'Encoding',
'Universal ID Type',
'Advanced Beneficiary Notice Code',
'Message Error Condition Codes',
'Diagnosis Priority',
'Application',
'Facility',
'Additive/Preservative',
'Special Handling Code',
'Country Codes (ISO-3166-1)',
'Supplemental Service Information Values',
'Extended Priority Codes',
'Specimen Type',
'Specimen Collection Method',
'Specimen Reject Reason',
'Specimen Condition',
'Observation Result Handling',
'Error Severity',
'Application Error Code',
'Specimen Source Type Modifier',
'Participation',
'Relevant Clinical Information',
'Exclusive Test',
'Preferred Specimen/Attribute Status',
'Observation Type',
'Observation Sub-Type',
'Collection Event/Process Step Limit',
'Communication Location'
)"/>
  <xsl:param name="newNames" select="(
'2.16.840.1.113883.9.195.4.1',
'2.16.840.1.113883.9.195.4.2',
'2.16.840.1.113883.9.195.4.3',
'2.16.840.1.113883.9.195.4.4',
'2.16.840.1.113883.9.195.4.5',
'2.16.840.1.113883.9.195.4.6',
'2.16.840.1.113883.9.195.4.7',
'2.16.840.1.113883.9.195.4.8',
'2.16.840.1.113883.9.195.4.9',
'2.16.840.1.113883.9.195.4.10',
'2.16.840.1.113883.9.195.4.11',
'2.16.840.1.113883.9.195.4.12',
'2.16.840.1.113883.9.195.4.13',
'2.16.840.1.113883.9.195.4.14',
'2.16.840.1.113883.9.195.4.15',
'2.16.840.1.113883.9.195.4.16',
'2.16.840.1.113883.9.195.4.17',
'2.16.840.1.113883.9.195.4.18',
'2.16.840.1.113883.9.195.4.19',
'2.16.840.1.113883.9.195.4.20',
'2.16.840.1.113883.9.195.4.21',
'2.16.840.1.113883.9.195.4.22',
'2.16.840.1.113883.9.195.4.23',
'2.16.840.1.113883.9.195.4.24',
'2.16.840.1.113883.9.195.4.25',
'2.16.840.1.113883.9.195.4.26',
'2.16.840.1.113883.9.195.4.27',
'2.16.840.1.113883.9.195.4.28',
'2.16.840.1.113883.9.195.4.29',
'2.16.840.1.113883.9.195.4.30',
'2.16.840.1.113883.9.195.4.31',
'2.16.840.1.113883.9.195.4.32',
'2.16.840.1.113883.9.195.4.33',
'2.16.840.1.113883.9.195.4.34',
'2.16.840.1.113883.9.195.4.35',
'2.16.840.1.113883.9.195.4.36',
'2.16.840.1.113883.9.195.4.37',
'2.16.840.1.113883.9.195.4.38',
'2.16.840.1.113883.9.195.4.39',
'2.16.840.1.113883.9.195.4.40',
'2.16.840.1.113883.9.195.4.41',
'2.16.840.1.113883.9.195.4.42',
'2.16.840.1.113883.9.195.4.43',
'2.16.840.1.113883.9.195.4.44',
'2.16.840.1.113883.9.195.4.45',
'2.16.840.1.113883.9.195.4.46',
'2.16.840.1.113883.9.195.4.47',
'2.16.840.1.113883.9.195.4.48',
'2.16.840.1.113883.9.195.4.49',
'2.16.840.1.113883.9.195.4.50',
'2.16.840.1.113883.9.195.4.51',
'2.16.840.1.113883.9.195.4.52',
'2.16.840.1.113883.9.195.4.53',
'2.16.840.1.113883.9.195.4.54',
'2.16.840.1.113883.9.195.4.55',
'2.16.840.1.113883.9.195.4.56',
'2.16.840.1.113883.9.195.4.57',
'2.16.840.1.113883.9.195.4.58',
'2.16.840.1.113883.9.195.4.59',
'2.16.840.1.113883.9.195.4.60',
'2.16.840.1.113883.9.195.4.61',
'2.16.840.1.113883.9.195.4.62',
'2.16.840.1.113883.9.195.4.63',
'2.16.840.1.113883.9.195.4.64'
)"/>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>


    <xsl:template match="//ValueSet[name/@value=$oldNames]/fhir:extension/fhir:valueUri/@value">
        <xsl:copy>
            <xsl:call-template name="replace">
                <xsl:with-param name="string" select="."/>
                <xsl:with-param name="old" select="$oldNames"/>
                <xsl:with-param name="new" select="$newNames"/>
            </xsl:call-template>
        </xsl:copy>
    </xsl:template>

    <xsl:template name="replace">
        <xsl:param name="string"/>
        <xsl:param name="old"/>
        <xsl:param name="new"/>
        <xsl:variable name="newString">
    <xsl:value-of select="replace($string,$string,$new[1])"/>           
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="count($old) > 1">
                <xsl:call-template name="replace">
                    <xsl:with-param name="string" select="$newString"/>
                    <xsl:with-param name="old" select="$old[position() > 1]"/>
                    <xsl:with-param name="new" select="$new[position() > 1]"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$newString"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>