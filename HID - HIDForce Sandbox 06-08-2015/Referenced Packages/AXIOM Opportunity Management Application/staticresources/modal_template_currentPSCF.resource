<table>
	{{#model}}
	<tr>
		<td class=" curPSCFId component-body-item-field">
			<span class=" view acId">
				<input Id="{{Id}}" class=" curPSCFCheckbox" type="checkbox" />
			</span>
		</td>

		<td class=" AXIOM_BASE__Product__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Product__c}}</span>
		</td>

		<td class=" AXIOM_BASE__Support__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Support__c}}</span>
		</td>

		<td class=" AXIOM_BASE__Company__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Company__c}}</span>
		</td>

		<td class=" AXIOM_BASE__Financial__c component-body-item-field">
			<span class=" view">{{AXIOM_BASE__Financial__c}}</span>
		</td>
	</tr>
	{{/model}}
</table>