<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="splitter_v2.xslt"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fhir="http://hl7.org/fhir">
	<!--xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" name="xml"/-->
	<xsl:output method="xml" indent="yes"/>
	<!--check if attribute is non null value and if so skip the transform-->
	<xsl:variable name="status" select="fn:lower-case(ValueSetLibrary/@Status)"/>
	<xsl:variable name="version" select="ValueSetLibrary/@ValueSetLibraryVersion"/>
	<xsl:variable name="date" select="ValueSetLibrary/@DateCreated"/>
	<xsl:variable name="publisher" select="ValueSetLibrary/@OrganizationName"/>
	<xsl:variable name="identifier-root" select="ValueSetLibrary/@ValueSetLibraryIdentifier"/>
	<xsl:variable name="library-name" select="ValueSetLibrary/@Name"/>
	<xsl:variable name="library-description" select="ValueSetLibrary/@Description"/>
	<xsl:template match="/">
		<!--convert to FHIR bundle-->
		<Bundle>
			<!-- from Resource: id, meta, implicitRules, and language -->
			<id value="{$identifier-root}"/>
			<type value="collection"/>
			<!-- 1..1 document | message | transaction | transaction-response | batch | batch-response | history | searchset | collection -->
			<link>
				<!-- 0..* Links related to this Bundle -->
				<relation value="about"/>
				<!-- 1..1 http://www.iana.org/assignments/link-relations/link-relations.xhtml -->
				<url value="http://www.hl7.org/implement/standards/product_brief.cfm?product_id=279"/>
				<!-- 1..1 Reference details for the link -->
			</link>
			<link>
				<!-- 0..* Links related to this Bundle -->
				<relation value="derivedfrom"/>
				<!-- 1..1 http://www.iana.org/assignments/link-relations/link-relations.xhtml -->
				<url value="http://www.hl7.org/implement/standards/product_brief.cfm?product_id=???"/>
				<!-- 1..1 Reference details for the link -->
			</link>
			<xsl:apply-templates mode="list"/>
			<!-- create list resource as first entry in bundle-->
			<xsl:apply-templates mode="xml"/>
			<!--populate rest of bundle with the actual value set resources-->
			<!-- value set resources-->
		</Bundle>
	</xsl:template>
	<xsl:template match="/ValueSetLibrary/NoValidation" mode="xml"/>
	<xsl:template match="/ValueSetLibrary/NoValidation" mode="list"/>
	<xsl:template match="/ValueSetLibrary/NoValidation" mode="xhtml-list"/>
	<xsl:template match="ValueSetLibrary" mode="list">
		<entry>
			<!-- 0..* Entry in the bundle - will have a resource, or information -->
			<!--link-->
			<!-- 0..* Content as for Bundle.link Links related to this entry-->
			<!--/link-->
			<fullUrl>
				<xsl:call-template name="list-url"/>
			</fullUrl>
			<!-- 0..1 Absolute URL for resource (server address, or UUID/OID) -->
			<resource>
				<List>
					<!-- from Resource: id, meta, implicitRules, and language -->
					<id value="{$date}{$library-name}"/>
					<xsl:apply-templates select="current()" mode="xhtml-list"/>
					<!--xhtml templates for narrative-->
					<!-- from DomainResource: text, contained, extension, and modifierExtension -->
					<identifier>
						<value value="{$library-name}"/>
					</identifier>
					<title value="{$library-name}"/>
					<!-- 0..1 Descriptive name for the list -->
					<source>
						<display value="{$publisher}"/>
						<!-- 0..1 Text alternative for the resource -->
						<!-- 0..1 Reference(Practitioner|Patient|Device) Who and/or what defined the list contents (aka Author) -->
					</source>
					<status value="current"/>
					<!-- 1..1 current | retired | entered-in-error -->
					<date value="{if ($date) then ($date) else '2015-12-01'}"/>
					<!-- 0..1 When the list was prepared -->
					<orderedBy>
						<coding>
							<system value="http://hl7.org/fhir/list-order"/>
							<!-- 0..1 Identity of the terminology system -->
							<code value="system"/>
							<!-- 0..1 Symbol in syntax defined by the system -->
							<display value="Sorted by system"/>
							<!-- 0..1 Representation defined by the system -->
							<!-- 0..1 CodeableConcept What order the list has -->
						</coding>
					</orderedBy>
					<mode value="working"/>
					<!-- 1..1 working | snapshot | changes -->
					<note value="{$library-description}"/>
					<!-- 0..1 Comments about the list -->
					<xsl:apply-templates mode="list"/>
				</List>
			</resource>
			<!--<request>-->
			<!-- ?? 0..1 Transaction Related Information -->
			<!--<method value="PUT"/>-->
			<!-- 1..1 GET | POST | PUT | DELETE -->
			<!--<url><xsl:call-template name="list-url"></xsl:call-template></url>-->
			<!-- 1..1 URL for HTTP equivalent of this entry -->
			<!--</request>-->
		</entry>
	</xsl:template>
	<xsl:template name="list-url">
		<xsl:attribute name="value">
			<xsl:text>List/</xsl:text>
			<xsl:value-of select="$date"/>
			<xsl:value-of select="$library-name"/>
		</xsl:attribute>
	</xsl:template>
	<xsl:template match="ValueSetDefinition" mode="list">
		<entry>
			<!-- ?? 0..* Entries in the list -->
			<item>
				<reference>
					<xsl:attribute name="value">
						<xsl:text>ValueSet/</xsl:text>
						<xsl:call-template name="generate-oid"/>
					</xsl:attribute>
				</reference>
				<!-- ?? 0..1 Relative, internal or absolute URL reference -->
				<display value="{@Name}"/>
				<!-- 0..1 Text alternative for the resource -->
				<!-- 1..1 Reference(Any) Actual entry -->
			</item>
		</entry>
	</xsl:template>
	<xsl:template match="ValueSetLibrary" mode="xhtml-list">
		<text>
			<!-- ?? 0..1 Narrative Text summary of the resource, for human interpretation -->
			<status value="generated"/>
			<!-- 1..1 generated | extensions | additional | empty -->
			<div xmlns="http://www.w3.org/1999/xhtml">
				<h3>Value Set Library </h3>
				<p>Value: <xsl:value-of select="$library-name"/>
				</p>
				<p>ID: <xsl:value-of select="$identifier-root"/>
				</p>
				<p>Source: <xsl:value-of select="$publisher"/>
				</p>
				<p>Status: <xsl:value-of select="$status"/>
				</p>
				<p>Date: <xsl:value-of select="if ($date) then ($date) else '12/01/2105'"/>
				</p>
				<p>Description: <xsl:value-of select="@Description"/>
				</p>
				<ol>
					<xsl:apply-templates mode="xhtml-list"/>
				</ol>
			</div>
		</text>
	</xsl:template>
	<xsl:template match="ValueSetDefinition" mode="xhtml-list">
		<li xmlns="http://www.w3.org/1999/xhtml">
			<a>
				<xsl:attribute name="href">
					<xsl:text>ValueSet/</xsl:text>
					<xsl:call-template name="generate-oid"/>
				</xsl:attribute>
				Valueset-ID: <xsl:value-of select="fn:concat(@BindingIdentifier,'-',$library-name)"/> (<xsl:value-of select="MessageLocation"/>-<xsl:value-of select="@Name"/>)
				</a>
		</li>
	</xsl:template>
	<xsl:template name="generate-oid">
		<xsl:text>2.16.840.1.113883.9.16.100.</xsl:text>
		<xsl:number count="ValueSetDefinition" level="any"/>
	</xsl:template>
	<xsl:template match="ValueSetDefinition" mode="xml">
		<!--xsl:variable name="filename" select="@BindingIdentifier"/-->
		<!--for splitting the file into separate files-->
		<!--xsl:variable name="filename" select="@BindingIdentifier"/-->
		<!--xsl:variable name="filename" select="@BindingIdentifier"/-->
		<!--xsl:result-document href="./output/{$filename}.xml" format="xml"-->
		<entry>
			<!-- 0..* Entry in the bundle - will have a resource, or information -->
			<!--link-->
			<!-- 0..* Content as for Bundle.link Links related to this entry-->
			<!--/link-->
			<fullUrl>
				<xsl:attribute name="value">
					<xsl:text>urn:oid:</xsl:text>
					<xsl:call-template name="generate-oid"/>
				</xsl:attribute>
			</fullUrl>
			<!-- 0..1 Absolute URL for resource (server address, or UUID/OID) -->
			<resource>
				<ValueSet>
					<id>
						<xsl:attribute name="value">
							<xsl:call-template name="generate-oid"/>
						</xsl:attribute>
					</id>
					<xsl:apply-templates select="current()" mode="xhtml"/>
					<!--xhtml templates foid narrative-->
					<!-- OID assigned to the value set or code system -->
					<extension xmlns="http://hl7.org/fhir" url="http://hl7.org/fhir/StructureDefinition/valueset-oid">
						<!-- from Element: extension -->
						<valueUri value="urn:oid:{@Oid}"/>
						<!-- 1..1 Value of extension -->
					</extension>
					<identifier>
						<value value="{@BindingIdentifier}-{$library-name}"/>
						<!-- 0..1 The value that is unique -->
						<!-- 0..1 Identifier Additional identifier for the value set (e.g. HL7 v2 / CDA) -->
					</identifier>
					<version value="{@Version}"/>
					<!-- 0..1 Logical identifier for this version of the value set -->
					<name value="{@Name}"/>
					<!-- 0..1 Informal name for this value set -->
					<status value="{$status}"/>
					<!-- 1..1 draft | active | retired -->
					<publisher value="{$publisher}"/>
					<!-- 0..1 Name of the publisher (organization or individual) -->
					<date value="{if ($date) then ($date) else '2015-12-01'}"/>
					<!-- 0..1 Date for given status   todo - need to format this or default to date if is empty-->
					<xsl:variable name="var" select="@Description"/>
					<xsl:if test="$var != ''">
						<description value="{$var}"/>
					</xsl:if>
					<!-- 0..1 Human language description of the value set -->
					<xsl:variable name="var" select="MessageLocation"/>
					<xsl:if test="$var != ''">
						<requirements value="{$var}"/>
					</xsl:if>
					<!-- 0..1 Why needed -->
					<xsl:variable name="var" select="@Extensibility"/>
					<xsl:if test="$var != ''">
						<extensible value="{if ($var='Open') then 'true' else 'false'}"/>
					</xsl:if>
					<!-- 0..1 Whether this is intended to be used with an extensible binding -->
					<compose>
						<!-- add included codes for ValueSet-->
						<!-- ?? 0..1 When value set includes codes from elsewhere -->
						<include>
							<xsl:variable name="var" select="ValueElement[1]/@CodeSystem"/>
							<xsl:if test="($var) and ($var != '')">
								<system value="{$var}"/>
							</xsl:if>
							<xsl:if test="(not($var)) or ($var = '')">
								<system value="system missing"/>
							</xsl:if>
							<xsl:variable name="var" select="ValueElement[1]/@CodeSystemVersion"/>
							<xsl:if test="($var) and ($var != '')">
								<version value="{$var}"/>
							</xsl:if>
							<xsl:if test="(not($var)) or ($var = '')">
								<version value="version missing"/>
							</xsl:if>
							<xsl:apply-templates mode="xml"/>
						</include>
					</compose>
				</ValueSet>
			</resource>
			<!--/xsl:result-document-->
			<!-- <request>-->
			<!-- ?? 0..1 Transaction Related Information -->
			<!-- <method value="PUT"/>-->
			<!-- 1..1 GET | POST | PUT | DELETE -->
			<!--  <url>
               <xsl:attribute name="value">
                 <xsl:text>ValueSet/</xsl:text>
                 <xsl:call-template name="generate-oid"/>
               </xsl:attribute>
             </url-->
			<!-- 1..1 URL for HTTP equivalent of this entry -->
			<!-- </request>-->
		</entry>
	</xsl:template>
	<xsl:template match="ValueSetDefinition" mode="xhtml">
		<!--xhtml templates for narrative-->
		<text>
			<!-- ?? 0..1 Narrative Text summary of the resource, for human interpretation -->
			<status value="generated"/>
			<!-- 1..1 generated | extensions | additional | empty -->
			<div xmlns="http://www.w3.org/1999/xhtml">
				<p>
					<xsl:text/>Valueset-OID: urn:oid:<xsl:value-of select="@Oid"/>
				</p>
				<!-- Limited xhtml content< -->
				<p>Valueset-ID: <xsl:value-of select="fn:concat(@BindingIdentifier,'-',$library-name)"/>
				</p>
				<p>Version: <xsl:value-of select="@Version"/>
				</p>
				<p>Name: <xsl:value-of select="@Name"/>
				</p>
				<p>Status: <xsl:value-of select="$status"/>
				</p>
				<p>Publisher: <xsl:value-of select="$publisher"/>
				</p>
				<p>Date: <xsl:value-of select="if ($date) then ($date) else '12/01/2105'"/>
				</p>
				<p>Description: <xsl:value-of select="@Description"/>
				</p>
				<p>Context: <xsl:value-of select="MessageLocation"/>
				</p>
				<p>Extensibility: <xsl:value-of select="@Extensibility"/>
				</p>
				<p/>
				<table border="1" cellpadding="1">
					<tbody>
						<tr>
							<th>No.</th>
							<th>Usage</th>
							<th>Code</th>
							<th>Display Term</th>
							<th>Code System</th>
							<!--th>Code System Version</th-->
							<th>Comments</th>
						</tr>
						<xsl:apply-templates mode="xhtml">
							<xsl:sort select="@Usage" order="descending"/>
						</xsl:apply-templates>
					</tbody>
				</table>
			</div>
		</text>
	</xsl:template>
	<xsl:template match="ValueElement" mode="xhtml">
		<tr xmlns="http://www.w3.org/1999/xhtml">
			<td>
				<xsl:value-of select="position()"/>
			</td>
			<td>
				<xsl:value-of select="@Usage"/>
			</td>
			<td>
				<xsl:value-of select="@Value"/>
			</td>
			<td>
				<xsl:value-of select="@DisplayName"/>
			</td>
			<td>
				<xsl:value-of select="@CodeSystem"/>
			</td>
			<td>
				<xsl:value-of select="@Comments"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="MessageLocation" mode="xhtml"/>
	<xsl:template match="MessageLocation" mode="xml"/>
	<xsl:template match="ValueElement" mode="xml">
		<concept xmlns="http://hl7.org/fhir">
			<xsl:variable name="var" select="@Usage"/>
			<xsl:if test="$var != ''">
				<extension xmlns="http://hl7.org/fhir" url="http://hl7.org/fhir/us/lab/StructureDefinition/code-usage">
					<!-- from Element: extension -->
					<valueCode value="{$var}"/>
					<!-- 1..1 Value of extension -->
				</extension>
			</xsl:if>
			<xsl:variable name="var" select="@Comments"/>
			<xsl:if test="$var != ''">
				<extension xmlns="http://hl7.org/fhir" url="http://hl7.org/fhir/StructureDefinition/valueset-comments">
					<!-- from Element: extension -->
					<valueString value="{$var}"/>
					<!-- 1..1 Value of extension EH if Null don't populate -->
				</extension>
			</xsl:if>
			<!-- ?? 0..* A concept defined in the system -->
			<xsl:variable name="var" select="@Value"/>
			<xsl:if test="$var != ''">
				<code value="{$var}"/>
			</xsl:if>
			<xsl:if test="$var = ''">
				<code value="code missing"/>
			</xsl:if>
			<!-- 1..1 Code or expression from system -->
			<xsl:variable name="var" select="@DisplayName"/>
			<xsl:if test="$var != ''">
				<display value="{$var}"/>
			</xsl:if>
			<!-- 0..1 Test to display for this code for this value set -->
		</concept>
	</xsl:template>
</xsl:stylesheet>
