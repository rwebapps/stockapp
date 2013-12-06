Ext.Loader.setConfig({
  disableCaching: false
});

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
      },
      itemclick : function(s, r){
        if(r.data.leaf){
          var name = r.data.text.split(" - ");
          var stock = name[0]
          var company = name[1];
          Ext.getCmp("details-panel").update('<div class="detaildiv"> <h3>' + company + '</h3> Yahoo Finance: <a target="_blank" href="http://finance.yahoo.com/q?s=' + stock + '">'+stock+'</a></div>');
        }            
      }
    }      
  });  
    
  var myToolbar = Ext.create('Ext.toolbar.Toolbar', {
    "items" :['->',{
      xtype: "combobox",
      editable: false,
        store: {
        fields: ['fun', 'name'],
          data : [
            {"fun":"smoothplot", "name":"Smooth Plot"},
            {"fun":"highlowplot", "name":"High/Low Plot"},
            {"fun":"areaplot", "name":"Area Plot"}
          ]          
        },
        queryMode: 'local',
        displayField: 'name',
        valueField: 'fun',
        value: "smoothplot",
        id: "graphtype",
        iconCls: 'chartIcon'
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
      },{
        xtype: "button",
        id: "currentBtn",
        enableToggle: true,
        text: "Toggle Current Value",
        iconCls: 'chartIcon'
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
      border: false,
      title: "Help",
      anchor: '-10, -262',
      contentEl: "helpdiv"
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
    bodyStyle: 'padding-bottom:15px;background:#eee;'
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
    Ext.getCmp("startdatetext").setText("From: " + datetostring(date));
  }
  
  function updateend(date){
    Ext.getCmp("enddatetext").setText("To: " + datetostring(date));
  }
  
  Ext.getCmp("startdate").picker.on("select", function(picker, date){
    updatestart(date);
    loadplot();
  });
  
  Ext.getCmp("enddate").picker.on("select", function(picker, date){
    updateend(date);
    loadplot();
  });  
  
  Ext.getCmp("currentBtn").on("click", function(){
    loadplot();
  });
  
  Ext.getCmp("graphtype").on("select", function(){
    loadplot();
  })  
  
  function addWorkspace(symbol){
    workspacePanel.add({
      iconCls: 'chartIcon',
      closable: true,
      title: symbol,
      border: false,
      data : {
        type : Ext.getCmp("graphtype").getValue(),
        current : Ext.getCmp("currentBtn").pressed,
        start : Ext.getCmp("startdate").picker.getValue(),
        end : Ext.getCmp("enddate").picker.getValue()
      }
    }).show();
    loadplot();
    }
  
  function updatemenu(){
    var data = Ext.getCmp('workspace-panel').getActiveTab().data;
    if(data){
      Ext.getCmp("startdate").picker.setValue(data.start);
      Ext.getCmp("enddate").picker.setValue(data.end);
      Ext.getCmp("graphtype").setValue(data.type);
      Ext.getCmp("currentBtn").toggle(data.current);      
      updatestart(data.start);
      updateend(data.end);
    }
  }
  
  function loadplot(){
    var symbol = Ext.getCmp('workspace-panel').getActiveTab().title;
    var from = Ext.getCmp("startdate").picker.getValue();
    var to = Ext.getCmp("enddate").picker.getValue()
    var type = Ext.getCmp("graphtype").getValue();
    var current = Ext.getCmp("currentBtn").pressed;
    
    //don't plot help tab
    if(symbol == "Help"){
      return;
    }
    
    //save settings in tab
    Ext.getCmp('workspace-panel').getActiveTab().data = {
      start: from,
      end: to,
      type: type,
      current: current    
    }  
    
    //request plot using OpenCPU library
    var id = Ext.getCmp('workspace-panel').getActiveTab().el.id;
    var req = $("#" + id + "-innerCt").rplot("plotwrapper", {
      ticker : symbol, 
      from : datetostring(from), 
      to : datetostring(to), 
      type : type, 
      current : current
    }).fail(function(){
      alert("Failed to plot stock: " + req.responseText)
    });
  }
  
  function datetostring(date){
    var dd = date.getDate();
    var mm = date.getMonth()+1;
    var yyyy = date.getFullYear();          
    return yyyy + "-" + mm + "-" + dd;    
  }
  
  //this function gets a list of stocks to populate the tree panel
  function loadtree(){
    var req = ocpu.rpc("listbyindustry", {}, function(data){
      Ext.getCmp("tree-panel").getStore().setProxy({
        type : "memory",
        data : data,
        reader : {
          type: "json"
        }
      });
      Ext.getCmp("tree-panel").getStore().load();
    }).fail(function(){
      alert("Failed to load stocks: " + req.responseText);
    });
  }

  //init
  loadtree();
});
