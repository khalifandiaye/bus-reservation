//$(document).ready(function() {
//	$('a.toIndex').bind("click.submit",function(event) {
//		$('form').prop("action", "index.action");
//		$('form').submit();
//		return false;
//	});
//	$('a.toBook').bind("click.submit",function(event) {
//		$('form').prop("action", "book.action");
//		$('form').submit();
//		return false;
//	});
//	$('a.toViewBooking').bind("click.submit",function(event) {
//		$('form').prop("action", "view.action");
//		$('form').submit();
//		return false;
//	});
//});
$(document).ready(function() {
	$('input[type="submit"]').bind('click.submit', function(event) {
		$('form').prop("action", event.target.id + '.action');
		return true;
	});
});