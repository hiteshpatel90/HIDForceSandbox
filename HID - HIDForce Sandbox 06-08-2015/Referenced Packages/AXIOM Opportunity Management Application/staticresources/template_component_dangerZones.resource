<div class=" component-body-header">
	<table><tr>
		<td class=" assignToAction component-body-item-field no-pdf"></td>
		<td class=" Description__c component-body-item-field">Description</td>
		<td class=" actionAssigned component-body-item-field no-pdf">Action</td>
	</tr></table>
</div>
{{#model}}
{{#Item}}
<div Id="{{type}}-{{Id}}" class=" {{#BIO_Worksheet__c}}toggle-{{BIO_Worksheet__c}} {{/BIO_Worksheet__c}}{{^BIO_Worksheet__c}}{{#Business_State__c}}toggle-{{Business_State__r.AXIOM_BASE__BIO_Worksheet__c}} {{/Business_State__c}}{{#PSC_Criteria__c}}toggle-{{PSC_Criteria__r.AXIOM_BASE__BIO_Worksheet__c}} {{/PSC_Criteria__c}}{{#Financial_Criteria__c}}toggle-{{Financial_Criteria__r.AXIOM_BASE__BIO_Worksheet__c}} {{/Financial_Criteria__c}}{{/BIO_Worksheet__c}}component-body-item{{#Addressed__c}} grayOut no-pdf{{/Addressed__c}}{{^Addressed__c}} noGrayOut{{/Addressed__c}}" style="{{#Addressed__c}}display: none;{{/Addressed__c}}">
	{{#isCustom__c}}
	<div class=" view edit-button hidden no-pdf">
		<div href="#{{type}}-{{Id}}" class=" view edit-button"></div>
		<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
	</div>
	{{/isCustom__c}}

	<div class=" component-body-item-content">
		<table><tr>
			<td class=" assignToAction component-body-item-field no-pdf">
				{{#isCustom__c}}
				<span class=" view">
				{{/isCustom__c}}
				<input type="checkbox" value="{{Id}}" />
				{{#isCustom__c}}
				</span>
				{{/isCustom__c}}
			</td>

			<td class=" Description__c component-body-item-field">
				{{#isCustom__c}}
				<span class=" view">
				{{/isCustom__c}}
				{{#isCustom__c}}
				{{#BIO_Worksheet__r}}{{#Contact__r}}{{Name}} - {{/Contact__r}}{{/BIO_Worksheet__r}}
				{{/isCustom__c}}
				{{Description__c}}
				{{#isCustom__c}}
				</span>
				<span class=" edit">
					<select class=" item" name="BIO_Worksheet__c" current="{{BIO_Worksheet__c}}">
						<option></option>
						{{#options}}{{#biow}}
						<option value="{{Id}}">{{Name}}</option>
						{{/biow}}{{/options}}
					</select>

					<div class=" text-wrapper">
						<textarea class=" item required" name="Description__c" current="{{Description__c}}">{{Description__c}}</textarea>
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
				{{/isCustom__c}}
			</td>

			<td class=" actionAssigned component-body-item-field no-pdf">
				{{/Item}}
				{{#URL}}
				<a class=" action-logo" href="{{URL}}">
				</a>
				{{/URL}}
				{{#Item}}
			</td>
		</tr></table>

		{{#isCustom__c}}
		<div class=" component-button component-body-item-field edit right">
			<div class=" buttons">
				<div class=" right">
					<a href="#{{type}}-{{Id}}" class=" button save-button">Save</a>
				</div>
				<div class=" right">
					<a href="#{{type}}-{{Id}}" class=" button cancel-button">Cancel</a>
				</div>
				<div class=" right">
					<a href="#{{type}}-{{Id}}" name="this" class=" delete-button">Delete</a>
				</div>
				<div class=" SaveObj component-body-item-field right">
					<div class=" error-message no-pdf"></div>
				</div>
				<div class=" clear"></div>
			</div>
			<div class=" busy-image"></div>
		</div>

		<div class=" edit clear"></div>
		{{/isCustom__c}}
	</div>
</div>
{{/Item}}
{{/model}}
<div class=" component-body-item toggle-dangerZones no-pdf">
	<div class=" component-body-item-content">
		<div class=" hide-dangerZones hidden">
			Hide Addressed
		</div>
		<div class=" show-dangerZones">
			Show Addressed
		</div>
	</div>
</div>
<div Id="{{type}}-" class=" component-body-item new">
	<div class=" component-body-item-content">
		{{#items}}
			<input type="hidden" class=" {{itemType}}" name="{{itemName}}" value="{{itemValue}}" current="{{itemValue}}" />
		{{/items}}

		<table><tr>
			<td class=" Description__c component-body-item-field">
				<div class=" label">
					<select class=" item" name="BIO_Worksheet__c" current="">
						<option></option>
						{{#options}}{{#biow}}
						<option value="{{Id}}">{{Name}}</option>
						{{/biow}}{{/options}}
					</select>
				</div>

				<div class=" text-wrapper">
					<textarea class=" item required" name="Description__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>
		</tr></table>

		<div class=" component-button component-body-item-field right">
			<div class=" buttons">
				<div class=" right">
					<a href="#{{type}}-{{Id}}" class=" button save-button">Save</a>
				</div>
				<div class=" right">
					<a href="#{{type}}-{{Id}}" class=" button clear-button">Cancel</a>
				</div>
				<div class=" SaveObj component-body-item-field right">
					<div class=" error-message no-pdf"></div>
				</div>
				<div class=" clear"></div>
			</div>
			<div class=" busy-image"></div>
		</div>

		<div class=" clear"></div>
	</div>
</div>