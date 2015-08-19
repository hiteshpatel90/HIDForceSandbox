/*
 * Loads component "PSC Criteria"
 */
loadPSCCriteria = function(callback) {
	var type = 'pscCriteria',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get p/s/c criteria ***/
	componentCollection.getBySIIdAndType(dealId, type, function() {
		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});

		var biow = function() {
			var tmp = [];
			/*** filling select options ***/
			_.each(evList, function(obj) {
				var name = obj.AXIOM_BASE__Contact__r.Name,
					id = obj.Id,
					roles = obj.AXIOM_BASE__Roles__c;


				if (roles) {
					roles = roles.replace(crMap['PT'],'PT');
					roles = roles.replace(crMap['PE'],'PE');
					roles = roles.replace(crMap['SE'],'SE');
					roles = roles.replace(crMap['CE'],'CE');
					roles = roles.replace(/[,]/g, ' ').match(/\bPT|PE|SE|CE\b/g);
					if (roles) {
						tmp.push({ Id : id, Name : name, Roles : roles});
					}
				}
			});
			return tmp;
		}

		componentBodyView.render({
			title : 'P/S/C Criteria',
			type : type,
			options : {
				biow : biow,
				pscAreas : pscAreas,
				pscImpacts : pscImpacts,
				Description : 'Only Evaluators with a Role of ' + crMap['CE'] + ', ' + crMap['PE'] +', ' + crMap['PT'] + ' or ' + crMap['SE'] + ' can have P/S/C Criteria added to them.'
			},
			newItem : {
				// nothing
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
				// none
			},
			duplicateErrorMsg : 'The selected Evaluator already has an entry with this Description pick-list value, duplicates Descriptions for the same Evaluator are not allowed.'
		}, function() {
			var items = el.find('.component-body-item');
			el.find('.Impact__c .view').each(function() {
				jQuery(this).html(jQuery(this).html().replace(/;/g, ', '));
			});
			_.each(componentCollection.models, function(item) {
				// show name of first contact item only
				el.find('.toggle-' + item.get('BIO_Worksheet__c') + ':first .BIO_Worksheet__c span:first').show();
			});

			el.find('.BIO_Worksheet__c select').change(function() {
				var self = jQuery(this),
					roles = self.find('option[value="' + self.val() + '"]').attr('roles');
					desc = self.parents('.component-body-item-field').siblings('.Description__c');

				desc.find('select.item option').attr('disabled', true);

				if (roles) {
					_.each(roles.split(','), function(role) {
						if (role == 'PT' || role == 'PE') {
							desc.find('select.item option[value="Product"]').attr('disabled', null);
						} else if (role == 'SE') {
							desc.find('select.item option[value="Support"]').attr('disabled', null);
						} else if (role == 'CE') {
							desc.find('select.item option[value="Company"]').attr('disabled', null);
						}
					});

					desc.find('select').val('');

					if (!noFancies) {
						desc.find('select').trigger("liszt:updated");
					}
				}
			});

			if (pscAreas) {
				var pscAreaSelect = el.find('.Description__c select');

				pscAreaSelect.each(function() {
					var self = jQuery(this);

					self.val(self.attr('current'));
				});

				/*editDOM(function() {
					items.addClass('edit');
					matchHeights('.' + type + ' .component-body-item .select-wrapper');
					items.removeClass('edit');
				});*/
			}

			if (typeof(callback) == 'function') {
				callback(componentCollection);
			}
		});
	});
};