<div class=" component-body-header">
	<table><tr>
		<td class=" assignToAction component-body-item-field no-pdf dsheader" style="width: 7%;"></td>
		<td class=" Event__c component-body-item-field">Event</td>
		<td class=" Time_Frame_Date__c component-body-item-field">Time Frame</td>
		<td class=" actionAssigned component-body-item-field no-pdf">Action</td>
	</tr></table>
</div>
{{#model}}
{{#Item}}
<div Id="{{type}}-{{Id}}" class=" component-body-item">
	<div class=" view edit-button hidden no-pdf">
		<div href="#{{type}}-{{Id}}" class=" view edit-button"></div>
		<input class=" keyId" type="hidden" name="Id" value="{{Id}}" />
	</div>

	<div class=" component-body-item-content">
		<table><tr>
			<td class=" assignToAction component-body-item-field no-pdf">
				<span class=" view">
					<input type="checkbox" value="{{Id}}" />
				</span>
			</td>
			<td class=" Event__c component-body-item-field">
				<span class=" view">
					{{Event__c}}
				</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<input type="text" class=" item required" name="Event__c" value="{{Event__c}}" current="{{Event__c}}" />
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>

			<td class=" Time_Frame_Date__c component-body-item-field">
				<span class=" view">
					{{Time_Frame_Date__c}}
				</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<input disabled style="width: 70%" type="text"  class=" item required change noEnterSave date" name="Time_Frame_Date__c" value="{{Time_Frame_Date__c}}" current="{{Time_Frame_Date__c}}" />
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
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

		<div class=" component-button component-body-item-field edit right">
			<div class=" buttons">
				<div class=" right">
					<a href="#{{type}}-{{Id}}" class=" button save-button">Save</a>
				</div>
				<div class=" right">
					<a href="#{{type}}-{{Id}}" class=" button cancel-button">Cancel</a>
				</div>
				<div class=" right">
					<a href="#{{type}}-{{Id}}" name="{{Event}}" class=" delete-button">Delete</a>
				</div>
				<div class=" SaveObj component-body-item-field right">
					<span class=" error-message no-pdf"></span><span class=" error-message-extra no-pdf">. This error could be caused by a validation rule on the {{#options}}{{ObjectType}}{{/options}}. To edit the {{#options}}{{ObjectType}}{{/options}}, <a href="/{{#options}}{{parentId}}{{/options}}/e?retURL=%2F{{#options}}{{parentId}}{{/options}}">click here</a></span>
				</div>
				<div class=" clear"></div>
			</div>
			<div class=" busy-image"></div>
		</div>

		<div class=" edit clear"></div>
	</div>
</div>
{{/Item}}
{{/model}}

<div Id="{{type}}-" class=" component-body-item new">
	{{#items}}
		<input class=" {{itemType}}" type="hidden" name="{{itemName}}" value="{{itemValue}}" />
	{{/items}}

	<div class=" component-body-item-content">
		<table><tr>
			<td class=" assignToAction component-body-item-field no-pdf" style="width: 5%;">
				<span class=" view">
				</span>
			</td>
			<td class=" Event__c component-body-item-field" style="width: 30%;">
				<div class=" text-wrapper">
					<input type="text" class=" item required" name="Event__c" value="" current="" />
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" Time_Frame_Date__c component-body-item-field">
				<div class=" text-wrapper">
					<input disabled style="width: 70%" class=" item required change noEnterSave date" type="text" name="Time_Frame_Date__c" value="" current=""/>
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
					<span class=" error-message no-pdf"></span><span class=" error-message-extra no-pdf"> This error could be caused by a validation rule on the {{#options}}{{ObjectType}}{{/options}}. To edit the {{#options}}{{ObjectType}}{{/options}}, <a href="/{{#options}}{{parentId}}{{/options}}/e?retURL=%2F{{#options}}{{parentId}}{{/options}}">click here</a>.</span>
				</div>
				<div class=" clear"></div>
			</div>
			<div class=" busy-image"></div>
		</div>

		<div class=" clear"></div>
	</div>
</div>