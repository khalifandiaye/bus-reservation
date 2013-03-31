(function($) {
    var logger = null;
    logger = {
        log : function(message) {
            if (console) {
                console.log(message);
            }
        },
        logInfo : function(message) {
            if (console && logger && logger.info) {
                if (Object.prototype.toString.call(message) == '[object String]') {
                    console.log('INFO: ' + message);
                } else {
                    console.log(message);
                }
            }
        },
        logError : function(message) {
            if (console && logger && logger.error) {
                if (Object.prototype.toString.call(message) == '[object String]') {
                    console.log('ERROR: ' + message);
                } else {
                    console.log(message);
                }
            }
        },
        logDebug : function(message) {
            if (console && logger && logger.debug) {
                if (Object.prototype.toString.call(message) == '[object String]') {
                    console.log('DEBUG: ' + message);
                } else {
                    console.log(message);
                }
            }
        },
        debug : true,
        info : true,
        error : true,
    };
    var directionsService = null;
    var methods = null;
    var pluginName = "jQuery.customGMap";
    methods = {
        initialize : function(options) {
            return this.each(function() {
                var map;
                var style = null;
                var opts = {
                    enableRoute : false,
                    hideMapLabels : false,
                    mapOptions : {
                        center : new google.maps.LatLng(16.0667,
                                107.2333),
                        zoom : 6,
                        disableDoubleClickZoom : true,
                        keyboardShortcuts : false,
                        draggable : false,
                        disableDefaultUI : true,
                        minZoom : 6,
                        maxZoom : 6,
                        mapTypeId : google.maps.MapTypeId.ROADMAP,
                    }
                };
                $.extend(true, opts, options);

                var temp = null;
                style = [
                        {
                            featureType : "all",
                            elementType : "labels",
                            stylers : [ {
                                visibility : opts.hideMapLabels ? "on"
                                        : "off"
                            } ]
                        },
                        {
                            featureType : "administrative",
                            elementType : "labels",
                            stylers : [ {
                                visibility : opts.showAdministrativeLabel ? "on"
                                        : "off"
                            } ]
                        },
                        {
                            featureType : "poi",
                            elementType : "labels",
                            stylers : [ {
                                visibility : opts.showPoILabel ? "on"
                                        : "off"
                            } ]
                        },
                        {
                            featureType : "water",
                            elementType : "labels",
                            stylers : [ {
                                visibility : opts.showWaterLabel ? "on"
                                        : "off"
                            } ]
                        },
                        {
                            featureType : "road",
                            elementType : "labels",
                            stylers : [ {
                                visibility : opts.showRoadLabel ? "on"
                                        : "off"
                            } ]
                        }, ];
                $.extend(true, style, opts.mapStyle);
                temp = [ 'hiddenLabelStyle' ];
                if (opts.mapOptions.mapTypeControlOptions) {
                    $
                            .merge(
                                    temp,
                                    opts.mapOptions.mapTypeControlOptions.mapTypeIds);
                    opts.mapOptions.mapTypeControlOptions.mapTypeIds = temp;
                } else {
                    $.merge(temp, [ google.maps.MapTypeId.ROADMAP ]);
                    opts.mapOptions.mapTypeControlOptions = {
                        mapTypeIds : temp,
                    };
                }
                opts.mapOptions.mapTypeId = 'hiddenLabelStyle';

                map = new google.maps.Map(this, opts.mapOptions);
                if (opts.hideMapLabels) {
                    map.mapTypes.set('hiddenLabelStyle',
                            new google.maps.StyledMapType(style, {
                                name : 'Hidden Label Style'
                            }));
                }
                $(this).data('map', map);
                if (opts.enableRoute) {
                    directionsService = new google.maps.DirectionsService();
                }
                logger.logInfo('CustomGMap initialized at ' + this);
            });
        },
        addMarker : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = null;
                if (options && options.routeId) {
                    var routes = $(this).data('routes');
                    if (!routes) {
                        routes = [];
                        $(this).data('routes', routes);
                    }
                    if (!routes[options.routeId]) {
                        routes[options.routeId] = {
                            markers : [],
                        };
                    }
                    markers = routes[options.routeId].markers;
                    if (!markers) {
                        markers = [];
                        routes[options.routeId].markers = markers;
                        logger
                                .logInfo('Created new marker list for route '
                                        + routeId);
                    }
                } else {
                    markers = $(this).data('markers');
                    if (!markers) {
                        markers = [];
                        $(this).data('markers', markers);
                        logger.logInfo('Created new marker list');
                    }
                }
                if (!options
                        || ((!options.latitude || !options.longitude) 
                                && (!options.markerOptions || !options.markerOptions.position))) {
                    logger.logError('Coordinates not specified!');
                    return;
                }
                if (map) {
                    var opts = {
                            labelPrefix : "",
                            displayMarkerLabels : false,
                            markerOptions : {
                                clickable : false,
                                draggable : false,
                                map : map,
                                labelAnchor: new google.maps.Point(50, 0),
                                labelClass: "marker-label",
                                labelStyle: {opacity: 1.00},
                            }
                        };
                    $.extend(true, opts, options);
                    if (opts.displayMarkerLabels) {
                        if (!opts.markerOptions.labelContent) {
                            opts.markerOptions.labelContent = opts.labelPrefix + (markers.length + 1);
                        }
                        if (!opts.markerOptions.labelAnchor) {
                            opts.markerOptions.labelAnchor = new google.maps.Point(50, 0);
                        }
                        if (!opts.markerOptions.labelClass) {
                            opts.markerOptions.labelClass = "marker-label";
                        }
                        if (!opts.markerOptions.labelStyle) {
                            opts.markerOptions.labelStyle = {opacity: 1.00};
                        }
                    }
                    if (!opts.markerOptions.position) {
                        opts.markerOptions.position = 
                            new google.maps.LatLng(opts.latitude, opts.longitude);
                    }
                    if (opts.hidden) {
                        opts.markerOptions.map = null;
                    }
                    logger.logDebug(opts.markerOptions);
                    if (opts.displayMarkerLabels) {
                        markers.push(new MarkerWithLabel(opts.markerOptions));
                    } else {
                        markers.push(new google.maps.Marker(opts.markerOptions));
                    }
                } else {
                    logger.logError('No map, no marker');
                }
            });
        },
        removeMarker : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = $(this).data('markers');
                var index = 0;
                if (!map) {
                    logger.logError('No map');
                    return;
                }
                if (!markers) {
                    logger.logError('No markers');
                    return;
                }
                if (!options || (isNaN(options) && (!options.index || isNaN(options.index)))) {
                    logger.logError('Index not specified!');
                    return;
                } else if (isNaN(options)) {
                    index = options.index;
                } else {
                    index = options;
                }
                var marker = markers[index];
                if (!marker) {
                    logger.logError('Invalid index: ' + index);
                    return;
                }
                marker.setMap(null);
                markers.splice(index, 1);
            });
        },
        removeMarkers : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = $(this).data('markers');
                var indices = 0;
                if (!map) {
                    logger.logError('No map');
                    return;
                }
                if (!markers) {
                    logger.logError('No markers');
                    return;
                }
                if (!options
                        || (!($.isArray(options))
                                && (!options.indices || !($.isArray(options.indices)))
                                && (!options.all))) {
                    logger.logError('Index not specified!');
                    return;
                } else if (options.all) {
                } else if (!($.isArray(options))) {
                    indices = options.indices;
                } else {
                    indices = options;
                }
                var marker;
                if (options.all) {
                    for (var i = 0; i < markers.length; i++) {
                        marker = markers[i];
                        marker.setMap(null);
                    }
                    markers.splice(0, markers.length);
                    logger.logDebug('All markers cleared');
                } else {
                    for (var i = 0; i < indices.length; i++) {
                        marker = markers[indices[i]];
                        if (!marker) {
                            logger.logError('Invalid index: ' + indices[i]);
                        }
                        marker.setMap(null);
                        markers.splice(indices[i], 1);
                    }
                }
            });
        },
        addRoute : function(options) {
            var map = $(this).data('map');
            var routes = null;
            var route = null;
            var markers = null;
            var waypoints = null;
            var directionsDisplay = null;
            var waypts = null;
            var request = null;
            var opts = {
                autoload : true,
                hidden : true,
            };
            if (!options) {
                logger.logError('Method addRoute in ' + pluginName
                        + ' require input parameters');
                return;
            }
            $.extend(opts, options);
            if (!opts.routeId) {
                logger.logError('Method addRoute in ' + pluginName
                        + ' require input parameter routeId');
                return;
            }
            routes = $(this).data('routes');
            if (!routes) {
                routes = [];
                $(this).data('routes', routes);
            }
            if (!opts.markers && !opts.waypoints) {
                logger.logError('Method addRoute in ' + pluginName
                        + ' require waypoints data');
                return;
            } else {
                markers = opts.markers;
                waypoints = opts.waypoints;
            }
            if (!map) {
                logger.logError('No map');
                return;
            }
            if (!directionsDisplay && (opts.autoload || !opts.hidden)) {
                directionsDisplay = new google.maps.DirectionsRenderer();
            }
            route = {
                marker : markers,
                directionsDisplay : directionsDisplay,
                waypoints : waypoints,
                status : 0,
            };
            routes[opts.routeId] = route;

            if (opts.autoload || !opts.hidden) {
                if (markers && markers.length > 2) {
                    waypts = [];
                    for ( var i = 1; i < markers.length - 1; i++) {
                        waypts.push({
                            location : markers[i].getPosition(),
                        });
                    }
                } else if (waypoints && waypoints.length > 2) {
                    waypts = [];
                    for ( var i = 1; i < waypoints.length - 1; i++) {
                        waypts.push({
                            location : new google.maps.LatLng(
                                    waypoints[i].latitude,
                                    waypoints[i].longitude),
                        });
                    }
                }
                logger.logDebug(markers);
                logger.logDebug(waypoints);
                request = {
                    origin : markers ? markers[0].getPosition()
                            : new google.maps.LatLng(waypoints[0].latitude,
                                    waypoints[0].longitude),
                    destination : markers ? markers[markers.length - 1]
                            .getPosition() : new google.maps.LatLng(
                            waypoints[waypoints.length - 1].latitude,
                            waypoints[waypoints.length - 1].longitude),
                    waypoints : waypts,
                    optimizeWaypoints : false,
                    travelMode : google.maps.TravelMode.DRIVING
                };
                $.extend(true, request, opts.request);
                if (!directionsService) {
                    directionsService = new google.maps.DirectionsService();
                }
                if (opts.hidden) {
                    route.status = 3;
                } else {
                    route.status = 1;
                }
                directionsService.route(request,
                        function(response, status) {
                            if (status == google.maps.DirectionsStatus.OK) {
                                directionsDisplay.setDirections(response);
                                if (route.status != 3) {
                                    directionsDisplay.setMap(map);
                                }
                                route.status = 2;
                            }
                        });
            }
        },
        showRoute : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = null;
                var directionsDisplay = null;
                var routeId = null;
                var routes = null;
                var waypoints = null;
                if (!map) {
                    logger.logError('No map');
                    return;
                }
                if (!options || (isNaN(options) && !options.routeId)) {
                    markers = $(this).data('markers');
                    directionsDisplay = $(this).data('directionsDisplay');
                    if (!directionsDisplay) {
                        directionsDisplay = new google.maps.DirectionsRenderer();
                        $(this).data('directionsDisplay', directionsDisplay);
                    }
                } else {
                    routeId = !isNaN(options) ? options : options.routeId;
                    routes = $(this).data('routes');
                    if (!routes) {
                        logger.logError('No routes');
                        return;
                    }
                    if (!routes[routeId]) {
                        logger.logError('No route ' + routeId);
                        return;
                    } else {
                        markers = routes[routeId].markers;
                        directionsDisplay = routes[routeId].directionsDisplay;
                        if (!directionsDisplay) {
                            directionsDisplay = new google.maps.DirectionsRenderer();
                            routes[routeId].directionsDisplay = directionsDisplay;
                        }
                        directionsDisplay.setMap(map);
                        waypoints = routes[routeId].waypoints;
                        if (!routes[routeId].status || routes[routeId].status != 2) {
                            routes[routeId].status = 1;
                        } else if (routes[routeId].status == 1) {
                            logger.logInfo('Loading');
                            return;
                        } else  if (routes[routeId].status == 2) {
                            directionsDisplay.setMap(map);
                            return;
                        } else {
                            logger.logInfo('Unknown status');
                        }
                    }
                }
                if (!markers && !waypoints) {
                    logger.logInfo('No waypoints');
                    return;
                } else if ((markers && markers.length < 2) || (waypoints && waypoints.length < 2)) {
                    logger.logInfo('Not enough waypoints');
                    return;
                }
                var waypts = null;
                if (markers && markers.length > 2) {
                    waypts = [];
                    for (var i = 1; i < markers.length - 1; i++) {
                        waypts.push({
                            location : markers[i].getPosition(),
                        });
                    }
                } else if (waypoints && waypoints.length > 2) {
                    waypts = [];
                    for (var i = 1; i < waypoints.length - 1; i++) {
                        waypts.push({
                            location : new google.maps.LatLng(waypoints[i].latitude, waypoints[i].longitude),
                        });
                    }
                }
                var opts = {
                    request : {
                        origin : markers ? markers[0].getPosition()
                                : new google.maps.LatLng(
                                        waypoints[0].latitude,
                                        waypoints[0].longitude),
                        destination : markers ? markers[markers.length - 1]
                                .getPosition()
                                : new google.maps.LatLng(
                                        waypoints[waypoints.length - 1].latitude,
                                        waypoints[waypoints.length - 1].longitude),
                        waypoints : waypts,
                        optimizeWaypoints : false,
                        travelMode : google.maps.TravelMode.DRIVING
                    }
                };
                $.extend(true, opts, options);
                if (options && options.travelMode) {
                    opts.request.travelMode = options.travelMode;
                }
                if (!directionsService) {
                    directionsService = new google.maps.DirectionsService();
                }
                directionsService.route(opts.request, function(response, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        logger.logDebug(response);
                        directionsDisplay.setDirections(response);
                        if (!routes || routes.status != 3) {
                            directionsDisplay.setMap(map);
                        }
                        if (routes) {
                            routes[routeId].status = 2;
                        }
                    }
                });
            });
        },
        hideRoute : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = $(this).data('markers');
                var directionsDisplay = $(this).data('directionsDisplay');
                var routes = $(this).data('routes');
                if (!map) {
                    logger.logError('No map');
                    return;
                }
                if (!markers) {
                    logger.logError('No markers');
                    return;
                }
                if (directionsDisplay) {
                    directionsDisplay.setMap(null);
                }
                if (routes) {
                    $.each(routes, function(key, value) {
                        if (value) {
                            if (value.directionsDisplay)
                                value.directionsDisplay.setMap(null);
                            if (value.status && value.status == 1) {
                                value.status = 3;
                            }
                        }
                    });
                }
            });
        },
    };

    $.fn.customGMap = function(method) {
        // Method calling logic
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(
                    arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.initialize.apply(this, arguments);
        } else {
            $.error('Method ' + method
                    + ' does not exist on ' + pluginName);
        }
    };
}(jQuery));