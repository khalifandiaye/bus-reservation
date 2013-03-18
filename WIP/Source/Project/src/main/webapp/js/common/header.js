$(document).ready(function(){
     function checkUser() {
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/user/checkUser.html",
            success : function(data) {
                if (data.success) {
                    $("div.login").addClass('hidden');
                    $("div.logout").removeClass('hidden');
                    $("#tab_reservationList").removeClass('hidden');
                    $("span#name").html(data.name);
                } else {
                    $("div.logout").addClass('hidden');
                    $("div.login").removeClass('hidden');
                    $("span#name").html('');
                }
            },
            error : function() {
                $("div.logout").addClass('hidden');
                $("div.login").removeClass('hidden');
                $("span#name").html('');
            }
        });
        // run it every 5 minutes
        setTimeout(checkUser, 5*60*1000);
    };
    
    function loginDisplay(data) {
        $("div.login").addClass('hidden');
        $("div.logout").removeClass('hidden');
        $("span#name").html(data.name);
    }
    
    function logoutDisplay() {
        $("div.logout").addClass('hidden');
        $("div.login").removeClass('hidden');
        $("span#name").html('');
    }
    
    checkUser();
    
	$('#btn_login').on('click.auth', function(e) {
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/user/login.html",
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
    
    $('#btn_logout').on('click.auth', function(e) {
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/user/logOut.html",
            success : function(data) {
                if (data.success) {
                    $("div.logout").addClass('hidden');
                    $("div.login").removeClass('hidden');
                    $("span#name").html('');
                } else {
                    // do nothing
                }
            },
            error : function() {
                //TODO handle error
                $("#errorMessage").html("ERROR");
            }
        });
        // disable default behavior (event will still bubble up)
        e.preventDefault();
    });
});