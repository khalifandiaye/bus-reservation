$(document).ready(function(){
    $('li').removeClass('active');
    $('li#tab_reservationList').addClass('active');
    $('#btnPrint').on('click.print', function(){
        window.print();
    });
});