var css = {},
	cssLoaded = 0,
	totalCSS = 0;
var pdfCSS;
var evLoad = false;
var evList = [];
var firstTime = true;
var componentsLoaded = 0,	// keeps track of the number of components loaded, incremented with postPageLoad()
	totalComponents = 0,	// total number of components loaded
	done = false;			// status of loading, updated with postPageLoad()

var canCreateCCEvaluator = false;

preBoot = function() {

	// "axiom" is the package's prefix
	// if package exists, set non-prefix global variable name to prefixed global variable name
	if (typeof(AXIOMOMD) !== 'undefined') {
		controller = 'AXIOMOMD.' + controller;
	}

	// load css : load css through ajax instead of during page load to allow the pdf creation to have access to css

	if (OmdConf.isDeveloperMode()) {
		for(x in tempDir) {
			++totalCSS;
		}
		for (x in tempDir) {
			getCSS(x);
		}
	} else {
		jQuery.ajax({
			url : cssURL,
			success : function(data) {
				data = data.replace(/url\(\'\/resource\/axiom_base__images\//g, 'url(\'' + imagePrefix);
				pdfCSS += data;
				pdfCSS = '<style>' + pdfCSS + '</style>';
				boot();
			}
		});
	}
}
function changeWinData(sectionName) {
	Visualforce.remoting.Manager.invokeAction(
		controller + '.getWinProbability',
		parentId,
		function(result, event){
			if(result == true){
				renderWinData(sectionName);
			}
		},
		{escape: true}
	);
}
function renderWinData(sectionName) {
		Visualforce.remoting.Manager.invokeAction(
			controller + '.createWinProbabilityChartWithIndicator',
			parentId, 'Win Probability', urlImage,
			function(result, event){
				var chartReference = FusionCharts($('#Win-radar').children().prop('id'));
				chartReference.setJSONData(result);
				if(sectionName != null){
					$('.' + sectionName).trigger('refreshDepend');
				}
			},
			{escape: true}
		);
}

function rerenderWinFunc() {
	Visualforce.remoting.Manager.invokeAction(
		controller + '.createWinProbabilityChartWithIndicator',
		parentId, 'Win Probability', urlImage,
			function(result, event){
				FusionCharts.setCurrentRenderer('javascript');
				var ahsChart = new FusionCharts({
					type: 'AngularGauge',
					width: $('.summary-win').width()*0.75 > 190 ? $('.summary-win').width()*0.75 : 190,//'99%',
					height: '110px',
					debugMode : false,
					registerWithJS : '0'
				});
				ahsChart.setJSONData(result);
				ahsChart.render('Win-radar');
				var rendered = false;
				ahsChart.addEventListener("DrawComplete" , function(evt, args) {
					//$('#Win-radar').attr('style', 'width: 190px');
					if (/(msie|ie)/.test(navigator.userAgent.toLowerCase()) && !rendered) {
						rendered = true;
						$('#Win-radar').children().width($('#Win-radar').width());
						var gaugeChart = getChartFromId($('#Win-radar').children().prop('id'));
						if (gaugeChart != null) {
							getChartFromId($('#Win-radar').children().prop('id')).render();
						}
					}
				});
			},
			{escape: true}
		);
}

function validateAccess (e){
	var target = jQuery(e.target),
	compButton = target.parents('.component-button');
	var tr = jQuery(target.attr('href'));
	if(!isUpdateableParent){
		target.removeClass('saving');
		target.removeClass('deleting');
		compButton.removeClass('busy');
		var field = tr.find('.SaveObj');
		field.find('.error-message').show();
		field.find('.error-message').html('You do not have permissions to update this '+ ObjectType + '.');
	}
	return isUpdateableParent;
}
boot = function() {
	try {
		// load parent object
		++totalComponents;
		loadParentObject(function() {
			try {
				// load evaluators : boot_component_evaluators.resource
				++totalComponents;
				loadEvaluators(function(evaluators) {
					// load rest asynchronously
					evLoad = true;
					postPageLoad();
				});
			} catch (err) {
				postPageLoad();
			}
			try {
				// load decision stages
				++totalComponents;
				loadDecisionStages(function() {});
			} catch (err) {
				postPageLoad();
			}
			try {
				// load action registers : boot_component_actionRegisters.resource
				++totalComponents;
				loadActionRegisters(function() {});
			} catch (err) {
				postPageLoad();
			}
			try {
				// load current pscf : boot_component_currentPSCF.resource
				++totalComponents;
				loadCurrentPSCF(function() {});
			} catch (err) {
				postPageLoad();
			}
			try {
				// load commonalities : boot_component_commonalities.resource
				++totalComponents;
				loadCommonalities(function() {


				});
			} catch (err) {
				postPageLoad();
			}
		});
	} catch (err) {
		postPageLoad();
	}
};

// ajax for a specific CSS file and insert into its appropriate container div
function getCSS(type) {
	jQuery.ajax({
		url : tempDir[type].css,
		success : function(data) {
			data = data.replace(/url\(\'\/resource\/axiom_base__images\//g, 'url(\'' + imagePrefix);
			jQuery('#css').append(data);
			pdfCSS += data;
			++cssLoaded;

			if (cssLoaded >= totalCSS) {
				jQuery('#css').html('<style>' + jQuery('#css').html() + '</style>');
				pdfCSS = '<style>' + pdfCSS + '</style>';
				boot();
			}
		}
	});
}

// load parent object
function loadParentObject(callback) {
	loadCurrency();
	$("#CloseDate").datepicker({
		dateFormat: 'M dd, yy',
		showOn: "button",
		buttonImage: calendarURL,
		buttonImageOnly: true
	});
	matchHeightsHeader('.summary-item');
	$(window).resize(function() {
		matchHeightsHeader('.summary-item');
		matchChartWidth();
	});
	var stageSelect = jQuery('.summary-'+ ObjectType +'-stage .edit select'),
		shortDescSize = 0,
		fullDescSize = 0;

	stageSelect.val(stageSelect.attr('current'));

	editDOM(function() {
		jQuery('.summary-' + ObjectType + '-stage .edit').show();

		if (!noFancies) {
			stageSelect.chosen();
			jQuery('.summary-' + ObjectType + '-stage .edit .chzn-container input').addClass('noEnterSave');
		}

		jQuery('.summary-close-date .edit .dateFormat').addClass('hidden');
		jQuery('.summary-close-date .edit input').attr('name', 'CloseDate');

		jQuery('.summary-' + ObjectType + '-stage .edit').hide();

		shortDescSize = jQuery('.header-description .view .desc').height();
		jQuery('.header-description .view .desc').addClass('fullDesc').removeClass('shortDesc');
		fullDescSize = jQuery('.header-description .view .desc').height();
		jQuery('.header-description .view .desc').addClass('shortDesc').removeClass('fullDesc');

		matchHeights('.summary-wrapper .summary-item-content');
	});

	// show more/less button
	if (fullDescSize > shortDescSize) {
		jQuery('.header-description .view .show .more').click(function(e) {
			e.preventDefault();
			e.stopPropagation()

			jQuery('.header-description .view .shortDesc').removeClass('shortDesc').addClass('fullDesc');
		});

		jQuery('.header-description .view .show .less').click(function(e) {
			e.preventDefault();
			e.stopPropagation();

			jQuery('.header-description .view .fullDesc').removeClass('fullDesc').addClass('shortDesc');
		});
	} else {
		jQuery('.header-description .view .show').hide();
	}

	// set update function for parent object
	var updateParentObject = function() {
		var self = jQuery(this);
		if (self.attr('class').indexOf('item') == -1) {
			self = jQuery(this).parent().parent().children('.item');
		}
		var name = self.attr('api-name'),
			val = self.val(),
			edit = self.parents('.edit'),
			view = edit.siblings('.view');

		if (val == '' || val == null) {
			val = self.attr('default');

			if (val == null) {
				val = '';
			}
		}
		if(self.hasClass('date')){
			val = $.datepicker.formatDate('yy-mm-dd', new Date(val));
		}
		// max length of input fields is 255
		if (!jQuery(this).hasClass('noLimit') && val.length > 255) {
			edit.find('.error-message').html('Max length 255. Currently ' + val.length + '.');
			return;
		}
		Visualforce.remoting.Manager.invokeAction( controller + '.saveObj', ObjectType, parentId, '', encodeURIComponent(name) + '=' + encodeURIComponent(val), function(result, event) {
			if (result == null) {
				window.location.href='/' + parentId;
				return;
			}

			jQuery('.' + ObjectType + ' .header .error-message').html('');

			var res = result.split(':', 2);
			if (res[0] == 'ID') {
				reRenderParentObj();
				jQuery('.dangerZones .refresh-button').click();
			} else if (res[0] == 'ERROR') {
				var err = res[1].split('|', 2);

				jQuery('.' + ObjectType + ' .header .error-message').html('ERROR: ' + err[1] + '. This error could be caused by a validation rule on the ' + ObjectType + '. To edit the ' + ObjectType + ', <a href="/' + parentId + '/e?retURL=%2F' + parentId + '">click here</a>');
			}
		});
	};

	// bind parent object events
	jQuery('.' + ObjectType + '-item .edit .item.change').bind('change', updateParentObject);
	jQuery('.' + ObjectType + '-item .edit .save').bind('click', updateParentObject);

	jQuery('.' + ObjectType + '-item .edit .cancel').click(function(e) {
		var edit = jQuery(this).parents('.edit'),
			view = edit.siblings('.view'),
			cancelledValue = jQuery(this).parents('.edit').children('.item');

		if (cancelledValue != null) {
			if (cancelledValue.attr('name') == 'StageName') {
				cancelledValue.val(parentStage);
				cancelledValue.trigger('liszt:updated');
			} else
			if (cancelledValue.attr('name') == 'CloseDate') {
				cancelledValue.val(parentCloseDate);
			}
		}

		edit.hide();
		view.show();
	});

	jQuery('.' + ObjectType + '-item .edit .item.blur').bind('blur', updateParentObject);

	jQuery('.' + ObjectType + '-item .view').click(function(e) {
		var view = jQuery(this),
			edit = view.siblings('.edit'),
			item = edit.find('.item'),
			itemId = item.attr('id');

		view.hide();
		edit.show();

		if (itemId != null) {
			try{
				jQuery('#' + itemId).focus();
				jQuery('#' + itemId + '_chzn .chzn-single').mousedown();
			} catch(e){}
		} else {
			item.focus();
		}
	});

	jQuery('.summary-data input.item').bind('keypress', function(e) {
		var self = jQuery(this);
		if (e.keyCode == 13) {
			if (self.hasClass('blur')) {
				self.blur();
			}
		}
	});

	if (typeof(callback) == 'function' && !done) {
		callback();
	}
}

//corrects the matching heights of small-group-2 if 1 of section is collapsed
function matchHeightCollapsed() {
	var smallBlockCommonalities = jQuery('.commonalities');
	var smallBlockDesHistory = jQuery('.decisionHistory');
	if (smallBlockCommonalities.find('.component-body').css('display') != 'none' ||
		smallBlockDesHistory.find('.component-body').css('display') != 'none') {
		if (smallBlockCommonalities.find('.component-body').css('display') != 'none' &&
			smallBlockDesHistory.find('.component-body').css('display') == 'none') {
				smallBlockDesHistory.css('height', '43px');
				smallBlockCommonalities.css('height', '');
		}  else if (smallBlockCommonalities.find('.component-body').css('display') == 'none' &&
			smallBlockDesHistory.find('.component-body').css('display') != 'none') {
				smallBlockCommonalities.css('height', '43px');
				smallBlockDesHistory.css('height', '');
		}
	} else {
		smallBlockDesHistory.css('height', '');
		smallBlockCommonalities.css('height', '');
	}
}

// finds the max height among a group of elements and sets them to the same height
function matchHeights(selector) {
	try{
		var maxHeight = 0;

		// reset to recalculate
		jQuery(selector).height('auto');

		jQuery(selector).each(function() {
			var h = jQuery(this).height();
			if (maxHeight < h) {
				maxHeight = h;
			}
		});

		jQuery(selector).height(maxHeight);
		matchHeightCollapsed();
	} catch(e){}
}

function matchHeightsHeader(selector) {
	try{
		var maxHeight = 0;

		// reset to recalculate
		jQuery(selector).height('auto');

		jQuery(selector).each(function() {
			var h = jQuery(this).outerHeight();
			if (maxHeight < h) {
				maxHeight = h;
			}
		});

		jQuery(selector).height(maxHeight);
	} catch(e){}
}

function matchChartWidth() {
	var chartWidth = $('.summary-win').width()*0.75 > 190 ? $('.summary-win').width()*0.75 : 190;
	//$('#Win-radar').attr('style', chartWidth);
	try{getChartFromId($('#Win-radar').children().prop('id')).resizeTo(chartWidth, '110px');}catch(e){}
}

function getSecFromCookies(flag) {
	var sessionId = jQuery.cookie('sid');
	sessionId = sessionId.substring(20, 26);
	var curCookie = jQuery.cookie(sessionId + '_' + parentId + '_cookie');
	if (curCookie != null && curCookie != '') {
		var sectionNames = curCookie.split(';');
		for (var i=0; i + 1 < sectionNames.length; i++) {
			if (sectionNames[i] == 'actionRegistersOpportunity') {
				jQuery('#' + sectionNames[i]).css('display', 'block');
				matchHeights('.small-component-group-1');
			} else {
				var selector = '.' + sectionNames[i] + ' .component-footer-wrapper';
				jQuery(selector).css('display', 'block');
			}
			var selector = '.' + sectionNames[i] + ' .component-body';
			jQuery(selector).css('display', 'block');
			if(sectionNames[i] == 'decisionHistory' || sectionNames[i] == 'commonalities'){
				matchHeights('.small-component-group-2');
			}
			if(!flag){
				var selectorLoad = '.' + sectionNames[i] + ' .loader2';
				jQuery(selectorLoad).css('display', 'block');
			}
		}
	}
}


function postPageLoad() {
	++componentsLoaded;
	if(evLoad && firstTime){
		firstTime = false;
		evload = false;
					try {
						// load danger zones : boot_component_dangerZones.resource
						++totalComponents;
						loadDangerZones(function() {});
					} catch (err) {
						postPageLoad();
					}

					try {
						// load psc criteria : boot_component_pscCriteria.resource
						++totalComponents;
						loadPSCCriteria(function() {});
					} catch (err) {
						postPageLoad();
					}

					try {
						// load financial criteria : boot_component_financialCriteria.resource
						++totalComponents;
						loadFinancialCriteria(function() {});
					} catch (err) {
						--totalComponents
					}
					try {
						// load decision history : boot_component_decisionHistory.resource
						++totalComponents;
						loadDecisionHistory(function() {});
					} catch (err) {
						postPageLoad();
					}
					try {
						// load business states : boot_component_businessStates.resource
						loadBusinessStates(function() {});
					} catch (err) {
						postPageLoad();
					}
	}
	// remove loading and bind events for pdf creation
	if (!done && componentsLoaded > 9) {
		getSecFromCookies(done);
		done = true;
		jQuery('.loader').hide();
		jQuery('.' + ObjectType + '').removeClass('hidden').show();
		jQuery('.chatter').removeClass('hidden');
		jQuery('.details').removeClass('hidden');
		rerenderWinFunc();
		$('#Win-radar').attr('style', 'width: 265px');
		if (/(msie|ie)/.test(navigator.userAgent.toLowerCase())) {
			$('#Win-radar').children().width($('#Win-radar').width());
			var gaugeChart = getChartFromId($('#Win-radar').children().prop('id'));
			if (gaugeChart != null) {
				getChartFromId($('#Win-radar').children().prop('id')).render();
			}
		}

		matchHeights('.summary-wrapper .summary-item-content');
		matchHeights('.small-component-group-1');
		matchHeights('.small-component-group-2');
		matchHeightsHeader('.summary-item');
		matchChartWidth();

		// bind window resize event
		jQuery(window).resize(function() {
			matchHeights('.summary-wrapper .summary-item-content');
			matchHeights('.small-component-group-1');
			matchHeights('.small-component-group-2');

			jQuery('.' + ObjectType + ' .component-body-item.edit').addClass('_edit');
			jQuery('.' + ObjectType + ' .component-body-item').addClass('edit');

			jQuery('.chzn-done').each(function() {
				var self = jQuery(this);

				self.removeClass('.chzn-done');
			});

			jQuery('.' + ObjectType + ' .component-body-item').removeClass('edit');
			jQuery('.' + ObjectType + ' .component-body-item._edit').addClass('edit').removeClass('_edit');
		});

		// bind resize event for SFDC
		jQuery('.handlebarContainer').mouseup(function() {
			jQuery('.chzn-done').each(function() {
				var self = jQuery(this);

				self.removeClass('.chzn-done');
				self.chosen();
				self.siblings('.chzn-container').find('input').addClass('noEnterSave');
			});
		});

		// bind pdf creation events
		var pdfButton = jQuery('#pdf-button'),
			pdfLink = jQuery('#pdf-link');

		pdfLink.click(function() {
			window.open(jQuery(this).attr('href'));
		});

		pdfButton.click(function() {
			if (pdfButton.hasClass('creating')) {
				return;
			}

			pdfLink.attr('href', '');

			pdfButton.addClass('creating');

			pdfButton.find('.printpdf').hide();
			pdfButton.find('.loadpdf').show();

			// clone current page displays
			jQuery('body').append('<div id="pdfContent" class="' + ObjectType + ' pdf hidden"></div');
			var content = jQuery('.' + ObjectType + '').html();
			content = content.replace('Id="', 'Id=" ')
			jQuery('#pdfContent').html(content);

			// remove invisible components and chart from pdf
			jQuery('#pdfContent #chart_div').remove();
			jQuery('#pdfContent .edit').remove();
			jQuery('#pdfContent .new').remove();
			jQuery('#pdfContent .no-pdf').remove();
			jQuery('#pdfContent .component-button').remove();
			jQuery('#pdfContent .fusionChart').remove();

			//Add Win Probability info
			var winProbContainer  = '';
			var winProbContainer  = '<div class="summary-item-content" style="text-align:left !important">';
				winProbContainer += '<div class="summary-item-label">Win Probability</div>';
				winProbContainer += '<div class=" value left" style="font-size:14px;font-weight:bold;line-height:22px;">';
				winProbContainer += getChartFromId($('#Win-radar').children().prop('id')).getData(1) + '%';
				winProbContainer += '<div class="summary-arrow right">';
				winProbContainer += '<img src="' + getChartFromId($('#Win-radar').children().prop('id')).getJSONData().annotations.groups[0].items[2].url + '"/>';
				winProbContainer += '</div></div></div>';
			jQuery('#pdfContent .summary-win').html(winProbContainer);

			//remove empty description
			var description = $('.shortDesc').children();
			if (description != null && description.length != 0 && $(description[0]).html() == 'Add a Description') {
				jQuery('#pdfContent .header-description').remove();
			}

			// make clone visible for DOM fixes
			jQuery('#pdfContent').show();
			matchHeights('#pdfContent .summary-wrapper .summary-item-content');
			matchHeights('#pdfContent .small-component-group-1');
			matchHeights('.small-component-group-2');

			// add pdf styles
			var pdfContent = '<html><head><style>@page { margin: 0; padding: 0; } #pdfContent .' + ObjectType + '.pdf { width: 8.5in }</style>';

			// add rest of styles
			pdfContent += pdfCSS;
			//jQuery('#css').html();
			// add pdf content and remove from DOM
			pdfContent += '</head><body><div class="' + ObjectType + ' pdf">' + jQuery('#pdfContent').html() + '</div></body></html>';
			jQuery('#pdfContent').remove();

			// save pdf to server
			Visualforce.remoting.Manager.invokeAction( controller + '.savePDF', parentId, pdfContent, function(result, event) {
				if (result == null) {
					window.location.href='/' + parentId;
					return;
				}

				if (result.indexOf('ERROR:') == -1) {
					// generate pdf on server
					Visualforce.remoting.Manager.invokeAction( controller + '.generatePDF', parentId, result, function(result2, event) {
						// redirect to download
						if (result2.indexOf('ERROR:') == -1) {
							window.location.href = '/servlet/servlet.FileDownload?file=' + result2;
						}

						pdfButton.find('.loadpdf').hide();
						pdfButton.find('.printpdf').show();
						pdfButton.removeClass('creating');
					}, 'false');
				}
			}, 'false');
		});
		$('.evaluators').find('.refresh-button').click();
		$('.decisionStages').trigger('refreshDepend');
		$('.currentPSCF').trigger('refreshDepend');
		$('.commonalities').trigger('refreshDepend');
		// show pdf creation button after all bindings set and page loaded
		pdfButton.show();
	}
}

// all DOM changes must be done on visible elements or else height/widht won't calculate properly
function editDOM(callback) {
	var oppWrapper = jQuery('.' + ObjectType + ''),
		isHidden = oppWrapper.hasClass('hidden');

	if (isHidden) {
		jQuery('.loader').hide();
		oppWrapper.removeClass('hidden');
	}

	if (typeof(callback) == 'function') {
		callback();
	}

	if (isHidden) {
		oppWrapper.addClass('hidden');
		jQuery('.loader').show();
	}
}