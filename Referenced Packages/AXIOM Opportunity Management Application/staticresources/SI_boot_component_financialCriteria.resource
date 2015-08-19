/*
 * Loads component "Financial Criteria"
 */
loadFinancialCriteria = function(callback) {
	var type = 'financialCriteria',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get financial criteria ***/
	componentCollection.getBySIIdAndType(dealId, type, function() {
		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});

		var biow = function() {
			var tmp = [];
			var excludeIds = '';
			_.each(componentCollection.models, function(item) {
				// show name of first contact item only
				var id = item.get('BIO_Worksheet__c');

				excludeIds += id + ';';
			});
			_.each(evList, function(obj) {
				var name = obj.AXIOM_BASE__Contact__r.Name,
					id = obj.Id,
					roles = obj.AXIOM_BASE__Roles__c;
					if(roles){
						roles= roles.replace(crMap['FE'],'FE');
					}

				if (excludeIds.match(id) == null && roles && roles.replace(/[,]/g, ' ').match(/\bFE\b/)) {
					tmp.push({ Id : id, Name : name});
				}
			});
			return tmp;
		}
		var lightBox = function() {
			var tmp = biow();
			var obj = [];
			if(tmp.length == 0){
				obj.push({modal: 'error_message', text: 'Please create evaluators with ' + crMap['FE'] +'  role for this Strategic Initiative, to create Financial Criteria'});
			}
			return obj;
		}

		componentBodyView.render({
			title : 'Financial Criteria',
			type : type,
			options : {
				biow : biow,
				financialConsiderations : financialConsiderations,
				fcSize : financialConsiderations.length,
				Description : 'Only Evaluators assigned the role of ' + crMap['FE'] + ' can have financial criteria added for them.',
				hasLightbox : lightBox
			},
			newItem : {
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
				'click .Status .minus' : function(e) {
					e.preventDefault();
					var self = this,
						target = jQuery(e.target),
						compButton = target.parents('.component-button'),
						buttons = compButton.find('.buttons'),
						busy = compButton.find('.busy'),
						itemSaveButton = jQuery(target.attr('href')).find('.save-button');

					if (itemSaveButton.hasClass('saving')) {
						return;
					}

					setStatus(e, 'minus');
					itemSaveButton.click();
				},
				'click .Status .plus' : function(e) {
					e.preventDefault();
					var self = this,
						target = jQuery(e.target),
						compButton = target.parents('.component-button'),
						buttons = compButton.find('.buttons'),
						busy = compButton.find('.busy'),
						itemSaveButton = jQuery(target.attr('href')).find('.save-button');
					if (itemSaveButton.hasClass('saving')) {
						return;
					}

					setStatus(e, 'plus');
					itemSaveButton.click();
				},
				'click .modal-cancel-button' : function(e) {
					e.preventDefault();
					var target = jQuery(e.target),
						modal = target.parents('.modal');
					modal.modal('hide');
				}
			}
		}, function() {
			$('#fin-Modal').modal().modal('hide');
			el.find('.Financial_Considerations .view').each(function() {
				jQuery(this).html(jQuery(this).html().replace(/;/g, ', '));
			});

			var items = el.find('.component-body-item');

			_.each(componentCollection.models, function(item) {
				// show name of first contact item only
				var id = item.get('AXIOM_BASE__BIO_Worksheet__c');

				el.find('.toggle-' + id + ':first .AXIOM_BASE__BIO_Worksheet__c span:first').show();
			});

			var financialConsiderationSelect = el.find('.Financial_Considerations select.AXIOM_BASE__Financial_Considerations__c'),
				primaryFinancialConsiderationSelect = el.find('.Financial_Considerations select.AXIOM_BASE__Primary_Financial_Consideration__c');

			/*** set change event for Financial_Considerations__c : Primary_Financial_Considerations__c options change ***/
			financialConsiderationSelect.change(function() {
				var self = jQuery(this),
					financialConsiderations = self.val(),
					options = '<option></option>';
				if (financialConsiderations) {
					_.each(financialConsiderations, function(financialConsideration) {
						options += '<option value="' + financialConsideration + '">' + financialConsideration + '</option>';
					});
				}

				var primaryFinancialConsideration = self.parents('.Financial_Considerations').find('select.AXIOM_BASE__Primary_Financial_Consideration__c');
				primaryFinancialConsideration.html(options);
				primaryFinancialConsideration.val(primaryFinancialConsideration.attr('current'));
				primaryFinancialConsideration.trigger('liszt:updated');
			});
			financialConsiderationSelect.change();

			if (typeof(callback) == 'function') {
				callback(componentCollection);
			}
		});
	});
	var setStatus = function(e, status) {
		var field= '';
		var parent = jQuery(e.target).parents('.Status');
		if(parent.hasClass('AXIOM_BASE__Budget_Status__c')){
			field = 'AXIOM_BASE__Budget_Status__c';
		} else if(parent.hasClass('AXIOM_BASE__Value_Assignment_Status__c')) {
			field = 'AXIOM_BASE__Value_Assignment_Status__c';
		}
		var item = jQuery(e.target).siblings('.item'),
			parent = item.parents('.' + field),
			val = item.val();

		parent.removeClass(val);
		if (val == status) {
			parent.addClass('none');
			item.val('none');
		} else {
			parent.addClass(status);
			item.val(status);
		}
	}
};