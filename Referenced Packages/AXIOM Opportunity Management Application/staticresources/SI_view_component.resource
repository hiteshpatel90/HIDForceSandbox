var componentView = Backbone.View.extend({
	events : {
		'click .cancel-button' : 'cancelButton',
		'click .component-title' : 'onClick',
		'click .component-logo' : 'onClick',
		'click .clear-button' : 'clearButton',
		'click .delete-button' : 'deleteButton',
		'click .edit-button' : 'editButton',
		'click .new-button' : 'newButton',
		'click .refresh-button' : 'refreshButton',
		'click .save-button' : 'saveButton',
		'click .AXIOM_BASE__Status__c .minus' : 'setMinus',
		'click .AXIOM_BASE__Status__c .plus' : 'setPlus',
		'keypress input' : 'clickSaveButton',
		'refreshDepend' : 'refreshDepend'

	},
	renderModal : function(params) {
		var self = this;
		if (self.collection.type) {
			templates.get(tempDir[self.collection.type],
				function(template) {
					self.$el.find('.component-body-item-content').html(template({
						model : self.collection.toJSON(),
						type : self.collection.type,
						items : self.items,
						options : self.options
					}));
					if(self.collection.type == 'Modal_Commonalities'){
						$('#com_filter').chosen();
					}
					self.$el.parent().parent().find('.pull-from-text').text( 'Pull From Existing( '+ self.collection.length +' )');
				}
			);
			// any passed in events get delegated
			if(params){
				if (params.events) {
					jQuery.extend(self.events, params.events);
				}

				if (params.duplicateErrorMsg) {
					self.duplicateErrorMsg = params.duplicateErrorMsg;
				}
				self.delegateEvents(self.events);
			}
		}
	},
	render : function(params, callback) {
		var self = this;
		self.postRenderCallback = callback;
		templates.get(tempDir['component'],
			function(template) {
					self.$el.html(template({
						params : params
					}));
				self.$el.find('.dropdown-toggle').dropdown();
				// bootstrap puts block on hidden
				self.$el.find('.dropdown-toggle.hidden').hide();

				// a specific inner component
				if (params.type) {
					self.type = params.type;
					if (params.newItem) {
						self.items = params.newItem.items;
						if(params.newItem.hasLightbox){
							self.hasLightbox = params.newItem.hasLightbox;
						}
					}
					if (params.options) {
						self.options = params.options;
					}

					self.renderContent();
				}

				// none? just callback
				else {
					if (typeof(self.postRenderCallback) == 'function') {
						var item = self.$el.find('.component-body-item');

						item.addClass('edit');
						// disable for IE8-
						if (!noFancies) {
							//self.$el.find('textarea').elastic();
							self.$el.find('select').chosen();
							self.$el.find('.chzn-container input').addClass('noEnterSave');
							self.$el.find('.noFancies').remove();
						} else {
							// font-size needs to be "re-"set for IE8-
							self.$el.find('.fancies').remove();
						}
						item.removeClass('edit');

						self.postRenderCallback();
					}
				}
			}
		);

		// any passed in events get delegated
			if (params.events) {
				jQuery.extend(self.events, params.events);
			}

			if (params.duplicateErrorMsg) {
				self.duplicateErrorMsg = params.duplicateErrorMsg;
			}

			self.delegateEvents(self.events);

			// add dependentComponents to refresh
			if (params.dependentComponents) {
				self.dependentComponents = params.dependentComponents;
			}
			postPageLoad();
	},
	renderContent : function() {
		var self = this;

		if (self.type) {
			templates.get(tempDir[self.type],
				function(template) {
					self.$el.find('.component-body').html(template({
						model : self.collection.toJSON(),
						type : self.type,
						items : self.items,
						options : self.options
					}));

					if(done){
						self.$el.find('.new-button').removeClass('disabled');
					}

					// hide filtered
					self.$el.find('.Toggler input').each(function() {
						var toggler = jQuery(this);

						if (!toggler.attr('checked')) {
							self.$el.find(toggler.val()).hide();
						}
					});

					if (typeof(self.postRenderCallback) == 'function') {
						var items = self.$el.find('.component-body-item');

						editDOM(function() {
							items.addClass('edit');

							try {
								// set values for selects
								self.$el.find('select').each(function() {
									var self = jQuery(this),
										cur = self.attr('current'),
										mul = self.attr('multiple');

									if (cur != null) {
										self.val(cur);

										if (mul && mul != false) {
											self.val(cur.split(';'));
										}

										self.change();
										self.trigger('liszt:updated');
									}
								});

								self.$el.find('input').each(function() {
									var self = jQuery(this),
										cur = self.attr('current');

									if (cur != null) {
										self.val(cur);
									}
								});

								// disable for IE8-
								if (!noFancies) {
									//self.$el.find('textarea').elastic();
									self.$el.find('select').chosen();
									self.$el.find('.chzn-container input').addClass('noEnterSave');
									self.$el.find('.noFancies').remove();
								} else {
									// font-size needs to be "re-"set for IE8-
									self.$el.find('.fancies').remove();
								}
							} catch (err) { }

							items.removeClass('edit');
						});
						if(done){
							$('.' + self.type + ' .loader2').hide();
							$('.' + self.type + ' .component-body-header').show();
						}
						self.postRenderCallback();
					}
				}
			);
		}
	},
	cancelButton : function(e) {
		e.preventDefault();
		var target = jQuery(e.target),
			compButton = target.parents('.component-button'),
			buttons = compButton.find('.buttons'),
			busy = compButton.find('.busy'),
			componentItem = jQuery(target.attr('href'));

		if (target.hasClass('canceling')) {
			return;
		}

		target.addClass('canceling');
		compButton.addClass('busy');

		componentItem.find('.item').each(function() {
			var self = jQuery(this),
				cur = self.attr('current'),
				mul = self.attr('multiple');

			if (cur != null) {
				self.val(cur);

				if (self.is('select')) {
					if (mul && mul != false) {
						self.val(cur.split(';'));
					}
				}

				self.change();
				self.trigger('liszt:updated');
			}
		});

		componentItem.find('.component-body-item-field').removeClass('error');
		componentItem.find('.component-body-item-field .error-message').html('');
		componentItem.find('input.clearItem').val('');
		componentItem.removeClass('edit');

		target.removeClass('canceling');
		compButton.removeClass('busy');
	},
	onClick : function(e) {
		if(this.type != 'decisionStages' && this.type != 'dangerZones' && this.type != 'actionRegisters'){
			var target = jQuery(e.target);
			var clickBlock = target.parents('.round-corners');
			var bodyBlock = clickBlock.children('.component-body');
			var footerBlock = clickBlock.children('.component-footer-wrapper');
			if (bodyBlock.css("display") == 'none') {
				setCookie(this.type);
				footerBlock.css("display","block");
				bodyBlock.css("display","block");
				if (this.type == 'commonalities' || this.type == 'decisionHistory') {
					var anotherSmallBlock;
					if (this.type == 'commonalities') {
						anotherSmallBlock = 'decisionHistory';
					} else if (this.type == 'decisionHistory') {
						anotherSmallBlock = 'commonalities';
					}
					var anotherSmallTarget = jQuery('.' + anotherSmallBlock).find('.component-body');
					var selector;
					if (anotherSmallTarget.css("display") == 'none') {
						selector = '.' + this.type;
					} else {
						selector = '.small-component-group-2';
					}
					matchHeights(selector);
				}
			} else {
				deleteCookie(this.type);
				footerBlock.css("display","none");
				bodyBlock.css("display","none");
				if (this.type == 'commonalities' || this.type == 'decisionHistory') {
					jQuery('.' + this.type).css("height", "43px");
					var anotherSmallBlock;
					if (this.type == 'commonalities') {
						anotherSmallBlock = 'decisionHistory';
					} else if (this.type == 'decisionHistory') {
						anotherSmallBlock = 'commonalities';
					}
					var anotherSmallTarget = jQuery('.' + anotherSmallBlock).find('.component-body');
					if (anotherSmallTarget.css("display") != 'none') {
						matchHeights('.' + anotherSmallBlock);
					}
				}
			}
		}
	},
	clearButton : function(e) {
		e.preventDefault();
		var self = this;

		self.$el.find('.new').removeClass('edit');
		self.$el.find('.new-button').removeClass('disabled');

		self.$el.find('.new table .item').val('');
		self.$el.find('input.clearItem').val('');
		self.$el.find('.new .item').trigger('liszt:updated');
		self.$el.find('.new .error').removeClass('error');
		self.$el.find('.new .error-message').html('');

		self.$el.find('.cancel-button').click();
	},
	deleteButton : function(e) {
		e.preventDefault();
		if(!validateAccess (e)){
			return;
		}
		var self = this,
			target = jQuery(e.target)
			compButton = target.parents('.component-button'),
			buttons = compButton.find('.buttons'),
			busy = compButton.find('.busy'),
			tr = jQuery(target.attr('href'));
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
				}
				if(result == 'SUCCESS'){
					// reload component after deleting
					self.collection.getByDealId(dealId, function() {
						self.deleteButtonCallback(e);
					});
				} else {
					var num = result.indexOf(':');
					if(num< 0){
						return;
					}
					var res = [];
					res[0] = result.substring(0,num);
					res[1] = result.substring(num+1);
					if (res[0] == 'ERROR') {
						target.removeClass('deleting');
						compButton.removeClass('busy');
						num = res[1].indexOf('|');
						if(num< 0){
							return;
						}
						var err = [];
						err[0] = res[1].substring(0,num);
						err[1] = res[1].substring(num+1);
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
	},
	deleteButtonCallback : function(e) {
		var self = this;

		self.$el.find('.refresh-button').click();
	},
	editButton : function(e) {
		e.preventDefault();
		var self = this,
			target = jQuery(e.target),
			tr = jQuery(target.attr('href'));

		if(/(msie|ie)/.test(navigator.userAgent.toLowerCase()) &&
				target.parents('.component').hasClass('evaluators')) {
			var evaluatorId = target.attr('href').replace('#' + this.type + '-',''),
				favoredAltsElement = $('#evaluators-' + evaluatorId + ' .edit .alternativeSelectPick'),
				cur = favoredAltsElement.attr('current');

				if (cur != null) {
					favoredAltsElement.val(cur);

					favoredAltsElement.change();
					favoredAltsElement.trigger('liszt:updated');
				}

		}

		if (target.hasClass('editing')) {
			return;
		}

		target.addClass('editing');

		tr.siblings('.edit').find('.cancel-button').click();
		tr.siblings('.edit').find('.clear-button').click();

		tr.addClass('edit');
		//tr.find('input[type="text"]:first').focus();

		target.removeClass('editing');

	},
	newButton : function(e) {
		if(!($(e.target).parents('.component').hasClass('evaluators'))) {
			if($(e.target).parents('.component').find('.error_message').length != 0){
				$(e.target).parents('.component').find('.modal.error_message').modal().modal('show');
				return;
			}
		}
		e.preventDefault();
		var self = this,
			n = self.$el.find('.new'),
			newButton = self.$el.find('.new-button');

		if (newButton.hasClass('disabled')) {
			return;
		}

		self.$el.find('.cancel-button').click();
		self.$el.find('.clear-button').click();

		newButton.addClass('disabled');

		n.addClass('edit');
		if($(e.target).parents('.component').hasClass('dangerZones')){
			matchHeights('.small-component-group-1');
		}
		n.find('input[type="text"]:first').focus();
	},
	saveButton : function(e) {
		e.preventDefault();
		if(!validateAccess (e)){
			return;
		}
		var self = this,
			target = jQuery(e.target),
			compButton = target.parents('.component-button'),
			buttons = compButton.find('.buttons'),
			busy = compButton.find('.busy'),
			data = '',
			keys = '',
			id = '',
			tr = jQuery(target.attr('href')),
			errorCount = 0;

		if (target.hasClass('saving')) {
			return;
		}

		target.addClass('saving');
		compButton.addClass('busy');

		// clear error fields
		tr.find('.component-body-item-field').removeClass('error');
		tr.find('.error-message-extra').hide();
		tr.find('.error-message').html('');
		var reqSetPass = false,
			reqSet = tr.find('.required-set');

		if (reqSet.length > 0) {
			reqSet.each(function() {
				var val = jQuery(this).val();

				if (val == null || val == 'null') {
					val = '';
				}

				if (val != '') {
					reqSetPass = true;
				}
			});
			if (!reqSetPass) {
				++errorCount;
				tr.find('.SaveObj').addClass('error');
				tr.find('.SaveObj .error-message').html('At least one field must be populated.');
			}
		}
		var oneOfTwoNotEmpty = false;
		var fieldCount = 0;
		tr.find('.required-one-of-two').each(function() {
			fieldCount += 1;
			var self = jQuery(this),
				container = self.closest('.component-body-item-field'),
				val = self.val() ? jQuery.trim('' + self.val()) : '';

			if (val != '') {
				oneOfTwoNotEmpty = true;
			}
			if(fieldCount == 2 && !oneOfTwoNotEmpty){
				container.addClass('error');
				container.find('.error-message').html('Required to populate value for one of two fields.');
				++errorCount;
			}
		});
		tr.find('.required').each(function() {
			var self = jQuery(this),
				container = self.closest('.component-body-item-field'),
				val = self.val() ? jQuery.trim('' + self.val()) : '';

			if (!self.hasClass('noLimit') && val.length > 255) {
				container.addClass('error');
				container.find('.error-message').html('Max length 255. Currently ' + val.length + '.');
				++errorCount;
			} else if (val == '') {

				container.addClass('error');
				container.find('.error-message').html('Required');
				++errorCount;
			}
		});

		tr.find('.key').each(function() {
			var self = jQuery(this),
				container = self.closest('.component-body-item-field'),
				name = encodeURIComponent(self.attr('name')),
				val = self.val() ? jQuery.trim('' + self.val()) : '';
			if(($(e.target).parents('.component').hasClass('evaluators')) && name == 'AXIOM_BASE__Roles__c' && val.indexOf('CC') != -1) {
				isCCRoleMentioned = true;
			}

			if (!self.hasClass('noLimit') && val.length > 255) {
				container.addClass('error');
				container.find('.error-message').html('Max length 255. Currently ' + val.length + '.');
				++errorCount;
			} else if (val == '') {
				container.addClass('error');
				container.find('.error-message').html('Required');
				++errorCount;
			} else {
				keys += name + '=' + encodeURIComponent(val) + '&';
			}
		});

		tr.find('.keyId').each(function() {
			var self = jQuery(this);
			id = encodeURIComponent(self.val());
		});
		var isCCRoleMentioned = false;
		if (target.parents('.component').hasClass('evaluators')) {
			var evId = target.attr('href').replace('#' + this.type + '-','');
			if (evId != null && evId != '' && totalAmountOfEvaluators == 2) {
				canCreateCCEvaluator = true;//false;
			}
		}
		tr.find('.item').each(function() {
			var self = jQuery(this),
				container = self.closest('.component-body-item-field'),
				name = encodeURIComponent(self.attr('name')),
				val = self.val() ? jQuery.trim('' + self.val()) : '';
			if ($(e.target).parents('.component').hasClass('decisionHistory') && name == 'Outcome_Alternative__c') {
				vals = val.split(',');
				val = '';
				_.each(vals, function(v) {
					if (v != null && v != '') {
						val += v + ',';
					}
				});
				if (val != '') {
					val = val.substring(0, val.length - 1);
				}
			}
			if(($(e.target).parents('.component').hasClass('evaluators')) && name == 'AXIOM_BASE__Roles__c' && val.indexOf('CC') != -1) {
				isCCRoleMentioned = true;
			}

			if (!self.hasClass('noLimit') && val.length > 255) {
				container.addClass('error');
				container.find('.error-message').html('Max length 255. Currently ' + val.length + '.');
				++errorCount;
			} else if (val == 'null') {
				val = '';
			}

			if (self.get(0).tagName.toUpperCase() == 'SELECT' && jQuery(self.get(0)).attr('multiple')) {
				val = val.replace(/,/g, ';');
			}
			if(self.hasClass('date')){
				val = $.datepicker.formatDate('yy-mm-dd', new Date(val));
			}
			data += name + '=' + encodeURIComponent(val) + '&';
		});

		if(isCCRoleMentioned && !canCreateCCEvaluator) {
			if($(e.target).parents('.component').find('.error_message').length != 0){
				$(e.target).parents('.component').find('.modal.error_message').modal().modal('show');
				target.removeClass('saving');
				compButton.removeClass('busy');
				var evId = target.attr('href').replace('#' + this.type + '-','');
				if (evId != null && evId != '' && totalAmountOfEvaluators == 2) {
					canCreateCCEvaluator = true;
				}
				return;
			}
		}

		if (target.parents('.component').hasClass('evaluators')) {
			var evId = target.attr('href').replace('#' + this.type + '-','');
			if (evId != null && evId != '' && totalAmountOfEvaluators == 2) {
				canCreateCCEvaluator = true;
			}
		}

		if (errorCount > 0) {
			target.removeClass('saving');
			compButton.removeClass('busy');
			return;
		}

		var type = tr.attr('id');
		type = type.substring(0, type.indexOf('-'));
		StrategicInitiativeExtension.saveObj(type, id, keys, data, function(result, event) {
			if (result == null) {
				window.location.href='/' + opportunityId;
				return;
			}

			var res = result.split(':', 2);

			if (res[0] == 'ID') {
				self.saveButtonCallback(id);
			} else if (res[0] == 'ERROR') {
				target.removeClass('saving');
				compButton.removeClass('busy');

				var err = res[1].split('|', 2);
				var prefix = '';
				if(err[0].indexOf("axiom_base__") >= 0){
					prefix = 'AXIOM_BASE__';
					err[0] = err[0].replace('axiom_base__','');
				}
				if (err.length == 2) {
					var $field = tr.find('.' + prefix + err[0].charAt(0).toUpperCase() + err[0].slice(1));
					$field.addClass('error');

					if (err[1].charAt(err[1].length - 1) != '.') {
						err[1] += '.';
					}

					if (err[1] == 'Duplicate key.') {
						tr.find('.key').parents('.component-body-item-field').addClass('error');
						$field.find('.error-message').html(self.duplicateErrorMsg);
					} else {
						$field.find('.error-message-extra').show();
						$field.find('.error-message').html(err[1]);
					}
				}
			}
		});
	},
	saveButtonCallback : function(id) {
		// reload component after saving
		var self = this;
		self.$el.find('.refresh-button').click();
	},
	clickSaveButton : function(e) {
		var self = this,
			target = jQuery(e.target),
			saveButton = target.parents('.component-body-item').find('.save-button');

		if (target.hasClass('noEnterSave')) {
			if (e.keyCode == 13) {
				e.preventDefault();
			}
			return;
		}

		if (e.keyCode == 13) {
			e.preventDefault();
			saveButton.click();
		}
	},
	refreshButton : function(e) {
		e.preventDefault();
		var self = this,
			target = jQuery(e.target),
			compButton = target.parents('.component-button'),
			buttons = compButton.find('.buttons'),
			busy = compButton.find('.busy');

		if (target.hasClass('refreshing')) {
			return;
		}

		target.addClass('refreshing');
		compButton.addClass('busy');

		self.collection.getByDealId(dealId, function() {
			self.$el.find('clear-button').click();
			_.each(self.dependentComponents, function(component) {
				jQuery('.' + component).trigger('refreshDepend')
			});

			self.renderContent();

			target.removeClass('refreshing');
			compButton.removeClass('busy');
		});
	},
	refreshDepend : function(e) {
		e.preventDefault();
		var self = this;
		if ($(e.target).hasClass('refreshing')) {
			return;
		}
		$(e.target).addClass('refreshing');
		self.collection.getByDealId(dealId, function() {
			self.$el.find('clear-button').click();
			self.renderContent();
			$(e.target).removeClass('refreshing');
		});
	},
	setStatus : function(e, status) {
		var item = jQuery(e.target).siblings('.item'),
			parent = item.parents('.AXIOM_BASE__Status__c'),
			val = item.val();

		parent.removeClass(val);

		if (val == status) {
			parent.addClass('none');
			item.val('none');
		} else {
			parent.addClass(status);
			item.val(status);
		}
	},
	setMinus : function(e) {
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

		self.setStatus(e, 'minus');
		itemSaveButton.click();
	},
	setPlus : function(e) {
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

		self.setStatus(e, 'plus');
		itemSaveButton.click();
	}
});