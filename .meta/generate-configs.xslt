<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
                xmlns:lkk="http://www.github.com/lukke100"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="UTF-8" method="text"/>

  <xsl:template match="lkk:ref">
    <xsl:variable name="curr-name" select="@name"/>
    <xsl:variable name="curr-defs" select="/*/lkk:declare[@name = $curr-name]"/>

    <!-- TODO: handle missing and duplicate declarations -->

    <xsl:value-of select="$curr-defs/@value"/>
  </xsl:template>

</xsl:stylesheet>
