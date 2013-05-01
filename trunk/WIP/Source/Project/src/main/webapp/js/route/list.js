function loadDetails(routeid) {
	var url = $('#contextPath').val() + "/route/route-detail-list.html?routeId=" + routeid;
    	window.location = url;
 	};
 
 	function deleteRoute(id) {
 	   $('#routeId').val(id);
   $("#deleteRouteDialog").modal();
};

function activeRoute(id) {
	$.ajax({
     url: "activeRoute.html?routeId=" + id,
  }).done(function(data) {
     $("#saveSuccessDialogLabeMessage").text(data.message);
     $("#saveSuccess").modal();
  });
}
function getStation(el, des, stationEndAtKey) {
    cityId = $('#' + el).val();
       if (cityId != -1) {
       $.ajax({url: "getStation.html?cityId=" + cityId }).done(
       function(data) {
             $('#' + des).empty();
              $.each(data.stationInfos, function() {
                $('#' + des).append('<option value="'+this.id+'">'+this.name+'</option>');
              });
              if (el == 'startAt' && stationEndAtKey) {
                $("#stationStartAt").val(stationEndAtKey);
              }
              getDuration();
              if ($('#' + el).prop('disabled')) {
              	$('#' + el).select2('disable');
                  $('#' + des).select2('disable');
              } else {
                  $('#' + des).select2('enable');
              }
              $('#' + des).trigger('change');
          });
     }
 };
 
 function getDuration() {
	   var startStationAt = $("#stationStartAt").val();
	   var endStationAt = $("#stationEndAt").val();
	   if (startStationAt && endStationAt && startStationAt != -1 && endStationAt != -1) {
		   $.ajax({
			      type : "GET",
			      url: "getSegmentDuration.html?startStation=" + startStationAt + "&endStation=" + endStationAt,
	            contentType : "application/x-www-form-urlencoded; charset=utf-8",
			   }).done(
				   function(data) {
					   if (data.travelTime != '') {
						   $("#duration").val(data.travelTime);
						   $("#duration").prop("disabled", true);
					   } else {
						   $("#duration").prop("disabled", false);
					   }
					   checkAdd();
			      });
		} 
 }
 
 function checkAdd() {
	   var startAt = $('#startAt').val();
	   var endAt = $("#endAt").val();
	   var duration = $('#duration').val();
	   
	   duration = parseInt(duration.replace(":",""), 10);

	   if(startAt != -1 && endAt != -1 && duration != '' && duration >= parseInt('100', 10) && giCount < 5){
		   $("#add").prop("disabled", false); 
	   } else { 
		   $("#add").prop("disabled",true);
	   }
 }
 
 $(document).ready(function() {
    
	   var routeTable = $('#routeTable').dataTable({ bSort : false });
	   var segmentTable = $('#segmentTable').dataTable({ 
		   bSort : false , 
		   bPaginate : false,
		   bInfo : false
	   });

	   //SELECT 2
	   $("#startAt").select2();
	   $("#endAt").select2();
	   $("#stationStartAt").select2({minimumResultsForSearch : 5});
	   $("#stationEndAt").select2({minimumResultsForSearch : 5});
	   $('.select2-input').on('focusin.anti-modal', function(e){
			 e.stopPropagation();
		 });
	   
    $('#addRoute').bind('click', function(event) {
  	  $(".alert.fade.in").hide();
  	   giCount = 0;
  	   $("#routeAddDialogOk").removeClass('btn-primary');
  	   $("#routeAddDialogOk").prop("disabled", true); 
  	   segmentTable.dataTable().fnClearTable();
  	   $("#startAt").prop("disabled", false);
  	   $("#stationStartAt").prop("disabled", false);
       // sort start at
       $('#startAt').html($('option', $('#startAt')).sort(function(a, b) {
      	 return a.text == b.text ? 0 : a.text < b.text ? -1 : 1;
       }));
       // re-attach detached end at location
       if ($('#startAt').data('removedOptionList')) {
      	 $($('#startAt').data('removedOptionList')).each(function(index, value) {
      		 value.appendTo('#endAt');
      	 });
       }
  	   //$("#startAt").val(-1);
       $("#startAt").trigger('change');
       // sort end at
       $('#endAt').html($('option', $('#endAt')).sort(function(a, b) {
      	 return a.text == b.text ? 0 : a.text < b.text ? -1 : 1;
       }));
       $('#endAt').trigger('change');
  	   //$("#endAt").val(-1);
  	   $("#duration").val('01:00');
       $("#errorMessage").text('');
       $("#errorMessage").parent().hide();
//  	   $('#stationStartAt').empty();
//  	   $('#stationEndAt').empty();
//  	   $("#endAt option").show();
  	   checkAdd();
  	   $("#addRouteDialog").modal();
    });
     
    $('#routeDeleteDialogOk').click(function() {
  	   var routeId = $('#routeId').val();
       $.ajax({
      	   url: "deleteRoute.html?routeId=" + routeId,
       }).done(function(data) {
      	   $('#deleteRouteDialog').modal('hide');
      	   $("#saveSuccessDialogLabeMessage").text(data.message);
          $("#saveSuccess").modal();
      	});
    });
	   
    $('#return').bind('click', function() {
  	   var url = $('#contextPath').val() + "/route/list.html";
       window.location = url;
    });
     
    $("#duration").mask("99:99");
    
    accounting.settings = {
       currency: {
          symbol : " VNĐ",   // default currency symbol is '$'
          format: "%v%s", // controls output: %s = symbol, %v = value/number (can be object: see below)
          decimal : ",",  // decimal point separator
          thousand: ".",  // thousands separator
          precision : 0   // decimal places
       },
       number: {
          precision : 0,  // default precision on numbers is 0
          thousand: ",",
          decimal : "."
       }
    };
                
    $('#startAt').change(function() {
//  	   $("#endAt option").show();
//  	   $("#endAt").val(-1);
//  	   $('#stationEndAt').empty();
//  	   getStation('startAt', 'stationStartAt');
//  	   $("#endAt option[value=" + $("#startAt").val() + "]").hide();
//  	   checkAdd();
         getStation('startAt', 'stationStartAt');
         // re attach previous option
	   	 if ($(this).data('previousOption') && !$(this).prop('disabled')) {
	   	     console.log($(this).data('previousOption'));
	   		 $(this).data('previousOption').appendTo('#endAt');
	   	 }
	   	 // detach current option
	        if ($(this).val() != -1) {
	       	 if ($(this).prop('disabled')) {
	       		 if (!$(this).data('removedOptionList')) {
	       			 $(this).data('removedOptionList', []);
	       		 }
	       		 $(this).data('removedOptionList').push($("#endAt option[value=" + $("#startAt").val() + "]").detach());
	       	 } else {
	           	 $(this).data('previousOption', $("#endAt option[value=" + $("#startAt").val() + "]").detach());
	       	 }
	        } else {
	       	 $(this).removeData('previousOption');
	        }
	        // sort end at
	        $('#endAt').html($('option', $('#endAt')).sort(function(a, b) {
	       	 return a.text == b.text ? 0 : a.text < b.text ? -1 : 1;
	        }));
	        //$("#endAt option[value=" + $("#startAt").val() + "]").hide();
	        $("#endAt").trigger('change');
	        checkAdd();
    });
                
    $('#endAt').change(function() {
       getStation('endAt', 'stationEndAt');
       checkAdd();
    });
    
    $('#stationEndAt').change(function() {
  	   getDuration();
        checkAdd();
    });
    
    $('#duration').change(function(){
  	   checkAdd();
    });
                
    $("#validDateDiv").datetimepicker({
       format : "yyyy/mm/dd - hh:ii",
       autoclose : true,
       todayBtn : true,
       startDate : new Date(),
       minuteStep : 10
    });
    
    $("#add").bind('click', function() {
  	      if (giCount == 5) {
             $("#errorMessage").text("Sorry, you cannot add more than 5 segments per route.");
             $(".alert.fade.in").show();
             $("#add").attr("disabled","disabled");
             return;
  	      }
  	    
  	      $("#routeAddDialogOk").addClass("btn-primary");
  	      $("#routeAddDialogOk").prop("disabled", false);  

          var startAtKey = $("#startAt").val();
          var stationStartAtKey = $("#stationStartAt").val();
          var endAtKey = $("#endAt").val();
          var stationEndAtKey = $("#stationEndAt").val();
          var startAt = $("#startAt option:selected").text();
          var stationStartAt = $("#stationStartAt option:selected").text();
          var endAt = $("#endAt option:selected").text();
          var stationEndAt = $("#stationEndAt option:selected").text();
          var duration = $("#duration").val();
                         
          if (endAt.trim() == '' || endAtKey == -1) {
          	return;
          }
          
          if (stationStartAt.trim() == '' || stationStartAtKey == -1) {
             return;
          }
                         
          if (stationEndAt.trim() == '' || stationEndAtKey == -1) {
             return;
          }
                         
          if (duration.trim() == '') {
             return;
          }
                         
          $('#segmentTable').dataTable().fnAddData(
                [ startAt + ' - ' + stationStartAt,
                  endAt + ' - ' + stationEndAt, 
                  duration ]);
          giCount++;

          $("#startAt").val(endAtKey);
          $("#startAt").prop("disabled", true);
//          $("#stationStartAt").prop("disabled", true);
//          $("#stationEndAt").empty();
//          getStation('startAt', 'stationStartAt', stationEndAtKey);
          $("#startAt").trigger('change');
                        
          //$("#endAt option[value=" + endAtKey + "]").hide();
//          $("#endAt").val(-1);
          $("#endAt").trigger('change');
          $("#duration").val('01:00');
//          $('#stationEndAt').empty();
          $("#duration").prop("disabled", false);

          var segment = {};
          segment['startAt'] = startAtKey;
          segment['stationStartAt'] = stationStartAtKey;
          segment['endAt'] = endAtKey;
          segment['stationEndAt'] = stationEndAtKey;
          segment['duration'] = duration;
          segments.push(segment);

          if (giCount == 5) {
             $("#errorMessage").text("Maximum segment added!");
             $("#errorMessage").parent().show();
          }
          checkAdd();
   });

   $("#routeAddDialogOk").bind('click', 
  		 function() {
  	 	$("#routeAddDialogOk").attr("disabled","disabled");
          info['segments'] = segments;
                         
          $.ajax({
             type : "POST",
             url : 'saveSegment.html',
             contentType : "application/x-www-form-urlencoded; charset=utf-8",
             data : {
                data : JSON.stringify(info)
             },
             success : function(response) {
            	  $('#addRouteDialog').modal('hide');
                $("#saveSuccessDialogLabeMessage").html(response);
                $("#saveSuccess").modal();
             },
             error: function(){
            	 $('#saveSuccess').modal('hide');
              $("#saveSuccessDialogLabeMessage").html(response);
              $("#saveSuccess").text("Save new route failed!");
             }
          });
       });
   
   $('#saveSuccessDialogOk').click(function() {
          var url = $('#contextPath').val() + "/route/list.html";
          window.location = url;
    });
   
   $('#routeAddDialogCancel').click(function() {
  	 info = {};
  	 segments = [];
  	 giCount = 0;
   });
 });

 var info = {};
 var segments = [];
 var giCount = 0;