function removeSeatInHiddenInput(seatName,seatType){
	if(seatType == "deleteOutSeats"){
		var selectedOutSeat = sessionStorage.getItem("selectedOutSeat").split(";");
		for(var i = 0; i < selectedOutSeat.length; i++){
			if(selectedOutSeat[i] == seatName || selectedOutSeat[i] == ""){
				selectedOutSeat.splice(i, 1);
			}
		} 
		var nwHiddenInput = "";
		for(var i = 0;i < selectedOutSeat.length; i++){
			nwHiddenInput += selectedOutSeat[i]+";";
		}
		sessionStorage.setItem("selectedOutSeat", nwHiddenInput);
		$("#selectedOutSeat").val(nwHiddenInput);
	}else if(seatType == "deleteReturnSeats"){
		var selectedReturnSeat = sessionStorage.getItem("selectedReturnSeat").split(";");
		for(var i = 0; i < selectedReturnSeat.length; i++){
			if(selectedReturnSeat[i] == seatName || selectedReturnSeat[i] == ""){
				selectedReturnSeat.splice(i, 1);
			}
		} 
		var nwHiddenInput = "";
		for(var i = 0;i < selectedReturnSeat.length; i++){
			nwHiddenInput += selectedReturnSeat[i]+";";
		}
		sessionStorage.setItem("selectedReturnSeat", nwHiddenInput);
		$("#selectedReturnSeat").val(nwHiddenInput);
	}
}

function removeSeat(){
	var isDel = false;
	var seatList = $(".listCheckedSeats tbody tr");
	for(var i = 0; i < seatList.length; i++ ){
		var seatType = seatList.eq(i).find("input[type='checkbox']").attr("name");
		if($(seatList).eq(i).find("input[type='checkbox']").is(":checked")){
			$(seatList).eq(i).remove();
			removeSeatInHiddenInput($(seatList).eq(i).find(".seatChecked").text(),seatType);
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
	
	var listOutSeat = sessionStorage.getItem("selectedOutSeat").split(";");
	var listReturnSeat = sessionStorage.getItem("selectedReturnSeat").split(";");
	$("#selectedOutSeat").val(sessionStorage.getItem("selectedOutSeat"));
	$("#selectedReturnSeat").val(sessionStorage.getItem("selectedReturnSeat"));
	if(listOutSeat.length > 0){
		$(".listCheckedSeats tbody").append("<tr><th colspan='2'>Chuyến đi :</th></tr>"); 
		for ( var i = 0; i < listOutSeat.length; i++) {
			if(listOutSeat[i] != ""){ 
				$(".listCheckedSeats tbody").append('<tr><td class="seatChecked">'+listOutSeat[i]+'</td><td style="text-align: center"><input type="checkbox" name="deleteOutSeats"></td></tr>');
			}
		}
	}
	if(listReturnSeat.length > 0){
		$(".listCheckedSeats tbody").append("<tr><th colspan='2'>Chuyến khứ hồi :</th></tr>");
		for ( var i = 0; i < listReturnSeat.length; i++) {
			if(listReturnSeat[i] != ""){ 
				$(".listCheckedSeats tbody").append('<tr><td class="seatChecked">'+listReturnSeat[i]+'</td><td style="text-align: center"><input type="checkbox" name="deleteReturnSeats"></td></tr>');
			}
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
	$("#booking-info-submit").bind("click",function(){
		if($("#booking-form").valid()){
			sessionStorage.removeItem("selectedOutSeat");
			sessionStorage.removeItem("selectedReturnSeat");
		}
	})
});