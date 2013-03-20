$(document).ready(function(){
     function checkUser() {
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/user/checkUser.html",
            dataType: 'jsonp',
            crossDomain: true,
            success : function(data) {
                if (data.success) {
                    loginDisplay(data);
                } else {
                    logoutDisplay();
                }
            },
            error : function() {
                logoutDisplay();
            }
        });
        // run it every 5 minutes
        setTimeout(checkUser, 5*60*1000);
    };
    
    function loginDisplay(data) {
        $("#loginErrorMessage").html('');
        $("#logoutErrorMessage").html('');
        $("div.login").addClass('hidden');
        $("div.logout").removeClass('hidden');
        $("span#name").html(data.name);
        if (2 == data.roleId) {
            $(".operator").removeClass('hidden');
        } else if (3 == data.roleId) {
            $(".operator").removeClass('hidden');
            $(".admin").removeClass('hidden');
        }
    }
    
    function logoutDisplay() {
        $("#loginErrorMessage").html('');
        $("#logoutErrorMessage").html('');
        $("div.logout").addClass('hidden');
        $("div.login").removeClass('hidden');
        $("span#name").html('');
        $(".operator").addClass('hidden');
        $(".admin").addClass('hidden');
    }
    
    checkUser();
    
	$('#btn_login').on('click.auth', function(e) {
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/user/login.html",
            dataType: 'jsonp',
            crossDomain: true,
            data : {
                username : $('input[name="username"]').val(),
                password : $('input[name="password"]').val()
            },
            success : function(data) {
                if (data.success) {
                    loginDisplay(data);
                } else {
                    $("#loginErrorMessage").html(data.errorMessage);
                }
            },
            error : function(jqXHR, textStatus, errorThrown) {
                $("#loginErrorMessage").html("ERROR");
                if (console) {
                    console.log(jqXHR);
                    console.log(textStatus);
                    console.log(errorThrown);
                }
            }
        });
        // disable default behavior (event will still bubble up)
        e.preventDefault();
	});
    
    $('#btn_logout').on('click.auth', function(e) {
        $.ajax({
            type : "POST",
            url : $('#contextPath').val() + "/user/logOut.html",
            dataType: 'jsonp',
            crossDomain: true,
            success : function(data) {
                if (data.success) {
                    logoutDisplay();
                } else {
                    // do nothing
                }
            },
            error : function() {
                //TODO handle error
                $("#logoutErrorMessage").html("ERROR");
            }
        });
        // disable default behavior (event will still bubble up)
        e.preventDefault();
    });
});