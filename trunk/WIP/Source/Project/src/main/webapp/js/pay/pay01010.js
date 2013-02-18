$(document).ready(function() {
    $('select').bind('change.fill_info',function(e) {
        var evt = e ? e : event;
        var target;
        target = evt.target ? evt.target
                : evt.source;
//        if (console && console.log) {
//            console.log("Value:", $(target)
//                    .val());
//        }
        $.ajax({
            type : "GET",
            url : "calculateFee.html",
            data : {
                paymentMethodId : $(target).val()
            },
            success : function(data) {
                $("#transactionFee").html(
                        data.reservationInfo.transactionFee
                        + data.reservationInfo.currency
                        + "<br />=$"
                        + data.reservationInfo.transactionFeeInUSD);
                $("#totalAmount").html(
                        data.reservationInfo.totalAmount
                        + data.reservationInfo.currency
                        + "<br />=$"
                        + data.reservationInfo.totalAmountInUSD);
            }
        });
    });
    $('input#pay01020').bind('click.submit', function(e) {
        $('form').prop("action", $('#contextPath').val() + '/pay/pay01020.html');
        $('form').submit();
//        if (console && console.log) {
//            console.log("Value:", $(target)
//                    .val());
//        }
        
    });
});