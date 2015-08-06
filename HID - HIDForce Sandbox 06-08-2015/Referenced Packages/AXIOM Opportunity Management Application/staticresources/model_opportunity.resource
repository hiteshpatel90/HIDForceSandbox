var parentModel = Backbone.Model.extend({
	getById: function(id, callback) {
		var self = this;
		
		var parentObject = Visualforce.remoting.Manager.invokeAction( controller + '.getOpportunityById', id, function(result, event) {
			self.set(result);
			
			if (typeof(callback) == 'function') {
				callback();
			}
		});
	}
});