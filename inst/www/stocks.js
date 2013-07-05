Ext.onReady(function() {
	
	var today = new Date();
	
    var treePanel = new Ext.tree.TreePanel({
    	id: 'tree-panel',
		iconCls: 'chartIcon',
    	title: 'by Index',
    	region: 'center',
    	title: "stocks",
        height: 300,
        border: false,
        autoScroll: true,
		lazyRender:true,
        animate: true,
        containerScroll: true,
		enableDrag: true,
		dragConfig: {ddGroup: 'DragDrop' },
		autoWidth: true,
        
        // tree-specific configs:
        rootVisible: false,
        lines: false,
        singleExpand: true,
        useArrows: true,
		store: {
	        root: {
	            expanded: true
	        }
	    },
	    listeners: {
	    	itemdblclick: function(s, r){
	    		if(r.data.leaf){
	    			addWorkspace(r.data.id.substring(7));
	    		}
	        }
	    }	    
    });	
    
	var myToolbar = Ext.create('Ext.toolbar.Toolbar', {
		"items" :['->',{
			text:"Smooth Plot", 
			id: "graphTypeBtn",
			iconCls: 'chartIcon',
			menu:{
				defaults: {
					handler : function(btn) {
						Ext.getCmp("graphTypeBtn").setText(btn.text);
					}, 
				},
				id: 'currentGraphType',
				items:[{
					text:"Smooth Plot",
					group: 'graphType',
					checked: true,
					value: 'S'
				},{
					text:"High/Low Plot",
					group: 'graphType',
					checked: false,
					value: 'H'
				}]
			}
		}, {
			text: 'From 2013-01-01',
			id: 'startdatetext',
			iconCls: 'calendarIcon',
			menu: {
				xtype: 'datemenu',
				minValue: new Date('01/01/2000'),
				id: 'startdate',
				value: new Date('01/01/2013')
			}
		}, {
			text: 'To: ' + today.getFullYear() + "-" + (today.getMonth()+1) + "-" + today.getDate(),
			id: 'enddatetext',
			iconCls: 'calendarIcon',			
			menu: {
				xtype: 'datemenu',
				minValue: new Date('01/01/2000'),
				id: 'enddate',
				value: new Date()
			}
		}]
	});

	var workspacePanel = new Ext.TabPanel({
		activeTab: 0,
		createTab: addWorkspace,
		id: 'workspace-panel',
		region: 'center',
		margins: '2 5 5 0',	
        height: 350,
		border: false,		
		tabPosition: 'bottom',
		items: [{
			iconCls: 'chartIcon',
			closable: false,
			title: "Help",
			border: false,
			html : "Help help"		
		}],
		listeners: {
			"tabchange" : function(tabPanel, newtab){
				updatemenu();
			}
		},
		tbar: myToolbar	
	});
	
	var detailsPanel = Ext.Panel({
		id: 'details-panel',
        split: true,      
        height: 205,
        minSize: 150,   
        title: 'Details',
		region: 'south',		
        bodyStyle: 'padding-bottom:15px;background:#eee;',
		html: '<p class="details-info">When you select a company from the menu, some details will display here.</p>'
    });	

	new Ext.Viewport({
		id : 'viewport',
		layout : 'border',
		items : [ {
			layout : 'border',
			id : 'layout-browser',
			region : 'west',
            border: false,
            split:true,
            margins: '2 0 5 5',
            width: 290,
            minSize: 100,
            maxSize: 500,
			items : [ treePanel, detailsPanel ]
		}, workspacePanel ],
		renderTo : Ext.getBody()
	});
	
	function updatestart(date){
		var dd = date.getDate();
		var mm = date.getMonth()+1;
		var yyyy = date.getFullYear();					
		Ext.getCmp("startdatetext").setText("From: " + yyyy + "-" + mm + "-" + dd);
		Ext.getCmp('workspace-panel').getActiveTab().data.start = date;		
	}
	
	function updateend(date){
		var dd = date.getDate();
		var mm = date.getMonth()+1;
		var yyyy = date.getFullYear();					
		Ext.getCmp("enddatetext").setText("To: " + yyyy + "-" + mm + "-" + dd);
		Ext.getCmp('workspace-panel').getActiveTab().data.end = date;			
	}
	
	Ext.getCmp("startdate").picker.on("select", function(picker, date){
		updatestart(date);
		loadplot();
	});
	
	Ext.getCmp("enddate").picker.on("select", function(picker, date){
		updateend(date);
		loadplot();
	});	
	
	function addWorkspace(symbol){
		workspacePanel.add({
			iconCls: 'chartIcon',
			closable: true,
			title: symbol,
			border: false,
			data : {
				type : Ext.getCmp("graphTypeBtn").getText(),
				start : Ext.getCmp("startdate").picker.value,
				end : Ext.getCmp("enddate").picker.value
			}
		}).show();
		loadplot();
    }
	
	function updatemenu(){
		var data = Ext.getCmp('workspace-panel').getActiveTab().data;
		if(data){
			//Ext.getCmp("graphTypeBtn").setText(data.type);
			Ext.getCmp("startdate").picker.setValue(data.start);
			Ext.getCmp("enddate").picker.setValue(data.end);
			updatestart(data.start);
			updateend(data.end);
		}
	}
	
	function loadplot(){
		var symbol = Ext.getCmp('workspace-panel').getActiveTab().title;
		var from = Ext.getCmp("startdatetext").getText().substring(5);
		var to = Ext.getCmp("enddatetext").getText().substring(3);
		var id = Ext.getCmp('workspace-panel').getActiveTab().el.id;
		$("#" + id + "-innerCt").r_fun_plot("smoothplot", {ticker:symbol, from:from, to:to});
	}
	
	function loadtree(){
		ocpu.r_fun_call("listbyindustry", {}, function(location){
			Ext.getCmp("tree-panel").getStore().setProxy({
				type: "ajax",
				url: location + "R/.val/json"
			});
			Ext.getCmp("tree-panel").getStore().load();
		});
	}
	
	
	//init
	loadtree();

});