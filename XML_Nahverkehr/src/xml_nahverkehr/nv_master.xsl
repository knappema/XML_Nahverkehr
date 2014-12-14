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
				<script type="text/javascript" src="js/jquery-2.1.1-min.js"/>
				<script src="js/bootstrap.min.js"/>
				<script type="text/javascript" src="js/referenceLogic.js"/>
				<link rel="stylesheet" href="css/bootstrap.min.css"/>
				<link rel="stylesheet" href="css/bootstrap-theme.min.css"/>
			</head>
			
			<body>

				<!-- nav bar -->
				<nav class="navbar navbar-default static" role="navigation">
				  <div class="container-fluid static">
				    <div class="navbar-header static">
				    	<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
				      <a class="navbar-brand static" href="#">Nuremberg Local Transport</a>
				    </div>
				    <div class="collapse navbar-collapse static" id="navbar">
				      <!-- major view toggles -->
				      <ul class="nav navbar-nav">
				        <li><a class="routesToggle" href="#">Routes</a></li>
				        <li><a class="stationsToggle" href="#">Stations</a></li>
				        <li class="disabled"><a class="ticketsToggle">Tickets</a></li>
				        <li class="disabled"><a class="driversToggle">Drivers</a></li>
				        <li class="disabled"><a class="vehiclesToggle">Vehicles</a></li>
				      </ul>
				    </div>
				  </div>
				</nav>
				<!-- load all xsl-templates here -->
				<xsl:apply-templates select="st:stations"/>
				<xsl:apply-templates select="sc:schedules"/>
				<xsl:apply-templates select="rt:routes"/>
			</body>
			
		</html>
	</xsl:template>		

		
	<xsl:template match="rt:routes">	

		<!-- routes -->
		<div class="routeNames">
			<div class="container static">
				<div class="row static">
					<div class="col-md-2 col-xs-12 static">

						<div class="panel panel-default static">
							<div class="panel-heading static">Routes</div>
							<div class="list-group static">
								<xsl:for-each select="rt:route">
										<a href="#">
											<xsl:attribute name="class"><xsl:value-of select="@routeId"/> routeDetailToggle list-group-item</xsl:attribute>
											<xsl:value-of select="@routeId"/>   <span class="badge"><xsl:value-of select="@type"/></span>
										</a>
								</xsl:for-each>
							</div>
						</div>
					</div>

					<div class="col-md-4 col-xs-12 static">
						<!-- details for each route -->

						<div class="panel panel-default static">
							<div class="panel-heading static">Stations</div>
							<div>
								<xsl:for-each select="rt:route">
									<xsl:attribute name="class"><xsl:value-of select="@routeId"/> routeDetails list-group</xsl:attribute>
									<xsl:for-each select="rt:station">
												<a href="#">
													<xsl:attribute name="class"><xsl:value-of select="@stationId"/> stationDetailToggle station list-group-item</xsl:attribute>
														<xsl:value-of select="@stationId"/>
												</a>
									</xsl:for-each>
								</xsl:for-each>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="st:stations">
		<div class="stationNames">
			<div class="col-md-4 col-xs-12 static">
				<!-- details for each route -->
				<div class="panel panel-default static">
					<div class="panel-heading static">Stations</div>
					<div class="list-group static">
						<xsl:for-each select="st:station">
						<a href="#">
											<xsl:attribute name="class"><xsl:value-of select="@stationId"/> stationDetailToggle station list-group-item</xsl:attribute>
							<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
							<xsl:value-of select="@name"/>
						</a>
						</xsl:for-each>
					</div>
			</div>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="sc:schedules">
		<div class="container static">
			<div class="row static">
				<!-- schedule groups for each station -->
				<xsl:for-each select="sc:schedule">
						<div>
							<xsl:attribute name="class">schedule <xsl:value-of select="@stationId"/></xsl:attribute>
							<xsl:variable name="routeIdValue" select="@routeId"/>
								<!-- schedules for each station-->
								<xsl:for-each select="sc:departureTimes">
									<div class="col-md-offset-3 col-md-6 col-xs-12 static">
										
										<div class="panel panel-default static">
							
											<div class="panel-heading static">
												<xsl:value-of select="$routeIdValue" />&#160;&#160;<i class="glyphicon glyphicon-arrow-right"></i>&#160;&#160;<span class="destinationId"><xsl:value-of select="current()/@finalStationId"/></span>
											</div>

											<ul class="list-group static">
												<!-- departure times for one schedule -->
												<xsl:for-each select="sc:time">
										    	<li class="list-group-item"><xsl:value-of select="current()"/></li>
										  	</xsl:for-each>
										  </ul>

										</div>

									</div>
								</xsl:for-each>
						</div>
				</xsl:for-each>
			</div>
		</div>

	</xsl:template>
	
	
	
	
</xsl:stylesheet>