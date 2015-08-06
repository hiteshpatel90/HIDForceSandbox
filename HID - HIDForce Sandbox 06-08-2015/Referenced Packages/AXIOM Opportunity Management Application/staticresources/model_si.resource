var SIModel = Backbone.Model.extend({
	getById: function(id, callback) {
		var self = this;

		var si = StrategicInitiativeExtension.getSIById(id, function(result, event) {
			self.set(result);

			if (typeof(callback) == 'function') {
				callback();
			}
		});
	}
});