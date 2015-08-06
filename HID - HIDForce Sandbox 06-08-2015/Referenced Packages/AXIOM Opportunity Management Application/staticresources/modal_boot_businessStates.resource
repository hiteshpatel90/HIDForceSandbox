loadModalBusinessStates = function(callback) {
	var type = 'Modal_BusinessStates',
		el = jQuery('#ap-bs-Modal');

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
				'change #bs_filter' : function(e) {
					e.preventDefault();
					var self = this;
					var filter = jQuery('#bs_filter').val();
					self.collection.getByAccountIdAndType(parentId, 'Modal_BusinessStates', filter, function() {
						self.renderModal();
					});
				},
				'click .modal-cancel-button' : function(e) {
					$('#ap-bs-Modal').modal('hide');
				},
				'click .bs-radio' : function(e) {
					$('.bs-addSelected').removeClass('disabled');
				},
				'click .bs-addSelected' :function(e) {
					e.preventDefault();
					if(!$('.bs-addSelected').hasClass('disabled')) {

						$('.businessStates .new-button').click();

						var id = $('input[name=pick]:checked').closest('tr').attr('id');

						var area = $('.AXIOM_BASE__Area__c .view', $('#'+id)).html();
						var desc = $('.AXIOM_BASE__Description__c .view', $('#'+id)).html();
						var impact = $('.AXIOM_BASE__Impact__c .view', $('#'+id)).html();
						var impactDesc = $('.AXIOM_BASE__ImpactDescription__c .view', $('#'+id)).html();
						var gap = $('.AXIOM_BASE__Gap__c .view', $('#'+id)).html();
						

						var impacts = impact.split(';');
						$('.businessStates .AXIOM_BASE__Area__c .chzn-results li').each(function() {
							if($(this).html() == area) {
								$(this).trigger('mouseup');
							}
						});

						// IE support
						$('.businessStates select[name="AXIOM_BASE__Area__c"]').val(area);

						$('.businessStates .AXIOM_BASE__Description__c textarea').val(desc);


						//IE support
						$('.businessStates select[name="AXIOM_BASE__Impact__c"] option').each(function(){
							$(this).removeAttr('selected');
							for(var i=0; i<impacts.length; i++) {
								if($(this).val() == impacts[i]) {
									$(this).attr('selected','selected');
								}
							}
						});
						if (!noFancies) {
							$('.businessStates select[name="AXIOM_BASE__Impact__c"]').trigger('liszt:updated');
						}

						$('.businessStates .AXIOM_BASE__ImpactDescription__c textarea').val(impactDesc);
						$('.businessStates .AXIOM_BASE__Gap__c textarea').val(gap);

						$('#ap-bs-Modal').modal('hide');
					}
				}
			}
		});
	});
}