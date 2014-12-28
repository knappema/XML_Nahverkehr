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
                            <a class="home navbar-brand static" href="#">Nuremberg Local Transport</a>
                        </div>
                        <div class="collapse navbar-collapse static" id="navbar">
                            <!-- major view toggles -->
                            <ul class="nav navbar-nav">
                                <li>
                                    <a class="routesToggle" href="#">Routes</a>
                                </li>
                                <li>
                                    <a class="stationsToggle" href="#">Stations</a>
                                </li>
                                <li>
                                    <a class="ticketsToggle" href="#">Tickets</a>
                                </li>
                                <li>
                                    <a class="driversToggle" href="#">Drivers</a>
                                </li>
                                <li>
                                    <a class="vehiclesToggle" href="#">Vehicles</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class="title static">
                    <h2 class="text-center static">
                        Welcome
                    </h2>
                    <h2 class="text-center static">
                        to
                    </h2>
                    <h2 class="text-center static">
                        Nuremberg Local Transport System
                    </h2>
                </div>

                <!-- load all xsl-templates here -->
                <xsl:apply-templates select="st:stations"/>
                <xsl:apply-templates select="rt:routes"/>
                <xsl:apply-templates select="sc:schedules"/>
                <xsl:apply-templates select="ti:tickets"/>
                <xsl:apply-templates select="vh:vehicles"/>
                <xsl:apply-templates select="dr:drivers"/>
                <xsl:apply-templates select="dr:drivers/dr:driver"/>
            </body>

        </html>
    </xsl:template>

    <!-- routes view -->
    <xsl:template match="rt:routes">
        <div class="routeNames">
            <div class="col-md-2 col-xs-12 static">
                <div class="panel panel-default static">
                    <div class="panel-heading static">Routes</div>
                    <div class="list-group static">
                        <xsl:for-each select="rt:route">
                            <a href="#">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="@routeId"/> routeDetailToggle list-group-item</xsl:attribute>
                                <xsl:value-of select="@routeId"/>
                                <span class="badge">
                                    <xsl:value-of select="@type"/>
                                </span>
                            </a>
                        </xsl:for-each>
                    </div>
                </div>
            </div>

            <xsl:for-each select="rt:route">
                <div class="col-md-4 col-xs-12">
                    <xsl:attribute name="class">
                        <xsl:value-of select="@routeId"/> routeDetails col-md-4 col-xs-12</xsl:attribute>
                    <!-- details for each route -->
                    <div class="panel panel-default static">
                        <div class="panel-heading static">Stations</div>
                        <div class="list-group static">

                            <xsl:attribute name="class">
                                <xsl:value-of select="@routeId"/> routeDetails list-group</xsl:attribute>
                            <xsl:for-each select="rt:station">
                                <a href="#">
                                    <xsl:attribute name="class">
                                        <xsl:value-of select="@stationId"/> stationDetailToggle station list-group-item</xsl:attribute>
                                    <xsl:value-of select="@stationId"/>
                                </a>
                            </xsl:for-each>

                        </div>
                    </div>
                </div>
            </xsl:for-each>
        </div>
    </xsl:template>

    <!-- station view -->
    <xsl:template match="st:stations">
        <div class="stationNames">
            <div class="col-md-4 col-xs-12 static">
                <!-- details for each route -->
                <div class="panel panel-default static">
                    <div class="panel-heading static">Stations</div>
                    <div class="list-group static">
                        <xsl:for-each select="st:station">
                            <a href="#">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="@stationId"/> stationDetailToggle station list-group-item</xsl:attribute>
                                <xsl:attribute name="name">
                                    <xsl:value-of select="@name"/>
                                </xsl:attribute>
                                <xsl:value-of select="@name"/>
                            </a>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- station detail view -->
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
                            <div class="col-md-6 col-xs-12 static">

                                <div class="panel panel-default static">

                                    <div class="panel-heading static">
                                        <xsl:value-of select="$routeIdValue" />&#160;&#160;
                                        <i class="glyphicon glyphicon-arrow-right"></i>&#160;&#160;
                                        <span class="destinationId">
                                            <xsl:value-of select="current()/@finalStationId"/>
                                        </span>
                                    </div>

                                    <ul class="list-group static">
                                        <!-- departure times for one schedule -->
                                        <xsl:for-each select="sc:time">
                                            <li class="list-group-item">
                                                <xsl:value-of select="current()"/>
                                            </li>
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

    <!-- tickets view -->
    <xsl:template match="ti:tickets">
        <div class="ticketNames">
            <div class="col-md-4 col-xs-12 static">
                <xsl:for-each select="ti:ticket">
                    <!-- details for each ticket -->
                    <div class="panel panel-default static">
                        <div class="panel-heading static">
                            <xsl:value-of select="@type"/>
                        </div>
                        <div class="list-group static">
                            <div class="list-group-item static">
                                <div class="row static">
                                    <div class="col-md-6 static">
                                        <b>Fare zone</b>
                                    </div>
                                    <div class="col-md-6 static">
                                        <b>Price</b>
                                    </div>
                                </div>
                            </div>
                            <xsl:for-each select="ti:fares/ti:fare">
                                <div class="list-group-item static">
                                    <div class="row static">
                                        <div class="col-md-6 static">
                                            <xsl:value-of select="@type"/>
                                        </div>
                                        <div class="col-md-6 static">
                                            <xsl:value-of select="@price"/>
                                        </div>
                                    </div>
                                </div>
                            </xsl:for-each>
                        </div>
                    </div>
                </xsl:for-each>
            </div>
        </div>
    </xsl:template>

    <!-- vehicles view -->
    <xsl:template match="vh:vehicles">
        <div class="vehicleNames">
            <div class="col-md-6 col-xs-12 static">
                <div class="panel panel-default static">
                    <div class="panel-heading static">
                        Vehicles
                    </div>
                    <div class="list-group static">
                        <div class="list-group-item static">
                            <div class="row static">
                                <div class="col-md-4 static">
                                    <b>Licence plate</b>
                                </div>
                                <div class="col-md-3 static">
                                    <b>Type</b>
                                </div>
                                <div class="col-md-2 static">
                                    <b>Capacity</b>
                                </div>
                                <div class="col-md-3 static">
                                    <b>Build year</b>
                                </div>
                            </div>
                        </div>
                        <xsl:for-each select="vh:vehicle">
                            <!-- details for each vehicle -->
                            <div class="list-group-item static">
                                <div class="row static">
                                    <div class="col-md-4 static">
                                        <xsl:value-of select="@licensePlate"/>
                                    </div>
                                    <div class="col-md-3 static">
                                        <span class="badge">
                                            <xsl:value-of select="@type"/>
                                        </span>
                                    </div>
                                    <div class="col-md-2 static">
                                        <xsl:value-of select="@capacity"/>
                                    </div>
                                    <div class="col-md-3 static">
                                        <xsl:value-of select="@buildYear"/>
                                    </div>
                                </div>
                            </div>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- drivers view -->
    <xsl:template match="dr:drivers">
        <div class="driverNames">
            <div class="col-md-8 col-xs-12 static">
                <div class="panel panel-default static">
                    <div class="panel-heading static">
                        Drivers
                    </div>
                    <div class="list-group static">
                        <div class="list-group-item static">
                            <div class="row static">
                                <div class="col-md-1 static">
                                    <b>Id</b>
                                </div>
                                <div class="col-md-3 static">
                                    <b>First name</b>
                                </div>
                                <div class="col-md-3 static">
                                    <b>Name</b>
                                </div>
                                <div class="col-md-2 static">
                                    <b>Types</b>
                                </div>
                                <div class="col-md-3 static">
                                    <b>Phone</b>
                                </div>
                            </div>
                        </div>
                        <xsl:for-each select="dr:driver">
                            <!-- details for each driver -->
                            <a ref="#">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="@driverId"/> driverDetailToggle list-group-item static</xsl:attribute>
                                <div class="row static">
                                    <div class="col-md-1 static">
                                        <xsl:value-of select="@driverId"/>
                                    </div>
                                    <div class="col-md-3 static">
                                        <xsl:value-of select="@firstname"/>
                                    </div>
                                    <div class="col-md-3 static">
                                        <xsl:value-of select="@lastname"/>
                                    </div>
                                    <div class="col-md-2 static">
                                        <xsl:for-each select="dr:vehicle">
                                            <div class="static">
                                                <span class="badge">
                                                    <xsl:value-of select="@type"/>
                                                </span>
                                            </div>
                                        </xsl:for-each>
                                    </div>
                                    <div class="col-md-3 static">
                                        <xsl:value-of select="@phone"/>
                                    </div>
                                </div>
                            </a>
                        </xsl:for-each>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- driver detail view -->
    <!-- driver part (vehicle part if necessary) -->
    <xsl:template match="dr:driver">
        <div>
            <xsl:attribute name="class">driverDetails <xsl:value-of select="@driverId"/></xsl:attribute>

            <!-- general panel -->
            <div class="col-md-4 col-xs-12 static">
                <div class="panel panel-default static">
                    <div class="panel-heading static">
                        General
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                Id
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="@driverId"/>
                            </div>
                        </div>
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                First name
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="@firstname"/>
                            </div>
                        </div>
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                Name
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="@lastname"/>
                            </div>
                        </div>
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                Types
                            </div>
                            <div class="col-md-8 static">
                                <xsl:for-each select="dr:vehicle">
                                    <div class="static">
                                        <span class="badge">
                                            <xsl:value-of select="@type"/>
                                        </span>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </div>
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                Phone
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="@phone"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- address panel -->
            <div class="col-md-4 col-xs-12 static">
                <div class="panel panel-default static">
                    <div class="panel-heading static">
                        Address
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                Street
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="dr:homeaddress/dr:street"/>
                            </div>
                        </div>
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                House No.
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="dr:homeaddress/dr:houseNo"/>
                            </div>
                        </div>
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                Areacode
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="dr:homeaddress/dr:areacode"/>
                            </div>
                        </div>
                    </div>
                    <div class=" list-group-item static">
                        <div class="row static">
                            <div class="col-md-4 static">
                                Town
                            </div>
                            <div class="col-md-8 static">
                                <xsl:value-of select="dr:homeaddress/dr:town"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </xsl:template>


</xsl:stylesheet>