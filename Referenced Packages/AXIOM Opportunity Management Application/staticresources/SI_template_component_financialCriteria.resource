<div class=" component-body-header">
	<table><tr>
		<td class=" AXIOM_BASE__Status__c component-body-item-field no-pdf"></td>
		<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">Evaluator</td>
		<td class=" Financial_Considerations component-body-item-field">Financial Considerations/ Primary</td>
		<td class=" Status component-body-item-field no-pdf">
		<td class=" AXIOM_BASE__Budget__c component-body-item-field">Budget</td>
		<td class=" Status component-body-item-field no-pdf">
		<td class=" Value_Assignment component-body-item-field">Value Assignment</td>
	</tr></table>
</div>
{{#model}}

<div Id="{{type}}-{{Id}}" class=" toggle-{{AXIOM_BASE__BIO_Worksheet__c}} component-body-item">
	<div class=" view edit-button hidden no-pdf">
		<div href="#{{type}}-{{Id}}" class=" view edit-button"></div>
		<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
	</div>

	<div class=" component-body-item-content">
		<table><tr>
			<td class=" Status AXIOM_BASE__Status__c {{AXIOM_BASE__Status__c}} component-body-item-field no-pdf">
				<div class=" plus right" href="#{{type}}-{{Id}}"></div>
				<div class=" minus right" href="#{{type}}-{{Id}}"></div>
				<input type="hidden" class=" item" name="AXIOM_BASE__Status__c" value="{{AXIOM_BASE__Status__c}}" />
				<div class=" clear"></div>
			</td>
			<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">
				{{#AXIOM_BASE__BIO_Worksheet__r}}
				<span class=" hidden">
					<span class=" view">
						{{#AXIOM_BASE__Contact__r}}
						<a href="/{{Id}}" target="_blank">{{Name}}</a>
						{{/AXIOM_BASE__Contact__r}}
					</span>
					<span class=" edit">
						{{#AXIOM_BASE__Contact__r}}{{Name}}{{/AXIOM_BASE__Contact__r}}
					</span>
				</span>
				{{/AXIOM_BASE__BIO_Worksheet__r}}
			</td>

			<td class=" Financial_Considerations component-body-item-field">
				<span class=" view">
					{{AXIOM_BASE__Financial_Considerations__c}}
					{{#AXIOM_BASE__Primary_Financial_Consideration__c}}
					<div class=" picked-primary">
						<div class=" star left"></div>
						<div class=" text left">{{AXIOM_BASE__Primary_Financial_Consideration__c}}</div>
						<div class=" clear"></div>
					</div>
					{{/AXIOM_BASE__Primary_Financial_Consideration__c}}
				</span>
				<span class=" edit">
					<select class=" item AXIOM_BASE__Financial_Considerations__c" name="AXIOM_BASE__Financial_Considerations__c" multiple="true" current="{{AXIOM_BASE__Financial_Considerations__c}}" size="{{#optinos}}{{fcSize}}{{/options}}">
						{{#options}}{{#financialConsiderations}}
						<option value="{{.}}">{{.}}</option>
						{{/financialConsiderations}}{{/options}}
					</select>
					<div class=" tooltip noFancies">
						Click to select a financial consideration. You can select multiple roles by clicking while pressing ctrl or by clicking and dragging.
					</div>
					<div class=" label">
						<label>Primary</label>
					</div>
					<select style="width: 150px;" class=" item AXIOM_BASE__Primary_Financial_Consideration__c" name="AXIOM_BASE__Primary_Financial_Consideration__c" current="{{AXIOM_BASE__Primary_Financial_Consideration__c}}">
						<option value="{{AXIOM_BASE__Primary_Financial_Consideration__c}}">{{AXIOM_BASE__Primary_Financial_Consideration__c}}</option>
					</select>
				</span>
			</td>
			<td class=" Status AXIOM_BASE__Budget_Status__c {{AXIOM_BASE__Budget_Status__c}} component-body-item-field no-pdf">
				{{#EnableStatusBudget}}
					<div class=" plus right" href="#{{type}}-{{Id}}"></div>
					<div class=" minus right" href="#{{type}}-{{Id}}"></div>
					<input type="hidden" class=" item" name="AXIOM_BASE__Budget_Status__c" value="{{AXIOM_BASE__Budget_Status__c}}" />
					<div class=" clear"></div>
				{{/EnableStatusBudget}}
			</td>
			<td class=" AXIOM_BASE__Budget__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Budget__c}}</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<input class=" item" type="text" name="AXIOM_BASE__Budget__c" value="{{edit_Budget__c}}" current="{{edit_Budget__c}}" />
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>
			<td class=" Status AXIOM_BASE__Value_Assignment_Status__c {{AXIOM_BASE__Value_Assignment_Status__c}} component-body-item-field no-pdf">
				{{#EnableStatusAssignment}}
					<div class=" plus right" href="#{{type}}-{{Id}}"></div>
					<div class=" minus right" href="#{{type}}-{{Id}}"></div>
					<input type="hidden" class=" item" name="AXIOM_BASE__Value_Assignment_Status__c" value="{{AXIOM_BASE__Value_Assignment_Status__c}}" />
					<div class=" clear"></div>
				{{/EnableStatusAssignment}}
			</td>
			<td class=" Value_Assignment component-body-item-field  AXIOM_BASE__Favored_alternative_value_assignment__c AXIOM_BASE__Support_value_assignment__c AXIOM_BASE__Company_value_assignment__c AXIOM_BASE__Product_value_assignment__c">
				<span class=" view">
				<div class=" assignment-wrapper" style="text-align: right;">
					{{#AXIOM_BASE__Favored_Alternative_Value_Assignment__c}}<label style="font-weight: bold;">Favored Alternative:</label> {{AXIOM_BASE__Favored_Alternative_Value_Assignment__c}}%{{/AXIOM_BASE__Favored_Alternative_Value_Assignment__c}}
					<br/><br/>
					{{#AXIOM_BASE__Support_Value_Assignment__c}}<label style="font-weight: bold;">Support:</label> {{AXIOM_BASE__Support_Value_Assignment__c}}%{{/AXIOM_BASE__Support_Value_Assignment__c}}
				</div>
				<div class=" assignment-wrapper" style="margin-right: 2%; text-align: right;">
					{{#AXIOM_BASE__Company_Value_Assignment__c}}<label style="font-weight: bold;">Company:</label> {{AXIOM_BASE__Company_Value_Assignment__c}}%{{/AXIOM_BASE__Company_Value_Assignment__c}}
					<br/><br/>
					{{#AXIOM_BASE__Product_Value_Assignment__c}}<label style="font-weight: bold;">Product:</label> {{AXIOM_BASE__Product_Value_Assignment__c}}%{{/AXIOM_BASE__Product_Value_Assignment__c}}
				</div>
				</span>
				<span class=" edit">
					<div class=" assignment-wrapper">
						<div class=" label"><label for="fav-{{Id}}">Favored Alternative</label></div><div><input maxlength="3" Id="fav-{{Id}}" class=" item" type="text" name="AXIOM_BASE__Favored_Alternative_Value_Assignment__c" current="{{AXIOM_BASE__Favored_Alternative_Value_Assignment__c}}"/></div>
						<div class=" label"><label for="sup-{{Id}}">Support</label></div><div><input maxlength="3" class=" item" Id="sup-{{Id}}" type="text" name="AXIOM_BASE__Support_Value_Assignment__c" current="{{AXIOM_BASE__Support_Value_Assignment__c}}"/></div>
					</div>
					<div class=" assignment-wrapper" style="margin-right: 2%;">
						<div class=" label"><label for="comp-{{Id}}">Company</label></div><div><input maxlength="3" Id="comp-{{Id}}" class=" item" type="text" name="AXIOM_BASE__Company_Value_Assignment__c" current="{{AXIOM_BASE__Company_Value_Assignment__c}}"/></div>
						<div class=" label"><label for="prod-{{Id}}">Product</label></div><div><input maxlength="3" Id="prod-{{Id}}" class=" item" type="text" name="AXIOM_BASE__Product_Value_Assignment__c" current="{{AXIOM_BASE__Product_Value_Assignment__c}}"/></div>
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
					<a href="#{{type}}-{{Id}}" name="{{#AXIOM_BASE__BIO_Worksheet__r}}{{#AXIOM_BASE__Contact__r}}{{Name}}{{/AXIOM_BASE__Contact__r}}{{/AXIOM_BASE__BIO_Worksheet__r}}" class=" delete-button">Delete</a>
				</div>
				<div class=" SaveObj component-body-item-field right">
					<div class=" error-message no-pdf"></div>
				</div>
				<div class=" clear"></div>
			</div>
			<div class=" busy-image"></div>
		</div>

		<div class=" edit clear"></div>
	</div>
</div>
{{/model}}
{{#options}}
{{#hasLightbox}}
<div class=" modal no-pdf {{modal}}" Id="fin-Modal">
	<div class=" modal-header component-header">
		<span>Warning!</span>
		<div class=" modal-x modal-cancel-button right"></div>
	</div>
	<div class=" modal-body">
				{{text}}
			</div>
	<div class=" modal-footer">
		<div class=" component-button">
		</div>
	</div>
</div>
{{/hasLightbox}}
{{/options}}
<div Id="{{type}}-" class=" component-body-item new">
	<div class=" component-body-item-content">
		<table><tr>
			<td class=" AXIOM_BASE__Status__c {{AXIOM_BASE__Status__c}} component-body-item-field no-pdf"></td>

			<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">
				<select class=" key item required" name="AXIOM_BASE__BIO_Worksheet__c" href="#{{type}}-" current="">
					<option></option>
					{{#options}}{{#biow}}
					<option value="{{Id}}">{{Name}}</option>
					{{/biow}}{{/options}}
				</select>
				<div class=" error-message">
					Required
				</div>
			</td>

			<td class=" Financial_Considerations component-body-item-field">
				<div class=" select-wrapper">
					<select class=" item AXIOM_BASE__Financial_Considerations__c" name="AXIOM_BASE__Financial_Considerations__c" multiple="true" current="" size="{{#options}}{{fcSize}}{{/options}}">
						{{#options}}{{#financialConsiderations}}
						<option value="{{.}}">{{.}}</option>
						{{/financialConsiderations}}{{/options}}
					</select>
					<div class=" tooltip noFancies">
						Click to select a financial consideration. You can select multiple roles by clicking while pressing ctrl or by clicking and dragging.
					</div>
				</div>
				<div class=" label">
					<label>Primary</label>
				</div>
				<select style="width: 150px;" class=" item AXIOM_BASE__Primary_Financial_Consideration__c" name="AXIOM_BASE__Primary_Financial_Consideration__c" current="">
					<option></option>
				</select>
			</td>
			<td class=" Status AXIOM_BASE__Budget_Status__c component-body-item-field no-pdf">
			</td>
			<td class=" AXIOM_BASE__Budget__c component-body-item-field">
				<div class=" text-wrapper">
					<input class=" item" type="text" name="AXIOM_BASE__Budget__c" current="" />
				</div>

				<div class=" error-message no-pdf"></div>
			</td>
			<td class=" Status AXIOM_BASE__Value_Assignment_Status__c component-body-item-field no-pdf">
			</td>
			<td class=" Value_Assignment component-body-item-field AXIOM_BASE__Favored_alternative_value_assignment__c AXIOM_BASE__Support_value_assignment__c AXIOM_BASE__Company_value_assignment__c AXIOM_BASE__Product_value_assignment__c">
				<div class=" assignment-wrapper">
					<div class=" label"><label for="fav-">Favored Alternative</label></div><div><input maxlength="3" Id="fav-" class=" item" type="text" name="AXIOM_BASE__Favored_Alternative_Value_Assignment__c" current="" /></div>
					<div class=" label"><label for="sup-">Support</label></div><div><input maxlength="3" class=" item" Id="sup-" type="text" name="AXIOM_BASE__Support_Value_Assignment__c" current="" /></div>
				</div>
				<div class=" assignment-wrapper" style="margin-right: 2%;">
					<div class=" label"><label for="comp-">Company</label></div><div><input maxlength="3" Id="comp-" class=" item" type="text" name="AXIOM_BASE__Company_Value_Assignment__c" current="" /></div>
					<div class=" label"><label for="prod-">Product</label></div><div><input maxlength="3" Id="prod-" class=" item" type="text" name="AXIOM_BASE__Product_Value_Assignment__c" current="" /></div>
				</div>
				<div class=" error-message no-pdf"></div>
			</td>
		</tr></table>

		<div class=" component-body-item-field tooltip left">
			{{#options}}{{Description}}{{/options}}
		</div>

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