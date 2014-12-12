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
			
			// show stations within a route
			$(".routeDetailToggle").click(function(){
				var route = $(this).attr('class');
				route = route.replace(" routeDetailToggle", "");
				console.log(route);
				
				// only show stations of the selectd route
				$('.routeDetails').hide();
				var routeDetails = $('.' +route + '.routeDetails');
				routeDetails.show();
				
				// turn station IDs to station names
				var stationIdArray = routeDetails.find('td');
				$.each(stationIdArray, function(){$(this).text(getStationNameFromId($(this).text()))});
			})
			
			
			// show all stations
			$(".stationsToggle").click(function(){
				$('div:not(.stationNames, .static)').hide(); 
				$('.stationNames').show();  
			})
			
			// toggle schedule details for selected station
			$(".stationDetailToggle").click(function(){
				//$('.scheduleIds').show();

				var id = $(this).attr('class');
				id = id.replace(" stationDetailToggle", "");
				id = id.replace(" station", "");
				$(".schedule").hide(); 
				$(".schedule." +id).show();
				
				// turn destionation station IDs to station names
				var destinationIdArray = $(".schedule." +id).find('.destinationId');
				$.each(destinationIdArray, function(){
					$(this).text(getStationNameFromId($(this).text()));
				});
				
			})
			
			function getStationNameFromId(stationId){
				return $('.' + stationId + '.station').attr('name');
			}
			
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
							<xsl:attribute name="class"><xsl:value-of select="@routeId"/> routeDetailToggle</xsl:attribute>
							<xsl:value-of select="@routeId"/>  (<xsl:value-of select="@type"/>)
						</a>
						</td>
					</tr>
				</xsl:for-each>
				</table>
				<xsl:for-each select="rt:route">
					<span>
						<xsl:attribute name="class"><xsl:value-of select="@routeId"/> routeDetails</xsl:attribute>
						<table>
							<xsl:for-each select="rt:station">
								<tr>
									<td>
										 <xsl:variable name="thisStationId" select="@stationId"/>
										<xsl:value-of select="@stationId"/>
									</td>
								</tr>
							</xsl:for-each>
						</table>
					</span>
				</xsl:for-each>
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
								<xsl:attribute name="class"><xsl:value-of select="@stationId"/> stationDetailToggle station</xsl:attribute>
								<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
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
					<xsl:value-of select="@routeId"/><br/>
						<xsl:for-each select="sc:departureTimes">
							Richtung: <span class="destinationId"><xsl:value-of select="current()/@finalStationId"/></span>

							
							<xsl:for-each select="sc:time">
								<p><xsl:value-of select="current()"/></p>
							</xsl:for-each>
						</xsl:for-each>
					
				</div>
			</xsl:for-each>
	</xsl:template>
	
	
	
	
</xsl:stylesheet>