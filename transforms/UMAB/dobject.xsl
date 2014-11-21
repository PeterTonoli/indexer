<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    EAC-CPF to Apache Solr Input Document Format Transform
    Copyright 2013 eScholarship Research Centre, University of Melbourne
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
-->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:str="http://exslt.org/strings"
    extension-element-prefixes="str"
    version="1.0">

    <xsl:import href="../lib/dobject-common.xsl" />

    <xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes" />
    <xsl:template match="/">
        <add>
            <doc>
                <xsl:call-template name="dobject-common" />
                <xsl:for-each select="str:split(//dl[@class='content-summary']/dd[@class='dointepretation']/p, '; ')">
                    <xsl:variable name="count" select="position()" />
                    <xsl:choose>
                        <xsl:when test="$count &lt; 3">
                            <field name="{concat('level', $count)}"><xsl:value-of select="." /></field>
                        </xsl:when>
                        <xsl:when test="$count &gt;= 3">
                            <field name="tag"><xsl:value-of select="." /></field>
                        </xsl:when>
                    </xsl:choose>
                </xsl:for-each>
            </doc>
        </add>
    </xsl:template>
</xsl:stylesheet>