/*
 * Loads component "Evaluators"
 */
loadEvaluators = function(callback) {
	var type = 'evaluators',
		el = jQuery('.' + type);
	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get evaluators ***/
	componentCollection.getByParentIdAndType(parentId, type, function() {
		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});
		componentBodyView.refreshButton = function(e) {
			e.preventDefault();
			var self = componentBodyView,
				target = jQuery(e.target);
			if (target.hasClass('refreshing')) {
				return;
			}

			target.addClass('refreshing');

			self.collection.getByParentId(parentId, function() {
				self.$el.find('clear-button').click();
				_.each(self.dependentComponents, function(component) {
					jQuery('.' + component + ' .refresh-button').trigger('refreshDepend');
				});

				Visualforce.remoting.Manager.invokeAction( controller + '.getContactsByQ','', parentId, function(result) {
					contacts = [];
					_.each(result, function(c) {
						contacts.push({
							Id : c.Id,
							Name : c.Name + '(' + (c.AccountId == null ? 'No Account' : c.Account.Name) + ')'
						});
					});
					self.options.contacts = contacts;
					self.renderContent();
					renderWinData();
					target.removeClass('refreshing');
				});
			});
		};
		componentBodyView.refreshDepend = function(e) {
			e.preventDefault();
			var self = componentBodyView;
			self.collection.getByParentId(parentId, function() {
				self.$el.find('clear-button').click();
				Visualforce.remoting.Manager.invokeAction( controller + '.getContactsByQ','', parentId, function(result) {
					contacts = [];
					_.each(result, function(c) {
						contacts.push({
							Id : c.Id,
							Name : c.Name + '(' + (c.AccountId == null ? 'No Account' : c.Account.Name) + ')'
						});
					});
					self.options.contacts = contacts;
					self.renderContent();
					renderWinData();
				});
			});
		};
		customAlternatives = function() {
			// get custom alternatives
			var ca = [];
			if (isAlternativeObjEmpty) {
				ca.push('Do Nothing');
			}
			_.each(componentBodyView.collection.models, function(model) {
				var alts = model.get('AXIOM_BASE__Alternatives__c');

				if (alts) {
					_.each(alts.split(';'), function(alternative) {
						ca.push(alternative);
					});
				}
			});

			ca = _.uniq(ca);
			ca = _.difference(ca, alternatives);

			return ca;
		};

		/*favoredAlternatives = function() {
			// get favored alternatives
			var fa = [];

			_.each(componentBodyView.collection.models, function(model) {
				var alts = model.get('AXIOM_BASE__Favored_Alternative__c');

				if (alts) {
					_.each(alts.split(';'), function(alternative) {
						fa.push(alternative);
					});
				}
			});

			fa = _.uniq(fa);
			fa = _.difference(fa, alternatives);

			return fa;
		}*/

		componentBodyView.saveButtonCallback = function(id) {
			// reload component after saving
			var self = this;
			Visualforce.remoting.Manager.invokeAction( controller + '.purgeEvaluatorDataById', id, function(result) {
				self.$el.find('.refresh-button').click();
			});
		}

		var contactURL = '/003/e?retURL=' + encodeURIComponent('/' + parentId) + '&saveURL=' + encodeURIComponent('/' + parentId) + '&con4_lkid=' + encodeURIComponent(parentAccountId);

		var lightBox = function() {
			var obj = [];
			//if (!canCreateCCEvaluator) {
				obj.push({modal: 'error_message', text: 'Please enter at least 2 evaluators, before creating an evaluator with CC role'});
			//}
			return obj;
		}

		componentBodyView.render({
			title : 'Evaluators & Relationships',
			type : type,
			newItem : {
				items : [{
					itemName: prentFieldAPI,
					itemValue : parentId,
					itemType : 'key'
				}]
			},
			options : {
				ObjectType : ObjectType,
				parentId : parentId,
				contacts : contacts,
				contactURL : contactURL,
				roles : roles,
				roleSize : roles.length,
				alternatives : alternatives,
				customAlternatives : customAlternatives,
				//favoredAlternatives : favoredAlternatives,
				influenceScores : influenceScores,
				goodQualityScores : goodQualityScores,
				rQualityScores : rQualityScores,
				hasLightbox : lightBox
			},
			dependentComponents : [
				'businessStates',
				'dangerZones',
				'financialCriteria',
				'pscCriteria',
				'decisionHistory',
				'actionRegisters'
			],
			buttons : [
				{
					name : '',
					buttonClass : 'help-button button',
					href : urlsMap[type.toLowerCase()],
					target : '_blank'
				}
			],
			events : jQuery.extend(
				alternativesChosenEvents(),
				contactQueryEvents(componentBodyView),
				{
					'click .save-button-wrapper' : function(e) {
						e.preventDefault();
						var self = this,
							target = jQuery(e.target),
							tr = jQuery(target.attr('href')),
							roleSelect = tr.find('.AXIOM_BASE__Roles__c select');

						var cur = roleSelect.attr('current').split(';'),
							val = roleSelect.val(),
							diff = _.difference(cur, val);

						if (val == null) {
							val = [""];
						}

						if (diff.length > 1 || (diff.length == 1 && diff[0] != '')) {
							if (!confirm('Warning! Removing an Evaluator\'s Role will delete all criteria associated with that Role. Press OK to continue.')) {
								return;
							}
						}

						tr.find('.save-button').click();
					},
					'click .modal-cancel-button' : function(e) {
						e.preventDefault();
						var target = jQuery(e.target),
							modal = target.parents('.modal');
						modal.modal('hide');
					}, 
					/*'click .evaluators .component-body-item-content tr' : function(e) {
						var toggler = $($(e.target).parents('tr')[0]).find('.Toggler input');
						var isEdit = $($(e.target).parents('tr')[0]).find('.AXIOM_BASE__Contact__c .edit').is(':visible');
						if(!isEdit){
							toggler.attr('checked', !toggler.is(':checked'));
							if(toggler.is(':checked')) {
								$(toggler.parents('.component-body-item')[0]).addClass('green');
							} else {
								$(toggler.parents('.component-body-item')[0]).removeClass('green');
							}
							toggler.trigger('filteredByEv');
						}
					},*/
					'change .Toggler input' : function(e) {
						var self = this,
							target = jQuery(e.target),
							id = target.val().replace('.toggle-',''),
							checked = target.attr('checked');

						if (checked) {
							target.parents('.component-body-item').removeClass('no-pdf');
							jQuery(target.val()).removeClass('hidden no-pdf');
							_.each(self.collection.models, function(item) {
								if (item.get('Id') == id) {
									item.hidden = false;
								}
							});
						} else {
							target.parents('.component-body-item').addClass('no-pdf');
							jQuery(target.val()).addClass('hidden no-pdf');
							_.each(self.collection.models, function(item) {
								if (item.get('Id') == id) {
									item.hidden = true;
								}
							});
						}

						jQuery('select[name="AXIOM_BASE__BIO_Worksheet__c"]').each(function() {
							var self = jQuery(this),
								option = self.find('option[value="' + id + '"]'),
								chznOption = jQuery('#' + self.attr('id') + '_chzn_o_' + option.index());

							if (self.val() == id) {
								self.val('');
								self.trigger('liszt:updated');
							}

							if (checked) {
								option.show();
								chznOption.show();
							} else {
								option.hide();
								chznOption.hide();
							}
						});
					}
				}
			)
		}, function() {
			$('#eval-Modal').modal().modal('hide');
			//$('.evaluators .component-body-item').addClass('green');
			// text fixes
			el.find('.AXIOM_BASE__Roles__c .view').each(function() {
				jQuery(this).html(jQuery(this).text().replace(/;/g, ', '));
			});
			el.find('.AXIOM_BASE__Alternatives__c .view .text').each(function() {
				jQuery(this).html(jQuery(this).text().replace(/;/g, ', '));
			});
			el.find('.AXIOM_BASE__Contact__c .accountName').each(function() {
				if (jQuery(this).attr('id') == accountId) {
					jQuery(this).attr('style', 'display:none;');
				}
			});

			var items = el.find('.component-body-item');

			// remove class hasDecisionMaker and recheck
			el.find('.component-body').removeClass('hasDecisionMaker');

			_.each(componentBodyView.collection.models, function(model) {
				var id = model.get('AXIOM_BASE__Contact__c'),
					influence = model.get('AXIOM_BASE__Influence_Score__c');

				// toggle visibility
				jQuery('.toggle-' + id).show();

				// add class if there's a decision maker
				if (influence == 6) {
					el.find('.component-body').addClass('hasDecisionMaker');
				} else if (el.find('.component-body').hasClass('hasDecisionMaker')) {
					var select = jQuery('#' + type + '-' + model.get('Id')).find('.AXIOM_BASE__Influence__c select');

					// remove Decision Maker option
					select.find('option[value="' + influenceScores[0] + '"]').remove();
					if (!noFancies) {
						// update chosen
						select.trigger('liszt:updated');
					}
				}
			});

			var contactSelect = el.find('.AXIOM_BASE__Contact__c select');
			var roleSelect = el.find('.AXIOM_BASE__Roles__c select');

			/*** set change event for role select options change ***/
			roleSelect.change(function() {
				var self = jQuery(this),
					alternative = self.parents('.roles-reports-wrapper').siblings('.AXIOM_BASE__Alternatives__c'),
					alternativeFavoredSelect = alternative.find('.picked-alternative select'),
					influence = self.parents('.roles-reports-wrapper').siblings('.AXIOM_BASE__Influence__c'),
					influenceSelect = influence.find('select'),
					quality = self.parents('.roles-reports-wrapper').siblings('.AXIOM_BASE__Quality__c'),
					qualitySelect = quality.find('.normal select'),
					val = self.val();

				// remove quality selects for CC
				if (val && _.indexOf(val, 'CC', true) != -1) {
					alternativeFavoredSelect.val(orgName);
					alternativeFavoredSelect.attr('disabled', true);

					qualitySelect.find('option:gt(0)').attr('disabled', null);
					qualitySelect.find('option:gt(2)').attr('disabled', true);
					if (qualitySelect.find('option[value="' + qualitySelect.val() + '"]').attr('disabled')) {
						qualitySelect.val(qualitySelect.find('option:eq(2)').val());
					}
				} else {
					alternativeFavoredSelect.attr('disabled', null);
					alternativeFavoredSelect.val('');

					qualitySelect.find('option').attr('disabled', null);
				}

				alternativeFavoredSelect.trigger('liszt:updated');
				qualitySelect.trigger('liszt:updated');
			});
			roleSelect.change();

			var alternativeSelect = el.find('.alternativeSelect');
			var favoredAlternative = el.find('.alternativeSelectPick');

			/*** set change event for alternative-field select options change ***/
			alternativeSelect.change(function() {
				var self = jQuery(this),
					alternatives = self.val(),
					options = '<option></option><option value="' + orgName + '">' + orgName + '</option>';

				if (alternatives) {
					_.each(alternatives, function(alternative) {
						if (isAlternativeObjEmpty) {
							options += '<option value="' + alternative + '">' + alternative + '</option>';
						} else {
							options += '<option value="' + alternativesMap[alternative] + '">' + alternativesMap[alternative] + '</option>';
						}
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
			});
			alternativeSelect.change();

			favoredAlternative.change(function() {
				var self = jQuery(this),
					quality = self.parents('.alternative-field').siblings('.AXIOM_BASE__Quality__c'),
					selector = quality.find('.normal select'),
					chznSelector = quality.find('.normal .chzn-results'),
					val = self.val();
					if (val == orgName) {
						if(selector.find(':selected').hasClass('resister')){
							selector.val('');
						}
						selector.find('.good').removeAttr('disabled');
						selector.find('.resister').attr( 'disabled', 'disabled' );
					} else {
						if(selector.find(':selected').hasClass('good')){
							selector.val('');
						}
						selector.find('.good').attr( 'disabled', 'disabled' );
						selector.find('.resister').removeAttr('disabled');
					}
					selector.trigger("liszt:updated");
			});
			favoredAlternative.change();

			// we need special fields for IE8-
			if (noFancies) {
				var contactInput = el.find('#contact-input'),
					contactIdInput = contactInput.siblings('input[name="AXIOM_BASE__Contact__c"]');

				// set autocomplete for contact look up
				if (contactInput.length) {
					contactInput.autocomplete({
						appendTo : '#contact-input-wrapper',
						close : function(event, ui) {
							if (contactIdInput.val() == '') {
								contactInput.val('');
							}

							contactInput.removeClass('searched');
						},
						focus : function(event, ui) {
							event.preventDefault();

							if (ui.item.value != '') {
								contactInput.val(ui.item.label);
								contactIdInput.val(ui.item.value);
							} else {
								contactIdInput.val('');
							}
						},
						minLength: 0,
						select : function(event, ui) {
							event.preventDefault();

							if (ui.item.value != '') {
								contactInput.val(ui.item.label);
								contactIdInput.val(ui.item.value);
							} else {
								contactIdInput.val('');
							}

							contactInput.removeClass('searched');
						},
						source : function(request, response) {
							contactInput.addClass('searched');
							contactIdInput.val('');

							// request.term.replace(/ \((.+)\)$/, '') to remove the account if it was added from a previous search
							Visualforce.remoting.Manager.invokeAction(controller + '.getContactsByQ', request.term.replace(/ \((.+)\)$/, ''), parentId, function(result, event) {
								if (result == null) {
									window.location.href='/' + parentId;
									return;
								}

								if (result.length > 0) {
									response(jQuery.map(result, function(item) {
										return {
											label : jQuery('<div>').html(item.Name).text() + ' (' + (item.AccountId ? jQuery('<div>').html(item.Account.Name).text() : 'No Account') + ')',
											value : item.Id
										}
									}));
								} else {
									response([{
										label : 'No Results',
										value : ''
									}]);
								}
							});
						}
					}).focus(function(e) {
						if (contactInput.val() == '' || contactInput.val() == null) {
							if (!contactInput.hasClass('searched')) {
								contactInput.autocomplete('search', '');
							}
						}
					});
					// remove 40px padding
					jQuery('.ui-autocomplete').css('padding', 0);
				}

				var altInput = el.find('.custom-alternatives');

				// set custom alternative input
				altInput.bind('keyup', function(e) {
					var self = jQuery(this),
						altSelect = self.parents('.component-body-item-field').find('.alternativeSelect');
					if (!e.shiftKey && (e.keyCode == 13 || e.keyCode == 188)) {
						if (isAlternativeObjEmpty) {
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
					}
				});

				var noFancyInputs = el.find('.noFancies input');

				// set help text
				noFancyInputs.bind('blur', function(e) {
					var self = jQuery(this);
					if (self.val() == '') {
						self.val(self.attr('dataHolder'));
						self.addClass('dataHolder');
					}
				});

				noFancyInputs.bind('focus', function(e) {
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
	/*** events for allowing custom Alternatives__c with chosen : button event that allows adding custom Alternatives__c with <enter> or <comma> ***/
	function alternativesChosenEvents () {

		/*** binds close events for custom options : should be called after chosen list gets updated to rebind ***/
		var bindSearchChoiceCloseEvents = function(item) {
			jQuery(item + ' .search-choice-close').each(function() {
				jQuery(this).click(function(e) {
					var target = jQuery(e.target);

					jQuery(item + ' select').trigger('liszt:updated');

					// rebind after updating list (updating list removes current binds)
					bindSearchChoiceCloseEvents('.alternative-field');
				});
			});
		};

		// determine whether or not to create a custom alternative
		var createCustomValue = function(target) {
			if (isAlternativeObjEmpty) {
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
			}
		}

		return {
			'keyup .evaluators .alternative-field .search-field input' : function(e) {
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

			/*** blur for custom alternatives ***/
			'blur .evaluators .alternative-field .search-field input' : function(e) {
				var target = jQuery(e.target),
					alternativeSelect = target.closest('.alternative-field').find('.alternativeSelect');

				// unmark all deletion marks
				alternativeSelect.find('.custom.deleteMe').removeClass('deleteMe');

				createCustomValue(target);
			}
		}
	};

	/*
	 * contactQueryEvents
	 * params:
	 *  view - current view for contact query
	 * returns:
	 *  button event binding a query search for contacts
	 */
	function contactQueryEvents (view) {
		return {
			'keyup .AXIOM_BASE__Contact__c .chzn-search input' : function(e) {
				/*** ignore non-printable characters ***/
				if (String.fromCharCode(e.keyCode) == null) {
					return;
				}

				var target = jQuery(e.target),
					q = target.val();
					options = '';

				var contactSelect = view.$el.find('.AXIOM_BASE__Contact__c select');

				/*** set a timeout delay (500ms) to prevent constantly querying while typing ***/
				setTimeout(function() {
					/*** query only if the query text hasn't changed in 500ms ***/
					if (q == target.val()) {
						var options = '<option></option>';

						Visualforce.remoting.Manager.invokeAction( controller + '.getContactsByQ', q, parentId, function(result, event) {
							if (result == null) {
								window.location.href='/' + parentId;
								return;
							}

							/*** display results only if query text hasn't changed ***/
							if (q == target.val()) {
								_.each(result, function(contact) {
									options += '<option value="' + contact.Id + '">' + contact.Name + ' (' + (contact.AccountId ? contact.Account.Name : 'No Account') +  ')</option>';
								});

								if (result.length == 0) {
									contactSelect.html('<option></option>').trigger('liszt:updated');

									var noResultText = '<li class="no-results active-results">No results found for "' + q.replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;') + '". <a href="' + contactURL + '" onClick="window.location.href = this.href;">Add a new contact</a>?</li>';
									jQuery(e.target).closest('.chzn-search').siblings('.chzn-results').html(noResultText);
								} else {
									// update chosen list
									contactSelect.html(options).trigger('liszt:updated');
								}

								target.val(q);
							}
						});
					}
				}, 500);
			}
		};
	};
};