loadModalCurrentPSCF = function(callback) {
	var type = 'Modal_CurrentPSCF',
		el = jQuery('#ap-currentPSCF-Modal');

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

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();
	/*** get commonalities ***/
	componentCollection.getByAccountIdAndType(parentId, type, 'All', function() {
		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});
		componentBodyView.renderModal({
			type : type,
			dependentComponents : [
				// nothing
			],
			events : {
				'change #currentPSCF_filter' : function(e) {
					e.preventDefault();
					var self = this;
					var filter = jQuery('#currentPSCF_filter').val();
					self.collection.getByAccountIdAndType(parentId, 'Modal_CurrentPSCF', filter, function() {
						self.renderModal();
					});
				},
				'click .modal-cancel-button' : function(e) {
					$('#ap-currentPSCF-Modal').modal('hide');
				},
				'click #curPSCF-modal-check-toggle' : function(e) {
					if($('#curPSCF-modal-check-toggle').is(":checked")) {
						$('.curPSCFCheckbox').attr('checked', 'checked');
					} else {
						$('.curPSCFCheckbox').removeAttr('checked');
					}
					checkSelectedButton();
				},
				'click .curPSCF-add-selected' :function(e) {
					e.preventDefault();

					if(!$('.curPSCF-add-selected').hasClass('disabled')) {
						var ids = '';
						$('.curPSCFCheckbox:checked').each(function() {
							ids += ',' + $(this).attr('id');
						});

						ids = ids.replace(',','');
						ids = ids.replace(/_([^,]*)$/,'');
						$('.curPSCFBusy').addClass('busy');
						$('#ap-currentPSCF-Modal .component-button .button').hide();
						eval(controller).pullInCurPSCF(ids, parentId, accountId, function(result, event) {
							if(result == 'SUCCESS'){
								$('.currentPSCF').find('.refresh-button').click();
							} else {
								alert(result);
								$('.curPSCFBusy').removeClass('busy');
								$('#ap-currentPSCF-Modal .component-button .button').show();
							}
						});
					}
				},
				'click .curPSCFCheckbox' : function(e) {
					checkSelectedButton();
				}
			}
		});
	});
}