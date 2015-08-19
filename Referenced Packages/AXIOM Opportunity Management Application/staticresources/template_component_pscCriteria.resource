<div class=" component-body-header">
	<table><tr>
		<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">Evaluator</td>
		<td class=" AXIOM_BASE__Status__c component-body-item-field no-pdf"></td>
		<td class=" AXIOM_BASE__Description__c component-body-item-field">Description</td>
		<td class=" AXIOM_BASE__Impact__c component-body-item-field">Impact (PIERS)</td>
		<td class=" AXIOM_BASE__Criterion__c component-body-item-field">Criterion</td>
		<td class=" AXIOM_BASE__Evidence__c component-body-item-field">Evidence</td>
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

			<td class=" AXIOM_BASE__Status__c {{AXIOM_BASE__Status__c}} component-body-item-field no-pdf">
				<div class=" minus left" href="#{{type}}-{{Id}}"></div>
				<div class=" plus left" href="#{{type}}-{{Id}}"></div>
				<input type="hidden" class=" item" name="AXIOM_BASE__Status__c" value="{{AXIOM_BASE__Status__c}}" />
				<div class=" clear"></div>
			</td>

			<td class=" AXIOM_BASE__Description__c component-body-item-field">
				<div class=" select-wrapper">
					<b>{{AXIOM_BASE__PSC_Area__c}}</b>
					<input type="hidden" class=" required" name="AXIOM_BASE__PSC_Area__c" value="{{AXIOM_BASE__PSC_Area__c}}" />
				</div>
				<span class=" view">
					{{AXIOM_BASE__Description__c}}
				</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<textarea class=" item noLimit" name="AXIOM_BASE__Description__c" current="{{AXIOM_BASE__Description__c}}">{{AXIOM_BASE__Description__c}}</textarea>
					</div>

					<div class=" error-message no-pdf">
				</div>
			</td>

			<td class=" AXIOM_BASE__Impact__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Impact1__c}}</span>
				<span class=" edit">
					<div class=" select-wrapper"></div>
					<select class=" item" name="AXIOM_BASE__Impact1__c" multiple="true" current="{{AXIOM_BASE__Impact1__c}}">
						{{#options}}{{#pscImpacts}}
						<option value="{{.}}">{{.}}</option>
						{{/pscImpacts}}{{/options}}
					</select>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>

			<td class=" AXIOM_BASE__Criterion__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Criterion__c}}</span>
				<span class=" edit">
					<div class=" select-wrapper"></div>
					<div class=" text-wrapper">
						<textarea class=" item noLimit" name="AXIOM_BASE__Criterion__c" current="{{AXIOM_BASE__Criterion__c}}">{{AXIOM_BASE__Criterion__c}}</textarea>
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>

			<td class=" AXIOM_BASE__Evidence__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Evidence__c}}</span>
				<span class=" edit">
					<div class=" select-wrapper"></div>
					<div class=" text-wrapper">
						<textarea class=" item noLimit" name="AXIOM_BASE__Evidence__c" current="{{AXIOM_BASE__Evidence__c}}">{{AXIOM_BASE__Evidence__c}}</textarea>
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
<div Id="{{type}}-" class=" component-body-item new">
	<div class=" component-body-item-content">
		<table><tr>
			<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">
				<select class=" item required" name="AXIOM_BASE__BIO_Worksheet__c" data-placeholder="Choose a Contact" href="#{{type}}-" current="">
					<option></option>
					{{#options}}{{#biow}}
					<option value="{{Id}}" roles="{{Roles}}">{{Name}}</option>
					{{/biow}}{{/options}}
				</select>
				<div class=" error-message">
					Required
				</div>
			</td>

			<td class=" AXIOM_BASE__Status__c {{AXIOM_BASE__Status__c}} component-body-item-field no-pdf"></td>

			<td class=" AXIOM_BASE__Description__c component-body-item-field">
				<div class=" select-wrapper">
					<select class=" item required" name="AXIOM_BASE__PSC_Area__c" data-placeholder="Choose an Area" current="">
						<option></option>
						{{#options}}{{#pscAreas}}
						<option value="{{.}}">{{.}}</option>
						{{/pscAreas}}{{/options}}
					</select>
				</div>

				<div class=" text-wrapper">
					<textarea class=" item noLimit" name="AXIOM_BASE__Description__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Impact__c component-body-item-field">
				<div class=" select-wrapper"></div>
				<select class=" item" name="AXIOM_BASE__Impact1__c" multiple="true" current="">
					{{#options}}{{#pscImpacts}}
					<option value="{{.}}">{{.}}</option>
					{{/pscImpacts}}{{/options}}
				</select>
			</td>

			<td class=" AXIOM_BASE__Criterion__c component-body-item-field">
				<div class=" select-wrapper"></div>
				<div class=" text-wrapper">
					<textarea class=" item noLimit" name="AXIOM_BASE__Criterion__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Evidence__c component-body-item-field">
				<div class=" select-wrapper"></div>
				<div class=" text-wrapper">
					<textarea class=" item noLimit" name="AXIOM_BASE__Evidence__c" current=""></textarea>
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