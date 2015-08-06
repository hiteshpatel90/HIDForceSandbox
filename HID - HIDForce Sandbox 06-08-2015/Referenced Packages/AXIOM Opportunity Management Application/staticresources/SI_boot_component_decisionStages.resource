/*
 * Loads component "Decision Stages"
 */
loadDecisionStages = function(callback) {
	var type = 'decisionStages',
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

		componentBodyView.deleteButton = function(e) {
			e.preventDefault();
			if(!validateAccess (e)){
				return;
			}
			var self = this,
				target = jQuery(e.target)
				compButton = target.parents('.component-button'),
				buttons = compButton.find('.buttons'),
				busy = compButton.find('.busy');
			var tr = jQuery(target.attr('href'));
			if (target.hasClass('deleting')) {
				return;
			}

			target.addClass('deleting');
			compButton.addClass('busy');

			if (confirm('Are you sure you want to delete this item?')) {
				StrategicInitiativeExtension.deleteObj(this.type, target.attr('href').replace('#' + this.type + '-',''), function(result, event) {
					if (result == null) {
						window.location.href='/' + dealId;
						return;
					} else
					if(result == 'SUCCESS'){
						StrategicInitiativeExtension.removeActionAssignment(target.attr('href').replace('#' + this.type + '-',''), function(result, event) {
							if (result != '') {
								window.location.href='/' + dealId;
								return;
							}
							self.collection.getByDealId(dealId, function() {
								self.deleteButtonCallback(e);
							});
						});
					} else {
						var res = result.split(':', 2);
						if (res[0] == 'ERROR') {
							target.removeClass('deleting');
							compButton.removeClass('busy');
							var err = res[1].split('|', 2);
							var field = tr.find('.' + err[0].charAt(0).toUpperCase() + err[0].slice(1));
							field.find('.error-message').show();
							field.find('.error-message').html(err[1]);
						}
					}
				});
			} else {
				target.removeClass('deleting');
				compButton.removeClass('busy');
			}
		}

		componentBodyView.render({
			title : 'Decision Stages',
			type : type,
			newItem : {
				items : [{
					itemName:'StrategicInitiative__c',
					itemValue : dealId,
					itemType : 'item'
				}]
			},
			dependentComponents : [
				'dangerZones',
				'actionRegisters'
			],
			options : {
				dealId : dealId
			},
			status : {
				'class' : 'Decision_Status',
				value : decisionStatus
			},
			buttons : [
				{
					name : 'Edit',
					buttonClass : 'edit-danger-zones button hidden',
					dropdown : true,
					options : [
						{
							name : 'Log a Call',
							buttonClass : 'dsCall'
						},
						{
							name : 'Create a Task',
							buttonClass : 'dsTask'
						},
						{
							name : 'Schedule an Event',
							buttonClass : 'dsEvent'
						},
						{
							isDivider : true
						},
						{
							name : 'Remove Action',
							buttonClass : 'dsRemoveAction'
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
				'click .dsCall' : function(e) {
					e.preventDefault();
					var ids = getChecked();
					StrategicInitiativeExtension.saveRelatedAction(ids, 'Call', dealId, function(result, event) {
						location.href = '/' + result + '/e?' + retURL;
					}, {escape : false});
				},
				'click .dsTask' : function(e) {
					e.preventDefault();
					var ids = getChecked();
					StrategicInitiativeExtension.saveRelatedAction(ids, 'Task', dealId, function(result, event) {
						location.href = '/' + result + '/e?' + retURL;
					}, {escape : false});


				},
				'click .dsEvent' : function(e) {
					e.preventDefault();
					var ids = getChecked();
					StrategicInitiativeExtension.saveRelatedAction(ids, 'Event', dealId, function(result, event) {
						location.href = '/' + result + '/e?' + retURL;
					}, {escape : false});
				},
				'click .dsRemoveAction' : function(e) {
					e.preventDefault();
					var ids = getChecked();

					StrategicInitiativeExtension.removeActionAssignment(ids, function(result, event) {
						if (result == null) {
							window.location.href='/' + dealId;
							return;
						}

						jQuery('.deal .decisionStages .refresh-button').click();
					});
				},
				'click .new-button' : function(e) {
					var self = this;

					self.newButton(e);
					matchHeights('.small-component-group-1');
				},
				'click .clear-button' : function(e) {
					var self = this;

					self.clearButton(e);
					matchHeights('.small-component-group-1');
				},
				'click .edit-button' : function(e) {
					var self = this;

					self.editButton(e);
					matchHeights('.small-component-group-1');
				},
				'click .cancel-button' : function(e) {
					var self = this;

					self.cancelButton(e);
					matchHeights('.small-component-group-1');
				},
				'click .Decision_Status .minus' : function(e) {
					decisionStatus = 'minus';
					if(jQuery('.component-header .Decision_Status').hasClass('minus')){
						decisionStatus = 'none';
					}
					StrategicInitiativeExtension.changeDecisionStatus(dealId, decisionStatus, function(result){
						if(result == 'SUCCESS'){
							jQuery('.component-header .Decision_Status').removeClass().addClass('Decision_Status left ' + decisionStatus);
							renderWinData();
						}else {
							var res = result.split(':', 2);
							if (res[0] == 'ERROR') {
								var err = res[1].split('|', 2);

								jQuery('.deal .header .error-message').html('ERROR: ' + err[1] + '. This error could be caused by a validation rule on the Opportunity. To edit the opportunity, <a href="/' + opportunityId + '/e?retURL=%2F' + opportunityId + '">click here</a>');
							}
						}
					});
				},
				'click .Decision_Status .plus' : function(e) {
					decisionStatus = 'plus';
					if(jQuery('.component-header .Decision_Status').hasClass('plus')){
						decisionStatus = 'none';
					}
					StrategicInitiativeExtension.changeDecisionStatus(dealId, decisionStatus, function(result){
						if(result == 'SUCCESS'){
							jQuery('.component-header .Decision_Status').removeClass().addClass('Decision_Status left ' + decisionStatus);
							renderWinData();
						}else {
							var res = result.split(':', 2);
							if (res[0] == 'ERROR') {
								var err = res[1].split('|', 2);

								jQuery('.deal .header .error-message').html('ERROR: ' + err[1] + '. This error could be caused by a validation rule on the Opportunity. To edit the opportunity, <a href="/' + opportunityId + '/e?retURL=%2F' + opportunityId + '">click here</a>');
							}
						}
					});
				}
			}
		}, function() {
			var editButton = el.find('.edit-danger-zones');
			editButton.hide();
			if(decisionStatus == 'empty'){
				changeWinData('decisionStages');
				$('.Decision_Status').hide();
			} else {
				$('.Decision_Status').show();
			}
			if(componentBodyView.collection.length == 1){
				changeWinData('decisionStages');
			}
			if(decisionStatus == 'plus'){
				$('.Decision_Status').removeClass().addClass('Decision_Status left plus');
			} else if(decisionStatus == 'minus'){
				$('.Decision_Status').removeClass().addClass('Decision_Status left minus');
			} else if(decisionStatus = 'none'){
				$('.Decision_Status').removeClass().addClass('Decision_Status left none');
			}
			$(".date").datepicker({
				dateFormat: 'M dd, yy',
				showOn: "button",
				buttonImage: calendarURL,
				buttonImageOnly: true
			});
			editDOM(function() {
				matchHeights('.small-component-group-1');
			});

			if (typeof(callback) == 'function') {
				callback(componentCollection);
			}
		});
	});
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
};