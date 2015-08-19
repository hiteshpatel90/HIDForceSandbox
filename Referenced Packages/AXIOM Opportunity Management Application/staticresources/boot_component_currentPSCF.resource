/*
 * Loads component "Current PSCF"
 */
loadCurrentPSCF = function(callback) {
	var type = 'currentPSCF',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get current PSCF ***/
	componentCollection.getByParentIdAndType(parentId, type, function() {
			/*** file: view_component ***/
			var componentBodyView = new componentView({
				collection : componentCollection,
				el : el
			});

			var checkSelectedButton = function() {
				var hasChecked = false;
				$('.curPSCFCheckbox').each(function() {
					if($(this).is(":checked")) {
						hasChecked = true;
					}
				});

				if(hasChecked) {
					$('.curPSCF-add-selected').removeClass('disabled');
				} else {
					$('.curPSCF-add-selected').addClass('disabled');
				}
			};

			componentBodyView.render({
				title : 'Current P/S/C/F',
				type : type,
				options : {
					modalTitle : 'Pull From Existing Current P/S/C/F',
					modalOptions : modalOptions[type]
				},
				newItem : {
					items : [{
						itemName: prentFieldAPI,
						itemValue : parentId,
						itemType : 'item'
					},
					{
						itemName: 'AXIOM_BASE__Account__c',
						itemValue : parentAccountId,
						itemType : 'item'
					}],
					hasAccountPlan : {
						number: '0'
					}
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
					'click .ap-button' : function(e) {
						e.preventDefault();
						if(!$('.currentPSCF .ap-button').hasClass('disabled')) {
							var self = this;
							$('#ap-currentPSCF-Modal').modal('show');
						}

					},
					'click .edit-button' : function(e) {
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
						tr.find('input[type="text"]:first').focus();

						target.removeClass('editing');
					}
				}
			}, function() {
				$('.modal-backdrop').remove();
				$('#ap-currentPSCF-Modal').modal().modal('hide');
				loadModalCurrentPSCF(function() {});
				if (typeof(callback) == 'function') {
					callback(componentCollection);
				}
			});
	});
}