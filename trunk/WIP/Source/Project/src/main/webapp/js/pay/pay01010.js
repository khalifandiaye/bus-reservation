$(document).ready(function() {
    var calculateFee = function(e) {
          $.ajax({
              type : "GET",
              url : $('#contextPath') + "/pay/calculateFee.html",
              data : {
                  paymentMethodId : $('#selectPaymentMethod').val(),
                  forwardSeats : sessionStorage.getItem("selectedOutSeat"),
                  returnSeats : sessionStorage.getItem("selectedReturnSeat"),
              },
              success : function(data) {
                  $('#basePrice').html(
                          data.reservationInfo.basePrice
                          + " VND ($"
                          + data.reservationInfo.basePriceInUSD + ")");
                  $("#transactionFee").html(
                          data.reservationInfo.transactionFee
                          + " VND ($"
                          + data.reservationInfo.transactionFeeInUSD + ")");
                  $("#totalAmount").html(
                          data.reservationInfo.totalAmount
                          + " VND ($"
                          + data.reservationInfo.totalAmountInUSD + ")");
              }
          });
    };
    $('#selectPaymentMethod').bind('change.fill_info', calculateFee);
    $('.listCheckedSeats').on('click.fill_info', 'button', calculateFee);
    $('input#pay01020').bind('click.submit', function(e) {
        $('form').prop("action", $('#contextPath').val() + '/pay/pay01020.html');
        $('form').submit();
    });
});