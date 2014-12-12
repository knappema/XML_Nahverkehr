<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								xmlns:st="nv_stations.dtd"
								xmlns:dr="nv_drivers.dtd" 
								xmlns:vh="nv_vehicles.dtd" 
								xmlns:rt="nv_routes.dtd"
								xmlns:sc="nv_schedules.dtd"
								xmlns:ti="nv_tickets.dtd">
								
	<xsl:template match="master">
		<html>
		
			<head>
				<script type="text/javascript" src="js/jquery-2.1.1-min.js"></script>
			</head>
			
			<!-- toggle different views via jQuery -->
			<script>
			
			// hide everything except static page elements
			$('div:not(.static)').hide(); 
			
			
			// show all routes
			$(".routesToggle").click(function(){
				$('div:not(.routeNames, .static)').hide(); 
				$('.routeNames').show();  
				$(".routeDetails").hide();
			})
			
			$(".detailToggle").click(function(){
				var route = $(this).attr('class');
				route = route.replace(" detailToggle", "");
				console.log(route);
				//TODO FIX THIS SHIT
				$('.'+route+'.routeDetails').show();
			})
			
			// show all stations
			$(".stationsToggle").click(function(){
				$('div:not(.stationNames, .static)').hide(); 
				$('.stationNames').show();  
			})
			
			// toggle schedule details for selected station
			$(".detailToggle").click(function(){
				//$('.scheduleIds').show();

				var id = $(this).attr('class');
				id = id.replace(" detailToggle", "");
				
				$(".schedule").hide(); 
				$(".schedule." +id).show();
			})
			
			</script>

			<body>
				<h1>Nürnberg Nahverkehr</h1>
			
				<!-- major view toggles -->
				<div class="navBar static">
					<button class="routesToggle">Routes</button>
					<button class="stationsToggle">Stations</button>
					<button class="ticketsToggle">Tickets</button>
					<button class="driversToggle">Drivers</button>
					<button class="vehiclesToggle">Vehicles</button>
				</div>
			
			
				<!-- load all xsl-templates here -->
				<xsl:apply-templates select="st:stations"/>
				<xsl:apply-templates select="sc:schedules"/>
				<xsl:apply-templates select="rt:routes"/>
			</body>
			
		</html>
	</xsl:template>		

		
	<xsl:template match="rt:routes">	
		<div class="routeNames">
				<table>
				<tr>
					<th>Route Name</th>
				</tr>
				<xsl:for-each select="rt:route">
				<tr>
					<td>
					<a href="#">
						<xsl:attribute name="class"><xsl:value-of select="@routeId"/> detailToggle</xsl:attribute>
						<xsl:value-of select="@routeId"/>
					</a>
					</td>
				</tr>
				</xsl:for-each>
				</table>
				
				<span>
					<xsl:attribute name="class">routeDetails</xsl:attribute>
					<table>
					<xsl:for-each select="rt:route/rt:station">
						
						<tr>
							<td>
								stationId: <xsl:value-of select="@stationId"/>
							</td>
						</tr>
					</xsl:for-each>
					</table>
				</span>
				
		</div>
	</xsl:template>
	
	<xsl:template match="st:stations">
		<div class="stationNames">
		
				<table>
				<tr>
					<th>Station Name</th>
				</tr>
				<xsl:for-each select="st:station">
				<tr>
					<td>
					<a href="#">
						<xsl:attribute name="class"><xsl:value-of select="@stationId"/> detailToggle</xsl:attribute>
						<xsl:value-of select="@name"/>
					</a>
					</td>
				</tr>
				</xsl:for-each>
				</table>
		</div>
	</xsl:template>
	
	<xsl:template match="sc:schedules">
			<xsl:for-each select="sc:schedule">
				<div>
					<xsl:attribute name="class">schedule <xsl:value-of select="@stationId"/></xsl:attribute>
					<xsl:value-of select="@routeId"/>
					<xsl:for-each select="sc:departureTimes"></xsl:for-each>
						<xsl:for-each select="sc:departureTimes">
							Richtung: <xsl:value-of select="current()/@finalStationId"/>

							
							<xsl:for-each select="sc:time">
							<p><xsl:value-of select="current()"/></p>
						</xsl:for-each>
					</xsl:for-each>
				</div>
			</xsl:for-each>
	</xsl:template>
	
	
	
	
</xsl:stylesheet>