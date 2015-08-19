/*
 * Loads component "Business States"
 */
loadBusinessStates = function(callback) {
	var type = 'businessStates',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get business states ***/
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
			title : 'Business State & Gaps',
			type : type,
			options : {
				biow : biow,
				bsAreas : bsAreas,
				bsImpacts : bsImpacts,
				modalOptions : modalOptions[type]
			},
			newItem : {
				hasAccountPlan : {
					number: '0'
				},
				items : [{
					itemName: 'AXIOM_BASE__Strategic_Initiative__c',
					itemValue : dealId,
					itemType : 'item'
				},
				{
					itemName: 'AXIOM_BASE__Account__c',
					itemValue : dealAccountId,
					itemType : 'item'
				}]
			},
			dependentComponents : [
				'dangerZones',
				'evaluators'
			],
			buttons : [
				{
					name : '',
					buttonClass : 'help-button button',
					href : urlsMap[type.toLowerCase()],
					target : '_blank'
				}

			],
			events : {
				'click .ap-button' : function(e) {
					e.preventDefault();
					if(!$('.businessStates .ap-button').hasClass('disabled')) {
						var self = this;
						$('#ap-bs-Modal').modal('show');
					}
				}
			},
			duplicateErrorMsg : 'The selected Evaluator already has an entry with this Description pick-list value, duplicates for the same Evaluator are not allowed.'
		}, function() {
			el.find('.AXIOM_BASE__Impact__c .view').each(function() {
				jQuery(this).html(jQuery(this).html().replace(/;/g, ', '));
			});

			var items = el.find('.component-body-item');

			// show name of first contact item only in each group
			_.each(componentCollection.models, function(item) {
				el.find('.toggle-' + item.get('BIO_Worksheet__c') + ' .AXIOM_BASE__BIO_Worksheet__c span:first').show();
			});

			// hide all groups that are not checked from evaluators
			_.each(evList.models, function(item) {
				if (item.hidden) {
					el.find('.toggle-' + item.get('Id')).addClass('hidden no-pdf');
				} else {
					el.find('.toggle-' + item.get('Id')).removeClass('hidden no-pdf');
				}
			});
			$('.modal-backdrop').remove();
			$('#ap-bs-Modal').modal().modal('hide');
			loadModalBusinessStates(function() {});
			if (typeof(callback) == 'function') {
				callback(componentCollection);
			}
		});
	});
};