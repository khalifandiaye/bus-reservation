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
	var seatList = $(".listCheckedSeats tbody tr");
	for(var i = 0; i < seatList.length; i++ ){
		var seatType = seatList.eq(i).find("input[type='checkbox']").attr("name");
		if($(seatList).eq(i).find("input[type='checkbox']").is(":checked")){
			$(seatList).eq(i).remove();
			removeSeatInHiddenInput($(seatList).eq(i).find(".seatChecked").text(),seatType);
			return true; 
		}
	}
	return false;
}

function showPopup(message){
	if($(".notify-message").html().trim()!=""){
		$(".notify-message").empty();
	}
	$(".notify-message").append('<div class="alert fade in"><button type="button" class="close" data-dismiss="alert">×</button>'+message+'</div>');
}

function genSeatFromSessionStorage(){
	
	var listOutSeat = sessionStorage.getItem("selectedOutSeat").split(";");
	var listReturnSeat = sessionStorage.getItem("selectedReturnSeat").split(";");
	$("#selectedOutSeat").val(sessionStorage.getItem("selectedOutSeat"));
	$("#selectedReturnSeat").val(sessionStorage.getItem("selectedReturnSeat"));
	if(sessionStorage.getItem("selectedOutSeat") != "" && listOutSeat[0] != ""){ 
		$(".listCheckedSeats tbody").append("<tr><th colspan='2'>Chuyến đi :</th></tr>"); 
		for ( var i = 0; i < listOutSeat.length; i++) {
			if(listOutSeat[i] != ""){ 
				$(".listCheckedSeats tbody").append('<tr><td class="seatChecked">'+listOutSeat[i]+'</td><td style="text-align: center"><input type="checkbox" name="deleteOutSeats"></td></tr>');
			}
		}
	}
	if(sessionStorage.getItem("selectedReturnSeat") != "" && listReturnSeat[0] != ""){
		$(".listCheckedSeats tbody").append("<tr><th colspan='2'>Chuyến khứ hồi :</th></tr>");
		for ( var i = 0; i < listReturnSeat.length; i++) {
			if(listReturnSeat[i] != ""){ 
				$(".listCheckedSeats tbody").append('<tr><td class="seatChecked">'+listReturnSeat[i]+'</td><td style="text-align: center"><input type="checkbox" name="deleteReturnSeats"></td></tr>');
			}
		}
	}
}

$(function(){
	genSeatFromSessionStorage();
	
	$(".listCheckedSeats button").bind("click",function(event){
		var message = "";
		var allSelectedSeat = $("input[type='checkbox']:checked");
		var allSeatCheckbox = $("input[type='checkbox']");
		var seatOutNumber = $("input[name='deleteOutSeats']").size();
		var seatReturnNumber = $("input[name='deleteReturnSeats']").size();
		
		if(allSelectedSeat.length == allSeatCheckbox.length){ 
			message = "Không được phép bỏ chọn tất cả các ghế.";
		}else if(seatOutNumber > 0 && seatOutNumber == $("input[name='deleteOutSeats']:checked").size()){
			message = "Bạn không được phép bỏ chọn tất cả các ghế chuyến đi.";
		}else if(seatReturnNumber > 0 && seatReturnNumber == $("input[name='deleteReturnSeats']:checked").size()){
			message = "Bạn không được phép bỏ chọn tất cả các ghế chuyến khứ hồi.";
		}else{
			if(removeSeat()){
				message = "Bỏ ghế thành công.";
			}else{
				message = "Bạn chưa chọn ghế để bỏ.";
			}
		}
		
		if(message){
            showPopup(message);
        }
	});
	
	$("#booking-info-submit").bind("click",function(){
		if($("#booking-form").valid()){
			sessionStorage.removeItem("selectedOutSeat");
			sessionStorage.removeItem("selectedReturnSeat");
			
			$("#booking-form").submit();
		}else{
			return;
		}
	})
});