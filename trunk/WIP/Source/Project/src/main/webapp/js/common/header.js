$(document).ready(function(){
	$('#btn_login').on('click.auth', function(e) {
        $.ajax({
            type : "POST",
            url : $('contextPath').val() + "/user/login.html",
            data : {
                username : $('input[name="username"]').val(),
                password : $('input[name="password"]').val()
            },
            success : function(data) {
                if (data.success) {
                    $("div.login").addClass('hidden');
                    $("div.logout").removeClass('hidden');
                    $("span#name").html(data.name);
                } else {
                    $("#errorMessage").html(data.errorMessage);
                }
            },
            error : function() {
                $("#errorMessage").html("ERROR");
            }
        });
        // disable default behavior (event will still bubble up)
        e.preventDefault();
	});
});