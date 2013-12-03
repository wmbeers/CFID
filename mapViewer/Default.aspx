<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Default.aspx.vb" Inherits="mapViewer_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>CFID Map Viewer</title>
    <link rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/dojo/dijit/themes/claro/claro.css" />
    <link rel="stylesheet" href="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/js/esri/css/esri.css" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/flick/jquery-ui.css" />
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
            margin-left: 0;
            margin-right: 0;
            margin-top: 0;
            margin-bottom: 0;
            float: right;
            width: 80%;
        }
        
        #filterOptionsDiv
        {
            margin-left: 0;
            margin-top: 0;
            margin-bottom: 20;
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
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script type="text/javascript" src="scripts/jQuery.dataTables.js"></script>
    <script src="../Scripts/knockout-2.3.0.js" type="text/javascript"></script>
    <script src="../Scripts/knockout.validation.debug.js" type="text/javascript"></script>
    <script src="../Scripts/knockout-jQueryUI-Bindings.js" type="text/javascript"></script>
    <script type="text/javascript" src="../js/cfid.js"></script>
    <script type="text/javascript" src="http://serverapi.arcgisonline.com/jsapi/arcgis/3.5/"></script>
    <script type="text/javascript">
        dojo.require("esri.map");
        dojo.require("esri.layers.FeatureLayer");
        dojo.require("esri.tasks.query");
        dojo.require("esri.toolbars.draw");



        //initialize global variables that will be referenced in various functions
        //map = the map itself
        //tableDialog = popup dialog for displaying tabular results
        //cfidPointLayer = dynamic CFID points layer shown in the map
        //cfidLineLayer = dynamic CFID line layer shown in the map
        //infoTemplate = ESRI InfoTemplate object applied to displaying info window for identified features
        //identifyParams = ESRI IdentifyParams object used in the identify function
        //toolBar = ESRI drawing toolbar (not shown, but used for drawing features on map)
        //clickHandler = reference to dojo-connected map click handler, disconnected and reconnected depending on active tools--usually identify but can be the getlatlong tool
        var map, tableDialog, cfidPointLayer, cfidLineLayer, infoTemplate, identifyParams, toolBar, clickHandler;


        //Called after page load is complete to initialize map, dialogs, identify task, etc.
        function init() {

            //Initialize dynamic layers
            cfidPointLayer = new esri.layers.FeatureLayer("http://webgis.ursokr.com/arcgis/rest/services/TAL/cfidsde/MapServer/0",
                    {
                        mode: esri.layers.FeatureLayer.MODE_SNAPSHOT,
                        outFields: ["SITE_LOCATION", "COUNTY", "PRIORITY", "FREIGHT_NEED", "FIELD_VERIFIED"]
                    }
                );

            cfidLineLayer = new esri.layers.FeatureLayer("http://webgis.ursokr.com/arcgis/rest/services/TAL/cfidsde/MapServer/1",
                    {
                        mode: esri.layers.FeatureLayer.MODE_SNAPSHOT,
                        outFields: ["SITE_LOCATION", "COUNTY", "PRIORITY", "FREIGHT_NEED", "FIELD_VERIFIED"]
                    }
                );

            cfidPointLayer.setDefinitionExpression("ARCHIVED = 0");
            cfidLineLayer.setDefinitionExpression("ARCHIVED = 0");


            //Set up symbology for dynamic CFID layers
            var lineSymbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
                new dojo.Color([0, 190, 12]), 3);

            var borderSymbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
                new dojo.Color([0, 190, 12]), 2);

            var pointSymbol =
                new esri.symbol.SimpleMarkerSymbol(esri.symbol.SimpleMarkerSymbol.STYLE_CIRCLE, 10,
                borderSymbol,
                new dojo.Color([0, 255, 12]));

            cfidPointLayer.setRenderer(new esri.renderer.SimpleRenderer(pointSymbol));
            cfidLineLayer.setRenderer(new esri.renderer.SimpleRenderer(lineSymbol));


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
            moreInfoLink = dojo.create("a", {
                "class": "action",
                "innerHTML": "More Info",
                "onClick": "openMoreInfo()",
                "href": "javascript:void(0)"
            }, dojo.query(".actionList", map.infoWindow.domNode)[0]);


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
            map.addLayer(cfidLineLayer, 1);


            //Add onClick handler to do custom identify task
            clickHandler = dojo.connect(map, "onClick", identify);

            //create identify tasks and setup parameters
            identifyTask = new esri.tasks.IdentifyTask("http://webgis.ursokr.com/arcgis/rest/services/TAL/cfidsde/MapServer");
            identifyParams = new esri.tasks.IdentifyParameters();
            identifyParams.tolerance = 6;
            identifyParams.returnGeometry = false;
            identifyParams.layerIds = [0, 1];
            identifyParams.layerOption = esri.tasks.IdentifyParameters.LAYER_OPTION_ALL;
            identifyParams.width = map.width;
            identifyParams.height = map.height;

            //create the Info Window template, applied to features identified in the identify function
            infoTemplate = new esri.InfoTemplate("Issue #: ${OID}",
                "<table><tr><th>District</th><td>${FDOT_District}</td></tr>" +
                "<tr><th>County</th><td>${COUNTY}</td></tr>" +
                "<tr><th>Corridor</th><td>${CORRIDOR}</td></tr>" +
                "<tr><th>Extent</th><td>${ISSUE_EXTENT}</td></tr>" +
                "<tr><th>Site Location</th><td>${SITE_LOCATION}</td></tr>" +
                "<tr><th>U.S. Road</th><td>${USROAD}</td></tr>" +
                "<tr><th>State Road</th><td>${STATEROAD}</td></tr>" +
                "<tr><th>Local Road</th><td>${LOCALROAD}</td></tr>" +
                "<tr><th>To</th><td>${SEGMENT_TO}</td></tr>" +
                "<tr><th>From</th><td>${SEGMENT_FROM}</td></tr>" +
                "<tr><th>Issue Location</th><td>${ISSUESITELOC}</td></tr>" +
                "<tr><th>Freight Need</th><td>${FREIGHT_NEED}</td></tr>" +
                "<tr><th>Issue Description</th><td>${ISSUE_DESCRIPTION}</td></tr>" +
                "<tr><th>Corridor Segment</th><td>${CORRIDOR_SEGMENT}</td></tr>" +
                "<tr><th>Priority</th><td>${PRIORITY}</td></tr>" +
                "<tr><th>Implementation Ease</th><td>${EASE}</td></tr>" +
                "<tr><th colspan='2' style='border-bottom: 1px solid'>Constraints</th></tr>" +
                "<tr><th>ROW</th><td>${ROWCONSTRAINT}</td></tr>" +
                "<tr><th>Utility</th><td>${UTILITYCONSTRAINT}</td></tr>" +
                "<tr><th>Light Pole</th><td>${LIGHTPOLECONSTRAINT}</td></tr>" +
                "<tr><th>Signage</th><td>${SIGNAGECONSTRAINT}</td></tr>" +
                "<tr><th>Structure</th><td>${STRUCTURECONSTRAINT}</td></tr>" +
                "<tr><th>Other</th><td>${OTHERCONSTRAINT}</td></tr>" +
                "<tr><th colspan='2' style='border-top: 1px solid'>&nbsp;</th></tr>" +
                "<tr><th>Field Verified</th><td>${FIELD_VERIFIED}</td></tr>" +
                "<tr><th>Date Recommended</th><td>${DATE_RECOMMENDED}</td></tr>" +
                "<tr><th>Transport System</th><td>${TRANSPORT_SYSTEM}</td></tr>" +
                "<tr><th>Freight System</th><td>${FREIGHT_SYSTEM}</td></tr>" +
                "<tr><th colspan='2'>Field Observations</th></tr>" +
                "<tr><td colspan='2'>${FIELD_OBS}</td></tr>" +
                "<tr><th colspan='2'>Reccomendation</th></tr>" +
                "<tr><td colspan='2'>${RECOMMENDATION_DESC}</td></tr>" +
                "<tr><th colspan='2'>Comments</th></tr>" +
                "<tr><td colspan='2'>${COMMENTS}</td></tr>" +
                "<tr><th>Improvement Stage</th><td>${IMPRVMNT_STAGE}</td></tr>" +
                "<tr><th>Source</th><td>${SOURCE}</td></tr>" +
                "<tr><th>Date Modified</th><td>${DATE_MODIFIED}</td></tr>" +
                "</table>");


            //bind click event handler to all checkboxes that appear in the filterOptions Div. Note that
            //these aren't yet added to the DOM, but jQuery "on" deals with that nicely
            jQuery("#filterOptions").on("click", "input[type='checkbox']", function (event) {
                updateFilter();
            });

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
                                "<input type='checkbox' value='" + filterLabelValue.Value + "' name='" + filterObject.FieldName + "' id='cb" + i + "'/>" +
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
            dojo.connect(cfidLineLayer, "onUpdateEnd", function (evt) {
                jQuery("#filterOptions input[type=checkbox]").removeAttr("disabled");
            });

            dojo.connect(cfidPointLayer, "onUpdateEnd", function (evt) {
                jQuery("#filterOptions input[type=checkbox]").removeAttr("disabled");
            });

            //tablular results dialog
            jQuery("#tableDiv").dialog({
                "autoOpen": false,
                "height": 250,
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

            jQuery("#spatialFilterOption input").on("click", refreshObjectIds);

            jQuery("#attributeTable").dataTable({
                bLengthChange: false,
                bInfo: "",
                bPaginate: false,
                fnRowCallback: function (nRow, aData, iDisplayIndex) {
                    //add ZoomTo link
                    //console.log("processing row for event #" + aData[0] + " at display index " + iDisplayIndex);
                    var zoomLink = "<a href='javascript:void(0);' onclick='zoomTo(" + aData[0] + ", \"" + aData[9] + "\");'>Zoom</a>";
                    //console.log(zoomLink);
                    $('td:eq(6)', nRow).html(zoomLink);
                    var moreLink = "<a href='javascript:void(0);' onclick='openMoreInfo(" + aData[0] + ");'>More</a>";
                    $('td:eq(7)', nRow).html(moreLink);
                    var editLink = "<a href='javascript:void(0);' onclick='openRecord(" + aData[0] + ");'>Edit</a>";
                    $('td:eq(8)', nRow).html(editLink);

                }
            });

            //console.log("***********" + jQuery("#selectFromMapButton").length);
            jQuery("#selectFromMapButton").button();

            jQuery("button, #selectFromMapButton, #drawAreaButton").button();


            jQuery("#spatialFilterOption").buttonset();


            //openRecord(1450);
        } // end init

        function initToolbar() {
            toolBar = new esri.toolbars.Draw(map);
            dojo.connect(toolBar, "onDrawEnd", addGraphic);


        }

        function toggleDrawArea() {
            if (jQuery("#drawAreaButton").is(":checked")) {
                toolBar.activate(esri.toolbars.Draw.FREEHAND_POLYGON);
            } else {
                toolBar.deactivate();
            }

        }

        function addGraphic(geometry) {
            toolBar.deactivate();
            jQuery("#drawAreaButton").prop("checked", false);
            //workaround to a jQuery bug that keeps it looking pressed and not updating the style
            jQuery("label[for='drawAreaButton']").removeClass("ui-state-active").attr("aria-pressed", false);

            //enable area-of-interest spatial filter option
            jQuery("#spatialFilterOptionAOI").button("enable");
            
            //add graphic to map
            map.graphics.clear();
            var outLineSymbol = new esri.symbol.SimpleLineSymbol(esri.symbol.SimpleLineSymbol.STYLE_SOLID,
                new dojo.Color([120, 190, 12]), 3);
            var fillSymbol = new esri.symbol.SimpleFillSymbol(esri.symbol.SimpleFillSymbol.STYLE_SOLID, outLineSymbol,
                new dojo.Color([120, 190, 12, 0.25]));
            map.graphics.add(new esri.Graphic(geometry, fillSymbol));

            //update table
            refreshObjectIds();
        };


        function clearMap() {
            //disable area-of-interest spatial filter option
            jQuery("#spatialFilterOptionAOI").button("disable");
            jQuery("#spatialFilterOptionMap").attr("checked", "checked");
            //jQuery("label[for='drawAreaButton']").removeClass("ui-state-active").attr("aria-pressed", false);

            map.graphics.clear();
            refreshObjectIds();
        }

        //call init function when page is fully loaded and dojo initialized
        dojo.ready(init);

        //Opens the "more info" dialog to display the full record in a jQuery Dialog
        function openMoreInfo(issueID) {
            if (issueID == null) {
                //surely there's a better way to get the issue ID...
                //the object ID is in the title, e.g. Issue #: 1234 (i of n)
                var title = jQuery(".esriPopup .title").html();
                var rx = /Issue #: (\d+)/;
                var m = rx.exec(title);
                issueID = m[1];
            }
            var url = "fullRecord.aspx?OID=" + issueID;

            jQuery("<div></div>").load(url, function () {
                jQuery(this).dialog({ width: 700, title: "Issue #" + issueID });
            });

        }

        //handles click event to initiate identify task
        function identify(evt) {
            //console.log("identify");
            identifyParams.geometry = evt.mapPoint;
            identifyParams.mapExtent = map.extent;
            identifyParams.layerDefinitions = [];
            identifyParams.layerDefinitions[0] = cfidPointLayer.getDefinitionExpression();
            identifyParams.layerDefinitions[2] = cfidLineLayer.getDefinitionExpression();

            var deferred = identifyTask.execute(identifyParams);

            deferred.addCallback(function (response) {
                //console.log(response);
                // response is an array of identify result objects    
                // Let's return an array of features.
                return dojo.map(response, function (result) {
                    //console.log(result);
                    var feature = result.feature;
                    feature.attributes.layerName = result.layerName;
                    feature.setInfoTemplate(infoTemplate);
                    return feature;
                });
            });


            // InfoWindow expects an array of features from each deferred
            // object that you pass. If the response from the task execution 
            // above is not an array of features, then you need to add a callback
            // like the one above to post-process the response and return an
            // array of features.
            map.infoWindow.setFeatures([deferred]);
            map.infoWindow.show(evt.mapPoint);
        }



        //handles click events on checkboxes to dynamically update the definition expression of the map layers
        function updateFilter() {
            //disable checkboxes temporarily
            jQuery("#filterOptions input[type=checkbox]").attr("disabled", "disabled");

            var filters = {};
            //get a list of all clicked checkboxes
            jQuery("#filterOptions input[type=checkbox]:checked").each(function () {
                var cb = jQuery(this);
                var fieldName = cb.attr('name');
                var fieldValue = cb.val();

                if (fieldName.indexOf("CONSTRAINT") > 0) {
                    //The six constraint options are handled differently, these are a series of six
                    //individual columns with "Yes" / "No" values.
                    filters[fieldName] = new Array();
                    filters[fieldName].push('Yes');
                } else {

                    if (!filters.hasOwnProperty(fieldName))
                        filters[fieldName] = new Array();

                    filters[fieldName].push(fieldValue);
                }
            });

            var definitionExpression = "ARCHIVED = 0";
            jQuery.each(filters, function (key, value) {
                definitionExpression = definitionExpression + " AND (";

                definitionExpression = definitionExpression + key + " in ('" + value.join("','") + "')";
                
                if (jQuery.inArray("<null>",value) >= 0)
                    definitionExpression = definitionExpression + " OR " + key + " is null";
                definitionExpression = definitionExpression + ")"
            });


            //assign to definition expression property of layers, will dynamically refresh the map to only show
            //features that match
            //console.log("*************setting layer definitionExpression to " + definitionExpression);
            cfidPointLayer.setDefinitionExpression(definitionExpression);
            cfidLineLayer.setDefinitionExpression(definitionExpression);

            //store query for later user
            jQuery("#tableDiv").data("definitionExpression", definitionExpression);



            //update the table
            refreshObjectIds();

        }

        function refreshObjectIds() {
            //console.log("refreshing object Ids");

            //get the saved query
            //why not just pass to this function, you say? because we won't always be doing this in response to changing filter options
            var definitionExpression = jQuery("#tableDiv").data("definitionExpression");
            if (definitionExpression == null || definitionExpression == "") definitionExpression = "ARCHIVED = 0"; 

            //query our two layers for the objectIds.
            var query = new esri.tasks.Query();

            var spatialFilterOption = getSpatialFilterOption();
            if (spatialFilterOption == "map") {
                query.geometry = map.extent;
            } else if (spatialFilterOption == "aoi") {
                query.geometry = map.graphics.graphics[0].geometry;
            }

            //console.log("using spatial filter option " + spatialFilterOption);
            //console.log("using definition expression " + definitionExpression);
            query.where = definitionExpression;

            //console.log(query.where);

            //execute queries and store results
            //the point layer is queried first, then in the callback function the line layer is queried
            //this keeps things tidily ordered. Only after the line layer query is done do we refresh the table
            cfidPointLayer.queryIds(query, function (objectIds) {
                jQuery("#tableDiv").data("pointObjectIds", objectIds);
                cfidLineLayer.queryIds(query, function (objectIds) {
                    jQuery("#tableDiv").data("lineObjectIds", objectIds);
                    refreshTable();
                });
            });
        }

        function refreshTable() {
            //console.log("refreshing table");
            //get the full list of object IDs as one unified set
            var objectIds = jQuery("#tableDiv").data("pointObjectIds");
            objectIds.concat(jQuery("#tableDiv").data("lineObjectIds"));


            //bail if the dialog isn't open
            if (jQuery("#tableDiv").dialog("isOpen") == false) {
                //console.log("attribute table is not open, nothing to refresh");
                return;
            }

            //reset the table's data
            //jQuery("#attributeTableBody").html("");
            jQuery("#attributeTable").dataTable().fnClearTable();


            //initiate the query for all records
            var query = new esri.tasks.Query();
            query.returnGeometry = false;
            query.objectIds = jQuery("#tableDiv").data("pointObjectIds");
            cfidPointLayer.queryFeatures(query, function (featureSet) {
                addRecords(featureSet, "p");
                query.objectIds = jQuery("#tableDiv").data("lineObjectIds");
                cfidLineLayer.queryFeatures(query, function (featureSet2) {
                    addRecords(featureSet2, "l");
                    esri.hide(dojo.byId("status"));
                });
            });
        }

        //        
        //        function showExtent() {
        //            alert('new esri.geometry.Extent({ "xmin": ' + map.extent.xmin + ', "ymin": ' + map.extent.ymin + ', "xmax": ' + map.extent.xmax + ', "ymax": ' + map.extent.ymax + ', "spatialReference": { "wkid": ' + map.extent.spatialReference.wkid + ' });');
        //        }

        //appends records from the selected featureset to the tableData array
        function addRecords(featureSet, featureClassCode) {
            var data = [];
            for (var i = 0; i < featureSet.features.length; i++) {
                var a = featureSet.features[i].attributes;
                data.push([
                     a.OBJECTID, a.SITE_LOCATION, a.COUNTY, a.PRIORITY, a.FREIGHT_NEED,
                     a.FIELD_VERIFIED == 0 ? "Yes" : "No",
                     "Zoom", "More", "Edit", featureClassCode]);
            }
            jQuery("#attributeTable").dataTable().fnAddData(data);

            //            dojo.forEach(featureSet.features, function (entry, i) {
            //                //var zoomLink = jQuery("<a href='javascript:void(0);'>").on("click", function () { zoomTo(entry) }).html("Zoom");
            //                //var moreInfoLink = ""; //TODO

            //                var a = entry.attributes;
            //                var idx = 


            //                //var tr = jQuery("#attributeTable tr td:first-child:contains('" + a.OID + "')").parent();
            //                //var zoomCell = jQuery('td:nth-child(7)', tr);
            //                //zoomCell.html("").append(zoomLink);

            //                //                var tr = jQuery("<tr></tr>").appendTo("#attributeTableBody");
            //                //                tr.append("<td>" + entry.attributes.OID + "</td>");
            //                //                tr.append("<td>" + entry.attributes.SITE_LOCATION + "</td>");
            //                //                tr.append("<td>" + entry.attributes.COUNTY + "</td>");
            //                //                tr.append("<td>" + entry.attributes.PRIORITY + "</td>");
            //                //                tr.append("<td>" + entry.attributes.FREIGHT_NEED + "</td>");
            //                //                tr.append("<td>" + (entry.attributes["FIELD_VERIFIED"] == 0 ? "Yes" : "No") + "</td>");
            //                //                var zoomLink = jQuery("<a href='javascript:void(0);'>").on("click", function () { zoomTo(entry) }).html("Zoom");
            //                //                tr.append("<td></td>").append(zoomLink);
            //                //                tr.append("<td><a href='javascript:void(0);' onclick='moreInfo(" + entry.attributes.OID + ");return false;'>More</a></td>");
            //            });
        }

        function zoomTo(oid, featureClassCode) {
            var featureClass = cfidPointLayer;
            if (featureClassCode == "l") featureClass = cfidLineLayer;

            //initiate the query for the record
            var query = new esri.tasks.Query();
            query.returnGeometry = true;
            query.objectIds = [oid];
            featureClass.queryFeatures(query, function (featureSet) {
                zoomToFeature(featureSet.features[0]);
            });
        }

        function zoomToFeature(feature) {
            if (feature.geometry.type == "point")
                map.centerAndZoom(feature.geometry, 17);
            else
                map.setExtent(feature.geometry.getExtent().expand(1.5));
        }

        function showTable() {
            esri.show(dojo.byId("status"));
            jQuery("#tableDiv").dialog("open");
        }

        function resetFilters() {
            jQuery("#filterOptions input[type=checkbox]").removeAttr("checked");
            updateFilter();
        }

        function showDebug() {
            jQuery("#debugDialog").dialog("open");
        }

        function getSpatialFilterOption() {
            var spatialFilterOption = jQuery("#spatialFilterOption input:checked").val();
            if (spatialFilterOption == "aoi" & map.graphics.graphics.length == 0) {
                //default to map if no drawn area; shouldn't happen...
                spatialFilterOption = "map";
            }
            return spatialFilterOption;
        }






    </script>
</head>
<body>
    <script id="errorTemplate" type="text/html">
    <span style="height: 30px" data-bind="if: !field.isValid() && field.isModified()">
        <img src="../images/error.png" data-bind='attr: { title: field.error }' />
    </span>
    </script>
    <div id="container">
        <div id="filterOptionsDiv">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/logo.jpg" />
            <div id="filterOptions">
            </div>
            <div id="controls">
                <button id="resetButton" onclick="resetFilters(); return false;" title="Click to clear all attribute filters and show all records">Clear Filters</button>
                <br />
                <button id="showTableButton" onclick="showTable(); return false;" title="Click to show a table of visible features in the current extent">
                    Show Table</button>
               
                <br />
                <button data-bind="click: addRecord" title="Click to add a new record">
                    Add Record</button>
               
                    <script language="javascript" type="text/javascript">
                        function test() {
                            alert(jQuery('label[for="CORRIDOR"]').length);
                        }
                    
                    </script>

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
                                Priority
                            </th>
                            <th>
                                Need
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
                            <th>Edit</th>
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

                <label for="SITE_LOCATION">Segment Location</label>
                <input type="text" id="SITE_LOCATION" data-bind="value:SITE_LOCATION" title="Descriptive value representing exact location of improvement (US 19 and 54 Ave. North).<br/>Max Characters=100" /><br />

                <label for="CORRIDOR">Corridor Name</label>
                <input type="text" id="CORRIDOR" data-bind="value:CORRIDOR" /><br />
            
                <label for="SEGMENT_FROM">From</label>
                <input type="text" id="SEGMENT_FROM" data-bind="value:SEGMENT_FROM" title="Descriptive value of start of Freight Corridor. Only use when referencing a Freight Corridor Screening Report corridor, (ex. US 19)." /><br />

                <label for="SEGMENT_TO">To</label>
                <input type="text" id="SEGMENT_TO" data-bind="value:SEGMENT_TO" title="Descriptive value of end of Freight Corridor. Only use when referencing a Freight Corridor Screening Report corridor, (ex. US 19)." /><br />

            </fieldset>

            
            <label for="ISSUE_EXTENT">Issue Extent</label>
            <select id="ISSUE_EXTENT" data-bind="options: $root.issueExtent, value:ISSUE_EXTENT" title="Specific Location: Refers to site specific issue, such as an intersection imrpovement. Corridor: Refers to an improvement recommended for an entire corridor, such as a safety, capacity, or maintenance improvement."></select><br />
            
            <label for="FREIGHT_NEED">Freight Need</label>
            <select id="FREIGHT_NEED" data-bind="options: $root.freightNeed, optionsCaption: '-Select a value-', value:FREIGHT_NEED"></select><br />
            
            <label for="ISSUE_DESCRIPTION">Issue Description</label>
            <select id="ISSUE_DESCRIPTION" data-bind="options: issueDescriptions, optionsCaption: '-Select a value-', value:ISSUE_DESCRIPTION"></select><br />
            
            <label for="SOURCE">Collection Source</label>
            <select id="SOURCE" data-bind="options: $root.source, optionsCaption: '-Select a value-', value:SOURCE" ></select><br />
            
            <!--TODO: County--auto-populate based on location?-->
            
            <input type="checkbox" id="FIELD_VERIFIED" data-bind="checked: FieldVerified" />
            <label for="FIELD_VERIFIED" class="noBlock">Field Verified</label><br />
            
            <label for="YEAR">Year Recommended</label>
            <input type="text" id="YEAR" data-bind="value:YearRecommended" title="4-digit year when improvement recommended" /><br />

            <label for="PRIORITY">Priority</label>
            <select id="PRIORITY" data-bind="options: $root.priority, optionsCaption: '-Select a value-', value:PRIORITY"></select><br />
            
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
                    <select id="OtherConstraint" data-bind="value: OTHERCONSTRAINT, options: $root.constraints, optionsCaption: '-Select a value-'"></select>
                </span>            
            </fieldset>

            <label for="TRANSPORT_SYSTEM">Transportation System</label>
            <select id=TRANSPORT_SYSTEM" data-bind="options: $root.transportSystem, optionsCaption: '-Select a value-', value:TRANSPORT_SYSTEM"></select><br />

            <label for="FREIGHT_SYSTEM">Freight System</label>
            <select id="FREIGHT_SYSTEM" data-bind="options: $root.freightSystem, optionsCaption: '-Select a value-', value:FREIGHT_SYSTEM"></select><br />

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

                <span data-bind="visible: isCorridor">
                    <label for="BEGMP">Begin Milepost</label>
                    <input type="text" id="BEGMP" data-bind="value:BEGMP" title="Beginning Milepost of Corridor (Only use if defining a corridor improvement. use up to 3 decimal places, ex. 2.135)" /><br />

                    <label for="ENDMP">End Milepost</label>
                    <input type="text" id="ENDMP" data-bind="value:ENDMP" title="Ending Milepost of Corridor (Only use if defining a corridor improvement. use up to 3 decimal places, ex. 2.135)" />
                </span>
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

            <label for="RECOMMENDATION_DESC">Recommendation Description</label>
            <textarea rows="5" cols="80" id="RECOMMENDATION_DESC" data-bind="value:RECOMMENDATION_DESC" title="Details regarding the description of the recommended improvement Add recommendation from source"></textarea><br />

            <label for="FIELD_OBS">Field Notes</label>
            <textarea rows="5" cols="80" id="FIELD_OBS" data-bind="value:FIELD_OBS" title="Field Observations noted from the source records."></textarea><br />


            <label for="COMMENTS">Comments</label>
            <textarea rows="5" cols="80" id="COMMENTS" data-bind="value:COMMENTS" title="Comments about the Specific Location or Corridor."></textarea><br />

    </div>
</body>
</html>
