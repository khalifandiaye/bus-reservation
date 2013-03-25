$(document).ready(function() {
    // create and display a map
    $('#map').customGMap('initialize', {hideMapLabels : true, enableRoute : true});
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
});