/// <reference path="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.5-vsdoc.js"/>
/// <reference path="jquery-ui.js" />
/// <reference path="../Scripts/knockout-2.3.0.debug.js" />
/// <reference path="../Scripts/knockout.validation.debug.js" />


function openRecord(objectID) {
    var data = "{OIDs: ['" + objectID + "']}";
    jQuery.ajax({
        "type": "POST",
        "url": "../mapViewer/FilterData.asmx/GetRecordsByOIDs",
        "contentType": "application/json; charset=utf-8",
        "data": data,
        "dataType": "json",
        "success": function (data) {
            RootViewModel.cfidRecord(new CFIDRecord(data.d[0]));
            jQuery("#editDialog").dialog("option", "title", "Edit Record #" + RootViewModel.cfidRecord().OID);
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

    this.OID = m.OID || 0;
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
    this.YearRecommended = ko.validatedObservable(m.YearRecommended).extend({ required: true, minLength: 4, maxLength: 4, digit: true });
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
    this.FIELD_OBS = ko.validatedObservable(m.FIELD_OBS).extend({maxLength: 255});
    this.RECOMMENDATION_DESC = ko.validatedObservable(m.RECOMMENDATION_DESC).extend({maxLength: 255});
    this.COMMENTS = ko.validatedObservable(m.COMMENTS).extend({ maxLength: 255 }); ;
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


    this.commitChanges = function () {
        if (self.canSave()) {

            var data = "{'cfidRecord':" + ko.toJSON(RootViewModel.cfidRecord()) + "}";
            //console.log(data);

            jQuery.ajax({
                "type": "POST",
                "url": "../mapViewer/FilterData.asmx/SaveRecord",
                "contentType": "application/json; charset=utf-8",
                "data": data,
                "dataType": "json",
                "success": function (data) {
                    RootViewModel.cfidRecord(new CFIDRecord(data.d[0])); //read back into local object, will now have the new ID
                    jQuery("#editDialog").dialog("close");
                    //TODO: better confirmation? alerts are so annoying
                    alert("Saved Record #" + RootViewModel.cfidRecord().OID);
                }, // end success callback function,
                error: function (e) {
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
        o.title = self.OID == 0 ? "New Record" : "Edit Record #" + self.OID;
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