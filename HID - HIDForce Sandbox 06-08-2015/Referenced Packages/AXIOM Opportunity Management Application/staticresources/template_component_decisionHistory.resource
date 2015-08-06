<div class=" component-body-header">
	<table><tr>
		<td class=" BIO_Worksheet__c component-body-item-field">Evaluator</td>
		<td class=" Prior_Alternatives__c component-body-item-field">Prior Alternatives</td>
		<td class=" WWW__c component-body-item-field">When, Where & Why</td>
	</tr></table>
</div>
{{#model}}
<div Id="{{type}}-{{Id}}" class=" toggle-{{BIO_Worksheet__c}} component-body-item">
	<div class=" view edit-button hidden no-pdf">
		<div href="#{{type}}-{{Id}}" class=" view edit-button"></div>
		<input type="hidden" class=" keyId" name="Id" value="{{Id}}" />
	</div>

	<div class=" component-body-item-content">
		<table><tr>
			<td class=" BIO_Worksheet__c component-body-item-field">
				{{#BIO_Worksheet__r}}
				{{#AXIOM_BASE__Contact__r}}
				<span class=" view">
					<a href="/{{Id}}" target="_blank">{{Name}}</a>
				</span>
				<span class=" edit">
					{{Name}}
				</span>
				{{/AXIOM_BASE__Contact__r}}
				{{/BIO_Worksheet__r}}
			</td>

			<td class=" Prior_Alternatives__c alternative-field component-body-item-field">
				<span class=" view">
					<div class=" alternative-list text">{{Prior_Alternatives__c}}</div>
					{{#Outcome_Alternative__c}}
					<div class=" picked-alternative">
						<div class=" star left"></div>
						<div class=" text left">{{Outcome_Alternative__c}}</div>
						<div class=" clear"></div>
					</div>
					{{/Outcome_Alternative__c}}
				</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<input type="text" class=" custom-alternatives noFancies noEnterSave dataHolder" dataHolder="Type and press enter to add alternatives..." current="Type and press enter to add alternatives..." />
					</div>

					<select class=" item alternativeSelect" name="Prior_Alternatives__c" multiple="true" current="{{Prior_Alternatives__c}}">
						{{#options}}
						{{#alternatives}}
						<option value="{{.}}">{{.}}</option>
						{{/alternatives}}
						{{#customAlternatives}}
						<option value="{{.}}" class=" custom">{{.}}</option>
						{{/customAlternatives}}
						{{/options}}
					</select>
					<div class=" picked-alternative">
						<div class=" label">
							<label>Outcome</label>
						</div>
						<select class=" item alternativeSelectPick" name="Outcome_Alternative__c" multiple="true" current="{{Outcome_Alternative__c}}">
							<option></option>
							{{#outcomeAlternativesMultiple}}
							<option value="{{.}}">{{.}}</option>
							{{/outcomeAlternativesMultiple}}
						</select>
					</div>
				</span>
			</td>

			<td class=" WWW__c component-body-item-field">
				<span class=" view">{{WWW__c}}</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<textarea class=" item" name="WWW__c" current="{{WWW__c}}">{{WWW__c}}</textarea>
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
					<a href="#{{type}}-{{Id}}" name="{{#BIO_Worksheet__r}}{{#Contact__r}}{{Name}}{{/Contact__r}}{{/BIO_Worksheet__r}}" class=" delete-button">Delete</a>
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
<div Id="{{type}}-" class=" component-body-item new">
	<div class=" component-body-item-content">
		{{#items}}
			<input type="hidden" class=" {{itemType}}" name="{{itemName}}" value="{{itemValue}}" current="{{itemValue}}" />
		{{/items}}

		<table><tr>
			<td class=" BIO_Worksheet__c component-body-item-field">
				<select class=" key item required" name="BIO_Worksheet__c" current="">
					<option></option>
					{{#options}}{{#biow}}
					<option value="{{Id}}">{{Name}}</option>
					{{/biow}}{{/options}}
				</select>
				<div class=" error-message">
					Required
				</div>
			</td>

			<td class=" Prior_Alternatives__c alternative-field component-body-item-field">
				<div class=" text-wrapper">
					<input type="text" class=" custom-alternatives noFancies noEnterSave dataHolder" dataHolder="Type and press enter to add alternatives..." current="Type and press enter to add alternatives..." />
				</div>

				<select class=" item alternativeSelect" name="Prior_Alternatives__c" multiple="true" current="">
					{{#options}}
					{{#alternatives}}
						<option value="{{.}}">{{.}}</option>
					{{/alternatives}}
					{{#customAlternatives}}
						<option value="{{.}}">{{.}}</option>
					{{/customAlternatives}}
					{{/options}}
				</select>
				<div class=" picked-alternative">
					<div class=" label">
						<label>Outcome</label>
					</div>
					<select class=" item alternativeSelectPick" name="Outcome_Alternative__c" multiple="true" current="">
						<option></option>
					</select>
				</div>
			</td>

			<td class=" WWW__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea class=" item" name="WWW__c" current=""></textarea>
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