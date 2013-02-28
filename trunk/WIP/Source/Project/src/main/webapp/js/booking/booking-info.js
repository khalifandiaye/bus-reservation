function removeSeatInHiddenInput(seatName){
	var seatsSelected = $.cookie('selectedSeat').split(";");
	for(var i = 0; i < seatsSelected.length; i++){
		if(seatsSelected[i] == seatName || seatsSelected[i] == ""){
			seatsSelected.splice(i, 1);
		}
	} 
	var nwHiddenInput = "";
	for(var i = 0;i < seatsSelected.length; i++){
		nwHiddenInput += seatsSelected[i]+";";
	}
	$.cookie('selectedSeat', nwHiddenInput, { expires: 1 });
}

function removeSeat(parent){
	var seatName = $(parent).eq(0).find(".seatCheckedName").html().trim();
	var message = "Có lỗi xảy ra.";

	if(seatName != ""){
		removeSeatInHiddenInput(seatName);
		$(parent).remove();
		message = "Bỏ ghế chọn "+seatName+".";
	}
	return message;
}

function showPopup(message){
	if($(".notify-message").html().trim()!=""){
		$(".notify-message").empty();
	}
	$(".notify-message").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'+message+'</div>');
}

function genSeatFromCookie(){
	var listSeat = $.cookie('selectedSeat').split(";");
	for ( var i = 0; i < listSeat.length; i++) {
		if(listSeat[i] != ""){ 
			$(".listCheckedSeats").append('<div class="seatChecked"><span class="seatCheckedName">'+listSeat[i]+'</span><button class="btn btn-mini btn-danger" type="button">Bỏ ghế</button></div>');
		}
	}
}

$(function(){
	genSeatFromCookie();
	
	$(".seatChecked button").bind("click",function(event){
		var message = "";
		if($(".seatChecked").size() > 1){
			message = removeSeat($(this).parent());
		}else{
			message = "Không được phép bỏ chọn tất cả các ghế.";
		}
		if(message){
            showPopup(message);
        }
	});
});