var componentDataCollection = Backbone.Collection.extend({
	getBySIIdAndType : function(id, type, callback) {
		var self = this;
		// set type for later reloads
		self.type = type;

		// clear self first
		self.reset();

		function getTextDate(stamp) {
			var tmpDate = new Date(stamp);
			var months = new Array('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec');
			dat = (months[tmpDate.getUTCMonth()]) + ' ' + (tmpDate.getUTCDate()) + ', ' + tmpDate.getUTCFullYear();
			return dat;
		}
		if(done){
			if (type == 'actionRegisters') {
				StrategicInitiativeExtension.getActionRegistersBySIId(id, 'Task', function(result, event) {
					_.each(result, function(task) {
						if (task.activity.ActivityDate != null) {
							var tmp = new Date(task.activity.ActivityDate);

							task.activity.ActivityDate = getTextDate(tmp);
						} else {
							taskAcitivityDate = '';
						}
						task.activity.type = type + 'T';
					});

					// get rid of namespacePrefix
					result = JSON.parse(JSON.stringify(result).replace(/AXIOM_BASE__/g,''));
					result = JSON.parse(JSON.stringify(result).replace(/AXIOMOMD__/g,''));

					if(done){
						self.add(result);
					}

					StrategicInitiativeExtension.getActionRegistersBySIId(id, 'Event', function(result, event) {
						var today = new Date();

						_.each(result, function(event) {
							if (event.activity.ActivityDate != null) {
								var tmp = new Date(event.activity.ActivityDate);

								event.activity.ActivityDate = getTextDate(tmp);
								if (tmp < today) {
									event.activity.IsClosed = true;
									event.IsClosed = true;
								} else {
									event.activity.IsClosed = false;
									event.IsClosed = false;
								}
							} else {
								event.activity.ActivityDate = '';
							}
							event.activity.type = type + 'U';
						});
						// get rid of namespacePrefix
						result = JSON.parse(JSON.stringify(result).replace(/AXIOM_BASE__/g,''));
						result = JSON.parse(JSON.stringify(result).replace(/AXIOMOMD__/g,''));

						if(done){
							self.add(result);
						}

						// sort by activity dates first
						self.models = _.sortBy(self.models, function(model) { return model.get('IsClosed') + model.get('ActivityDate'); });

						if (typeof(callback) == 'function') {
							callback();
						}
					});
				});
			}
			else if (type == 'dangerZones') {
				StrategicInitiativeExtension.getDangerZonesBySIId(id, function(result, event) {
					// get rid of namespacePrefix
					result = JSON.parse(JSON.stringify(result).replace(/AXIOMOMD__/g,''));
					self.add(result);
					self.models = _.sortBy(self.models, function(model) { return model.get('Description__c'); });
					if (typeof(callback) == 'function') {
						callback();
					}
				}, {escape : false});
			}
			else if (type == 'decisionStages') {
				StrategicInitiativeExtension.getDecisionStagesBySIId(id, function(result, event) {
					result = JSON.parse(JSON.stringify(result).replace(/AXIOMOMD__/g,''));
					_.each(result, function(ds) {
						if (ds.Item.Time_Frame_Date__c != null) {
							var tmp = new Date(ds.Item.Time_Frame_Date__c);

							ds.Item.Time_Frame_Date__c = getTextDate(tmp);
						}
					});
					if(result.length != 0){
						decisionStatus = result[0].Status; 
					} else {
						decisionStatus = 'empty';
					}
					if(done){
						self.add(result);
					}
					if (typeof(callback) == 'function') {
						callback();
					}
				}, {escape : false});
			}
			else
			{
				StrategicInitiativeExtension.getComponentDataBySIIdAndType(id, type, function(result, event) {
					if(type == 'commonalities' ){
						commonalityStatus
						if(result.length != 0){
							commonalityStatus = result[0].AXIOM_BASE__Strategic_Initiative__r.AXIOM_BASE__CommonalityStatus__c; 
						} else {
							commonalityStatus = 'empty';
						}
					}
					if(type == 'financialCriteria') {
						_.each(result, function(fin_criteria) {
							if (fin_criteria.AXIOM_BASE__Budget__c > 0) {
								fin_criteria.EnableStatusBudget = true;
							}
							if (fin_criteria.AXIOM_BASE__Favored_Alternative_Value_Assignment__c > 0 ||
									fin_criteria.AXIOM_BASE__Company_Value_Assignment__c > 0 ||
									fin_criteria.AXIOM_BASE__Support_Value_Assignment__c > 0 ||
									fin_criteria.AXIOM_BASE__Product_Value_Assignment__c > 0) {
								fin_criteria.EnableStatusAssignment = true;
							}
							fin_criteria.edit_Budget__c = fin_criteria.AXIOM_BASE__Budget__c;
							fin_criteria.AXIOM_BASE__Budget__c = accounting.formatMoney(fin_criteria.AXIOM_BASE__Budget__c, isoCode);
						});
					}
					if(type == 'evaluators') {
						totalAmountOfEvaluators = result.length;
						canCreateCCEvaluator = (totalAmountOfEvaluators > 1) ? true : false;
						evList = result;
						_.each(result, function(ev) {
							var competitorAlternatives = '';
							var q = ev.AXIOM_BASE__Quality_Score__c ;
							switch( true ){
								case q >= 0 && q < 0.8:
									ev.Quality = 'Opponent';
									break;
								case q >= 0.8 && q < 1.7:
									ev.Quality = 'Adversary';
									break;
								case q >= 1.7 && q < 2.6:
									ev.Quality = 'Resistor';
									break;
								case q >= 2.6 && q < 3.5:
									ev.Quality = 'Neutral';
									break;
								case q >= 3.5 && q < 4.4:
									ev.Quality = 'Supporter';
									break;
								case q >= 4.4 && q < 5.3:
									ev.Quality = 'Advocate';
									break;
								case q >= 5.3 && q <= 6:
									ev.Quality = 'Sponsor';
									break;
							};
							if(ev.AXIOM_BASE__Roles__c != null){
								var roles = ev.AXIOM_BASE__Roles__c.split(';');
								var viewRoles = '';
								for(role in roles){
									if(rolesMap[roles[role]]!= null){
										viewRoles += rolesMap[roles[role]] + ', '
									}
								}
								ev.Veiw_Roles = viewRoles.substring(0, viewRoles.length - 2);
							}
							if(ev.AXIOM_BASE__Contact__r.Account === undefined) {
								ev.AXIOM_BASE__Contact__r.Account = { Name: 'No Account' };
							}
							if (!isAlternativeObjEmpty) {
								ev.favoredAlternative = '';
								ev.FavoredAlternativeName = '';
								_.each(ev.AXIOM_BASE__BIO_Worksheet_Competitors__r, function(bwCompetitor) {
									if (competitorAlternatives != '') {
										competitorAlternatives += ', ';
									}
									competitorAlternatives += bwCompetitor.AXIOM_BASE__Competitor__r.Name;
									if (bwCompetitor.AXIOM_BASE__Favored__c == true) {
										ev.favoredAlternative = bwCompetitor.AXIOM_BASE__Competitor__c;
										ev.favoredAlternativeName = bwCompetitor.AXIOM_BASE__Competitor__r.Name;
									}
								});
								ev.competitorAlternatives = competitorAlternatives;
								//if main alternative is favored
								if (ev.AXIOM_BASE__Favored_Alternative__c == orgName) {
									ev.favoredAlternative = orgName;
									ev.favoredAlternativeName = orgName;
								}
							} else {
								ev.favoredAlternative = ev.AXIOM_BASE__Favored_Alternative__c;
								ev.favoredAlternativeName = ev.AXIOM_BASE__Favored_Alternative__c;
							}
						});
					}
					if (type == 'decisionHistory') {
						_.each(result, function(dh) {
							outcomeAlternatives = [];
							if (dh.AXIOMOMD__Outcome_Alternative__c != null) {
								_.each(dh.AXIOMOMD__Outcome_Alternative__c.split(';'), function(alt) {
									if (alt != null && alt != '') {
										outcomeAlternatives.push(alt);
									}
								});
							}
							dh.outcomeAlternativesMultiple = outcomeAlternatives;
						});
					}
					// get rid of namespacePrefix
					if (type != 'financialCriteria') {
						result = JSON.parse(JSON.stringify(result).replace(/AXIOM_BASE__/g,''));
					}
					result = JSON.parse(JSON.stringify(result).replace(/AXIOMOMD__/g,''));
					if(type == 'businessStates'){
					}
					if(done){
						self.add(result);
					}

					if (type == 'dangerZones') {
						self.models = _.sortBy(self.models, function(model) { return model.get('Description__c'); });
					}

					if (typeof(callback) == 'function') {
						callback();
					}
				}, {escape : false});
			} 
		}else {
			if (typeof(callback) == 'function') {
				callback();
			}
		}

	},
	getByDealId : function(id, callback) {
		var self = this;

		self.getBySIIdAndType(id, self.type, callback);
	},
	getByAccountIdAndType : function(id, type, filter, callback) {

		var self = this;
		// set type for later reloads
		self.type = type;

		// clear self first
		self.reset();

		StrategicInitiativeExtension.getComponentDataByAccountIdAndType(id, type, filter, function(result, event) {

			// get rid of namespacePrefix
			result = JSON.parse(JSON.stringify(result).replace(/AXIOMOMD__/g,''));

			self.add(result);

			if (typeof(callback) == 'function') {
				callback();
			}
		}, {escape : false});
	}
});