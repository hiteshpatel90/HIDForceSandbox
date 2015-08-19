.component {
	background-color: #FFFFFF;
	border: 1px solid #B9B9B9;

	border-radius: 6px;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;

	box-shadow: 0 1px 3px rgba(0, 0, 0, .17);
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,.17);
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,.17);

	margin: 10px 0;
	position: relative;
}
.component-body {
	font-size: 11px;
	line-height: 11px;
	margin-bottom: 5px;
	display: none;
}
.pdf .component-body {
	font-size: 8px;
}
.component-body table {
	font-size: 11px;
	line-height: 11px;
}
.pdf .component-body table {
	font-size: 8px;
}
.component-body table td {
	color: #404040;
}
.component-body table th {
	font-weight: bold;
}
.component-body .new {
	display: none;
}
.component-body .new.edit {
	display: block;
}
.component-body-item-content {
	padding: 5px;
}
.component-body-header {
	background-color: #FAFAFA;
	border-bottom: 1px solid #B9B9B9;

	box-shadow: inset 0 1px 4px -1px rgba(0,0,0,.3), inset 0 0 0 1px white;
	-moz-box-shadow: inset 0 1px 4px -1px rgba(0,0,0,.3), inset 0 0 0 1px white;
	-webkit-box-shadow: inset 0 1px 4px -1px rgba(0,0,0,.3), inset 0 0 0 1px white;

	color: #404040;
	font-weight: bold;
	padding: 1px 5px;
	text-shadow: 0px 1px 0px #FFFFFF;
}
.component-body-item {
	background-color: #FFFFFF;
	border-bottom: 1px dotted #B9B9B9;
	min-height: 26px;
}
.component-body-item:hover {
	background-color: #F0F9FE;
}
.component-body-item .label {
	color: #404040;
	display: block;
	margin: 5px 0;
}
.component-body-item.edit {
	background-color: #F4F4EE;
}
.component-body-item.grayOut, .component-body-item.grayOut a {
	color: #404040;
}
.component-body-item.new {
	display: none;
}
.component-body-item .chzn-container {
	font-size: 11px;
}
.component-body-item .chzn-container-multi .chzn-choices {
	border: 1px solid #b9b9b9;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;

	border-radius: 3px;
	-webkit-box-shadow: inset 0px 1px 5px 0px rgba(0, 0, 0, .1);
	-moz-box-shadow: inset 0px 1px 5px 0px rgba(0, 0, 0, .1);

	box-shadow: inset 0px 1px 5px 0px rgba(0, 0, 0, .1);
}
.component-body-item .chzn-search {
	display: none;
}
.component-body-item .component-button {
	margin: 10px 1px;
}
.component-body-item .component-button div {
	margin: 0 0 0 5px;
}
.component-body-item .component-button .button {
	background: rgb(255,255,255); /* Old browsers */
	background: -moz-linear-gradient(top,  rgba(255,255,255,1) 20%, rgba(230,230,230,1) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(20%,rgba(255,255,255,1)), color-stop(100%,rgba(230,230,230,1))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  rgba(255,255,255,1) 20%,rgba(230,230,230,1) 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  rgba(255,255,255,1) 20%,rgba(230,230,230,1) 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  rgba(255,255,255,1) 20%,rgba(230,230,230,1) 100%); /* IE10+ */
	background: linear-gradient(top,  rgba(255,255,255,1) 20%,rgba(230,230,230,1) 100%); /* W3C */

	box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);
	-moz-box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);
	-webkit-box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);

	border:1px solid #CCCCCC;
	color:#404040;
	text-shadow: 0px 1px 0px white;
}
.component-body-item .component-button .button.save-button, .component-body-item .component-button .button.save-button-wrapper, .component-body-item .component-button .button.modal-save-button, .modal .component-button .button.modal-add-selected-button {
	background: rgb(146,213,11); /* Old browsers */
	background: -moz-linear-gradient(top,  rgba(146,213,11,1) 20%, rgba(113,165,9,1) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(20%,rgba(146,213,11,1)), color-stop(100%,rgba(113,165,9,1))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* IE10+ */
	background: linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* W3C */

	box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);
	-moz-box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);
	-webkit-box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);

	border:1px solid #71a509;
	color:#fff;
	font-weight: normal;
	text-shadow: 0px -1px 0px rgba(0,0,0,.25);
}
.component-body-item .component-button .button.save-button:hover, .component-body-item .component-button .button.save-button-wrapper:hover, .component-body-item .component-button .button.modal-save-button:hover, .modal .component-button .button.modal-add-selected-button:hover {
	background-color: rgba(113, 165, 9, 1);

	box-shadow:0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5), inset 0 0 30px 5px rgba(255,255,255,.3);
	-moz-box-shadow:0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5), inset 0 0 30px 5px rgba(255,255,255,.3);
	-webkit-box-shadow:0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5), inset 0 0 30px 5px rgba(255,255,255,.3);
}
.component-body-item .component-button .button.save-button:active, .component-body-item .component-button .button.save-button-wrapper:active, .component-body-item .component-button .button.modal-save-button:active, .modal .component-button .button.modal-add-selected-button:active {
	background-color: rgba(113, 165, 9, 1);

	box-shadow:: inset 0 1px 4px -1px rgba(0,0,0,.5), 0 1px 0 rgba(255,255,255,1);
	-moz-box-shadow: inset 0 1px 4px -1px rgba(0,0,0,.5), 0 1px 0 rgba(255,255,255,1);
	-webkit-box-shadow: inset 0 1px 4px -1px rgba(0,0,0,.5), 0 1px 0 rgba(255,255,255,1);
}

.modal .component-button .button.modal-add-selected-button.disabled, .modal .component-button .button.modal-add-selected-button:hover.disabled, .modal .component-button .button.modal-add-selected-button:active.disabled {
	background: rgb(146,213,11); /* Old browsers */
	background: -moz-linear-gradient(top,  rgba(146,213,11,1) 20%, rgba(113,165,9,1) 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(20%,rgba(146,213,11,1)), color-stop(100%,rgba(113,165,9,1))); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* IE10+ */
	background: linear-gradient(top,  rgba(146,213,11,1) 20%,rgba(113,165,9,1) 100%); /* W3C */

	box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);
	-moz-box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);
	-webkit-box-shadow: 0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5);

	border:1px solid #71a509;
	color:#fff;
	font-weight: normal;
	text-shadow: 0px -1px 0px rgba(0,0,0,.25);

	cursor: default;
	filter: alpha(opacity=30);
	opacity: .3;
}
.component-body-item .delete-button, .component-body-item .delete-button:hover {
	color: #C43C35;
	text-decoration: underline;
}
.component-body-item .component-button .buttons div.right {
	height: 26px;
}
.component-body-item .component-button .buttons div.SaveObj {
	height: auto;
	margin: 0;
	padding: 0;
}
.component-body-item .component-button .busy-image, .busy-image {
	display: none;
}
.component-body-item .component-button.busy .busy-image, .busy-image.busy {
	display: block;
}
.component-body-item .component-button.busy .buttons {
	display: none;
}
.component-body-item .edit {
	display: none;
}
.component-body-item .edit-button {
	height: 0;
	margin: 0;
	padding: 0;
	width: 0;
}
.component-body-item .edit-button:hover {
	display: table-cell;
}
.component-body-item .edit-button .view {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -59px -34px transparent;
	background-color: #F0F9FE;
	border-color: #B9B9B9 #F0F9FE #B9B9B9 #B9B9B9;
	border-style: solid;
	border-width: 1px;

	border-radius: 5px 0 0 5px;
	-moz-border-radius: 5px 0 0 5px;
	-webkit-border-radius: 5px 0 0 5px;

	cursor: pointer;
	height: 24px;
	left: -19px;
	margin: 0;
	padding: 0;
	position: relative;
	top: -1px;
	width: 17px;
}
.component-body-item select {
	width: 100%;
}
.component-body-item:hover .edit-button {
	display: block;
}
.component-body-item.edit .edit {
	display: block;
}
.component-body-item.edit .view {
	display: none;
}
.component-body-item.edit:hover .edit-button {
	display: none;
}
.component-body-item-field {
	padding: 5px;
	word-wrap: break-word;
}
.component-body-item-field .error-message, .component-body-item-field .error-message-extra {
	color: #FF3821;
	display: none;
}
.component-body-item-field.error .chzn-single, .component-body-item-field.error textarea, .component-body-item-field.error input, .component-body-item-field.error select, .component-body-item-field.error div.chzn-container-multi {
	border: 1px solid #FF3821;
}
.component-body-item-field.error input {
	border: 1px solid #FF3821 !important;
}
.component-body-item-field.error .error-message, .component-body-item-field.error .error-message-extra {
	display: inline;
}
.component-body-header .AXIOM_BASE__Status__c, .component-body-item .AXIOM_BASE__Status__c {
	width: 32px;
}
.component-body-item .AXIOM_BASE__Status__c .minus, .component-body-item .AXIOM_BASE__Status__c .plus {
	cursor: pointer;
	height: 10px;
	margin: 2px;
	padding: 1px;
	width: 10px;
}
.component-body-item .AXIOM_BASE__Status__c .plus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -160px -44px transparent;
}
.component-body-item .AXIOM_BASE__Status__c .minus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -148px -44px transparent;
}
.component-body-item .AXIOM_BASE__Status__c.minus .minus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -148px -32px transparent;
	display: block;
}
.component-body-item .AXIOM_BASE__Status__c.plus .plus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -160px -32px transparent;
	display: block;
}
.component-header .Decision_Status .plus, .component-header .Commonality_Status .plus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -160px -44px transparent;
}
.component-header .Decision_Status .minus, .component-header .Commonality_Status .minus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -148px -44px transparent;
}
.component-header .Decision_Status.minus .minus, .component-header .Commonality_Status.minus .minus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -148px -32px transparent;
	display: block;
}
.component-header .Decision_Status.plus .plus, .component-header .Commonality_Status.plus .plus {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -160px -32px transparent;
	display: block;
}
.component-header .Decision_Status, .component-header .Commonality_Status {
	width: 32px;
	margin: 10px 0 10px 3px;
}
.component-header .Decision_Status .minus, .component-header .Decision_Status .plus,
.component-header .Commonality_Status .minus, .component-header .Commonality_Status .plus {
	cursor: pointer;
	height: 10px;
	margin: 2px;
	padding: 1px;
	width: 10px;
}
.component-button .button {
	background: #FFFFFF; /* Old browsers */
	background: -moz-linear-gradient(top, #FFFFFF 0%, #FFFFFF 25%, #E6E6E6 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #FFFFFF), color-stop(25%, #FFFFFF), color-stop(100%, #E6E6E6));
	background: -webkit-linear-gradient(top, #FFFFFF 0%, #FFFFFF 25%, #E6E6E6 100%);
	background: -o-linear-gradient(top, #FFFFFF 0%, #FFFFFF 25%, #E6E6E6 100%);
	background: -ms-linear-gradient(top, #FFFFFF 0%, #FFFFFF 25%, #E6E6E6 100%);
	background: linear-gradient(top, #FFFFFF 0%, #FFFFFF 25%, #E6E6E6 100%);

	border: 1px solid #B9B9B9;
	border-radius: 3px;
	-moz-border-radius: 3px;
	-webkit-border-radius:3px;

	box-shadow: 0 0 1px 0 white, inset 0 0 2px rgba(0,0,0,.17), 0px 0px 0px 1px white;
	-moz-box-shadow: 0 0 1px 0 white, inset 0 0 2px rgba(0,0,0,.17), 0px 0px 0px 1px white;
	-webkit-box-shadow: 0 0 1px 0 white, inset 0 0 2px rgba(0,0,0,.17), 0px 0px 0px 1px white;

	color: #000000;
	font-family: Helvetica Neue, Helvetica, Arial, sans-serif;
	font-size: 11px;
	font-weight: normal;
	margin: 0 1px;
	padding: 5px 10px;
}
.component-button .button:hover {
	box-shadow:0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5), inset 0 0 30px 5px rgba(255,255,255,.3);
	-moz-box-shadow:0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5), inset 0 0 30px 5px rgba(255,255,255,.3);
	-webkit-box-shadow:0 2px 0 0 rgba(0,0,0,.08), inset 0 1px 0 rgba(255,255,255,.5), inset 0 0 30px 5px rgba(255,255,255,.3);

	color: #000000;
	text-decoration: none;
}
.component-button .button:active {
	background-color:rgba(230, 230, 230, 1);
	box-shadow:: inset 0 1px 4px -1px rgba(0,0,0,.5), 0 1px 0 rgba(255,255,255,1);
	-moz-box-shadow: inset 0 1px 4px -1px rgba(0,0,0,.5), 0 1px 0 rgba(255,255,255,1);
	-webkit-box-shadow: inset 0 1px 4px -1px rgba(0,0,0,.5), 0 1px 0 rgba(255,255,255,1)
}
.component-footer-wrapper {
	height: 48px;
	display: none;
}
.component-footer {
	bottom: 0;
	height: 48px;
	position: absolute;
	width: 100%;
}
.component-footer .component-button .new-button {
	color: #404040;
	cursor: pointer;
	line-height: 28px;
	margin: 10px;
}
.component-footer .component-button .new-button.disabled {
	cursor: default;
	filter: alpha(opacity=30);
	opacity: .3;
}
.component-footer .component-button .new-button .new-button-icon {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -28px -32px transparent;
	border: 1px solid #CCCCCC;
	border-radius: 4px;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	display: block;
	height: 28px;
	margin-right: 6px;
	width: 28px;
}

.component-footer .component-button .ap-button {
	color: #404040;
	cursor: pointer;
	line-height: 28px;
	margin: 10px;
}
.component-footer .component-button .ap-button.disabled {
	cursor: default;
	filter: alpha(opacity=30);
	opacity: .3;
}
.component-footer .component-button .ap-button .ap-button-icon {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll 0 -32px transparent;
	border: 1px solid #CCCCCC;
	border-radius: 4px;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	display: block;
	height: 28px;
	margin-right: 6px;
	width: 28px;
}

.component-footer .refresh-button {
	cursor: pointer;
	display: none;
}
.component-header {
	background: #F5F5F5;
	background: -moz-linear-gradient(top, #F5F5F5 0%, #EEEEEE 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #F5F5F5), color-stop(100%, #EEEEEE));
	background: -webkit-linear-gradient(top, #F5F5F5 0%, #EEEEEE 100%);
	background: -o-linear-gradient(top, #F5F5F5 0%, #EEEEEE 100%);
	background: -ms-linear-gradient(top, #F5F5F5 0%, #EEEEEE 100%);
	background: linear-gradient(top,  #F5F5F5 0%, #EEEEEE 100%);

	border-bottom: 1px solid #B9B9B9;
	border-top-left-radius: 6px;
	border-top-right-radius: 6px;
	-webkit-border-top-left-radius: 6px;
	-webkit-border-top-right-radius: 6px;
	-moz-border-radius-topleft: 6px;
	-moz-border-radius-topright: 6px;

	box-shadow: 0 1px 3px rgba(0,0,0,.17), inset 0 0 0px 1px white;
	-moz-box-shadow: 0 1px 3px rgba(0,0,0,.17), inset 0 0 0px 1px white;
	-webkit-box-shadow: 0 1px 3px rgba(0,0,0,.17), inset 0 0 0px 1px white;

	color: #000000;
	font-size: 14px;
	font-weight: bold;
	height: 32px;
	line-height: 32px;
	padding: 5px;
	text-shadow: 0px 1px 0px #ffffff;
}
.component-header .component-logo {
	background-repeat: no-repeat;
	height: 32px;
	width: 32px;
}
.component-header .component-title {
	margin: 0 0 0 5px;
}
.component-header .component-button {
	margin-right: 5px;
}
.component-header .component-button ul, .component-header .component-button li {
	margin: 0;
	padding: 0;
}
.component-header .component-button .button.help-button {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -185px -32px transparent;
	box-shadow: none;
	-moz-box-shadow: none;
	-webkit-box-shadow: none;
	border: none;
	height: 16px;
	margin: 4px 0 0 6px;
	padding: 0;
	width: 16px;
	text-shadow: none;
}
.component-header .component-button .button.help-button:hover {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -185px -48px transparent;
}
.component-header .dropdown a .caret, .component-header .dropdown.open .caret, .component-header .dropdown.open.active .caret, .component-header .dropdown a:hover .caret, .component-header .dropdown.open a:hover .caret {
	border-bottom-color: #005580;
	border-top-color: #005580;
	opacity: 1;
}
.component-header .dropdown-toggle span, .component-header .dropdown-toggle:hover span {
	color: #000000;
}
.small-component {
	height: 100%;
	margin: 0;
}
.small-component .component-header .component-button .button.help-button {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -185px -32px transparent;
}
.small-component .component-header .component-button .button.help-button:hover {
	background: url('/resource/axiom_base__images/icon-sprite.png') no-repeat scroll -185px -48px transparent;
}
.small-component .component-body {
	width: 100%;
}
.small-component .component-body-header {
	padding: 0 5px;
}
.small-component-wrapper {
	margin: 10px 0;
}
.tooltip {
	margin: 5px 0;
}

.modal table {
	border-collapse: collapse;
	table-layout: fixed;
}

.opportunity-body > .component.round-corners {
	margin:10px 3px;
}