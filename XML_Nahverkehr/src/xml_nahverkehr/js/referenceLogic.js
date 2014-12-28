$(document).ready(function(){
			// hide everything except static page elements
			$('div:not(.static)').hide(); 
                        
                        
                        // show home
                        $(".home").click(function(){
                                $('div:not(.static)').hide(); 
                                $('.title').show();
                        });
			
			
			// show all routes
			$(".routesToggle").click(function(){
				$('div:not(.routeNames, .static)').hide(); 
                                $('.title').hide();
				$('.routeNames').show();  
				$(".routeDetails").hide();
			});
			
			// show stations within a route
			$(".routeDetailToggle").click(function(){
				var route = $(this).attr('class');
				route = route.replace(" routeDetailToggle", "");
				route = route.replace(" list-group-item", "");
				
				// hide any existing schedules that are being shown
				$(".schedule").hide(); 

				// only show stations of the selectd route
				$('.routeDetails').hide();
				var routeDetails = $('.' +route + '.routeDetails');
				routeDetails.show();
				
				// turn station IDs to station names
				var stationIdArray = routeDetails.find('a');
				$.each(stationIdArray, function(){$(this).text(getStationNameFromId($(this).text()))});
			});
			
			
			// show all stations
			$(".stationsToggle").click(function(){
				$('div:not(.stationNames, .static)').hide(); 
                                $('.title').hide();
				$('.stationNames').show();  
			});
			
			// toggle schedule details for selected station
			$(".stationDetailToggle").click(function(){
				var id = $(this).attr('class');
				id = id.replace(" stationDetailToggle", "");
				id = id.replace(" station", "");
				id = id.replace(" list-group-item", "");
				$(".schedule").hide(); 
				$(".schedule." +id).show();
				
				// turn destionation station IDs to station names
				var destinationIdArray = $(".schedule." +id).find('.destinationId');
				$.each(destinationIdArray, function(){
					$(this).text(getStationNameFromId($(this).text()));
				});
				
			});
                        
                        // show all tickets
			$(".ticketsToggle").click(function(){
				$('div:not(.ticketNames, .static)').hide();
                                $('.title').hide();
				$('.ticketNames').show();  
			});

                        // show all vehicles
			$(".vehiclesToggle").click(function(){
				$('div:not(.vehicleNames, .static)').hide();
                                $('.title').hide();
				$('.vehicleNames').show();  
			});
                        
                        // show all drivers
			$(".driversToggle").click(function(){
				$('div:not(.driverNames, .static)').hide();
                                $('.title').hide();
				$('.driverNames').show();  
			});
			
			function getStationNameFromId(stationId){
                            var name = null;
                            name = $('.' + stationId + '.station').attr('name');
                            // replace all spaces with real spaces
                            return name == null ? stationId : name.replace(/%20/g, " ");
			}
			
});