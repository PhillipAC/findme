var level = "To be updated";

function request_distance(onSuccess, element){
  
	if (navigator.geolocation) {
    
		var timeoutVal = 10 * 1000 * 1000;
    
		navigator.geolocation.getCurrentPosition(
      
			onSuccess, 
      
			displayError(element),
      
			{ enableHighAccuracy: true, timeout: timeoutVal, maximumAge: 0 }
);
} 
	else {
		$(element).text = "Geolocation is not supported by this browser";
  
}
}




function displayError(error) {
 
	var errors = { 
   
		1: 'Permission denied',
   
		2: 'Position unavailable',
   
		3: 'Request timeout'
 };
 
	$("#radar").text("Error: " + errors[error.code]);
}



function find_distance(position){
  
	$.ajax({
          
		url : "<%= get_distance_location_path %>",
          
		type : "post",
          
		data : { 
              
			x_coord: position.coords.latitude, 
              
			y_coord: position.coords.longitude},
          
		success : function(data){
            
			if (data.level !== null )
{
              
				level = data.level
            
			}
            
			$("#radar").html("<span style='color:red'>" + level + "</span> :" + data.distance);
	    
            $('.progress-bar').css('width', data.percentage+'%').attr('aria-valuenow', data.percentage).text(data.percentage+'%');

            
    },

          	error : function(){
            
			$("#radar").text("Could not connect to server")
          
		}
  
	});

};



function updateField(position) {
  
	$(document).ready(function(){
        
		$("#location_target_x").val(position.coords.latitude);
        
		$("#location_target_y").val(position.coords.longitude);
        
		$("#location_target_z").val(position.coords.altitude);
   
	});
}