<div class=" component-body-header">
	<table><tr>
		<td class=" AXIOM_BASE__Product__c component-body-item-field">Product</td>
		<td class=" AXIOM_BASE__Support__c component-body-item-field">Support</td>
		<td class=" AXIOM_BASE__Company__c component-body-item-field">Company</td>
		<td class=" AXIOM_BASE__Financial__c component-body-item-field">Financial</td>
	</tr></table>
</div>
{{#model}}
<div Id="{{type}}-{{Id}}" class=" component-body-item">
	<div class=" view edit-button hidden no-pdf">
		<div href="#{{type}}-{{Id}}" class=" view edit-button"></div>
		<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
	</div>

	<div class=" component-body-item-content">
		<table><tr>
		<td class=" AXIOM_BASE__Product__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Product__c}}</span>
			<span class=" edit">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Product__c" current="{{AXIOM_BASE__Product__c}}">{{AXIOM_BASE__Product__c}}</textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</span>
		</td>

		<td class=" AXIOM_BASE__Support__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Support__c}}</span>
			<span class=" edit">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Support__c" current="{{AXIOM_BASE__Support__c}}">{{AXIOM_BASE__Support__c}}</textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</span>
		</td>

		<td class=" AXIOM_BASE__Company__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Company__c}}</span>
			<span class=" edit">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Company__c" current="{{AXIOM_BASE__Company__c}}">{{AXIOM_BASE__Company__c}}</textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</span>
		</td>

		<td class=" AXIOM_BASE__Financial__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Financial__c}}</span>
			<span class=" edit">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Financial__c" current="{{AXIOM_BASE__Financial__c}}">{{AXIOM_BASE__Financial__c}}</textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</span>
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
					<a href="#{{type}}-{{Id}}" name="this" class=" delete-button">Delete</a>
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
{{/model}}

<div class=" modal no-pdf" Id="ap-currentPSCF-Modal">

	<div class=" modal-header component-header">
		<span>Pull Current PSCF</span>

			<span class=" filter" style="">
				<span>
					<label style="text-align:left;font-weight:bold;padding-right:.69em;" for="oppFilter">
						<span class=" requiredMark">*</span>View:
					</label>
					<select title="View:" Id="currentPSCF_filter" style="width:200px;">
						{{#options}}
							{{#modalOptions}}
								<option value="{{.}}">{{.}}</option>
							{{/modalOptions}}
						{{/options}}
					</select>
				</span>
			</span>

		<div class=" modal-x modal-cancel-button right"></div>
	</div>
	<div class=" modal-body">
		<div class=" component-body-header">
			<table>
				<tbody>
					<tr>
						<td class=" curPSCF-modal-checkbox">
							<input Id="curPSCF-modal-check-toggle" type="checkbox" />
						</td>
						<td class=" AXIOM_BASE__Product__c component-body-item-field">Product</td>
						<td class=" AXIOM_BASE__Support__c component-body-item-field">Support</td>
						<td class=" AXIOM_BASE__Company__c component-body-item-field">Company</td>
						<td class=" AXIOM_BASE__Financial__c component-body-item-field">Financial</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class=" component-body-item-content">
		</div>
	</div>
	<div class=" modal-footer">
		<div class=" component-button">
			<a class=" button modal-cancel-button" href="javascript:void(0);">Cancel</a>
			<a class=" button modal-add-selected-button curPSCF-add-selected disabled">Add Selected</a>
			<div class=" curPSCFBusy busy-image"></div>
		</div>
	</div>
</div>
<div Id="{{type}}-" class=" component-body-item new">
	<div class=" component-body-item-content">
		{{#items}}
			<input type="hidden" class=" {{itemType}}" name="{{itemName}}" value="{{itemValue}}" current="{{itemValue}}" />
		{{/items}}
		<table><tr>
			<td class=" AXIOM_BASE__Product__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Product__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Support__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Support__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Company__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Company__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Financial__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea maxlength="255" class=" item required-set" name="AXIOM_BASE__Financial__c" current=""></textarea>
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