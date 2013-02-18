
var t_bus = {
    "busSeat":[{
        "SeatsToAllocate" : 5,
        "SeatsNotAllocatedCount": 5
    }]
};

var t_selectedSeat = [{
        "seats" : []
}];

var SEAT_EMPTY = 0,
    SEAT_SOLD = 1,
    SEAT_SELECTED = 2;

function seatAvailable(seatImage){
//    if(seatImage.data('status') === SEAT_EMPTY ){
//        return true;
//    }
	if(seatImage.data('status') === SEAT_SOLD){
		return false;
	}
	for ( var i = 0; i <t_selectedSeat[0].seats.length; i++) {
		if(t_selectedSeat[0].seats[i].seatNum === seatImage.data('seat')){ 
			return false;
		}
	} 

	return true;
}

function getSelectedSeatList(){
    return t_selectedSeat[0];
}

function getSelectedSeatString(){
	var listString = "";
	for(var i = 0; i < t_selectedSeat[0].seats.length; i++){
		listString += t_selectedSeat[0].seats[i].seatNum+";";
	}
	return listString;
}

function getSeatImage(seatNumber) {
    return $('.seat-map-inner img[data-seat=\'' + seatNumber + '\']');
}

function getSeatStatus(seatNumber){
	return $('.seat-map-inner img[data-seat=\'' + seatNumber + '\']').attr('data-status');
}

function addSeatToSelectedList(seatImage){
    var seatSelectionObject = { "seatNum" : seatImage.data('seat') };
    t_selectedSeat[0].seats.unshift(seatSelectionObject); // Push to front
    return;

}

function selectSeat(seatNumber) {
    var seatImage = getSeatImage(seatNumber);

    if(t_bus.busSeat[0].SeatsNotAllocatedCount == 0){
        return false;
    }
    t_bus.busSeat[0].SeatsNotAllocatedCount -= 1; // Reduce the number of available seats

    seatImage.attr('data-status',SEAT_SELECTED);

    // Change to the reserved image
    seatImage.attr('src', seatImage.attr('src').replace('bus-one-seat', 'bus-one-seat-selected'));

    addSeatToSelectedList(seatImage);
}

function removeSeatFromSelectedList(seatImage){
    var selectedSeats = getSelectedSeatList();
    for (var i = 0; i < selectedSeats.seats.length; i++) {
        if (selectedSeats.seats[i].seatNum === seatImage) {
            selectedSeats.seats.splice(i, 1); // Remove from selected seats array
            return;
        }
    }
}

function deselectSeat(seatNumber){
    var seatImage = getSeatImage(seatNumber);

    t_bus.busSeat[0].SeatsNotAllocatedCount += 1; // Increase the number of available seats for this area category

    seatImage.attr('data-status',SEAT_EMPTY);
    seatImage.attr('src', seatImage.attr('src').replace('bus-one-seat-selected', 'bus-one-seat'));
    

    removeSeatFromSelectedList(seatNumber);
}

function seatClicked(seatImage){
	var message,thisImage;
	
	thisImage = getSeatImage(seatImage.data('seat'));
	
    if (seatAvailable(thisImage)) {
       
        if(selectSeat(seatImage.data('seat')) == false){
            return "Đặt quá số ghế quy định";
        }
        updateSeatNum();
    }
    else if (getSeatStatus(seatImage.data('seat')) == SEAT_SELECTED) { // The seat is already selected

        deselectSeat(seatImage.data('seat'));
        
        updateSeatNum();
    }
    else {

        return "Ghế đã có người đặt";

    }
    return message;
}

function showPopup(message){
    $('#myModal').on('show', function () {
        $(".modal-body p").text(message);
    });
    $('#myModal').modal('show');
}

function updateSeatNum(){
    $(".seat-number").text(t_bus.busSeat[0].SeatsToAllocate - t_bus.busSeat[0].SeatsNotAllocatedCount);
    $("#selectedSeat").val(getSelectedSeatString());
}

$(function(){
    $(".seat").bind("click",function(event){

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
        
    });
});