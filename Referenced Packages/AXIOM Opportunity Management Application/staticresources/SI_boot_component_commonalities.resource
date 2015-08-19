/*
 * Loads component "Commonalities"
 */
loadCommonalities = function(callback) {
	var type = 'commonalities',
		el = jQuery('.' + type);

	/*** file: collection_componentData ***/
	var componentCollection = new componentDataCollection();

	/*** get commonalities ***/
	componentCollection.getBySIIdAndType(dealId, type, function() {
		/*** file: view_component ***/
		var componentBodyView = new componentView({
			collection : componentCollection,
			el : el
		});

		componentBodyView.render({
			title : 'Commonalities',
			type : type,
			options : {
				modalOptions : modalOptions[type]
			},
			status : {
				'class' : 'Commonality_Status',
				'value' : commonalityStatus
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
					$('#ap-commonalities-Modal').modal('show');
				},
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
				'click .Commonality_Status .minus' : function(e) {
					commonalityStatus = 'minus';
					if(jQuery('.component-header .Commonality_Status').hasClass('minus')){
						commonalityStatus = 'none';
					}
					StrategicInitiativeExtension.changeCommonalityStatus(siId, commonalityStatus, function(result){
						if(result == 'SUCCESS'){
							jQuery('.component-header .Commonality_Status').removeClass().addClass('Commonality_Status left ' + commonalityStatus);
							renderWinData();
						}else {
							var res = result.split(':', 2);
							if (res[0] == 'ERROR') {
								var err = res[1].split('|', 2);

								jQuery('.deal .header .error-message').html('ERROR: ' + err[1] + '. This error could be caused by a validation rule on the Opportunity. To edit the opportunity, <a href="/' + opportunityId + '/e?retURL=%2F' + opportunityId + '">click here</a>');
							}
						}
					});
				},
				'click .Commonality_Status .plus' : function(e) {
					commonalityStatus = 'plus';
					if(jQuery('.component-header .Commonality_Status').hasClass('plus')){
						commonalityStatus = 'none';
					}
					StrategicInitiativeExtension.changeCommonalityStatus(siId, commonalityStatus, function(result){
						if(result == 'SUCCESS'){
							jQuery('.component-header .Commonality_Status').removeClass().addClass('Commonality_Status left ' + commonalityStatus);
							renderWinData();
						}else {
							var res = result.split(':', 2);
							if (res[0] == 'ERROR') {
								var err = res[1].split('|', 2);

								jQuery('.deal .header .error-message').html('ERROR: ' + err[1] + '. This error could be caused by a validation rule on the Opportunity. To edit the opportunity, <a href="/' + opportunityId + '/e?retURL=%2F' + opportunityId + '">click here</a>');
							}
						}
					});
				}
			}
		}, function() {
			if(commonalityStatus == 'empty'){
				changeWinData('commonalities');
				$('.Commonality_Status').hide();
			} else {
				$('.Commonality_Status').show();
			}
			if(componentBodyView.collection.length == 1){
				changeWinData('commonalities');
			}
			if(commonalityStatus == 'plus'){
				$('.Commonality_Status').removeClass().addClass('Commonality_Status left plus');
			} else if(commonalityStatus == 'minus'){
				$('.Commonality_Status').removeClass().addClass('Commonality_Status left minus');
			} else if(commonalityStatus = 'none'){
				$('.Commonality_Status').removeClass().addClass('Commonality_Status left none');
			}
			$('.modal-backdrop').remove();
			$('#ap-commonalities-Modal').modal().modal('hide');

			// add resizing of component when textareas resize
			var textAreas = el.find('textarea');
			textAreas.keyup(function(e) {
				matchHeights('.small-component-group-2');
			});
			loadModalCommonalities(function() {});
			if (typeof(callback) == 'function') {
				callback(componentCollection);
			}
		});
	});
}