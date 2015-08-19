<table>
	{{#model}}
		<tr Id="tr{{Id}}">
			<td class=" bsId component-body-item-field">
				<span class=" view bsId">
					<input Id="{{Id}}" class=" bs-radio" type="radio" name="pick"/>
				</span>
			</td>
			<td class=" AXIOM_BASE__Area__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Area__c}}</span>
			</td>
	
			<td class=" AXIOM_BASE__Description__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Description__c}}</span>
			</td>
	
			<td class=" AXIOM_BASE__Impact__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Impact__c}}</span>
			</td>
			<td class=" AXIOM_BASE__ImpactDescription__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__ImpactDescription__c}}</span>
			</td>	
			<td class=" AXIOM_BASE__Gap__c component-body-item-field">
				<span class=" view">{{AXIOM_BASE__Gap__c}}</span>
			</td>
		</tr>
	{{/model}}
</table>