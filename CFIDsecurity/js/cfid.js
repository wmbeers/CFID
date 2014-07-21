/// <reference path="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.5-vsdoc.js"/>
/// <reference path="jquery-ui.js" />
/// <reference path="../Scripts/knockout-2.3.0.debug.js" />
/// <reference path="../Scripts/knockout.validation.debug.js" />


function openRecord(issueID) {
    if (issueID == null) {
        //occurs when this function is called from the identify results dialog, which doesn't have an easier
        //way of passing the issue ID. So, we just retreive it from the esripopup dialog via regex
        //the issue ID is in the title, e.g. Issue #: 1234 (i of n)
        var title = jQuery(".esriPopup .title").html();
        var rx = /Issue #: (\d+)/;
        var m = rx.exec(title);
        issueID = m[1];
    }
    var data = "{IssueId: " + issueID + "}";
    jQuery.ajax({
        "type": "POST",
        "url": "FilterData.asmx/GetRecordByIssueId",
        "contentType": "application/json; charset=utf-8",
        "data": data,
        "dataType": "json",
        "success": function (data) {
            RootViewModel.cfidRecord(new CFIDRecord(data.d));
            jQuery("#editDialog").dialog("option", "title", "Edit Record #" + RootViewModel.cfidRecord().IssueID);
            openEditDialog();
        }, // end success callback function,
        error: function (e) {
            alert("Error opening record: " + e.responseText);
        }
    });
}

$(document).ready(function () {
    ko.applyBindingsWithValidation(RootViewModel);
});

var RootViewModel = {
    cfidRecord: ko.observable(),
    county: ko.observableArray(["Citrus","Hernando","Hillsborough","Manatee","Pasco","Pinellas","Polk","Sarasota"]),
    freightNeed: ko.observableArray(["Capacity", "Maintenance", "Operational", "Safety/Security"]),
    issueExtent: ko.observableArray(["Corridor", "Specific Location"]),
    source: ko.observableArray(["Consultant", "FDOT", "Freight Provider", "Hotspot Survey",
                                "MPO/Local Gov't", "Study Team/Screening", "Other Source", "Screening Reports"]),
    priority: ko.observableArray(["High", "Low"]),
    implementationEase: ko.observableArray(["Easy", "Moderate", "Difficult"]),
    lookupArrays: {
        Capacity: ["Left Turn Lane Length", "Queue Length", "Right Turn Lane Length", "Number of Lanes", "Other Capacity Issues"],
        Maintenance: ["Drainage/Ponding", "Railroad Crossing Replacement", "Substandard Pavement", "Other Maintenance Issues"],
        Operational: ["Access Management – median openings, driveways", "Add New Signal", "Line of Sight", "Signage – navigational/directional", "Signal Timing / Design", "Stop Bar Modification", "Turn Radii", "Other Operational Issues"],
        "Safety/Security": ["Operational Safety", "Parking/Staging", "Lane Width", "Bridge Structure", "Physical Security", "Other Safety/Security Issues"]
    },
    transportSystem: ko.observableArray(["NHS","Off System - Local Road","On System - State Road","Regional Freight Mobility Corridor","SIS Connector","SIS Corridor"]),
    freightSystem: ko.observableArray(["Freight Activity Center Street","Freight Distribution Route","Limited Access Facility","Regional Freight Mobility Corridor"]),
    improvementStage: ko.observableArray(["Issue Identified","Issue Field Verified","Strategy","Identified","Accepted/Assigned to Work Program","Improvement in Progress","Completed"]),

    constraints: ko.observableArray(["Yes","No","Not Available"])

//    filterCategories: ko.observableArray([]) //Not used, but could be someday
//        {"Label": "foo", "FieldName": "bar",
//            "Values": ko.observableArray([
//                { "Value": "val1", "Label": "text1"},
//                { "Value": "val2", "Label": "text2"}])
//        },
//        { "Label": "yadda", "FieldName": "YADDA",
//            "Values": ko.observableArray([
//                { "Value": "val1", "Label": "text1" },
//                { "Value": "val2", "Label": "text2"}])
//        }])



};

function openEditDialog() {

    jQuery("#editDialog").dialog("open");
    jQuery("#editDialog label").not(".noblock").not(".jqb").addClass("block");
    jQuery("#selectFromMapButton").button();
}


RootViewModel.addRecord = function () {
    RootViewModel.cfidRecord(new CFIDRecord());
    jQuery("#editDialog").dialog("option", "title", "Editing New Record");
    openEditDialog();
}

function CFIDRecord(m) {
    m = m || {};
    var self = this;

    this.IssueID = m.IssueID || 0;
    this.COUNTY = ko.validatedObservable(m.COUNTY).extend({required: true});
    this.CORRIDOR = ko.validatedObservable(m.CORRIDOR).extend({ required: true });
    this.ISSUE_EXTENT = ko.validatedObservable(m.ISSUE_EXTENT, "Specific Location").extend({ required: true });
    this.SITE_LOCATION = ko.validatedObservable(m.SITE_LOCATION).extend({ required: true });
    this.SEGMENT_TO = ko.observable(m.SEGMENT_TO);
    this.SEGMENT_FROM = ko.observable(m.SEGMENT_FROM);
    this.islNWcorner = ko.observable(m.islNWcorner);
    this.islNEcorner = ko.observable(m.islNEcorner);
    this.islSWcorner = ko.observable(m.islSWcorner);
    this.islSEcorner = ko.observable(m.islSEcorner);
    this.islNBapproach = ko.observable(m.islNBapproach);
    this.islSBapproach = ko.observable(m.islSBapproach);
    this.islEBapproach = ko.observable(m.islEBapproach);
    this.islWBapproach = ko.observable(m.islWBapproach);
    this.islNorthLegMedian = ko.observable(m.islNorthLegMedian);
    this.islSouthLegMedian = ko.observable(m.islSouthLegMedian);
    this.islWestLegMedian = ko.observable(m.islWestLegMedian);
    this.islEastLegMedian = ko.observable(m.islEastLegMedian);
    this.islNBlanes = ko.observable(m.islNBlanes);
    this.islSBlanes = ko.observable(m.islSBlanes);
    this.islEBlanes = ko.observable(m.islEBlanes);
    this.islWBlanes = ko.observable(m.islWBlanes);
    this.FREIGHT_NEED = ko.validatedObservable(m.FREIGHT_NEED).extend({ required: true });
    this.ISSUE_DESCRIPTION = ko.validatedObservable(m.ISSUE_DESCRIPTION).extend({ required: true });
    this.PRIORITY = ko.validatedObservable(m.PRIORITY).extend({ required: true });
    this.EASE = ko.validatedObservable(m.EASE).extend({ required: true });
    this.ROWCONSTRAINT = ko.observable(m.ROWCONSTRAINT).extend({ required: true });
    this.UTILITYCONSTRAINT = ko.observable(m.UTILITYCONSTRAINT).extend({ required: true });
    this.LIGHTPOLECONSTRAINT = ko.observable(m.LIGHTPOLECONSTRAINT).extend({ required: true });
    this.SIGNAGECONSTRAINT = ko.observable(m.SIGNAGECONSTRAINT).extend({ required: true });
    this.STRUCTURECONSTRAINT = ko.observable(m.STRUCTURECONSTRAINT).extend({ required: true });
    this.OTHERCONSTRAINT = ko.observable(m.OTHERCONSTRAINT).extend({ required: true });
    this.FieldVerified = ko.observable(m.FieldVerified);
    this.YearRecommended = ko.validatedObservable(m.YearRecommended).extend({ required: true, digit: true }); // minLength: 4, maxLength: 4, <--Doesn't work, because YearRecommended is an integer, validation function tries to use the length property of a string on it.
    this.ROADWAYID = ko.validatedObservable(m.ROADWAYID).extend({ required: true, minLength: 8, maxLength: 8, digit: true });
    this.BEGMP = ko.validatedObservable(m.BEGMP).extend(
        { required:
            { "message": "Begin Milepost is required for Corridors",
                "onlyIf": function () {
                    //console.log("BegMP required: " + self.ISSUE_EXTENT() == "Corridor");
                    return self.ISSUE_EXTENT() == "Corridor";
                }
            }, number: true
        });
        this.ENDMP = ko.validatedObservable(m.ENDMP).extend({ required:
            { "message": "End Milepost is required for Corridors",
                "onlyIf": function () {
                    //console.log("EndMP required: " + self.ISSUE_EXTENT() == "Corridor");
                    return self.ISSUE_EXTENT() == "Corridor";
                }
            }, number: true
        });
    this.SECONDRDWYID = ko.validatedObservable(m.SECONDRDWYID).extend({ required: false, minLength: 8, maxLength: 8, digit: true });
    this.LOCMP = ko.observable(m.LOCMP);
    this.Xdd = ko.validatedObservable(m.Xdd).extend(
        { required:
                { "message": "Longitude is required for Specific Locations",
                    "onlyIf": function () {
                        return self.ISSUE_EXTENT() == "Specific Location";
                    }
                }, number: true
        });
    this.Ydd = ko.validatedObservable(m.Ydd).extend(
        { required:
            { "message": "Latitude is required for Specific Locations",
                "onlyIf": function () {
                    return self.ISSUE_EXTENT() == "Specific Location";
                }
            }, number: true
        });
    this.TRANSPORT_SYSTEM = ko.validatedObservable(m.TRANSPORT_SYSTEM).extend({ required: true });
    this.FREIGHT_SYSTEM = ko.validatedObservable(m.FREIGHT_SYSTEM).extend({ required: true });
    this.FIELD_OBS = ko.validatedObservable(m.FIELD_OBS); // changed to nvarchar max, no limit .extend({maxLength: 255});
    this.RECOMMENDATION_DESC = ko.validatedObservable(m.RECOMMENDATION_DESC); // changed to nvarchar max, no limit .extend({maxLength: 255});
    this.COMMENTS = ko.validatedObservable(m.COMMENTS); // changed to nvarchar max, no limit .extend({ maxLength: 255 }); ;
    this.IMPRVMNT_STAGE = '';
    this.SOURCE = ko.validatedObservable(m.SOURCE).extend({ required: true});
    //this.DATE_MODIFIED = '';
    this.MISC_INFO = '';

    this.issueDescriptions = ko.computed(function () {
        return RootViewModel.lookupArrays[self.FREIGHT_NEED()] || [];
    });

    this.isSpecificLocation = ko.computed(function () {
        return self.ISSUE_EXTENT() == "Specific Location";
    });

    this.isCorridor = ko.computed(function () {
        return self.ISSUE_EXTENT() == "Corridor";
    });

    //TODO: this needs to be replaced by method that writes directly to feature classes
    this.commitChanges = function () {
        if (self.canSave()) {

            var data = "{'cfidRecord':" + ko.toJSON(RootViewModel.cfidRecord()) + "}";
            //console.log(data);

            jQuery.ajax({
                "type": "POST",
                "url": "FilterData.asmx/SaveRecord",
                "contentType": "application/json; charset=utf-8",
                "data": data,
                "dataType": "json",
                "success": function (data) {
                    //RootViewModel.cfidRecord(new CFIDRecord(data.d[0])); //read back into local object, will now have the new ID
                    jQuery("#editDialog").dialog("close");
                    //TODO: better confirmation? alerts are so annoying
                    alert("Saved Record #" + data.d.IssueID);
                }, // end success callback function,
                "error": function (e) {
                    alert("Error saving record: " + e.responseText);
                }
            });


        } else {
            alert("You must fix errors on the form");
        }

    };
    this.cancelChanges = function () {
        jQuery("#editDialog").dialog("close");
    };

    this.canSave = ko.computed(function () {
        var _isValid = true;
        for (var property in self) {
            if (self.hasOwnProperty(property) && property != "canSave") {
                if (self[property].hasOwnProperty("isValid")) {
                    if (!self[property].isValid()) {
                        //console.log("cannot save because " + property + " is invalid");
                        return false;
                    }
                }
            }
        }
        //console.log("can save");
        return true;
    });

    //loops through all validatedObservable properties and calls the 
    //valueHasMutated method to force the display of error messages. Call this prioer to
    //saving to update the UI
    this.forceValidationDisplay = function () {
        for (var property in self) {
            if (self.hasOwnProperty(property)) {
                if (self[property].hasOwnProperty("isValid")) {
                    self[property].valueHasMutated();
                }
            }
        }
    };

    this.dialogOptions = ko.computed(function () {
        var o = {};
        o.title = self.IssueID == 0 ? "New Record" : "Edit Record #" + self.IssueID;
        o.buttons = [{ text: "Save", click: self.commitChanges, disabled: !self.canSave() },
            { text: "Cancel", click: self.cancelChanges}];
        return o;
    });


//    this.canSaveSubscription = this.canSave.subscribe(function (newValue) {
//        console.log("canSaveSubscription " + newValue);
//        jQuery("#editDialog").dialog("option", "buttons", [
//            { text: "Save", click: self.commitChanges, disabled: !newValue },
//            { text: "Cancel", click: self.cancelChanges }
//        ]);
//    });
}


CFIDRecord.prototype.toJSON = function () {
    var copy = ko.toJS(this); //easy way to get a clean copy
   
    delete copy.issueDescriptions;
    delete copy.isSpecificLocation;
    delete copy.isCorridor;
    delete copy.canSave;
    delete copy.dialogOptions;

    return copy; //return the copy to be serialized
};

function selectFromMap() {
    dojo.disconnect(clickHandler);
    if (jQuery("#selectFromMapButton").is(":checked"))
        clickHandler = dojo.connect(map, "onClick", getLatLong);
    else
        clickHandler = dojo.connect(map, "onClick", identify);
}

function getLatLong(evt) {
    map.graphics.clear();

    //switch back to identify
    dojo.disconnect(clickHandler);
    clickHandler = dojo.connect(map, "onClick", identify);

    jQuery("#selectFromMapButton").prop("checked", false);
    //workaround to a jQuery bug that keeps it looking pressed and not updating the style
    jQuery("label[for='selectFromMapButton']").removeClass("ui-state-active").attr("aria-pressed", false);


    var symbol = new esri.symbol.SimpleMarkerSymbol().setStyle(esri.symbol.SimpleMarkerSymbol.STYLE_DIAMOND);

    map.graphics.add(new esri.Graphic(evt.mapPoint, symbol));

    // transforming point coordinates
    var mp = esri.geometry.webMercatorToGeographic(evt.mapPoint);
    RootViewModel.cfidRecord().Xdd(mp.x);
    RootViewModel.cfidRecord().Ydd(mp.y);

}

//thanks to http://stackoverflow.com/questions/9233176/unique-ids-in-knockout-js-templates/9235013
ko.bindingHandlers.uniqueId = {
    init: function(element) {
        element.id = ko.bindingHandlers.uniqueId.prefix + (++ko.bindingHandlers.uniqueId.counter);
    },
    counter: 0,
    prefix: "unique"
};

ko.bindingHandlers.uniqueFor = {
    init: function(element, valueAccessor) {
        var after = ko.bindingHandlers.uniqueId.counter + (ko.utils.unwrapObservable(valueAccessor()) === "after" ? 0 : 1);
          element.setAttribute("for", ko.bindingHandlers.uniqueId.prefix + after);
    } 
};

//standalone scripts
//Opens the "more info" dialog to display the full record in a jQuery Dialog, called from either the 
//identify dialog or the data table. When called from the datatable, issueID will be populated.
function openMoreInfo(issueID) {
    if (issueID == null) {
        //occurs when this function is called from the identify results dialog, which doesn't have an easier
        //way of passing the issue ID. So, we just retreive it from the esripopup dialog via regex
        //the issue ID is in the title, e.g. Issue #: 1234 (i of n)
        var title = jQuery(".esriPopup .title").html();
        var rx = /Issue #: (\d+)/;
        var m = rx.exec(title);
        issueID = m[1];
    }
    jQuery("#issueIds").val(issueID);
    jQuery("#ViewRecordsForm").submit();
}

function openReport() {
    var issueIds = jQuery("#tableDiv").data("issueIds");

    jQuery("#issueIds").val(issueIds);
    jQuery("#ViewRecordsForm").submit();
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

            if (!filters.hasOwnProperty(fieldName)) {
                filters[fieldName] = new Array();
            }
            filters[fieldName].push(fieldValue);

        }
    });



    var definitionExpression = "ARCHIVED = 0";
    jQuery.each(filters, function (key, value) {
        definitionExpression = definitionExpression + " AND (";

        definitionExpression = definitionExpression + key + " in ('" + value.join("','") + "')";

        if (jQuery.inArray("<null>", value) >= 0)
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
    var pointIds = jQuery("#tableDiv").data("pointObjectIds");
    var lineIds = jQuery("#tableDiv").data("lineObjectIds");
    
    //bail if the dialog isn't open
    if (jQuery("#tableDiv").dialog("isOpen") == false) {
        //console.log("attribute table is not open, nothing to refresh");
        return;
    }

    //reset the table's data
    jQuery("#attributeTable").dataTable().fnClearTable();
    jQuery("#tableDiv").data("issueIds", []);

    //if pointIDs is null and lineIDs is not null, just query lines
    //if lineIDs is null and pointIDs is not null, just query points
    //if both not null, query both
    //if both null, do nothing
    var hasPoints = (pointIds != null && pointIds.length > 0);
    var hasLines = (lineIds != null && lineIds.length > 0);
    if (hasPoints && hasLines) {
        //initiate the query for all records
        var query = new esri.tasks.Query();
        query.returnGeometry = false;
        query.objectIds = pointIds;
        cfidPointLayer.queryFeatures(query, function (featureSet) {
            addRecords(featureSet, "p");
            query.objectIds = lineIds;
            cfidLineLayer.queryFeatures(query, function (featureSet2) {
                addRecords(featureSet2, "l");
                esri.hide(dojo.byId("status"));
            });
        });
    } else if (hasPoints) {
        //query points only
        //initiate the query for all records
        var query = new esri.tasks.Query();
        query.returnGeometry = false;
        query.objectIds = pointIds;
        cfidPointLayer.queryFeatures(query, function (featureSet) {
            addRecords(featureSet, "p");
        });
    } else if (hasLines) {
        //query lines only
        var query = new esri.tasks.Query();
        query.returnGeometry = false;
        query.objectIds = lineIds;
        cfidLineLayer.queryFeatures(query, function (featureSet2) {
            addRecords(featureSet2, "l");
            esri.hide(dojo.byId("status"));
        });
    } else {
        //do nothing
    }
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
             a.IssueID, a.SITE_LOCATION, a.COUNTY, a.PRIORITY, a.FREIGHT_NEED,
             a.FIELD_VERIFIED == 0 ? "Yes" : "No",
             "Zoom", "More", "Edit", featureClassCode, a.OBJECTID]);
        jQuery("#tableDiv").data("issueIds").push(a.IssueID); //stores list of all issue IDs shown in table, so it can be passed to a full report
    }
    jQuery("#attributeTable").dataTable().fnAddData(data);

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



