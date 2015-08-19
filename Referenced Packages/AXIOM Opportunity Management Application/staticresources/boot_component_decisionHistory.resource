/*
 * Loads component "Decision History"
 */
loadDecisionHistory = function(callback) {
	var type = 'decisionHistory',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get decision history ***/
	componentCollection.getByParentIdAndType(parentId, type, function() {
		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});

		// get bio worksheets from evaluator list and remove existing ones
		var biow = function() {
			var b = [],
				excludeIds = '';

			_.each(componentCollection.models, function(item) {
				// show name of first contact item only
				var id = item.get('BIO_Worksheet__c');

				excludeIds += id + ';';
			});

			_.each(evList, function(obj) {
				var name = obj.AXIOM_BASE__Contact__r.Name,
					id = obj.Id;

				if (excludeIds.indexOf(id) == -1) {
					b.push({ Id : id, Name : name});
				}
			});

			return b;
		}


		var DHalternatives = function() {
			var alts = [];
			_.each(alternatives, function(alt){
				alts.push(alt.label);
			});
			return [].concat(alts, customAlternatives());
		}
		// get custom alternatives
		var DHcustomAlternatives = function() {
			var ca = [];

			_.each(componentBodyView.collection.models, function(model) {
				var alts = model.get('Prior_Alternatives__c');

				if (alts) {
					_.each(alts.split(';'), function(alternative) {
						ca.push(alternative);
					});
				}
			});

			ca = _.uniq(ca);
			ca = _.difference(ca, DHalternatives());

			return ca;
		}

		componentBodyView.render({
			title : 'Decision History',
			type : type,
			options : {
				biow : biow,
				alternatives : DHalternatives,
				customAlternatives : DHcustomAlternatives
			},
			newItem : {
				// nothing
			},
			dependentComponents : [
				// nothing
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
				'click .new-button' : function(e) {
					var self = this;

					self.newButton(e);
					matchHeights('.small-component-group-2');
				},
				'click .clear-button' : function(e) {
					var self = this;

					self.clearButton(e);
					matchHeights('.small-component-group-2');
				},
				'click .edit-button' : function(e) {
					var self = this;

					self.editButton(e);
					matchHeights('.small-component-group-2');
				},
				'click .cancel-button' : function(e) {
					var self = this;

					self.cancelButton(e);
					matchHeights('.small-component-group-2');
				},
				'keyup .decisionHistory .alternative-field .search-field input' : function(e) {
					var target = jQuery(e.target),
						alternativeSelect = target.closest('.alternative-field').find('.alternativeSelect');

					/*** create custom Alternative__c after <enter> or <comma> ***/
					if (e.keyCode == 13 || e.keyCode == 188) {
						createCustomValue(target);
					}

					// backstroke for custom Alternatives__c
					if (e.keyCode == 8) {
						// list of custom Alternatives__c prepared for deletion
						var deletes = alternativeSelect.find('.custom.deleteMe');

						if (deletes.length) {
							deletes.remove();
							alternativeSelect.trigger('liszt:updated');

							// add custom close event
							bindSearchChoiceCloseEvents('.alternative-field');
						}

						/*** mark custom Alternatives__c prepared for deletion ***/
						var focus = target.parents('.search-field').siblings('.search-choice-focus');
						if (focus.length) {
							alternativeSelect.find('.custom[value="' + focus.text() + '"]').addClass('deleteMe');
						}
					}
					else {
						// backed out on deleting, remove all marks
						alternativeSelect.find('.custom.deleteMe').removeClass('deleteMe');
					}
				},
				'blur .decisionHistory .alternative-field .search-field input' : function(e) {
					var target = jQuery(e.target),
						alternativeSelect = target.closest('.alternative-field').find('.alternativeSelect');

					// unmark all deletion marks
					alternativeSelect.find('.custom.deleteMe').removeClass('deleteMe');
					createCustomValue(target);
				}
			}
		}, function() {
			// text fixes
			el.find('.Prior_Alternatives__c .view').each(function() {
				jQuery(this).html(jQuery(this).html().replace(/;/g, ', '));
			});

			matchHeights('.small-component-group-2');

			var alternativeSelect = el.find('.alternativeSelect');
			var favoredAlternative = el.find('.alternativeSelectPick');

			/*** set change event for alternative-field select options change ***/
			alternativeSelect.change(function() {
				var self = jQuery(this),
					alternatives = self.val(),
					options = '<option></option><option value="' + orgName + '">' + orgName + '</option>';

				if (alternatives) {
					_.each(alternatives, function(alternative) {
						options += '<option value="' + alternative + '">' + alternative + '</option>';
					});
				}

				var pickAlternative = self.siblings('.picked-alternative').find('.alternativeSelectPick');
				pickAlternativeVal = pickAlternative.val();
				pickAlternative.html(options);
				if (pickAlternative.attr('current')) {
					pickAlternative.val(pickAlternative.attr('current'));
				}
				pickAlternative.val(pickAlternativeVal);
				pickAlternative.trigger('liszt:updated');

				matchHeights('.small-component-group-2');
			});
			alternativeSelect.change();

			var textAreas = el.find('textarea');
			textAreas.keyup(function(e) {
				matchHeights('.small-component-group-2');
			});

			if (noFancies) {
				var altInput = el.find('.custom-alternatives');
				altInput.bind('keyup', function(e) {
					var self = jQuery(this),
						altSelect = self.parents('.component-body-item-field').find('.alternativeSelect');

					if (!e.shiftKey && (e.keyCode == 13 || e.keyCode == 188)) {
						var val = jQuery(e.target).val();

						if (val.indexOf(',') > -1) {
							val = val.substring(0, val.indexOf(','));
						}
						val = val.replace(/<\/?script>/g, '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
						val.trim();

						if (val.length) {
							if (altSelect.find('option[value="' + val + '"]').length == 0) {
								var nval = altSelect.val();

								if (nval == null) {
									nval = [];
								}

								altSelect.append('<option value="' + val + '" class="custom">' + val + '</option>');
								nval.push(val);
								altSelect.val(nval);
								altSelect.change();
							}
						}

						jQuery(e.target).val('');
					}
				});

				altInput.bind('blur', function(e) {
					var self = jQuery(this);

					if (self.val() == '') {
						self.val(self.attr('dataHolder'));
						self.addClass('dataHolder');
					}
				});

				altInput.bind('focus', function(e) {
					var self = jQuery(this);

					if (self.hasClass('dataHolder')) {
						self.val('');
						self.removeClass('dataHolder');
					}
				});
			}

			if (typeof(callback) == 'function') {
				callback(componentCollection);
			}
		});
	});
	function createCustomValue(target) {
		var alternative = target.val(),
			alternativeSelect = target.closest('.alternative-field').find('.alternativeSelect');

		if (alternative.indexOf(',') > -1) {
			alternative = alternative.substring(0, alternative.indexOf(','));
		}
		alternative = alternative.replace(/<\/?script>/g, '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
		alternative.trim();

		/*** still a valid Alternative__c ? ***/
		if (alternative.length) {
			var results = alternativeSelect.siblings('.chzn-container').find('.chzn-drop .chzn-results');

			// check if not already in Alternatives__c list
			if (!alternativeSelect.find('option[value="' + alternative + '"]').length) {
				// add to list and remake list
				alternativeSelect.append('<option value="' + alternative + '" class="custom">' + alternative + '</option>').trigger('liszt:updated');

				// mimic event to chosen to add to selected
				var event = jQuery.Event('mouseup');
				event.target = results.find('li:last').addClass('highlighted');
				results.trigger(event);

				// add custom close event for custom Alternatives__c
				bindSearchChoiceCloseEvents('.alternative-field');
			} else {
				target.val('');
			}
		} else {
			target.val('');
		}
	};
	function bindSearchChoiceCloseEvents(item) {
		jQuery(item + ' .search-choice-close').each(function() {
			jQuery(this).click(function(e) {
				var target = jQuery(e.target);

				jQuery(item + ' select').trigger('liszt:updated');

				// rebind after updating list (updating list removes current binds)
				bindSearchChoiceCloseEvents('.alternative-field');
			});
		});
	};
	
}