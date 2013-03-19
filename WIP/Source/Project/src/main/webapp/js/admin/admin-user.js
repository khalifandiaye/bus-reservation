$.extend( true, $.fn.dataTable.defaults, {
	"sDom": "<'row-fluid'<'span3 pull-left'l><'span6 pull-right'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
	"sPaginationType": "bootstrap",
	"oLanguage": { 
		"sLengthMenu": "_MENU_ records per page"
	}
} );


/* Default class modification */
$.extend( $.fn.dataTableExt.oStdClasses, {
	"sWrapper": "dataTables_wrapper form-inline"
} );


/* API method to get paging information */
$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
{
	return {
		"iStart":         oSettings._iDisplayStart,
		"iEnd":           oSettings.fnDisplayEnd(),
		"iLength":        oSettings._iDisplayLength,
		"iTotal":         oSettings.fnRecordsTotal(),
		"iFilteredTotal": oSettings.fnRecordsDisplay(),
		"iPage":          oSettings._iDisplayLength === -1 ?
			0 : Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
		"iTotalPages":    oSettings._iDisplayLength === -1 ?
			0 : Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
	};
};


/* Bootstrap style pagination control */
$.extend( $.fn.dataTableExt.oPagination, {
	"bootstrap": {
		"fnInit": function( oSettings, nPaging, fnDraw ) {
			var oLang = oSettings.oLanguage.oPaginate;
			var fnClickHandler = function ( e ) {
				e.preventDefault();
				if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
					fnDraw( oSettings );
				}
			};

			$(nPaging).addClass('pagination').append(
				'<ul>'+
					'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
					'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
				'</ul>'
			);
			var els = $('a', nPaging);
			$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
			$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
		},

		"fnUpdate": function ( oSettings, fnDraw ) {
			var iListLength = 5;
			var oPaging = oSettings.oInstance.fnPagingInfo();
			var an = oSettings.aanFeatures.p;
			var i, ien, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

			if ( oPaging.iTotalPages < iListLength) {
				iStart = 1;
				iEnd = oPaging.iTotalPages;
			}
			else if ( oPaging.iPage <= iHalf ) {
				iStart = 1;
				iEnd = iListLength;
			} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
				iStart = oPaging.iTotalPages - iListLength + 1;
				iEnd = oPaging.iTotalPages;
			} else {
				iStart = oPaging.iPage - iHalf + 1;
				iEnd = iStart + iListLength - 1;
			}

			for ( i=0, ien=an.length ; i<ien ; i++ ) {
				// Remove the middle elements
				$('li:gt(0)', an[i]).filter(':not(:last)').remove();

				// Add the new list items and their event handlers
				for ( j=iStart ; j<=iEnd ; j++ ) {
					sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
					$('<li '+sClass+'><a href="#">'+j+'</a></li>')
						.insertBefore( $('li:last', an[i])[0] )
						.bind('click', function (e) {
							e.preventDefault();
							oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
							fnDraw( oSettings );
						} );
				}

				// Add / remove disabled classes from the static elements
				if ( oPaging.iPage === 0 ) {
					$('li:first', an[i]).addClass('disabled');
				} else {
					$('li:first', an[i]).removeClass('disabled');
				}

				if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
					$('li:last', an[i]).addClass('disabled');
				} else {
					$('li:last', an[i]).removeClass('disabled');
				}
			}
		}
	}
} );


/*
 * TableTools Bootstrap compatibility
 * Required TableTools 2.1+
 */
if ( $.fn.DataTable.TableTools ) {
	// Set the classes that TableTools uses to something suitable for Bootstrap
	$.extend( true, $.fn.DataTable.TableTools.classes, {
		"container": "DTTT btn-group",
		"buttons": {
			"normal": "btn",
			"disabled": "disabled"
		},
		"collection": {
			"container": "DTTT_dropdown dropdown-menu",
			"buttons": {
				"normal": "",
				"disabled": "disabled"
			}
		},
		"print": {
			"info": "DTTT_print_info modal"
		},
		"select": {
			"row": "active"
		}
	} );

	// Have the collection use a bootstrap compatible dropdown
	$.extend( true, $.fn.DataTable.TableTools.DEFAULTS.oTags, {
		"collection": {
			"container": "ul",
			"button": "li",
			"liner": "a"
		}
	} );
}

$(function(){
	
	$("#userList").dataTable({
		"sDom": "<'row'<'span6 pull-left'l><'span5 pull-right'f>r>t<'row'<'span6'i><'span6'p>>",
		"sPaginationType": "bootstrap", 
		"aoColumnDefs": [
             { 'bSortable': false, 'aTargets': [ 5,6 ] } 
          ]
	});
	
	$("#addUserButton").bind("click",function(){
		$.ajax({ 
            type : "POST",
            url : $('#contextPath').val() + "/admin/addUser.html",
            data : {
            	inputUsername : $('#modalAddUser input[name="inputUsername"]').val(),
            	inputPassword : $('#modalAddUser input[name="inputPassword"]').val(),
            	inputLastname : $('#modalAddUser input[name="inputLastname"]').val(),
            	inputFirstname : $('#modalAddUser input[name="inputFirstname"]').val(),
            	inputEmail : $('#modalAddUser input[name="inputEmail"]').val(),
            	inputMobilephone : $('#modalAddUser input[name="inputMobilephone"]').val(),
            	optionsRole : $('#modalAddUser input[name="optionsRole"]:checked').val(),
            	checkboxActive : $('#modalAddUser input[name="checkboxActive"]').is(':checked'),
            },
            success : function(data) {
                if (data.resultJSON) {
                    alert("Add new user successful.");
                    location = location;
                    return;
                } else {
                	alert("Why me god?");
                }
            },
            error : function() {
            	alert("Why me god? error cmnr");
            }
        });
	});
	
	$(".deleteUser").bind("click",function(event){
		var parent = $(this).parent();
		var username = parent.parent().find(".td-username").html();
		if (confirm("Are you sure you want to delete that user?")) {
			$.ajax({ 
	            type : "POST",
	            url : $('#contextPath').val() + "/admin/deleteUser.html",
	            data : {
	            	inputUsername : username
	            },
	            success : function(data) {
	                if (data.resultJSON) {
	                	location = location;
	                } else {
	                	alert("Why me god?");
	                }
	            },
	            error : function() {
	            	alert("Why me god? error cmnr");
	            }
	        });
	    }
	});
	
	$(".detailUser").bind("click",function(event){
		var parent = $(this).parent();
		var username = parent.parent().find(".td-username").html();
		$.ajax({ 
            type : "POST",
            url : $('#contextPath').val() + "/admin/getUser.html",
            data : {
            	inputUsername : username
            },
            success : function(data) {
                if (data.resultJSON) {
                	$('#modalEditUser input[name="inputUsername"]').val(username);
                	$('#modalEditUser input[name="inputEmail"]').val(data.inputEmail);
                	$('#modalEditUser input[name="inputFirstname"]').val(data.inputFirstname);
                	$('#modalEditUser input[name="inputLastname"]').val(data.inputLastname);
                	$('#modalEditUser input[name="inputMobilephone"]').val(data.inputMobilephone);
                	$('#modalEditUser input[name="optionsRole"][value="'+data.optionsRole+'"]').attr('checked',true);
                	if(data.checkboxActive){
                		$('#modalEditUser input[name="checkboxActive"]').attr('checked',true)
                	}
                	$('#modalEditUser').modal('show');
                    return;
                } else {
                	alert("Why me god?");
                }
            },
            error : function() {
            	alert("Why me god? error cmnr");
            }
        });
	});
	
	$("#editUserButton").bind("click",function(){
		$.ajax({ 
            type : "POST",
            url : $('#contextPath').val() + "/admin/updateUser.html",
            data : {
            	inputUsername : $('#modalEditUser input[name="inputUsername"]').val(),
            	inputLastname : $('#modalEditUser input[name="inputLastname"]').val(),
            	inputFirstname : $('#modalEditUser input[name="inputFirstname"]').val(),
            	inputEmail : $('#modalEditUser input[name="inputEmail"]').val(),
            	inputMobilephone : $('#modalEditUser input[name="inputMobilephone"]').val(),
            	optionsRole : $('#modalEditUser input[name="optionsRole"]:checked').val(),
            	checkboxActive : $('#modalEditUser input[name="checkboxActive"]').is(':checked'),
            },
            success : function(data) {
                if (data.resultJSON) {
                    alert("Edit user successful.");
                    location = location;
                    return;
                } else {
                	alert("Why me god?");
                }
            },
            error : function() {
            	alert("Why me god? error cmnr");
            }
        });
	});
});