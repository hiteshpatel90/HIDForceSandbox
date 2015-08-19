 	body
        {
            font-size:62.5%;
            height:100%;
        }
        
        #header
        {
            display:block;
            font-size: 3em;
            font-family:'Trebuchet MS','Verdana','Helvetica';
            color:#0041C4;
            margin:10px 0px 10px 0px;
            font-weight:bold;
            position: relative;
        }

        .bodyDiv
        {
            background-color:#BFD4FF;
        }
        
        #wrapper
        {
            width:960px;
            margin:0px auto;
            font-family:'Trebuchet MS','Verdana','Helvetica';
        }
        
        .topPanel
        {
            
            border:2px solid #FF9200;
            background-color:#FFE4BF;
            -moz-border-radius:10px;
            -webkit-border-radius:10px;
            padding:10px;
            position:relative;   
        }
        
        .divTitle
        {
            border:2px solid #0041C4;
            background-color:#80AAFF;
            -moz-border-radius:10px;
            -webkit-border-radius:10px;
            padding:2px 0px 2px 10px;
            margin-bottom:5px;
            font-weight:bold;
            font-size:14px; 
            color:white;
        }
        
        .dataTable
        {
            border-collapse:collapse;
            font-size:12px;
            text-align:left;
            width:100%;
        }
        
        .dataTable th
        {
            border-bottom:2px solid #6678B1;
            color:#003399;
            font-size:14px;
            font-weight:normal;
            padding:10px 8px;
        }
                        
        .dataTable td
        {
            border-bottom:1px solid #CCCCCC;
            color:#666699;
            padding:6px 8px;
        }
        
        .dataTable tr:hover td
        {
            background:#EFF2FF none repeat scroll 0 0;
        }
        
        
        .labelCol
        {
            text-align:right;
            font-weight:bold;
            font-size: 12px;
            width:25%;
        }
        
        .dataCol
        {
            width:25%;
        }
        
        #askAQuestionDiv
        {
            height: 415px;
            width: 610px;
            float: left;
        }
            
        #currentIssuesDiv
        {
            width:435px;
            float:left;
        }
        
        #topSolutionsDiv
        {   
            width : 260px;
            height: 415px;
            float : right;
            overflow : auto;
        }

		#questionInfoDiv
		{
			margin-top : 10px;
		}
        
        #usersCasesDiv
        {
            float: left;
            width: 936px;
            margin-top:10px;
        }
        
        .mouseOverInfoDiv
        {
        	float: left;
            width: 300px;
            height: 125px;
            padding: 10px;
        }
        .voteDiv
        {
        	float: right;
            width: 175px;
        }
        .voteMsg
        {
        	padding: 10px;
        }
        
        .voteButton
        {
        	height: 20px;
        	width: 30px;
        	font-weight: bold;
        	font-size: 16px;
        	padding: 5px;
        }
        
        .voteButtons
        {
        	padding-top : 30px;
        	padding-left : 15px;
        	height : 50px;
        }
        
        
        
        
        .voteTitleInstr
        {
        	font-style: italic;
        }
        
        .inputTextArea
        {
        	width:90%;
        	height:100px;
        	font-size: 12px;
        }
        
        #overlay
        {
            display:none;
            position:absolute;
            top:0;
            left:0;
            width:100%;
            height:4000px;
            z-index:250;
            background-color:#333;
            -moz-opacity: 0.8;
            opacity:.80;
            filter: alpha(opacity=80);
        }
        
        #searching
        {
             font-size:2em;
             font-style:italic;
             text-transform:uppercase;
        }
        
        
        .searchResultsMessage
        {
            font-weight:bold; 
            position:relative;
            font-size: 12px;
        }
        
        .voteImg
        {
        	height: 40px;
        	width: 40px;
        	border: 1px;
        	padding: 5px;
        }
        
        #error
        {
            font-size:1.5em;
            font-style:italic;
            text-transform:uppercase;   
        }
        
        .white_content 
        {
             display: none;
             position:absolute;
             top: 33%;
             left: 25%;
             width: 50%;
             height: 35px;
             padding: 16px;
             border: 16px solid #7998D2;
             background-color: white;
             z-index:1002;
             overflow: auto;
             text-align:center;
             -moz-border-radius: 5px;
             -webkit-border-radius: 5px;      
        }
        
        #overlay[id] { position:fixed; }
        .white_content[id] { position:fixed; }