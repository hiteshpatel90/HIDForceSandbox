<div class=" component-body-header">
	<table><tr>
		<td class=" Toggler component-body-item-field no-pdf"></td>
		<td class=" Contact__c component-body-item-field">Individual</td>
		<td class=" roles-reports-wrapper">
			<div class=" Roles__c component-body-item-field left">Role</div>
			<div class=" Reports_To__c component-body-item-field right">Reports To</div>
			<div class=" clear"></div>
		</td>
		<td class=" Alternatives__c component-body-item-field">Alternatives/Favored</td>
		<td class=" Reason_Favored__c component-body-item-field">Reason Favored</td>
		<td class=" Relationship_Notes__c component-body-item-field">Relationship Notes</td>
		<td class=" Influence__c component-body-item-field">Influence</td>
		<td class=" Quality__c component-body-item-field">Quality</td>
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
			<td class=" Toggler component-body-item-field no-pdf">
				<input type="checkbox" checked="true" value=".toggle-{{Id}}" class=" view" />
			</td>

			<td class=" Contact__c component-body-item-field">
				{{#Contact__r}}
				<span class=" view">
					<a href="/{{Id}}" target="_blank">{{Name}}</a><br/>
					{{Title}}
					<span class=" accountName" Id="{{Account.Id}}"><br/>({{Account.Name}})</span>
				</span>
				<span class=" edit">
					{{Name}}<br/>
					{{Title}}
					<input type="hidden" class=" key" name="AXIOM_BASE__Contact__c" value="{{Id}}" />
				</span>
				{{/Contact__r}}
			</td>

			<td class=" roles-reports-wrapper">
				<div class=" Roles__c component-body-item-field left">
					<span class=" view">{{Veiw_Roles}}</span>
					<span class=" edit">
						<div>
							<select class=" item required" name="AXIOM_BASE__Roles__c" multiple="true" current="{{Roles__c}}" size="{{#options}}{{roleSize}}{{/option}}">
								{{#options}}{{#roles}}
								<option value="{{val}}">{{label}}</option>
								{{/roles}}{{/options}}
							</select>
						</div>
						<div class=" tooltip noFancies">
							Click to select a role. You can select multiple roles by clicking while pressing ctrl or by clicking and dragging.
						</div>
						<div class=" error-message no-pdf"></div>
					</span>
				</div>

				<div class=" Reports_To__c component-body-item-field right">
					<span class=" view">
					{{#Contact__r}}
					{{#ReportsTo}}
						<a href="/{{Id}}" target="_blank">{{Name}}</a><br/>
						{{Title}}
					{{/ReportsTo}}
					{{/Contact__r}}
					</span>
				</div>

				<div class=" error-message no-pdf"></div>
				<div class=" clear"></div>
			</td>

			<td class=" Alternatives__c alternative-field component-body-item-field">
				<span class=" view">
					<div class="alternative-list text">
						{{Alternatives__c}}
						{{competitorAlternatives}}
					</div>
					{{#favoredAlternativeName}}
					<div class="picked-alternative">
						<div class="star left"></div>
						<div class="text left">{{favoredAlternativeName}}</div>
						<div class="clear"></div>
					</div>
					{{/favoredAlternativeName}}
				</span>
				<span class=" edit">
					<div class=" text-wrapper noFancies">
						<input type="text" class=" custom-alternatives noEnterSave dataHolder" dataHolder="Type and press enter to add alternatives..." value="Type and press enter to add alternatives..." />
					</div>
					<select class=" item alternativeSelect" name="AXIOM_BASE__Alternatives__c" data-placeholder="Select Some Alternatives" multiple="true" current="{{Alternatives__c}}{{#BIO_Worksheet_Competitors__r}};{{Competitor__c}}{{/BIO_Worksheet_Competitors__r}}">
						{{#options}}
						{{#alternatives}}
						<option value="{{val}}">{{label}}</option>
						{{/alternatives}}
						{{#customAlternatives}}
						<option value="{{.}}" class=" custom">{{.}}</option>
						{{/customAlternatives}}
						{{/options}}
					</select>

					<div class=" picked-alternative">
						<div class=" label">
							<label>Favored</label>
						</div>
						<select class="item alternativeSelectPick" name="AXIOM_BASE__Favored_Alternative__c" current="{{favoredAlternativeName}}">
							<option value="{{favoredAlternativeName}}">{{favoredAlternativeName}}</option>
						</select>
					</div>
				</span>
			</td>

			<td class=" Reason_Favored__c component-body-item-field">
				<span class=" view">{{Reason_Favored__c}}</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<textarea class=" item" name="AXIOM_BASE__Reason_Favored__c" current="{{Reason_Favored__c}}">{{Reason_Favored__c}}</textarea>
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>

			<td class=" Relationship_Notes__c component-body-item-field">
				<span class=" view">{{Relationship_Notes__c}}</span>
				<span class=" edit">
					<div class=" text-wrapper">
						<textarea class=" item" name="AXIOM_BASE__Relationship_Notes__c" current="{{Relationship_Notes__c}}">{{Relationship_Notes__c}}</textarea>
					</div>

					<div class=" error-message no-pdf"></div>
				</span>
			</td>

			<td class=" Influence__c component-body-item-field left-border">
				<span class=" view">{{Influence__c}}</span>
				<span class=" edit">
					<select class=" item" name="AXIOM_BASE__Influence__c" current="{{Influence__c}}" numval="{{Influence_Score__c}}">
						<option></option>
						{{#options}}{{#influenceScores}}
						<option value="{{.}}">{{.}}</option>
						{{/influenceScores}}{{/options}}
					</select>
				</span>
			</td>

			<td class=" Quality__c component-body-item-field left-border">
				<span class=" view">{{Quality_Score__c}} – {{Quality}}</span>
				<!--span class=" edit">
					<span class=" normal">
						<select class=" item" name="AXIOM_BASE__Quality__c" current="{{Quality__c}}">
							<option></option>
							{{#options}}
								{{#goodQualityScores}}
									<option value="{{.}}" class=" good">{{.}}</option>
								{{/goodQualityScores}}
								{{#rQualityScores}}
									<option value="{{.}}" class=" resister">{{.}}</option>
								{{/rQualityScores}}
							{{/options}}
						</select>
					</span>
				</span-->
			</td>
		</tr></table>

		<div class=" component-button component-body-item-field edit right">
			<div class=" buttons">
				<div class=" right">
					<a href="#{{type}}-{{Id}}" class=" button save-button-wrapper">Save</a>
					<a href="#{{type}}-{{Id}}" class=" button save-button hidden">Save</a>
				</div>
				<div class=" right">
				<a href="#{{type}}-{{Id}}" class=" button cancel-button">Cancel</a>
				</div>
				<div class=" right">
					<a href="#{{type}}-{{Id}}" name="{{#Contact__r}}{{Name}}{{/Contact__r}}" class=" delete-button">Delete</a>
				</div>
				<div class=" SaveObj component-body-item-field right">
					<span class=" error-message no-pdf"></span><span class=" error-message-extra no-pdf">. This error could be caused by a validation rule on the Strategic Initiative. To edit the Strategic Initiative, <a href="/{{#options}}{{dealId}}{{/options}}/e?retURL=%2F{{#options}}{{dealId}}{{/options}}">click here</a>.</span>
				</div>
				<div class=" clear"></div>
			</div>
			<div class=" busy-image"></div>
		</div>

		<div class=" clear"></div>
	</div>
</div>
{{/model}}

{{#options}}
{{#hasLightbox}}
<div class=" modal no-pdf {{modal}}" Id="eval-Modal">
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
		{{#items}}
			<input type="hidden" class=" {{itemType}}" name="{{itemName}}" value="{{itemValue}}" current="{{itemValue}}" />
		{{/items}}

		<table><tr>
			<td class=" Toggler component-body-item-field"></td>

			<td class=" Contact__c component-body-item-field">
				<div class=" text-wrapper noFancies" Id="contact-input-wrapper">
					<div class=" tooltip right">
						<a href="{{#options}}{{contactURL}}{{/options}}">Create a new contact</a>
					</div>
					<input type="text" class=" clearItem noEnterSave" Id="contact-input" current="Type to search for evaluators..." default="{{#contacts}};{{Name}}:{{Id}}{{/contacts}}" />
					<input type="hidden" name="AXIOM_BASE__Contact__c" class=" key item required" current="" />
				</div>

				{{#options}}
				<div class=" tooltip fancies">
					<a href="{{contactURL}}">Create a new contact</a>
				</div>
				<select class=" key item required fancies" name="AXIOM_BASE__Contact__c" current="" default="{{#contacts}};{{Name}}:{{Id}}{{/contacts}}">
					<option></option>
					{{#contacts}}
					<option value="{{Id}}">{{Name}}</option>
					{{/contacts}}
				</select>
				{{/options}}

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" roles-reports-wrapper">
				<div class=" Roles__c component-body-item-field left">
					<div>
						<select class=" item required" name="AXIOM_BASE__Roles__c" data-placeholder="Select Some Roles" multiple="true" current="" size="{{#options}}{{roleSize}}{{/options}}">
							{{#options}}{{#roles}}
							<option value="{{val}}">{{label}}</option>
							{{/roles}}{{/options}}
						</select>
					</div>
					<div class=" tooltip noFancies">
						Click to select a role. You can select multiple roles by clicking while pressing ctrl or by clicking and dragging.
					</div>
					<div class=" error-message no-pdf"></div>
				</div>

				<div class=" Reports_To__c component-body-item-field right"></div>

				<div class=" clear"></div>
			</td>

			<td class=" Alternatives__c alternative-field component-body-item-field">
				<div class=" text-wrapper noFancies">
					<input type="text" class=" custom-alternatives noEnterSave dataHolder" dataHolder="Type and press enter to add alternatives..." current="Type and press enter to add alternatives..." />
				</div>

				<select class=" item alternativeSelect" name="AXIOM_BASE__Alternatives__c" data-placeholder="Select Some Alternatives" multiple="true" current="">
					{{#options}}
					{{#alternatives}}
						<option value="{{val}}">{{label}}</option>
					{{/alternatives}}
					{{#customAlternatives}}
						<option value="{{.}}">{{.}}</option>
					{{/customAlternatives}}
					{{/options}}
				</select>

				<div class=" picked-alternative">
					<div class=" label">
						<label>Favored</label>
					</div>
					<select class=" item alternativeSelectPick" name="AXIOM_BASE__Favored_Alternative__c" current="">
						<option></option>
					</select>
				</div>
			</td>

			<td class=" Reason_Favored__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea class=" item" name="AXIOM_BASE__Reason_Favored__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" Relationship_Notes__c component-body-item-field">
				<div class=" text-wrapper">
					<textarea class=" item" name="AXIOM_BASE__Relationship_Notes__c" current=""></textarea>
				</div>

				<div class=" error-message no-pdf"></div>
			</td>

			<td class=" Influence__c component-body-item-field">
				<span class=" edit">
					<select class=" item" name="AXIOM_BASE__Influence__c" current="">
						<option></option>
						{{#options}}{{#influenceScores}}
						<option value="{{.}}">{{.}}</option>
						{{/influenceScores}}{{/options}}
					</select>
				</span>
			</td>

			<!--td class=" Quality__c component-body-item-field">
				<span class=" edit">
					<span class=" normal">
						<select class=" item" name="AXIOM_BASE__Quality__c" current="">
							<option></option>
							{{#options}}
								{{#goodQualityScores}}
									<option value="{{.}}" class=" good">{{.}}</option>
								{{/goodQualityScores}}
								{{#rQualityScores}}
									<option value="{{.}}" class=" resister">{{.}}</option>
								{{/rQualityScores}}
							{{/options}}
						</select>
					</span>
				</span>
			</td-->
			<td></td>
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
					<span class=" error-message no-pdf"></span><span class=" error-message-extra no-pdf">. This error could be caused by a validation rule on the Strategic Initiative. To edit the Strategic Initiative, <a href="/{{#options}}{{dealId}}{{/options}}/e?retURL=%2F{{#options}}{{dealId}}{{/options}}">click here</a></span>
				</div>
				<div class=" clear"></div>
			</div>
			<div class=" busy-image"></div>
		</div>

		<div class=" clear"></div>
	</div>
</div>