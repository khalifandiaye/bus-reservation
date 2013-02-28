(function($){
    
    var methods = {
            activate : function(options) {
                return this.each(function(){
                    var elements = $(this).find('input[type=checkbox]');
                    if (options && options.filter) {
                        elements = $(elements).filter(options.filter);
                    }
                    $(elements).addClass('custom-checkbox');
                    $(elements).after('<label class="custom-checkbox"></label>');
                    $(this).on('click.custom-checkbox', 'input[type=checkbox].custom-checkbox+label', function(event) {
                        var checkbox = $(this).prev();
                        if ($(checkbox).prop('checked')) {
                            $(checkbox).prop('checked', false);
                        } else {
                            $(checkbox).prop('checked', true);
                        }
                    });
                });
            },
            deactivate : function(options) {
                return this.each(function(){
                    $(this).off('custom-checkbox', 'input[type=checkbox].custom-checkbox+label');
                    $(this).find('label.custom-checkbox').remove();
                    $(this).find('input[type=checkbox]').removeClass('custom-checkbox');
                });
            },
    };
    
    $.fn.customCheckbox = function( method ) {
        // Method calling logic
        if ( methods[method] ) {
          return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
          return methods.activate.apply( this, arguments );
        } else {
          $.error( 'Method ' +  method + ' does not exist on jQuery.customCheckbox' );
        }
    };
}(jQuery));