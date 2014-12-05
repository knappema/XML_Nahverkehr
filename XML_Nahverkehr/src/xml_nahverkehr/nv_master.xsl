<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" 	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns:st="nv_stations.dtd"
								xmlns:dr="nv_drivers.dtd" 
								xmlns:vh="nv_vehicles.dtd" 
								xmlns:rt="nv_routes.dtd"
								xmlns:sc="nv_schedules.dtd"
								xmlns:ti="nv_tickets.dtd">
	<xsl:template match="/">
		<html>
			<body>
				<xsl:for-each select="/master/st:stations/st:station">
					<p><xsl:value-of select="@name"/></p>
				</xsl:for-each>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>