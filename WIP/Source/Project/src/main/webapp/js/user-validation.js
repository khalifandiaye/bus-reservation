

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

function checkUsernameAndEmail(username,ustat,email,estat){
	
	$.getJSON(ctx+'/user/check-username.html',{
			"inputUserName" : username,
			"inputUserNameStat" : ustat,
			"inputEmail" : email,
			"inputEmailStat" : estat
		}, 
		function(data) {
	 		var items = [];
	 		console.log(data);
			$.each(data, function(key, val) {
			    console.log(val);
			});
			console.log(items);
			console.log(username);
			console.log(ctx);
	});
	
}

function onChangeUsernameEmail(){
	var user = $("#inputUserName").val();
	var email = $("#inputEmail").val();
	var userStat = $("#inputUserName").attr('data-userStat');
	var emailStat = $("#inputEmail").attr('data-emailStat');
	
	//Change status
	if(userStat == 0 && user.length > 0){
		$("#inputUserName").attr('data-userStat',"1");
		userStat = "1";
	}
	if(emailStat == 0 && email.length > 0){
		$("#inputEmail").attr('data-emailStat',"1");
		emailStat = "1";
	}
	
	checkUsernameAndEmail(user,userStat,email,emailStat);
	
}
