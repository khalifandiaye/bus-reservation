(function($) {
    var logger = {
        log : function(message) {
            if (console) {
                console.log(message);
            }
        }
    };
    var directionsService = null;
    var methods = {
        initialize : function(options) {
            return this.each(function() {
                var map;
                var directionsDisplay;
                var style = null;
                var opts = {
                    enableRoute : false,
                    hideMapLabels : false,
                    mapOptions : {
                        center : new google.maps.LatLng(16.0667, 108.2333),
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
                if (opts.hideMapLabels) {
                    var temp = null;
                    style = [ {
                        featureType : "administrative",
                        elementType : "labels",
                        stylers : [ {
                            visibility : "off"
                        } ]
                    }, {
                        featureType : "poi",
                        elementType : "labels",
                        stylers : [ {
                            visibility : "off"
                        } ]
                    }, {
                        featureType : "water",
                        elementType : "labels",
                        stylers : [ {
                            visibility : "off"
                        } ]
                    }, {
                        featureType : "road",
                        elementType : "labels",
                        stylers : [ {
                            visibility : "off"
                        } ]
                    }, ];
                    temp = [ 'hiddenLabelStyle' ];
                    if (opts.mapOptions.mapTypeControlOptions) {
                        $.merge(temp, opts.mapOptions.mapTypeControlOptions.mapTypeIds);
                        opts.mapOptions.mapTypeControlOptions.mapTypeIds = temp;
                    } else {
                        $.merge(temp, [ google.maps.MapTypeId.ROADMAP ]);
                        opts.mapOptions.mapTypeControlOptions = {
                                mapTypeIds: temp,
                        };
                    }
                    opts.mapOptions.mapTypeId = 'hiddenLabelStyle';
                }
                map = new google.maps.Map(this, opts.mapOptions);
                if (opts.hideMapLabels) {
                    map.mapTypes.set('hiddenLabelStyle', new google.maps.StyledMapType(style, { name: 'Hidden Label Style' }));
                }
                $(this).data('map', map);
                if (opts.enableRoute) {
                    directionsDisplay = new google.maps.DirectionsRenderer();
                    directionsDisplay.setMap(map);
                    $(this).data('directionsDisplay', directionsDisplay);
                    directionsService = new google.maps.DirectionsService();
                }
                logger.log('CustomGMap initialized at ' + this);
            });
        },
        addMarker : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = $(this).data('markers');
                if (!markers) {
                    markers = [];
                    $(this).data('markers', markers);
                    logger.log('Created new marker list');
                }
                if (!options
                        || ((!options.latitude || !options.longitude) 
                                && (!options.markerOptions || !options.markerOptions.position))) {
                    logger.log('ERROR: Coordinates not specified!');
                    return;
                }
                if (map) {
                    var opts = {
                            labelPrefix : "",
                            displayMarkerLabels : true,
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
                    if (opts.displayMarkerLabels && !opts.markerOptions.labelContent) {
                        opts.markerOptions.labelContent = opts.labelPrefix + (markers.length + 1);
                    }
                    if (!opts.markerOptions.position) {
                        opts.markerOptions.position = 
                            new google.maps.LatLng(opts.latitude, opts.longitude);
                    }
                    if (opts.displayMarkerLabels) {
                        markers.push(new MarkerWithLabel(opts.markerOptions));
                    } else {
                        markers.push(new google.maps.Map(map, opts.markerOptions));
                    }
                } else {
                    logger.log('No map, no marker');
                }
            });
        },
        removeMarker : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = $(this).data('markers');
                var index = 0;
                if (!map) {
                    logger.log('ERROR: No map');
                    return;
                }
                if (!markers) {
                    logger.log('ERROR: No markers');
                    return;
                }
                if (!options || (isNaN(options) && (!options.index || isNaN(options.index)))) {
                    logger.log('ERROR: Index not specified!');
                    return;
                } else if (isNaN(options)) {
                    index = options.index;
                } else {
                    index = options;
                }
                var marker = markers[index];
                if (!marker) {
                    logger.log('ERROR: Invalid index: ' + index);
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
                    logger.log('ERROR: No map');
                    return;
                }
                if (!markers) {
                    logger.log('ERROR: No markers');
                    return;
                }
                if (!options
                        || (!($.isArray(options))
                                && (!options.indices || !($.isArray(options.indices)))
                                && (!options.all))) {
                    logger.log('ERROR: Index not specified!');
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
                    logger.log('DEBUG: All markers cleared');
                } else {
                    for (var i = 0; i < indices.length; i++) {
                        marker = markers[indices[i]];
                        if (!marker) {
                            logger.log('ERROR: Invalid index: ' + indices[i]);
                        }
                        marker.setMap(null);
                        markers.splice(indices[i], 1);
                    }
                }
            });
        },
        showRoute : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = $(this).data('markers');
                var directionsDisplay = $(this).data('directionsDisplay');
                if (!map) {
                    logger.log('ERROR: No map');
                    return;
                }
                if (!markers) {
                    logger.log('ERROR: No markers');
                    return;
                } else if (markers.length < 2) {
                    logger.log('INFO: Not enough markers');
                    return;
                }
                if (!directionsDisplay) {
                    logger.log('ERROR: No renderer');
                    return;
                }
                var waypts = null;
                if (markers.length > 2) {
                    waypts = [];
                    for (var i = 1; i < markers.length - 1; i++) {
                        waypts.push({
                            location : markers[i].getPosition(),
                        });
                    }
                }
                var opts = {
                    request : {
                        origin : markers[0].getPosition(),
                        destination : markers[markers.length - 1]
                                .getPosition(),
                        waypoints : waypts,
                        optimizeWaypoints : false,
                        travelMode : google.maps.TravelMode.DRIVING
                    }
                };
                $.extend(true, opts, options);
                if (directionsService) {
                    directionsService.route(opts.request, function(response, status) {
                        if (status == google.maps.DirectionsStatus.OK) {
                            directionsDisplay.setMap(map);
                            directionsDisplay.setDirections(response);
                        }
                    });
                }
            });
        },
        hideRoute : function(options) {
            return this.each(function() {
                var map = $(this).data('map');
                var markers = $(this).data('markers');
                var directionsDisplay = $(this).data('directionsDisplay');
                if (!map) {
                    logger.log('ERROR: No map');
                    return;
                }
                if (!markers) {
                    logger.log('ERROR: No markers');
                    return;
                }
                if (!directionsDisplay) {
                    logger.log('ERROR: No renderer');
                    return;
                }
                if (directionsService) {
                    directionsDisplay.setMap(null);
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
                    + ' does not exist on jQuery.customGMap');
        }
    };
}(jQuery));