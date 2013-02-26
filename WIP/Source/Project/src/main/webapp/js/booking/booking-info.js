function removeSeatInHiddenInput(seatName){
	var seatsSelected = $("#selectedSeat").val().split(";");
	for(var i = 0; i < seatsSelected.length; i++){
		if(seatsSelected[i] == seatName || seatsSelected[i] == ""){
			seatsSelected.splice(i, 1);
		}
	} 
	var nwHiddenInput = "";
	for(var i = 0;i < seatsSelected.length; i++){
		nwHiddenInput += seatsSelected[i]+";";
	}
	$("#selectedSeat").val(nwHiddenInput);
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

$(function(){
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