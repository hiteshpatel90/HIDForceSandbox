{{#params}}
<div class=" component-header">
	<div class=" component-logo {{type}}-logo left"></div>
	<div class=" component-title left"><a href="javascript:void(0);" class=" a-title">{{title}}</a></div>
	{{#status}}
		<div class=" {{class}} {{value}} left">
			<div class=" minus left"></div>
			<div class=" plus left"></div>
		</div>
	{{/status}}
	<div class=" component-button right">
		<ul class=" nav nav-pills pull-right">
			{{#buttons}}
			<li class=" button-wrapper{{#dropdown}} dropdown{{/dropdown}}">
				<a href="{{href}}" class=" {{buttonClass}}{{#dropdown}} dropdown-toggle{{/dropdown}}"{{#target}} target="{{target}}"{{/target}}{{#attr}} {{name}}="{{value}}"{{/attr}}>
					<span class=" button-name">{{name}}</span>
					{{#dropdown}}<b class=" caret"></b>{{/dropdown}}
				</a>
				{{#dropdown}}
				<ul class=" dropdown-menu">
					{{#options}}
					<li class=" {{#isDivider}}divider{{/isDivider}}">{{^isDivider}}<a href="{{href}}" class=" {{buttonClass}}"{{#target}} target="{{target}}"{{/target}}{{#attr}} {{name}}="{{value}}"{{/attr}}>{{name}}</a>{{/isDivider}}</li>
					{{/options}}
				</ul>
				{{/dropdown}}
			</li>
			{{/buttons}}
		</ul>
	</div>
	<div class=" clear"></div>
</div>
<div class=" loader2" style="height: 100%; width: 100%;">
	<div class=" loader-image-div"/>
</div>
<div class=" component-body">
	{{body}}
</div>

<div class=" component-footer-wrapper no-pdf">
	<div class=" component-footer">
		{{#newItem}}
		<div class=" component-button left">
			<div class=" new-button left disabled">
				<div class=" new-button-icon left"></div>
				<div class=" left">Add {{type}}</div>
				<div class=" clear"></div>
			</div>
			{{#hasAccountPlan}}
			<div class=" ap-button left">
				<div class=" ap-button-icon left"></div>
				<div class="pull-from-text left">Pull From Existing(&nbsp;{{number}}&nbsp;)</div>
				<div class=" clear"></div>
			</div>
			{{/hasAccountPlan}}
		</div>
		{{/newItem}}
		<div class=" refresh-button right">Refresh</div>
		<div class=" clear"></div>
	</div>
</div>
{{/params}}