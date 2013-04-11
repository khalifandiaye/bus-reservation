
var SeatsOutToAllocate = 5;
var SeatsOutNotAllocatedCount = 5;
var SeatsReturnToAllocate = 5;
var SeatsReturnNotAllocatedCount = 5;

var t_selectedSeat = [{
        "OutSeats" : [],
        "ReturnSeats" : []
}];


var SEAT_EMPTY = 0,
    SEAT_SOLD = 1,
    SEAT_SELECTED = 2;
 
function getSeatsToAllocate(seatType){
	if(seatType=="return"){
		return SeatsReturnToAllocate;
	}else{
		return SeatsOutToAllocate;
	}
}

function getSeatsNotAllocatedCount(seatType){
	if(seatType == "return"){
		return SeatsReturnNotAllocatedCount;
	}else{
		return SeatsOutNotAllocatedCount;
	}
}

function updateSeatsNotAllocatedCount(seatType,numSeat){
	if(seatType == "return"){
		return SeatsReturnNotAllocatedCount += numSeat;
	}else{
		return SeatsOutNotAllocatedCount += numSeat; 
	}
} 

function initSelectedSeat(){
	var selectedOutSeat = $("#selectedOutSeat").val();
	var selectedReturnSeat = $("#selectedReturnSeat").val();
	
	var arraySelectedOutSeat = null,arraySelectedReturnSeat = null;
	
	if(selectedOutSeat != ""){
		arraySelectedOutSeat = selectedOutSeat.split(";");
	}else if(sessionStorage.getItem("selectedOutSeat") != null){
		arraySelectedOutSeat = sessionStorage.getItem("selectedOutSeat").split(";");
	}
	if(arraySelectedOutSeat != null){
		if(arraySelectedOutSeat.length > 0){
			for(var i = 0; i < arraySelectedOutSeat.length ;i++){
				if(arraySelectedOutSeat[i] != ""){
					seatClicked($('.seat-img[data-seat="'+arraySelectedOutSeat[i]+'"][data-type="out"]'));
					}
			} 
		}
	}
	if(selectedReturnSeat != ""){ 
		arraySelectedReturnSeat = selectedReturnSeat.split(";");
	}else if(sessionStorage.getItem("selectedReturnSeat") != null && $("#seat-map-return").length > 0){
		arraySelectedReturnSeat = sessionStorage.getItem("selectedReturnSeat").split(";");
	}
	if(arraySelectedReturnSeat != null){
		if(arraySelectedReturnSeat.length > 0){
			for(var i = 0; i < arraySelectedReturnSeat.length ;i++){
				if(arraySelectedReturnSeat[i] != ""){
					seatClicked($('.seat-img[data-seat="'+arraySelectedReturnSeat[i]+'"][data-type="return"]'));
					}
			}
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
	if(seatImage.data('type')=="out"){
		for ( var i = 0; i <t_selectedSeat[0].OutSeats.length; i++) {
			if(t_selectedSeat[0].OutSeats[i].seatNum === seatImage.data('seat')){ 
				return false;
			}
		} 
	}else if(seatImage.data('type')=="return"){
		for ( var i = 0; i <t_selectedSeat[0].ReturnSeats.length; i++) {
			if(t_selectedSeat[0].ReturnSeats[i].seatNum === seatImage.data('seat')){ 
				return false;
			}
		} 
	}
	return true;
}

function getSelectedSeatList(seatType){
	if(seatType=="return"){
		return t_selectedSeat[0].ReturnSeats;
	}else{
		return t_selectedSeat[0].OutSeats;
	}
    
}

function getSelectedOutSeatString(){
	var listString = "";
	for(var i = 0; i < t_selectedSeat[0].OutSeats.length; i++){
		listString += t_selectedSeat[0].OutSeats[i].seatNum+";";
	}
	return listString;
}

function getSelectedReturnSeatString(){
	var listString = "";
	for(var i = 0; i < t_selectedSeat[0].ReturnSeats.length; i++){
		listString += t_selectedSeat[0].ReturnSeats[i].seatNum+";";
	}
	return listString;
}

function getSeatImage(seatNumber,seatType) {
    return $('.seat-map-inner img[data-seat=\'' + seatNumber + '\'][data-type=\''+seatType+'\']');
}

function getSeatStatus(seatNumber,seatType){
	return $('.seat-map-inner img[data-seat=\'' + seatNumber + '\'][data-type=\''+seatType+'\']').attr('data-status');
}

function addSeatToSelectedList(seatImage){
    var seatSelectionObject = { "seatNum" : seatImage.data('seat') };
    if(seatImage.data('type')=="out"){
    	t_selectedSeat[0].OutSeats.unshift(seatSelectionObject); // Push to front
    }else if(seatImage.data('type')=="return"){
    	t_selectedSeat[0].ReturnSeats.unshift(seatSelectionObject);
    }
    return;

}

function blockSeat(seatTyle){
	var listSeatImg = $(".seat-img[data-type='"+seatTyle+"']");
	if(getSeatsNotAllocatedCount(seatTyle) < 1){
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

function selectSeat(seatNumber,seatType) {
    var seatImage = getSeatImage(seatNumber,seatType);
    
    if(getSeatsNotAllocatedCount(seatType) == 0){
        return false;
    }
    
    updateSeatsNotAllocatedCount(seatType,-1); // Reduce the number of available seats

    seatImage.attr('data-status',SEAT_SELECTED);

    // Change to the reserved image
    seatImage.attr('src', seatImage.attr('src').replace('seat-available', 'seat-selected'));

    addSeatToSelectedList(seatImage);
}

function removeSeatFromSelectedList(seatImage,seatType){
    var selectedSeats = getSelectedSeatList(seatType);
    for (var i = 0; i < selectedSeats.length; i++) {
        if (selectedSeats[i].seatNum === seatImage) {
        	selectedSeats.splice(i, 1); // Remove from selected seats array
            return;
        }
    }
}

function deselectSeat(seatNumber,seatType){
    var seatImage = getSeatImage(seatNumber,seatType);

    updateSeatsNotAllocatedCount(seatType,1); // Increase the number of available seats for this area category

    seatImage.attr('data-status',SEAT_EMPTY);
    seatImage.attr('src', seatImage.attr('src').replace('seat-selected', 'seat-available'));
    

    removeSeatFromSelectedList(seatNumber,seatType);
}

function seatClicked(seatImage){
	var message,thisImage;
	
	thisImage = getSeatImage(seatImage.data('seat'),seatImage.data('type'));
	
    if (seatAvailable(thisImage)) {
       
        if(selectSeat(seatImage.data('seat'),seatImage.data('type')) == false){
//            return "Đặt quá số ghế quy định";
        	return;
        }
        updateSeatNum(seatImage.data('type'));
    }
    else if (getSeatStatus(seatImage.data('seat'),seatImage.data('type')) == SEAT_SELECTED) { // The seat is already selected

        deselectSeat(seatImage.data('seat'),seatImage.data('type'));
        
        updateSeatNum(seatImage.data('type'));
    }
    else {

        return "Ghế đã có người đặt";

    }
    
    //check seat and block
    blockSeat(seatImage.data('type')); 
    
    return message;
}

function showPopup(message){
	if($(".notify-message").html().trim()!=""){
		$(".notify-message").empty();
	}
	$(".notify-message").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'+message+'</div>');
}

function updateSeatNum(seatType){
    $(".seat-number").text(getSeatsToAllocate(seatType) - getSeatsNotAllocatedCount(seatType));
    if(seatType == 'out'){
    	$(".seat-number-selected").text(parseInt($("#passengerNoOut").val()) > 5 ? 5 : parseInt($("#passengerNoOut").val()));
    }else{
    	$(".seat-number-selected").text(parseInt($("#passengerNoReturn").val()) > 5 ? 5 : parseInt($("#passengerNoReturn").val()));
    }
}

$(function(){
	SeatsOutToAllocate = parseInt($("#passengerNoOut").val()) > 5 ? 5 : parseInt($("#passengerNoOut").val());
	SeatsReturnToAllocate = parseInt($("#passengerNoReturn").val()) > 5 ? 5 : parseInt($("#passengerNoReturn").val());
	$(".seat-number-selected").text(parseInt($("#passengerNoOut").val()) > 5 ? 5 : parseInt($("#passengerNoOut").val()));
	
	SeatsOutNotAllocatedCount = parseInt($("#passengerNoOut").val()) > 5 ? 5 : parseInt($("#passengerNoOut").val());
	SeatsReturnNotAllocatedCount = parseInt($("#passengerNoReturn").val()) > 5 ? 5 : parseInt($("#passengerNoReturn").val());
	
	if($("#isNew").val() == "new"){
		sessionStorage.clear();
	}
	
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
		if(((SeatsOutToAllocate - SeatsOutNotAllocatedCount == 0) && $('#seat-map-out').length > 0) 
				|| ((SeatsReturnToAllocate - SeatsReturnNotAllocatedCount == 0) && $('#seat-map-return').length > 0)){
			if(((SeatsOutToAllocate - SeatsOutNotAllocatedCount == 0) && $('#seat-map-out').length > 0)){
				showPopup("Bạn phải chọn ít nhất 1 ghế cho chuyến đi để tiếp tục.");
			}else if(((SeatsReturnToAllocate - SeatsReturnNotAllocatedCount == 0) && $('#seat-map-return').length > 0)){
				showPopup("Bạn phải chọn ít nhất 1 ghế cho chuyến về để tiếp tục.");
			}
			return;
		}
		sessionStorage.setItem("selectedOutSeat", getSelectedOutSeatString());
		sessionStorage.setItem("selectedReturnSeat", getSelectedReturnSeatString());
		
		$("#selectedOutSeat").val("");
		$("#selectedReturnSeat").val("");
		$("#isNew").val("");
		
	    $("#forwardSeats").val(getSelectedOutSeatString());
        $("#returnSeats").val(getSelectedReturnSeatString());
	     
	    $("form.booking").submit();  
	});
	
	$('#myTab a').click(function (e) {
		  e.preventDefault();
		  $(this).tab('show');
		  if($(this).attr('href') == '#seat-map-return'){
			  updateSeatNum('return');
		  }else{
			  updateSeatNum('out');
		  }
	});
	
	$('#myTab a:first').tab('show'); 

});