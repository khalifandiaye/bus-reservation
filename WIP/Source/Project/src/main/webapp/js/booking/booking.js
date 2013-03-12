
var SeatsToAllocate = 5;
var SeatsNotAllocatedCount = 5;

var t_selectedSeat = [{
        "seats" : []
}];


var SEAT_EMPTY = 0,
    SEAT_SOLD = 1,
    SEAT_SELECTED = 2;
 
function initSelectedSeat(){
	var selectedSeatInput = $("#selectedSeat").val();
	var arraySelectedSeat;
	
	if(selectedSeatInput != ""){
		arraySelectedSeat = selectedSeatInput.split(";");
	}else{
		if($.cookie('selectedSeat') == null){
			return;
		}
		arraySelectedSeat = $.cookie('selectedSeat').split(";");
	}
	for(var i = 0; i < arraySelectedSeat.length ;i++){
		if(arraySelectedSeat[i] != ""){
			seatClicked($('.seat-img[data-seat="'+arraySelectedSeat[i]+'"]'));
			}
	}
	if($("#message").val() != null && $("#message").val() != ""){
		showPopup($("#message").val());
	}
}

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

function blockSeat(){
	var listSeatImg = $(".seat-img");
	if(SeatsNotAllocatedCount < 1){
		for ( var i = 0; i < listSeatImg.length; i++) {
			if(listSeatImg.eq(i).data('status') == 0){
				listSeatImg.eq(i).attr('src', listSeatImg.eq(i).attr('src').replace('seat-available', 'seat-block'));
			}	
		} 
	}else{
		for ( var i = 0; i < listSeatImg.length; i++) {
			if(listSeatImg.eq(i).data('status') == 0){
				listSeatImg.eq(i).attr('src', listSeatImg.eq(i).attr('src').replace('seat-block', 'seat-available'));
			}
		}
	} 
}

function selectSeat(seatNumber) {
    var seatImage = getSeatImage(seatNumber);
    
    if(SeatsNotAllocatedCount == 0){
        return false;
    }
    SeatsNotAllocatedCount -= 1; // Reduce the number of available seats

    seatImage.attr('data-status',SEAT_SELECTED);

    // Change to the reserved image
    seatImage.attr('src', seatImage.attr('src').replace('seat-available', 'seat-selected'));

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

    SeatsNotAllocatedCount += 1; // Increase the number of available seats for this area category

    seatImage.attr('data-status',SEAT_EMPTY);
    seatImage.attr('src', seatImage.attr('src').replace('seat-selected', 'seat-available'));
    

    removeSeatFromSelectedList(seatNumber);
}

function seatClicked(seatImage){
	var message,thisImage;
	
	thisImage = getSeatImage(seatImage.data('seat'));
	
	
	
    if (seatAvailable(thisImage)) {
       
        if(selectSeat(seatImage.data('seat')) == false){
//            return "Đặt quá số ghế quy định";
        	return;
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
    
    //check seat and block
    blockSeat(); 
    
    return message;
}

function showPopup(message){
	if($(".notify-message").html().trim()!=""){
		$(".notify-message").empty();
	}
	$(".notify-message").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'+message+'</div>');
}

function updateSeatNum(){
    $(".seat-number").text(SeatsToAllocate - SeatsNotAllocatedCount);
    
}

$(function(){
	SeatsToAllocate = parseInt($("#passengerNo").val());
	$(".seat-number-selected").text($("#passengerNo").val()); 
	
	SeatsNotAllocatedCount = parseInt($("#passengerNo").val());
	
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
    
    //init selected seat 
	initSelectedSeat();
	
	$("#booking-submit").bind("click",function(){
		var date = new Date();
		var minutes = 15;
		date.setTime(date.getTime() + (minutes * 60 * 1000));
		
		$.cookie('selectedSeat', getSelectedSeatString(), { expires: date });
		
		$("#selectedSeat").val("");
		
	    $("#seatToPayment").val(getSelectedSeatString());
	    
	});
});