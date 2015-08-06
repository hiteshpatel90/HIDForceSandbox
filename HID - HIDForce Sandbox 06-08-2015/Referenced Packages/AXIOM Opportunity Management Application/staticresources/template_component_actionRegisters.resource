<div class=" component-body-header">
	<table><tr>
		<td class=" icons-wrapper component-body-item-field no-pdf"></td>
		<td class=" Action_Required__c component-body-item-field">Action Required</td>
		<td class=" Assigned_To__c component-body-item-field">Assigned To</td>
		<td class=" BIO_Worksheet__c component-body-item-field">Evaluator</td>
		<td class=" Due__c component-body-item-field">Due</td>
		<td class=" linkedDangerZones component-body-item-field no-pdf"></td>
	</tr></table>
</div>
{{#model}}
{{#activity}}
<div Id="{{type}}-{{Id}}" class=" component-body-item type-{{type}} {{#IsClosed}}grayOut hidden no-pdf{{/IsClosed}}">
	<div class=" view edit-button hidden no-pdf">
		<a href="/{{Id}}/e?retURL=%2F{{WhatId}}&saveURL=%2F{{WhatId}}" class=" view edit-button"></a>
	</div>

	<div class=" component-body-item-content">
		<table><tr>
			<td class=" icons-wrapper component-body-item-field no-pdf">
				<div Id="{{type}}-{{Id}}-Status" class=" Status left">
					<input type="checkbox" class=" save-modal" href="#{{type}}-{{Id}}-Modal" {{#IsClosed}}checked="checked" {{/IsClosed}} current="{{#IsClosed}}falsed{{/IsClosed}}{{^IsClosed}}true{{/IsClosed}}"/>
					<!-- div style="min-width: 45px; height: 18px;" class="switch closer switch-mini" data-on-label="|" data-off-label="O" Id="ar-{{Id}}">
						<input Id="check-{{Id}}" class="save-modal" type="checkbox" href="#{{type}}-{{Id}}-Modal" {{#IsClosed}}checked="checked" {{/IsClosed}} current="{{#IsClosed}}falsed{{/IsClosed}}{{^IsClosed}}true{{/IsClosed}}"/>
					</div -->
					<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
					<input type="hidden" class=" item" name="Status" value="{{^IsClosed}}Completed{{/IsClosed}}{{#IsClosed}}In Progress{{/IsClosed}}" />
					<input type="hidden" class=" save-button" href="#{{type}}-{{Id}}-Status" />
				</div>

				<div class=" Priority Priority-{{Priority}} save-button left" href="#{{type}}-{{Id}}-Priority-{{Priority}}">
					<div Id="{{type}}-{{Id}}-Priority-High" class=" Priority-High">
						<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
						<input type="hidden" class=" item" name="Priority" value="Normal" />
					</div>

					<div Id="{{type}}-{{Id}}-Priority-Normal" class=" Priority-Normal">
						<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
						<input type="hidden" class=" item" name="Priority" value="High" />
					</div>
				</div>

				<div class=" calendar-logo component-body-item-field left">

				</div>
			</td>

			<td class=" Action_Required__c component-body-item-field">
				{{Subject}}
			</td>

			<td class=" Assigned_To__c component-body-item-field">
				<a href="/{{OwnerId}}" target="_blank">{{#Owner}}{{Name}}{{/Owner}}</a>
			</td>

			<td class=" BIO_Worksheet__c component-body-item-field">
				<a href="/{{WhoId}}" target="_blank">{{#Who}}{{Name}}{{/Who}}</a>
			</td>

			<td class=" Due__c component-body-item-field">
				{{ActivityDate}}
			</td>

			<td class=" linkedDangerZones component-body-item-field no-pdf">
				{{/activity}}
				{{#totalLinked}}
				<ul class=" nav pull-right">
					<li class=" dropdown">
						<a class=" dropdown-toggle">{{totalLinked}}</a>
						<ul class=" dropdown-menu no-pdf">
							{{DangerZones}}
							{{#linkedDangerZones}}
							<li>{{Description__c}}</li>
							{{/linkedDangerZones}}
							{{DecisionStages}}
							{{#linkedDecisionStages}}
							<li>{{Event__c}}</li>
							{{/linkedDecisionStages}}
						</ul>
					</li>
				</ul>
				{{#hasDZ}}
				{{#activity}}
				<div class=" modal no-pdf" Id="{{type}}-{{Id}}-Modal">
					<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
					<input type="hidden" class=" item" name="Status" value="{{^IsClosed}}Completed{{/IsClosed}}{{#IsClosed}}In Progress{{/IsClosed}}" />
					<input type="hidden" class=" item" name="AXIOMOMD__Danger_Zones__c" value="" />
				{{/activity}}
					<div class=" modal-header component-header">
						<span>Complete Action</span>
						<div class=" modal-x modal-cancel-button right"></div>
					</div>
					<div class=" modal-body">
						<p>Please select Danger Zone items that are addressed:</p>
						{{#linkedDangerZones}}
						<div>
							<input type="checkbox" value="{{Id}}" /> {{Description__c}}
						</div>
						{{/linkedDangerZones}}
					</div>
					{{#activity}}
					<div class=" modal-footer">
						<div class=" component-button">
							<a class=" button modal-cancel-button" href="#{{type}}-{{Id}}-Status">Cancel</a>
							<a class=" button modal-save-button">Save</a>
							<a class=" button save-button hidden" href="#{{type}}-{{Id}}-Modal"></a>
						</div>
					</div>
					{{/activity}}
				</div>
				{{/hasDZ}}
				{{/totalLinked}}
				{{#activity}}
			</td>
		</tr></table>
	</div>
</div>
{{/activity}}
{{/model}}
<div class=" component-body-item toggle-actionRegisters no-pdf">
	<div class=" component-body-item-content">
		<div class=" hide-actionRegisters hidden">
			Hide Completed
		</div>
		<div class=" show-actionRegisters">
			Show Completed
		</div>
	</div>
</div>