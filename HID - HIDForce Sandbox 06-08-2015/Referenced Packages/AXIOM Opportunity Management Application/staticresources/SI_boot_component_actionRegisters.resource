/*
 * Loads component "Action Registers"
 */
loadActionRegisters = function(callback) {
	var type = 'actionRegisters',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get action registers ***/
	componentCollection.getBySIIdAndType(dealId, type, function() {

		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});

		var retURL = encodeURIComponent('/' + dealId),
			logURL = '/00T/e?title=Call&followup=1&tsk5=Call&what_id=' + dealId + '&who_id=' + dealAccountId + '&retURL=' + retURL + '&saveURL=' + retURL,
			taskURL = '/00T/e?what_id=' + dealId + '&who_id=' + dealAccountId + '&retURL=' + retURL + '&saveURL=' + retURL,
			eventURL = '/00U/e?what_id=' + dealId + '&who_id=' + dealAccountId + '&retURL=' + retURL + '&saveURL=' + retURL;

		componentBodyView.render({
			title : 'Activities',
			type : type,
			dependentComponents : [
				'dangerZones',
				'decisionStages'
			],
			buttons : [
				{
					name : 'New Action',
					buttonClass : 'add-action-register button',
					dropdown : true,
					options : [
						{
							name : 'Log a Call',
							buttonClass : 'logButton',
							href : logURL
						},
						{
							name : 'New Task',
							buttonClass : 'taskButton',
							href : taskURL
						},
						{
							name : 'New Event',
							buttonClass : 'eventButton',
							href : eventURL
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
				'click .edit-button' : function(e) {
					// empty function overriding component editButton to perform default and navigate to standard SFDC page
				},
				'change .save-modal' : function(e) {
					var target = jQuery(e.target),
						modal = jQuery(target.attr('href'));
					// if a modal exists and action is completed
					if (target.attr('checked') && target.attr('current') == 'true' && modal.length) {
						// open modal for checking off danger zones before saving
						modal.modal('show');
					} else {
						// perform default action of saving when modal does not exist or marking action as incomplete
						target.siblings('.save-button').click();
					}
				},
				'click .modal-save-button' : function(e) {
					e.preventDefault();
					var target = jQuery(e.target),
						modal = target.parents('.modal'),
						dzList = '';

					// create list of all checked danger zones
					modal.find('input:checked').each(function() {
						var self = jQuery(this);

						dzList += self.val() + ',';
					});

					if (dzList.indexOf(',') != -1) {
						dzList = dzList.substring(0, dzList.length - 1);
					}

					// update action danger zones
					modal.find('.item[name="AXIOMOMD__Danger_Zones__c"]').val(dzList);

					// mark all danger zones as addressed
					StrategicInitiativeExtension.updateObjs('dangerZones', dzList, 'Addressed__c=true', function(result, event) {
						if (result == null) {
							window.location.reload(true);
							return;
						}

						modal.find('.save-button').click();
						modal.modal('hide');
					});
				},
				'click .modal-cancel-button' : function(e) {
					e.preventDefault();
					var target = jQuery(e.target),
						modal = target.parents('.modal');
					// undo all checked danger zones
					jQuery(target.attr('href')).find(':checked').removeAttr('checked','');
					jQuery(target.attr('href')).find('.switch-on').removeClass('switch-on').addClass('switch-off');

					modal.modal('hide');
				},
				'click .Priority.Priority-High' : function(e) {
					var target = jQuery(e.target);

					target.removeClass('Priority-High');
					target.addClass('Priority-Normal');
				},
				'click .Priority.Priority-Normal' : function(e) {
					var target = jQuery(e.target);

					target.removeClass('Priority-Normal');
					target.addClass('Priority-High');
				},
				'click .hide-actionRegisters' : function(e) {
					e.preventDefault();

					el.find('.grayOut').hide();
					el.find('.hide-actionRegisters').hide();
					el.find('.show-actionRegisters').show();

					matchHeights('.small-component-group-1');
				},
				'click .show-actionRegisters' : function(e) {
					e.preventDefault();

					el.find('.grayOut').show();
					el.find('.show-actionRegisters').hide();
					el.find('.hide-actionRegisters').show();

					matchHeights('.small-component-group-1');
				}
			}
		}, function() {
			$('.closer').bootstrapSwitch();
			getSecFromCookies(done);

			var completed = el.find('.grayOut');

			// move all completed actions to hidden/completed area
			completed.each(function() {
				var self = jQuery(this),
					divider = el.find('.toggle-actionRegisters');

				self.insertAfter(divider);
			});

			el.find('.dropdown-toggle').dropdown();
			// bootstrap puts block on hidden, so undo
			el.find('.dropdown-toggle.hidden').hide();

			el.find('.modal').modal().modal('hide');

			el.find('.dropdown-toggle').click(function(e) {
				e.preventDefault();
				var target = jQuery(e.target),
					myDropdown = target.parents('.dropdown');

				el.find('.dropdown').removeClass('open');
				myDropdown.addClass('open');
			});

			editDOM(function() {
				matchHeights('.small-component-group-1')
			});

			if (typeof(callback) == 'function') {
				callback();
			}
		});
	});
};