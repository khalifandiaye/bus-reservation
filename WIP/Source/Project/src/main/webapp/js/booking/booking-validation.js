$().ready(function() {
	$("#booking-form").validate({
		rules: {
			inputFirstName: {
				required: true,
				maxlength: 30,
			},
			inputLastName: {
				required: true,
				maxlength: 30,
			},
			inputMobile: {
				minlength: 10,
				maxlength: 11,
				digits: true
			},
			inputEmail: {
				required: true,
				email: true
			}
		},
		messages: {
			inputFirstName: {
				required: "Vui lòng nhập tên.",
				maxlength: "Tên tối đa chỉ được 30 kí tự."
			},
			inputLastName: {
				required: "Vui lòng nhập họ.",
				maxlength: "Họ tối đa chỉ được 30 kí tự."
			},
			inputMobile: {
				minlength: "Số điện thoại phải tối thiểu 10 số.",
				maxlength: "Số điện thoại chỉ tối đa được 11 số.",
				digits: "Số điện thoại chỉ được có số."
			},
			inputEmail: {
				required: "Vui lòng nhập địa chỉ email",
				email: "Vui lòng nhập địa chỉ email chính xác."
			}
		}
	});
});
