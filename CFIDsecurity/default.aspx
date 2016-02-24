<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="mapViewer_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>CFID Map Viewer</title>
    <link rel="stylesheet" href="https://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/dojo/dijit/themes/claro/claro.css" />
    <link rel="stylesheet" href="https://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/esri/css/esri.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/flick/jquery-ui.css" />
    <link rel="Stylesheet" href="css/jquery.dataTables.css" />
    <style type="text/css">
        html, body, #container, #mapDiv, #filterOptionsDiv
        {
            padding: 0;
            height: 100%;
        }
        
        html, body, #container
        {
            margin: 0;
            font-size: 8pt;
        }
        
        #mapDiv
        {
            margin: 0;
            float: right;
            width: 80%;
        }
        
        #filterOptionsDiv
        {
            margin-left: 0;
            margin-top: 0;
            margin-bottom: 20px;
            width: 20%;
            float: left;
            background-color: #E3F4FD;
            overflow: auto;
        }
        
        #grid
        {
            height: 375px;
            width: 750px;
        }
        
        
        #filterOptions
        {
            margin: 5px;
        }
        
        #editDialog 
        {
            width: 450px;
            height: 450px;
        }
        
        #editDialog label.block 
        {
            display: block;
            font-weight: bold;
        }
        
        #editDialog label.noBlock
        {
            display:inline;
            font-weight: bold;
        }
        
        #editDialog input[type='text'], #editDialog select, #editDialog textarea
        {
            width: 95%;
            margin-bottom: 5px;
        }
        
        #editDialog fieldset input[type='text'], #editDialog fieldset select
        {
            margin-bottom: 5px;
        }
        
        fieldset
        {
            margin-bottom: 5px;
            margin-right: 5%
        }
        
        
        /*CSS to style the loading text*/
        #status
        {
            background-color: black;
            color: white;
            padding: 3px;
            border: solid 1px white;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
        }
        
        .esriPopup TH
        {
            text-align: left;
        }
    </style>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript" src="scripts/jQuery.dataTables.js"></script>
    <script src="Scripts/knockout-2.3.0.js" type="text/javascript"></script>
    <script src="Scripts/knockout.validation.debug.js" type="text/javascript"></script>
    <script src="Scripts/knockout-jQueryUI-Bindings.js" type="text/javascript"></script>
    <script type="text/javascript" src="js/cfid.js"></script>
    <script type="text/javascript" src="https://serverapi.arcgisonline.com/jsapi/arcgis/3.5/"></script>
    <script type="text/javascript">
        
        dojo.require("esri.map");
        dojo.require("esri.layers.FeatureLayer");
        dojo.require("esri.tasks.query");
        dojo.require("esri.toolbars.draw");
        dojo.require("esri.toolbars.edit");
        dojo.require("esri.geometry.Geometry");
        dojo.require("esri.geometry.Point");
        dojo.require("esri.geometry.Polyline");
        dojo.require("dojo._base.event");
        dojo.require("dojo.on");
        dojo.require("dojo.dom");

        var canEdit = <% =CanEdit.ToString().ToLower() %>;

        //initialize global variables that will be referenced in various functions
        //map = the map itself
        //tableDialog = popup dialog for displaying tabular results
        //cfidPointLayer = dynamic CFID points layer shown in the map
        //infoTemplate = ESRI InfoTemplate object applied to displaying info window for identified features
        //identifyParams = ESRI IdentifyParams object used in the identify function
        //toolBar = ESRI drawing toolbar (not shown, but used for drawing features on map)
        //clickHandler = reference to dojo-connected map click handler, disconnected and reconnected depending on active tools--usually identify but can be the getlatlong tool
        var map, tableDialog, cfidPointLayer, infoTemplate, identifyParams, toolBar, clickHandler;


        //Called after page load is complete to initialize map, dialogs, identify task, etc.
        function init() {

            //Initialize dynamic layers
            //TODO: for editing, use cfidPointLayer = new esri.layers.FeatureLayer("https://webgis.ursokr.com/arcgis/rest/services/TAL/cfid_provisional/FeatureServer/0",
            //cfidPointLayer = new esri.layers.FeatureLayer("https://207.150.177.36:6080/arcgis/rest/services/cfidmaster/MapServer/0",
            // REAL SERVER FOR LIVE USE 
            cfidPointLayer = new esri.layers.FeatureLayer("https://webgis.ursokr.com/arcgis/rest/services/TAL/cfid4/MapServer/0",
                    {
                        mode: esri.layers.FeatureLayer.MODE_SNAPSHOT,
                        outFields: ["IssueID", "SITE_LOCATION", "COUNTY", "FIELD_VERIFIED"]
                    }
                );

            cfidPointLayer.setDefinitionExpression("ARCHIVED = 0");

            var borderSymbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
                new dojo.Color([0, 190, 12]), 2);

            var pointSymbol =
                new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 10,
                borderSymbol,
                new dojo.Color([0, 255, 12]));

            cfidPointLayer.setRenderer(new esri.renderer.SimpleRenderer(pointSymbol));

            //Initialize the map
            map = new esri.Map("mapDiv", {
                extent: new esri.geometry.Extent({ "xmin": -9353446.277197964, "ymin": 3101203.111585402, "xmax": -8942520.813137054, "ymax": 3380656.8869958716, "spatialReference": { "wkid": 102100} }),
                nav: true,
                sliderStyle: "large",
                basemap: "streets"
            });
            map.showZoomSlider();
            dojo.connect(map, "onLoad", initToolbar);

            //Add link to display full record to info window
            dojo.create("a", {
                "class": "action",
                "innerHTML": "More Info",
                "onClick": "openMoreInfo(event)",
                "href": "javascript:void(0)"
            }, dojo.query(".actionList", map.infoWindow.domNode)[0]);

            //Add link to edit record
            if (canEdit) {
                dojo.create("a", {
                    "class": "action",
                    "innerHTML": "Edit Record",
                    "onClick": "openRecord()",
                    "href": "javascript:void(0)"
                }, dojo.query(".actionList", map.infoWindow.domNode)[0]);

                //Add link to edit map
                dojo.create("a", {
                    "class": "action",
                    "id" : "editMapBtn",
                    "innerHTML": "Edit Map",
                    "onClick": "initEditing(event)",
                    "href": "javascript:void(0)"
                }, dojo.query(".actionList", map.infoWindow.domNode)[0]);
            }

            //Hides the loading message and calls function to update the list of object IDs matching current filter options within the current map extent
            dojo.connect(map, "onUpdateEnd", function () {
                esri.hide(dojo.byId("status"));
                refreshObjectIds();
            });

            //Shows the loading message when the map update process begins
            dojo.connect(map, "onUpdateStart", function () {
                esri.show(dojo.byId("status"));
            });


            //Add layers to map
            map.addLayer(cfidPointLayer, 0);
            
            //Add onClick handler to do custom identify task
            clickHandler = dojo.connect(map, "onClick", identify);

            //create identify tasks and setup parameters
            identifyTask = new esri.tasks.IdentifyTask("https://webgis.ursokr.com/arcgis/rest/services/TAL/cfid4/MapServer");
            identifyParams = new esri.tasks.IdentifyParameters();
            identifyParams.tolerance = 6;
            identifyParams.returnGeometry = false;
            identifyParams.layerIds = [0, 1];
            identifyParams.layerOption = esri.tasks.IdentifyParameters.LAYER_OPTION_ALL;
            identifyParams.width = map.width;
            identifyParams.height = map.height;

            //create the Info Window template, applied to features identified in the identify function
            infoTemplate = new esri.InfoTemplate("Issue #: ${IssueID}",
                "<table><tr><th>District</th><td>${FDOT_District}</td></tr>" +
                "<tr><th>County</th><td>${COUNTY}</td></tr>" +
                "<tr><th>Site Location</th><td>${SITE_LOCATION}</td></tr>" +
                "<tr><th>U.S. Road</th><td>${USROAD}</td></tr>" +
                "<tr><th>State Road</th><td>${STATEROAD}</td></tr>" +
                "<tr><th>Local Road</th><td>${LOCALROAD}</td></tr>" +
                "<tr><th>Issue Location</th><td>${ISSUESITELOC}</td></tr>" +
                "<tr><th>Issue Description</th><td>${ISSUE_DESCRIPTION}</td></tr>" +
                "<tr><th>Implementation Ease</th><td>${EASE}</td></tr>" +
                "<tr><th colspan='2' style='border-bottom: 1px solid'>Constraints</th></tr>" +
                "<tr><th>ROW</th><td>${ROWCONSTRAINT}</td></tr>" +
                "<tr><th>Utility</th><td>${UTILITYCONSTRAINT}</td></tr>" +
                "<tr><th>Light Pole</th><td>${LIGHTPOLECONSTRAINT}</td></tr>" +
                "<tr><th>Signage</th><td>${SIGNAGECONSTRAINT}</td></tr>" +
                "<tr><th>Structure</th><td>${STRUCTURECONSTRAINT}</td></tr>" +
                "<tr><th>Other</th><td>${OTHERCONSTAINT}</td></tr>" +
                "<tr><th colspan='2' style='border-top: 1px solid'>&nbsp;</th></tr>" +
                "<tr><th>Field Verified</th><td>${FIELD_VERIFIED}</td></tr>" +
                "<tr><th>Date Recommended</th><td>${DATE_RECOMMENDED}</td></tr>" +
                "<tr><th>Transport System</th><td>${TRANSPORT_SYSTEM}</td></tr>" +
                "<tr><th colspan='2'>Field Observations</th></tr>" +
                "<tr><td colspan='2'>${FIELD_OBS}</td></tr>" +
                "</table>");


            //bind click event handler to all checkboxes that appear in the filterOptions Div. Note that
            //these aren't yet added to the DOM, but jQuery "on" deals with that nicely
            jQuery("#filterOptions").on("click", "input[type='checkbox']", function (event) {
                updateFilter();
            });

            // map.on wasn't working for adding this to the map itself so letting a button call this function for now.
            jQuery("#testing").on("click", function (event) {initEditing(event);});

            //initialize filters
            //this is done client-side rather than with asp.net controls because we need the values of the checkboxes locally
            //and asp.net checkboxlist controls hide the values in viewstate
            var i = 0; //just used to give unique IDs to checkboxes

            //query database for unique values found in all fields
            //response will be an array of objects with FieldName, Label and Values properties
            //FieldName=string, use as name attribute of checkbox
            //Label = string, display as accordion header
            //Values = array of FilterLabelValue objects, representing the displayed value to show (Label) and actual value stored in the database (Value)
            jQuery.ajax({
                "type": "POST",
                "url": "FilterData.asmx/GetFilterValues",
                "contentType": "application/json; charset=utf-8",
                "dataType": "json",
                "success": function (data) {
                    //console.log("Adding filter values");
                    //iterate through each filter object
                    for (var f = 0; f < data.d.length; f++) {
                        var filterObject = data.d[f];
                        //console.log(filterObject.Label);

                        //append header with "friendly" name
                        jQuery("#filterOptions").append("<h3>" + filterObject.Label + "</h3>");

                        //create container for content under header
                        var valuesDiv = jQuery("<div></div>").appendTo("#filterOptions");

                        //append a checkbox for each unique value found in this field
                        for (var j = 0; j < filterObject.Values.length; j++) {
                            var filterLabelValue = filterObject.Values[j];
                            i++; //increment the counter used to give unique IDs to checkboxes
                            valuesDiv.append(
                                "<input type='checkbox' value='" + filterLabelValue.Value + "' name='" + filterObject.FieldName + "' id='cb" + i + "' />" +
                                "<label for='cb" + i + "'>" + filterLabelValue.Label + "</label><br />");
                        } //end loop through filter object values
                    } // end loop through filter objects array

                    //Initialize filter pane "accordion" layout
                    jQuery("#filterOptions").accordion({ heightStyle: "content" });
                }, // end success callback function,
                error: function (e) {
                    alert("Error loading filters: " + e.responseText);
                }
            });     //end ajax call


            //onUpdateEnd handlers re-enable filter checkboxes after layers are done refreshing
            dojo.connect(cfidPointLayer, "onUpdateEnd", function (evt) {
                jQuery("#filterOptions input[type=checkbox]").removeAttr("disabled");
            });
            
            //tablular results dialog
            jQuery("#tableDiv").dialog({
                "autoOpen": false,
                "height": 350,
                "width": 800,
                "open": function (event, ui) {
                    refreshObjectIds();
                },
                "buttons": [{ "text": "Ok", click: function () { $(this).dialog("close"); } }]
            });

            jQuery("#editDialog").dialog({
                "autoOpen": false,
                "height": 450,
                "width": 450,
                "buttons": [
                    {
                        "text": "Save",
                        "id": "saveButton",
                        click: function () {
                            RootViewModel.cfidRecord().forceValidationDisplay();
                            RootViewModel.cfidRecord().commitChanges();
                        }
                    },
                    {
                        "text": "Cancel",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }]
            });

            jQuery("#loginDiv").dialog({
                "autoOpen": false,
                "height": 250,
                "width": 400,
                "open": function (event, ui) {
                    refreshObjectIds();
                },
                "buttons": [{ "text": "Ok", click: function () { $(this).dialog("close"); } }]
            });

            jQuery("#spatialFilterOption input").on("click", refreshObjectIds);

            jQuery("#attributeTable").dataTable({
                bLengthChange: false,
                bInfo: "",
                bPaginate: false,
                fnRowCallback: function (nRow, aData, iDisplayIndex) {
                    //add ZoomTo link, using objectID and feature type (data items 8 and 7)
                    var zoomLink = "<a href='javascript:void(0);' onclick='zoomTo(" + aData[8] + ", \"" + aData[7] + "\");'>Zoom</a>";
                    //add more info and edit links, using issueID (data item 0)
                    $('td:eq(4)', nRow).html(zoomLink);
                    var moreLink = "<a href='javascript:void(0);' onclick='openMoreInfo(" + aData[0] + ");'>More</a>";
                    $('td:eq(5)', nRow).html(moreLink);
                    var editLink = "<a href='javascript:void(0);' onclick='openRecord(" + aData[0] + ");'>Edit</a>";
                    $('td:eq(6)', nRow).html(editLink);

                }
            });

            //console.log("***********" + jQuery("#selectFromMapButton").length);
            jQuery("#selectFromMapButton").button();

            jQuery("button, #selectFromMapButton, #drawAreaButton").button();


            jQuery("#spatialFilterOption").buttonset();



            //openRecord(1450);
        } // end init


        //call init function when page is fully loaded and dojo initialized
        dojo.ready(init);




        $(document).ready(function () {
            /*$('.popup-with-form').magnificPopup({
                type: 'inline',
                preloader: false,
                focus: '#name',

                // When elemened is focused, some mobile browsers in some cases zoom in
                // It looks not nice, so we disable it:
                callbacks: {
                    beforeOpen: function () {
                        if ($(window).width() < 700) {
                            this.st.focus = false;
                        } else {
                            this.st.focus = '#name';
                        }
                    }
                }
            });*/
        });

        function toggleBasemap(basemap) {
            map.setBasemap(basemap);
        }

    </script>
</head>
<body>
    <script id="errorTemplate" type="text/html">
    <span style="height: 30px" data-bind="if: !field.isValid() && field.isModified()">
        <img src="images/error.png" data-bind='attr: { title: field.error }' />
    </span>
    </script>
    <div id="container">
        <div id="filterOptionsDiv">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo-cfid.png" />
            <div id="filterOptions">
            </div>
            <div id="controls">
                <button id="resetButton" onclick="resetFilters(); return false;" title="Click to clear all attribute filters and show all records">Clear Filters</button>
                <br />
                <button id="showTableButton" onclick="showTable(); return false;" title="Click to show a table of visible features in the current extent">
                    Show Table</button>
               
                <br />

                <!-- TEST -->
                <br />
                <button id="testing" title="Edit Map">Edit Map</button>
                <br />
                <!-- TEST -->

                <% If CanEdit And False Then 'TODO: enable adding later %>
                <button data-bind="click: addRecord" title="Click to add a new record">
                    Add Record</button>
                <br />
                <% End If%>
                <div id="userlogin"> 
                    <form id="form1" runat="server">   
                    <asp:LoginView ID="LoginView1" runat="server" ViewStateMode="Disabled">
                        <AnonymousTemplate>
                            <ul>
                                <%--<a id="registerLink" runat="server" style="color: blue; font-size: medium; font-weight: 700;"
                                    visible="false" href="~/Account/Register.aspx">Register</a>--%>
                                    <a id="A2" runat="server" style="color: blue; font-family: Arial, Helvetica, sans-serif; font-size: medium; font-size: 8pt;"
                                    href="~/help/help.htm">Help</a>
                                |
                                <a id="loginLink" runat="server" style="color: blue; font-family: Arial, Helvetica, sans-serif; font-size: medium; font-size: 8pt;"
                                    href="~/Account/Login.aspx">Log in</a>
                          
                            </ul>
                        </AnonymousTemplate>
                        <LoggedInTemplate>
                            <p style="color:black">
                                Hello, <a id="A1" style="color:black" runat="server" class="username" href="~/Account/Manage.aspx" title="Manage your account">
                                    <asp:LoginName ID="LoginName1" runat="server" CssClass="username" style="color: blue; font-size: medium; font-weight: 700;" />
                                </a>!
                                <asp:LoginStatus ID="LoginStatus1" runat="server" LogoutAction="Redirect" LogoutText="Log off" style="color:black" LogoutPageUrl="~/" />
                            </p>
                        </LoggedInTemplate>
                    </asp:LoginView>
                    </form>  
                </div><br />
                <fieldset>
                    <legend>Basemap</legend>
                    <div>
                        <input type="radio" name="basemapOption" id="basemapOptionStreets" value="streets" checked="checked" onclick="toggleBasemap('streets');"/><label for="basemapOptionStreets">Streets</label>
                        <input type="radio" name="basemapOption" id="basemapOptionSatellite" value="satellite" onclick="toggleBasemap('satellite');" /><label for="basemapOptionSatellite">Satellite</label>
                        <input type="radio" name="basemapOption" id="basemapOptionGray" value="gray" onclick="toggleBasemap('gray');" /><label for="basemapOptionGray">Gray</label>
                    </div>
                </fieldset>
                <button onclick="showDebug(); return false;" style="display: none">
                    Show Debug</button>
            </div>
            <div id="filter">
            </div>
        </div>
        <div id="mapDiv">
        </div>
        <span id="status" style="position: absolute; z-index: 1000; right: 5px; top: 5px;">Loading...
        </span>
        <div id="tableDiv" style="display: none" title="CFID Attributes">
            <span id="spatialFilterOption">
                <span>Spatial Filter:</span>
                <input type="radio" name="spatialFilterOption" id="spatialFilterOptionNone" value="none" /><label for="spatialFilterOptionNone">None (show all)</label>
                <input type="radio" name="spatialFilterOption" id="spatialFilterOptionMap" value="map" checked="checked" /><label for="spatialFilterOptionMap">Map Extent</label>
                <input type="radio" name="spatialFilterOption" id="spatialFilterOptionAOI" value="aoi" disabled="disabled" /><label for="spatialFilterOptionAOI">Drawn Area</label>
            </span>
            <label for="drawAreaButton">Draw</label><input type="checkbox" id="drawAreaButton" onclick="toggleDrawArea();" title="Click to draw an area of interest to filter results" />
            <button id="clearGraphics" onclick="clearMap();  return false;" title="Click to clear area of interest">Clear</button>
            <button id="showReport" onclick="openReport();  return false;" title="Click to view more info in a report">Report</button>
            <div style="overflow: auto">
                <table id="attributeTable">
                    <thead>
                        <tr>
                            <th>
                                Issue #
                            </th>
                            <th>
                                Site Name
                            </th>
                            <th>
                                County
                            </th>
                            <th>
                                Field Verified
                            </th>
                            <th>
                                Zoom
                            </th>
                            <th>
                                More
                            </th>
                            <%If CanEdit Then%>
                            <th>Edit</th>
                            <%End If%>
                        </tr>
                    </thead>
                    <tbody id="attributeTableBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div id="editDialog" data-bind="with: cfidRecord">
            <fieldset>
                <legend>Site Location Description</legend>

                <label for="COUNTY">County</label>
                <select id="COUNTY" data-bind="options: $root.county, optionsCaption: '-Select a value-', value:COUNTY"></select>

                <label for="SITE_LOCATION">Site Location</label>
                <input type="text" id="SITE_LOCATION" data-bind="value:SITE_LOCATION" title="Descriptive value representing exact location of improvement (US 19 and 54 Ave. North).<br/>Max Characters=100" /><br />

            </fieldset>
            
            <label for="ISSUE_DESCRIPTION">Issue Description</label>
            <select id="ISSUE_DESCRIPTION" data-bind="options: issueDescriptions, optionsCaption: '-Select a value-', value:ISSUE_DESCRIPTION"></select><br />
            
            <label for="SOURCE">Collection Source</label>
            <select id="SOURCE" data-bind="options: $root.source, optionsCaption: '-Select a value-', value:SOURCE" ></select><br />
            
            <!--TODO: County--auto-populate based on location?-->
            
            <input type="checkbox" id="FIELD_VERIFIED" data-bind="checked: FieldVerified" />
            <label for="FIELD_VERIFIED" class="noBlock">Field Verified</label><br />
            
            <label for="YEAR">Year Recommended</label>
            <input type="text" id="YEAR" data-bind="value:YearRecommended" title="4-digit year when improvement recommended" /><br />

            <label for="EASE">Implementation Ease</label>
            <select id="EASE" data-bind="options: $root.implementationEase, optionsCaption: '-Select a value-', value:EASE"></select><br />
            
            <fieldset> 
                <legend>Issue Contraints</legend>
                <span style="float:left; width: 49%">
                    <label for="ROW">Right of Way</label>
                    <select id="ROW" data-bind="value: ROWCONSTRAINT, options: $root.constraints, optionsCaption: '-Select a value-'"></select>
            
                    <label for="UtilityConstraint">Utility</label>
                    <select id="UtilityConstraint" data-bind="value: UTILITYCONSTRAINT, options: $root.constraints, optionsCaption: '-Select a value-'"></select>
            
                    <label for="LightPoleConstraint">Light Pole</label>
                    <select id="LightPoleConstraint" data-bind="value: LIGHTPOLECONSTRAINT, options: $root.constraints, optionsCaption: '-Select a value-'"></select>

                </span>
                <span style="float: left; width: 49%">
                    <label for="SignageConstraint">Signage</label>
                    <select id="SignageConstraint" data-bind="value: SIGNAGECONSTRAINT, options: $root.constraints, optionsCaption: '-Select a value-'"></select>
            
                    <label for="StructureConstraint">Structure</label>
                    <select id="StructureConstraint" data-bind="value: STRUCTURECONSTRAINT, options: $root.constraints, optionsCaption: '-Select a value-'"></select>
            
                    <label for="OtherConstraint">Other</label>
                    <select id="OtherConstraint" data-bind="value: OTHERCONSTAINT, options: $root.constraints, optionsCaption: '-Select a value-'"></select>
                </span>            
            </fieldset>

            <label for="TRANSPORT_SYSTEM">Transportation System</label>
            <select id="TRANSPORT_SYSTEM" data-bind="options: $root.transportSystem, optionsCaption: '-Select a value-', value:TRANSPORT_SYSTEM"></select><br />

            <fieldset>
                <legend>Issue Site Location</legend>
                <span style="float:left;width:50%">
                    <input type="checkbox" id="islNWcorner" data-bind="checked: islNWcorner" />
                    <label for="islNWcorner" class="noBlock">NW corner</label><br />
                    <input type="checkbox" id="islNEcorner" data-bind="checked: islNEcorner" />
                    <label for="islNEcorner" class="noBlock">NE corner</label><br />
                    <input type="checkbox" id="islSWcorner" data-bind="checked: islSWcorner" />
                    <label for="islSWcorner" class="noBlock">SW corner</label><br />
                    <input type="checkbox" id="islSEcorner" data-bind="checked: islSEcorner" />
                    <label for="islSEcorner" class="noBlock">SE corner</label><br />
                    <br />
                    <input type="checkbox" id="islNBapproach" data-bind="checked: islNBapproach" />
                    <label for="islNBapproach" class="noBlock">NB approach</label><br />
                    <input type="checkbox" id="islSBapproach" data-bind="checked: islSBapproach" />
                    <label for="islSBapproach" class="noBlock">SB approach</label><br />
                    <input type="checkbox" id="islEBapproach" data-bind="checked: islEBapproach" />
                    <label for="islEBapproach" class="noBlock">EB approach</label><br />
                    <input type="checkbox" id="islWBapproach" data-bind="checked: islWBapproach" />
                    <label for="islWBapproach" class="noBlock">WB approach</label>
                </span>
                <span style="float:left;">
                    <input type="checkbox" id="islNorthLegMedian" data-bind="checked: islNorthLegMedian" />
                    <label for="islNorthLegMedian" class="noBlock">North leg median</label><br />
                    <input type="checkbox" id="islSouthLegMedian" data-bind="checked: islSouthLegMedian" />
                    <label for="islSouthLegMedian" class="noBlock">South leg median</label><br />
                    <input type="checkbox" id="islWestLegMedian" data-bind="checked: islWestLegMedian" />
                    <label for="islWestLegMedian" class="noBlock">West leg median</label><br />
                    <input type="checkbox" id="islEastLegMedian" data-bind="checked: islEastLegMedian" />
                    <label for="islEastLegMedian" class="noBlock">East leg median</label><br />
                    <br />
                    <input type="checkbox" id="islNBlanes" data-bind="checked: islNBlanes" />
                    <label for="islNBlanes" class="noBlock">NB lanes</label><br />
                    <input type="checkbox" id="islSBlanes" data-bind="checked: islSBlanes" />
                    <label for="islSBlanes" class="noBlock">SB lanes</label><br />
                    <input type="checkbox" id="islEBlanes" data-bind="checked: islEBlanes" />
                    <label for="islEBlanes" class="noBlock">EB lanes</label><br />
                    <input type="checkbox" id="islWBlanes" data-bind="checked: islWBlanes" />
                    <label for="islWBlanes" class="noBlock">WB lanes</label>
                </span>
            </fieldset>

            <fieldset>
                <legend>Roadway Information</legend>

                <label for="ROADWAYID">Roadway ID</label>
                <input type="text" id="ROADWAYID" data-bind="value:ROADWAYID" title="FDOT Roadway value provided in TSO basemap, 8 digits (ex.02080001 or 15060000)" /><br />

                <label for="SECONDRDWYID">Secondary Roadway ID</label>
                <input type="text" id="SECONDRDWYID" data-bind="value:SECONDRDWYID" title="FDOT Roadway value provided in TSO basemap, 8 digits (ex.02080001 or 15060000)" /><br />
            </fieldset>

            <fieldset data-bind="visible: isSpecificLocation">
                <legend>Latitude/Longitude</legend>
                <label for="Ydd">Latitude</label>
                <input type="text" id="Ydd" data-bind="value:Ydd" title="Latitude in decimal degrees (e.g. 24.4321)" /><br />

                <label for="Xdd">Longitude</label>
                <input type="text" id="Xdd" data-bind="value:Xdd" title="Longitude in decimal degrees (e.g. -82.3422)" />

                <br />
                <label for="selectFromMapButton" class="jqb">Get From Map</label><input type="checkbox" id="selectFromMapButton" onclick="selectFromMap();" />
            </fieldset>

            <label for="FIELD_OBS">Field Notes</label>
            <textarea rows="5" cols="80" id="FIELD_OBS" data-bind="value:FIELD_OBS" title="Field Observations noted from the source records."></textarea><br />

    </div>
    <form target="_blank" id="ViewRecordsForm" action="ViewRecords.aspx" method="post">
        <input type="hidden" id="issueIds" name="issueIds" />
        <input type="hidden" id="spatialFilter" name="spatialFilter" />
        <input type="hidden" id="attributeFilter" name="attributeFilter" />
    </form>

</body>
</html>
