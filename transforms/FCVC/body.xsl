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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes" />
    <xsl:template match="/">
        <add>
            <doc>
                <field name="id"><xsl:value-of select="//meta[@name='DC.Identifier']/@content" /></field>
                <field name="creator"><xsl:value-of select="//meta[@name='DC.Creator']/@content" /></field>
                <field name="type">Text</field>
                <field name="name"><xsl:value-of select="//meta[@name='DC.Title']/@content" /></field>
                <field name="text"><xsl:value-of select="//body" /></field>
                <field name="state_long">Victoria</field>
                <field name="state_short">VIC</field>
            </doc>
        </add>
    </xsl:template>
</xsl:stylesheet>