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
	$("#selectedSeat").val(nwHiddenInput);
}

function removeSeat(){
	var isDel = false;
	var seatList = $(".listCheckedSeats tbody tr");
	for(var i = 0; i < seatList.length; i++ ){
		if($(seatList).eq(i).find("input[type='checkbox']").is(":checked")){
			$(seatList).eq(i).remove();
			removeSeatInHiddenInput($(seatList).eq(i).find(".seatChecked").text());
			isDel = true;
		}
	}
	return isDel;
}

function showPopup(message){
	if($(".notify-message").html().trim()!=""){
		$(".notify-message").empty();
	}
	$(".notify-message").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'+message+'</div>');
}

function genSeatFromCookie(){
	var listSeat = $.cookie('selectedSeat').split(";");
	$("#selectedSeat").val($.cookie('selectedSeat'));
	for ( var i = 0; i < listSeat.length; i++) {
		if(listSeat[i] != ""){ 
			$(".listCheckedSeats tbody").append('<tr><td class="seatChecked">'+listSeat[i]+'</td><td style="text-align: center"><input type="checkbox" name="deleteSeats"></td></tr>');
		}
	}
}

$(function(){
	genSeatFromCookie();
	
	$(".listCheckedSeats button").bind("click",function(event){
		var message = "";
		if($(".seatChecked").size() > 1){
			if(removeSeat()){
				message = ("Bỏ ghế thành công.");
			}else{
				message = ("Bạn chưa chọn ghế để bỏ.");
			}
		}else if($(".listCheckedSeats tbody tr").find("input[type='checkbox']").is(":checked") && $(".seatChecked").size() <= 1){
			message = "Không được phép bỏ chọn tất cả các ghế.";
		}else{
			message = ("Bạn chưa chọn ghế để bỏ.");
		}
		if(message){
            showPopup(message);
        }
	});
	
	$("#booking-info-submit").bind("click",function(event){
		if($("#booking-form").valid()){
			$.removeCookie('selectedSeat');
			console.log("removed cookie");
		}
	});
});