loadModalCommonalities = function(callback) {
	var type = 'Modal_Commonalities',
		el = jQuery('#ap-commonalities-Modal');

	var checkSelectedButton = function() {
		var hasChecked = false;
		$('.comCheckbox').each(function() {
			if($(this).is(":checked")) {
				hasChecked = true;
			}
		});

		if(hasChecked) {
			$('.com-add-selected').removeClass('disabled');
		} else {
			$('.com-add-selected').addClass('disabled');
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
				'change #com_filter' : function(e) {
					e.preventDefault();
					var self = this;
					var filter = jQuery('#com_filter').val();
					self.collection.getByAccountIdAndType(parentId, 'Modal_Commonalities', filter, function() {
						self.renderModal();
					});
				},
				'click .com-add-selected' :function(e) {
					e.preventDefault();
					if(!$('.com-add-selected').hasClass('disabled')) {
						var ids = '';
						$('.comCheckbox:checked').each(function() {
							ids += ',' + $(this).attr('id');
						});
						ids = ids.replace(',','');
						ids = ids.replace(/_([^,]*)$/,'');
						$('.comBusy').addClass('busy');
						$('#ap-commonalities-Modal .component-button .button').hide();
						
						eval(controller).pullInCommonalities(ids, parentId, accountId, function(result, event) {
							if(result == 'SUCCESS'){ 
								$('.commonalities').find('.refresh-button').click();
							} else {
								alert(result);
								$('.comBusy').removeClass('busy');
								$('#ap-commonalities-Modal .component-button .button').show();
							}
						});
					}
				},
				'click #com-modal-check-toggle' : function(e) {
					if($('#com-modal-check-toggle').is(":checked")) {
						$('.comCheckbox').attr('checked', 'checked');
					} else {
						$('.comCheckbox').removeAttr('checked');
					}
					checkSelectedButton();
				},
				'click .comCheckbox' : function(e) {
					checkSelectedButton();
				},
				'click .modal-cancel-button' : function(e) {
					$('#ap-commonalities-Modal').modal('hide');
				}
			}
		});
	});
}