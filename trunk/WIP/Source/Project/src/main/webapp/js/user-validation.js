$().ready(function() {
	$("#register-form").validate({
		rules: {
			inputFirstName: "required",
			inputLastName: "required",
			inputUserName: {
				required: true,
				minlength: 5
			},
			inputPassword: {
				required: true,
				minlength: 5
			},
			inputRePassword: {
				required: true,
				minlength: 5,
				equalTo: "#inputPassword"
			},
			inputEmail: {
				required: true,
				email: true
			}
		},
		messages: {
			inputFirstName: "Vui lòng nhập tên.",
			inputLastName: "Vui lòng nhập họ.",
			inputUserName: {
				required: "Vui lòng nhập tên đăng nhập.",
				minlength: "Tên đăng nhập ít nhất phải có 5 kí tự."
			},
			inputPassword: {
				required: "Vui lòng nhập mật khẩu.",
				minlength: "Mật khẩu ít nhất phải có 5 kí tự."
			},
			inputRePassword: {
				required: "Vui lòng nhập lại mật khẩu.",
				minlength: "Mật khẩu ít nhất phải có 5 kí tự.",
				equalTo: "Vui lòng nhập giống mật khẩu ở trên."
			},
			inputEmail: "Vui lòng nhập địa chỉ email"
		}
	});
});

function onKeyPressClear(){
	if($("#inputUserName").parent().find("label.mes").size() > 0){
		$("#inputUserName").parent().find("label.mes").remove();
	}
}

function onChangeUsername(){

	//if username valid do this code
	if($("#register-form").validate().element( "#inputUserName" )){
		var user = $("#inputUserName").val();
		$.getJSON(ctx+'/user/check-username.html',{
			"inputUserName" : user,
			"inputEmail" : "",
		}, 
		function(data) {
	 		// false mean that user is not exist in database
			if(data["checkUsernameResult"]["usernameCheck"] == false){
				if($("#inputUserName").parent().find("label .success").size() == 0){
					$("#inputUserName").parent().append("<label for='inputUserName' class='success mes'>Bạn có thể sử dụng tên đăng nhập này.</label>");
				}
				if($("#inputUserName").parent().find("label.error").size() > 0){
					$("#inputUserName").parent().find("label.error").remove();
				}
			}else{
				if($("#inputUserName").parent().find("label.success").size() > 0){
					$("#inputUserName").parent().find("label.success").remove();
				}
				if($("#inputUserName").parent().find("label.error").size() == 0){
					$("#inputUserName").parent().append("<label for='inputUserName' class='error mes'>Tên tài khoản này đã có người sử dụng.</label>");
				}
			}
		});
	}
}

function onChangeEmail(){
	//remove class error
	
	//if username valid do this code
	if($("#inputEmail").parent().find(".error").size() > 0){
		$("#inputEmail").parent().find(".error").remove();
	}
	if($("#inputEmail").parent().find(".success").size() > 0){
		$("#inputEmail").parent().find(".success").remove();
	}
	if($("#register-form").validate().element( "#inputEmail" )){
		var email = $("#inputEmail").val();
		$.getJSON(ctx+'/user/check-username.html',{
			"inputUserName" : "",
			"inputEmail" : email,
		}, 
		function(data) {
	 		// false mean that user is not exist in database
			if(data["checkUsernameResult"]["emailCheck"] == false){
				if($("#inputEmail").parent().find(".success").size() == 0){
					$("#inputEmail").parent().append("<label for='inputEmail' class='success'>Bạn có thể sử dụng email này.</label>");
				}
			}else{
				if($("#inputEmail").parent().find(".error").size() == 0){
					$("#inputEmail").parent().append("<label for='inputEmail' class='error'>Email này đã có người sử dụng.</label>");
				}
			}
		});
	}
}
