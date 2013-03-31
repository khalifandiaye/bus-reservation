$(document).ready(function() {
    // create and display a map
    $('#map').customGMap('initialize', {hideMapLabels : true, showAdministrativeLabel : false, enableRoute : true});
    // add a marker
    $('#map').customGMap('addMarker', {
        latitude : '10.7500',
        longitude : 106.6667,
        markerOptions : {
            labelContent : 'TP. Ho Chi Minh',
        }
    });
    // add another marker
    $('#map').customGMap('addMarker', {
        latitude : 21.0409,
        longitude : 105.7981,
        markerOptions : {
            labelContent : 'Ha Noi',
        }
    });

    $('#add').on('click.map', function() {
        var label = $('#location option:selected').text();
        var latLng = $('#location').val().split(';');
        $('#map').customGMap('addMarker', {
            latitude : latLng[0],
            longitude : latLng[1],
            markerOptions : {
                labelContent : label,
            }
        });
        $('#map').customGMap('showRoute');
    });

    $('#clear').on('click.map', function() {
        $('#map').customGMap('hideRoute');
        $('#map').customGMap('removeMarkers', {
            all : true
        });
    });

    var waypoints = new Array();
    waypoints.push({latitude : 21.0409, longitude : 105.7981});// Ha Noi
    waypoints.push({
        latitude : 12.2500,
        longitude : 109.1833
    }); // Nha Trang
    waypoints.push({
        latitude : 10.7500,
        longitude : 106.6667
    }); // TP. Ho Chi Minh
    $('#map').customGMap('addRoute', {
        routeId : 1,
        waypoints : waypoints
    });
    $('#map').customGMap('addRoute', {
        routeId : 2,
        waypoints : [ {
            latitude : 21.0409,
            longitude : 105.7981
        }, // Ha Noi
        {
            latitude : 11.9417,
            longitude : 108.4383
        }, // Da Lat
        {
            latitude : 10.7500,
            longitude : 106.6667
        } // TP. Ho Chi Minh
        ]
    });

    $('#routes').on('change.map', function() {
        // hide all routes
        $('#map').customGMap('hideRoute');
        $('#map').customGMap('showRoute', $(this).val());
    });
});