/* 
	Object: templateUtility
	
	Description:  Contains functions that are used to load templates
	
	Functions:
		
		get:
			Description - load template, if it does not currently exist. Then return template in the callback function.
				
			Params - templateObj - Object returned from grabbing data from the templateDirectory. 
								   Contains name: templates name, and url: templates source
								   
				     callback - function to pass the template back to.
*/
templateUtility = function() {
	var tObj = {
		get : function (templateObj, callback){
			// Check to see if template is already loaded
			if (typeof(ich[templateObj.name]) == 'undefined') {
					
						//Not loaded so grab the template and return with the callback
						jQuery.ajax({
							url: templateObj.url,
							type: "GET",
							dataType: 'text',
							success: function(data) {
								//Add the template
								if (typeof(ich[templateObj.name]) == 'undefined') {
									ich.addTemplate(templateObj.name, data);
								}
								callback(ich[templateObj.name]);
							}
						});
			}else{
				// Template already added - serve it to the callback function
				callback(ich[templateObj.name]);
			}
			return true;
		}
	}
	return tObj;
}