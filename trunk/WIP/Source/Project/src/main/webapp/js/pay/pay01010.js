$(document).ready(function() {
    var calculateFee = function(e) {
//      var evt = e ? e : event;
//      var target;
//      target = evt.target ? evt.target
//              : evt.source;
//      if (console && console.log) {
//          console.log("Value:", $(target)
//                  .val());
//      }
          $.ajax({
              type : "GET",
              url : $('#contextPath') + "/pay/calculateFee.html",
              data : {
                  paymentMethodId : $('#selectPaymentMethod').val(),
                  selectedSeat : $.cookie('selectedSeat')
              },
              success : function(data) {
                  $("#transactionFee").html(
                          data.reservationInfo.transactionFee
                          + " VND = $"
                          + data.reservationInfo.transactionFeeInUSD);
                  $("#totalAmount").html(
                          data.reservationInfo.totalAmount
                          + " VND = $"
                          + data.reservationInfo.totalAmountInUSD);
              }
          });
    };
    $('#selectPaymentMethod').bind('change.fill_info', calculateFee);
    $('.listCheckedSeats').on('click.fill_info', 'button', calculateFee);
    $('input#pay01020').bind('click.submit', function(e) {
        $('form').prop("action", $('#contextPath').val() + '/pay/pay01020.html');
        $('form').submit();
//        if (console && console.log) {
//            console.log("Value:", $(target)
//                    .val());
//        }
        
    });
});