
var t_bus = {
    "busId":"01",
    "busSeat":[{
        "seats" : [
            {"seatNum":"1","seatStatus":0},
            {"seatNum":"2","seatStatus":0},
            {"seatNum":"3","seatStatus":0},
            {"seatNum":"4","seatStatus":0},
            {"seatNum":"5","seatStatus":0},
            {"seatNum":"6","seatStatus":0},
            {"seatNum":"7","seatStatus":0},
            {"seatNum":"8","seatStatus":0},
            {"seatNum":"9","seatStatus":0},
            {"seatNum":"10","seatStatus":0},
            {"seatNum":"11","seatStatus":0},
            {"seatNum":"12","seatStatus":0},
            {"seatNum":"13","seatStatus":0},
            {"seatNum":"14","seatStatus":0},
            {"seatNum":"15","seatStatus":0},
            {"seatNum":"16","seatStatus":0},
            {"seatNum":"17","seatStatus":0},
            {"seatNum":"18","seatStatus":0},
            {"seatNum":"19","seatStatus":0},
            {"seatNum":"20","seatStatus":0},
            {"seatNum":"21","seatStatus":0},
            {"seatNum":"22","seatStatus":0},
            {"seatNum":"23","seatStatus":0},
            {"seatNum":"24","seatStatus":0},
            {"seatNum":"25","seatStatus":0},
            {"seatNum":"26","seatStatus":0},
            {"seatNum":"27","seatStatus":0},
            {"seatNum":"28","seatStatus":0},
            {"seatNum":"29","seatStatus":0},
            {"seatNum":"30","seatStatus":0},
            {"seatNum":"31","seatStatus":0},
            {"seatNum":"32","seatStatus":0},
            {"seatNum":"33","seatStatus":0},
            {"seatNum":"34","seatStatus":0},
            {"seatNum":"35","seatStatus":0},
            {"seatNum":"36","seatStatus":0},
            {"seatNum":"37","seatStatus":0},
            {"seatNum":"38","seatStatus":0},
            {"seatNum":"39","seatStatus":0},
            {"seatNum":"40","seatStatus":0},
            {"seatNum":"41","seatStatus":0},
            {"seatNum":"42","seatStatus":0},
            {"seatNum":"43","seatStatus":0},
            {"seatNum":"44","seatStatus":0},
            {"seatNum":"45","seatStatus":0}
        ],
        "SeatsToAllocate" : 5,
        "SeatsNotAllocatedCount": 5
    }]
};

var t_selectedSeat = [{
    "busId" : "01",
    "busSeat": [{
        "seats" : []
    }]
}];

var SEAT_EMPTY = 0,
    SEAT_SOLD = 1,
    SEAT_SELECTED = 2;

function getBusSeat(seatNumber){
    var seat;
    if(seatNumber > 0 && seatNumber < t_bus.busSeat[0].seats.length){
        seat = t_bus.busSeat[0].seats[seatNumber];
    }
    if(seat){
        seat.busId = t_bus.busId;
    }
    return seat;
}

function seatAvailable(seat){
    if(seat.seatStatus === SEAT_EMPTY ){
        return true;
    }
}

function getSelectedSeatList(busId){
    if(t_selectedSeat[0].busId === busId){
        return t_selectedSeat[0].busSeat;
    }
}

function getSeatImage(seatNumber) {
    return $('.seat-map-inner img[data-seat=\'' + seatNumber + '\']');
}

function addSeatToSelectedList(seat){
    var seatSelectionObject = { "seatNum" : seat.seatNum };

    if (t_selectedSeat[0].busId === seat.busId) {
        t_selectedSeat[0].busSeat[0].seats.unshift(seatSelectionObject); // Push to front
        return;
    }
}

function selectSeat(seatNumber) {
    var seat = getBusSeat(seatNumber);
        seatImage = getSeatImage(seatNumber);

    if(t_bus.busSeat[0].SeatsNotAllocatedCount == 0){
        return false;
    }
    t_bus.busSeat[0].SeatsNotAllocatedCount -= 1; // Reduce the number of available seats

    seat.seatStatus = SEAT_SELECTED;

    // Change to the reserved image
    seatImage.attr('src', seatImage.attr('src').replace('bus-one-seat', 'bus-one-seat-selected'));

    addSeatToSelectedList(seat);
}

function removeSeatFromSelectedList(seat){
    var selectedSeats = getSelectedSeatList(seat.busId);

    for (var i = 0; i < selectedSeats[0].seats.lengthseats.length; i++) {
        if (selectedSeats[0].seats[i].seatNum === seat.seatNum) {
            selectedSeats[0].seats.splice(i, 1); // Remove from selected seats array
            return;
        }
    }
}

function deselectSeat(seatNumber){
    var seat = getBusSeat(seatNumber);
    seatImage = getSeatImage(seatNumber);

    t_bus.busSeat[0].SeatsNotAllocatedCount += 1; // Increase the number of available seats for this area category

    seatImage.attr('src', seatImage.attr('src').replace('bus-one-seat-selected', 'bus-one-seat'));
    seat.seatStatus = SEAT_EMPTY;

    removeSeatFromSelectedList(seat);
}

function seatClicked(seatImage){
    var seat = getBusSeat(seatImage.data('seat')),
        message = '';

    if (!seat) {
        return;
    }

    else if (seatAvailable(seat)) {
        var seatsRemaining = t_bus.busSeat[0].SeatsNotAllocatedCount;

        if (seatsRemaining === 0) { // No seats left in this area category
            //Need to validate seat ?
        }

        var selectedSeats = getSelectedSeatList(seat.busId);

        if(selectSeat(seatImage.data('seat')) == false){
            return "Đặt quá số ghế quy định !"
        }
        updateSeatNum();
    }
    else if (seat.seatStatus === SEAT_SELECTED) { // The seat is already selected

        deselectSeat(seatImage.data('seat'));
        updateSeatNum();
    }
    else {

        return "Việc chọn ghế ko hợp lệ";

    }
    return message;
}

function showPopup(message){
    $('#myModal').on('show', function () {
        $(".modal-body p").text(message);
    })
    $('#myModal').modal('show');
}

function updateSeatNum(){
    $(".seat-number").text(t_bus.busSeat[0].SeatsToAllocate - t_bus.busSeat[0].SeatsNotAllocatedCount);
}

$(function(){
    $(".seat").bind("click",function(event){
        console.log("seat click: " + event.target.dataset.seat);

        var seatImage,targetTagName,message;

        targetTagName = event.target.tagName.toLowerCase();

        if(targetTagName !== 'img'){
            if(targetTagName === 'span'){
                seatImage = $(event.target).next();
            }else if(targetTagName === 'div'){
                seatImage = $(event.target).find('img');
            }else{
                return;
            }
        }else{
            seatImage = $(event.target);
        }

        if(seatImage.length == 0){
            return;
        }

        message = seatClicked(seatImage);

        if(message){
            showPopup(message);
        }
    })
})