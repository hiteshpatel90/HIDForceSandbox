/*
 * Loads component "Danger Zones"
 */
loadDangerZones = function(callback) {
	var type = 'dangerZones',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();
	var retURL = '&saveURL=' + encodeURIComponent('/' + dealId) + '&retURL=' + encodeURIComponent('/' + dealId);

	/*** get decision stages ***/
	componentCollection.getBySIIdAndType(dealId, type, function() {
		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});

		// grab bio worksheets from evaluator list
		var biow = function() {
			var tmp = [];
			_.each(evList, function(obj) {
				var name = obj.AXIOM_BASE__Contact__r.Name,
					id = obj.Id;
				tmp.push({ Id : id, Name : name});
			});
			return tmp;
		}

		componentBodyView.render({
			title : 'Danger Zones',
			type : type,
			options : {
				biow : biow
			},
			newItem : {
				items : [{
					itemName: 'StrategicInitiative__c',
					itemValue : dealId,
					itemType : 'item'
				}, {
					itemName: 'isCustom__c',
					itemValue : 'true',
					itemType : 'item'
				}]
			},
			dependentComponents : [
				'actionRegisters'
			],
			buttons : [
				{
					name : 'Edit',
					buttonClass : 'edit-danger-zones button hidden',
					dropdown : true,
					options : [
						{
							name : 'Mark as Addressed',
							buttonClass : 'dzAddress'
						},
						{
							name : 'Mark as Unaddressed',
							buttonClass : 'dzUnaddress'
						},
						{
							isDivider: true
						},
						{
							name : 'Log a Call',
							buttonClass : 'dzCall'
						},
						{
							name : 'Create a Task',
							buttonClass : 'dzTask'
						},
						{
							name : 'Schedule an Event',
							buttonClass : 'dzEvent'
						},
						{
							isDivider : true
						},
						{
							name : 'Remove Action',
							buttonClass : 'dzRemoveAction'
						}
					]
				},
				{
					name : '',
					buttonClass : 'help-button button',
					href : urlsMap[type.toLowerCase()],
					target : '_blank'
				}
			],
			events : {
				'click .assignToAction input:checkbox' : function(e) {
					var numChecked = el.find('.assignToAction input:checked').length,
						editButton = el.find('.edit-danger-zones');

					// update text in edit button
					if (numChecked > 0) {
						editButton.find('.button-name').html('Edit ' + numChecked);
						editButton.show();
					} else {
						editButton.hide();
					}
				},
				'click .dzAddress' : function(e) {
					e.preventDefault();

					updateDZ(getUnaddressedChecked(), 'Addressed__c=true', function() {
						jQuery('.deal .dangerZones .refresh-button').click();
					});
				},
				'click .dzUnaddress' : function(e) {
					e.preventDefault();

					updateDZ(getAddressedChecked(), 'Addressed__c=false', function() {
						jQuery('.deal .dangerZones .refresh-button').click();
					});
				},
				'click .dzCall' : function(e) {
					e.preventDefault();
					var ids = getChecked();
					StrategicInitiativeExtension.saveRelatedAction(ids, 'Call', dealId, function(result, event) {
						location.href = '/' + result + '/e?' + retURL;
					}, {escape : false});
				},
				'click .dzTask' : function(e) {
					e.preventDefault();
					var ids = getChecked();
					StrategicInitiativeExtension.saveRelatedAction(ids, 'Task', dealId, function(result, event) {
						location.href = '/' + result + '/e?' + retURL;
					}, {escape : false});


				},
				'click .dzEvent' : function(e) {
					e.preventDefault();
					var ids = getChecked();
					StrategicInitiativeExtension.saveRelatedAction(ids, 'Event', dealId, function(result, event) {
						location.href = '/' + result + '/e?' + retURL;
					}, {escape : false});
				},
				'click .dzRemoveAction' : function(e) {
					e.preventDefault();
					var ids = getChecked();

					StrategicInitiativeExtension.removeActionAssignment(ids, function(result, event) {
						if (result == null) {
							window.location.href='/' + dealId;
							return;
						}

						jQuery('.deal .dangerZones .refresh-button').click();
					});
				},
				'click .hide-dangerZones' : function(e) {
					e.preventDefault();

					el.find('.grayOut').hide();
					el.find('.hide-dangerZones').hide();
					el.find('.show-dangerZones').show();

					matchHeights('.small-component-group-1');
				},
				'click .show-dangerZones' : function(e) {
					e.preventDefault();

					el.find('.grayOut').show();
					el.find('.show-dangerZones').hide();
					el.find('.hide-dangerZones').show();

					matchHeights('.small-component-group-1');
				}
			}
		}, function() {
			var editButton = el.find('.edit-danger-zones');
			editButton.hide();

			var completed = el.find('.grayOut');

			// move addressed danger zones to addressed area
			completed.each(function() {
				var self = jQuery(this),
					dividerEnd = el.find('#dangerZones-');

				self.insertBefore(dividerEnd);
			});

			var items = el.find('.component-body-item');

			// resize component when textarea resizes
			var textAreas = el.find('textarea');
			textAreas.keyup(function(e) {
				matchHeights('.small-component-group-1');
			});

			editDOM(function() {
				matchHeights('.small-component-group-1')
			});

			if (typeof(callback) == 'function') {
				callback(componentCollection);
			}
		});
	});

	function updateDZ(ids, data, callback) {
		/*if (data.indexOf('Addressed__c=false') == -1) {
			StrategicInitiativeExtension.removeActionAssignment(ids, function(result, event) {
				if (result == null) {
					window.location.href='/' + dealId;
					return;
				}
	
				StrategicInitiativeExtension.updateObjs('dangerZones', ids, data, function(result, event) {
					if (result == '') {
						el.find('.edit-danger-zones').hide();
						callback();
					}
				});
			});
		} else {*/
			StrategicInitiativeExtension.updateObjs('dangerZones', ids, data, function(result, event) {
				if (result == '') {
					el.find('.edit-danger-zones').hide();
					callback();
				}
			});
		//}
	}

	// returns id list of checked danger zones
	function getChecked() {
		var ids = '';

		el.find('.assignToAction input:checked').each(function() {
			var self = jQuery(this);

			ids += self.val() + ',';
		});

		if (ids) {
			ids = ids.substring(0, ids.length-1);
		}

		return ids;
	}

	function getAddressedChecked() {
		var ids = '';

		el.find('.grayOut .assignToAction input:checked').each(function() {
			var self = jQuery(this);

			ids += self.val() + ',';
		});

		if (ids) {
			ids = ids.substring(0, ids.length-1);
		}

		return ids;
	}

	function getUnaddressedChecked() {
		var ids = '';

		el.find('.noGrayOut .assignToAction input:checked').each(function() {
			var self = jQuery(this);

			ids += self.val() + ',';
		});

		if (ids) {
			ids = ids.substring(0, ids.length-1);
		}

		return ids;
	}
};