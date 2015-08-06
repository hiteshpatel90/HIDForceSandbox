<div class=" component-body-header">
	<table><tr>
		<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">Evaluator</td>
		<td class=" AXIOM_BASE__Status__c component-body-item-field no-pdf"></td>
		<td class=" AXIOM_BASE__Area__c component-body-item-field">Area</td>
		<td class=" AXIOM_BASE__Description__c component-body-item-field">Description</td>
		<td class=" AXIOM_BASE__Impact__c component-body-item-field">Impact (PIERS)</td>
		<td class=" AXIOM_BASE__ImpactDescription__c component-body-item-field">Impact Description</td>
		<td class=" AXIOM_BASE__Gap__c component-body-item-field">Gap (PIERS)</td>
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
			<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">
				<span class=" {{#BIO_Worksheet__r}}{{#Contact__r}}hidden{{/Contact__r}}{{/BIO_Worksheet__r}}">
					<span class=" view">
						{{#BIO_Worksheet__r}}
						{{#Contact__r}}
							<a href="/{{Id}}" target="_blank">{{Name}}</a>
						{{/Contact__r}}
						{{/BIO_Worksheet__r}}
					</span>
					<span class=" edit">
						<select {{#BIO_Worksheet__r}}{{#Contact__r}} disabled {{/Contact__r}}{{/BIO_Worksheet__r}}  class="{{#BIO_Worksheet__r}}{{#Contact__r}} not-{{/Contact__r}}{{/BIO_Worksheet__r}}item required-one-of-two" name="AXIOM_BASE__BIO_Worksheet__c" current="{{#BIO_Worksheet__r}}{{Id}}{{/BIO_Worksheet__r}}">
							<option></option>
							{{#BIO_Worksheet__r}}
								<option value="{{Id}}">{{#Contact__r}}{{Name}}{{/Contact__r}}</option>
							{{/BIO_Worksheet__r}}
							{{#options}}{{#biow}}
							<option value="{{Id}}">{{Name}}</option>
							{{/biow}}{{/options}}
						</select>
					</span>
				</span>
				<span>
					<span class=" view">
					<br/>
						{{Source__c}}
					</span>
					<span class=" edit">
					<br/>
						{{#Source__c}}<textarea disabled style="margin-top: 6px;" name="AXIOM_BASE__Source__c" current="{{Source__c}}">{{Source__c}}</textarea>{{/Source__c}}
					</span>
				</span>
			</td>

			<td class=" AXIOM_BASE__Status__c {{Status__c}} component-body-item-field no-pdf">
				{{#BIO_Worksheet__c}}
					<div class=" minus left" href="#{{type}}-{{Id}}"></div>
					<div class=" plus left" href="#{{type}}-{{Id}}"></div>
					<input type="hidden" class=" item" name="AXIOM_BASE__Status__c" value="{{AXIOM_BASE__Area__c}}" current="{{Status__c}}" />
					<div class=" clear"></div>
				{{/BIO_Worksheet__c}}
			</td>

			<td class=" AXIOM_BASE__Area__c component-body-item-field">
				<span class=" view">{{Area__c}}</span>
				<span class=" edit">
					<select class=" required item" name="AXIOM_BASE__Area__c" current="{{Area__c}}">
						<option></option>
						{{#options}}{{#bsAreas}}
						<option value="{{.}}">{{.}}</option>
						{{/bsAreas}}{{/options}}
					</select>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>

			<td class=" AXIOM_BASE__Description__c component-body-item-field">
				<span class=" view">{{Description__c}}</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<textarea class=" item noLimit" name="AXIOM_BASE__Description__c" current="{{Description__c}}">{{Description__c}}</textarea>
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>

			<td class=" AXIOM_BASE__Impact__c component-body-item-field">
				<span class=" view">{{Impact__c}}</span>
				<span class=" edit">
					<select class=" item" name="AXIOM_BASE__Impact__c" multiple="true" current="{{Impact__c}}">
						{{#options}}{{#bsImpacts}}
						<option value="{{.}}">{{.}}</option>
						{{/bsImpacts}}{{/options}}
					</select>
				</span>
			</td>
			<td class=" AXIOM_BASE__ImpactDescription__c component-body-item-field">
				<span class=" view">{{ImpactDescription__c}}</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<textarea class=" item" name="AXIOM_BASE__ImpactDescription__c" current="{{ImpactDescription__c}}">{{ImpactDescription__c}}</textarea>
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>
			<td class=" AXIOM_BASE__Gap__c component-body-item-field">
				<span class=" view">{{Gap__c}}</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<textarea class=" item noLimit" name="AXIOM_BASE__Gap__c" current="{{Gap__c}}">{{Gap__c}}</textarea>
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

<div class=" modal no-pdf" Id="ap-bs-Modal">

	<div class=" modal-header component-header">
		<span>Pull Business States & Gaps</span>

			<span class=" filter" style="">
				<span>
					<label style="text-align:left;font-weight:bold;padding-right:.69em;" for="oppFilter">
						<span class=" requiredMark">*</span>View:
					</label>
					<select title="View:" Id="bs_filter" style="width:200px;">
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
						<td class=" BS-modal-checkbox"></td>
						<td class=" AXIOM_BASE__AXIOM_BASE__Description__c component-body-item-field">Area</td>
						<td class=" AXIOM_BASE__Description__c component-body-item-field">Description</td>
						<td class=" AXIOM_BASE__Impact__c component-body-item-field">Impact (PIERS)</td>
						<td class=" AXIOM_BASE__Gap__c component-body-item-field">Gap (PIERS)</td>
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
			<a class=" button modal-add-selected-button bs-addSelected disabled">Add Selected</a>
			<a class=" button save-button hidden" href="javascript:void(0);"></a>
		</div>
	</div>
</div>


<div Id="{{type}}-" class=" component-body-item new">
	<div class=" component-body-item-content">
		{{#items}}
			<input type="hidden" class=" {{itemType}}" name="{{itemName}}" value="{{itemValue}}" current="{{itemValue}}" />
		{{/items}}
		<table><tr>
			<td class=" AXIOM_BASE__BIO_Worksheet__c component-body-item-field">
				<select class=" item required-one-of-two" name="AXIOM_BASE__BIO_Worksheet__c" current="">
					<option></option>
					{{#options}}{{#biow}}
					<option value="{{Id}}">{{Name}}</option>
					{{/biow}}{{/options}}
				</select>
				<br/>
				<textarea style="margin-top: 6px;" class="item required-one-of-two" name="AXIOM_BASE__Source__c" current="{{Source__c}}">{{Source__c}}</textarea>
				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Status__c component-body-item-field"></td>

			<td class=" AXIOM_BASE__Area__c component-body-item-field">
				<select class=" required item" name="AXIOM_BASE__Area__c" current="">
					<option></option>
					{{#options}}{{#bsAreas}}
					<option value="{{.}}">{{.}}</option>
					{{/bsAreas}}{{/options}}
				</select>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Description__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea class=" item noLimit" name="AXIOM_BASE__Description__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" AXIOM_BASE__Impact__c component-body-item-field">
				<select class=" item" name="AXIOM_BASE__Impact__c" multiple="true" current="">
					{{#options}}{{#bsImpacts}}
					<option value="{{.}}">{{.}}</option>
					{{/bsImpacts}}{{/options}}
				</select>
			</td>
			<td class=" AXIOM_BASE__ImpactDescription__c component-body-item-field">
					<div class=" text-wrapper">
						<textarea class=" item" name="AXIOM_BASE__ImpactDescription__c" current=""></textarea>
					</div>

					<div class=" error-message no-pdf"></div>
			</td>
			<td class=" AXIOM_BASE__Gap__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea class=" item noLimit" name="AXIOM_BASE__Gap__c" current=""></textarea>
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