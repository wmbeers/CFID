/// <reference path="knockout-2.3.0.debug.js" />
/// <reference path="jquery-2.0.2.js" />
/// <reference path="jquery-ui-1.10.3.js" />
/// 
///<summary>
/// This sets up custom binding handlers in Knockout that will create and control jQueryUI widgets.
/// The usage is simple add the handler (typically named jq[Widget name]) to the data-bind attribute
/// with an object that would be structurally similar to the options object of the widget as the value.
/// Note that the individual options can each also be data bound. For example:
/// <button data-bind="jqButton: { disabled: formHasErrors }, click: save">Save</button>
/// 
/// Refer to http://www.jqueryui.com for more information about each widget.
///</summary>

ko.afterInitialBindingCallbacks = []

ko.afterInitialBindingTrigger = function () {
    for (var i = 0; i < ko.afterInitialBindingCallbacks.length; i++) {
        ko.afterInitialBindingCallbacks[i]();
    }
    ko.afterInitialBindingCallbacks = [];
}

ko.bindingHandlers.jqAccordion = {
    init: function (element, valueAccessor) {
        //var e = element;
        //ko.afterInitialBindingCallbacks.push(function () {
        //    $(e).accordion("option", "active", 0);
        //});
        $(element).accordion(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).accordion("option", valueAccessor()).accordion("refresh");
    }
};

ko.bindingHandlers.jqAutocomplete = {
    init: function (element, valueAccessor) {
        $(element).autocomplete(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).autocomplete("option", valueAccessor());
    }
};

ko.bindingHandlers.jqButton = {
    init: function (element, valueAccessor) {
        $(element).button(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).button("option", valueAccessor());
    }
};

ko.bindingHandlers.jqDatepicker = {
    init: function (element, valueAccessor) {
        $(element).datepicker(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).datepicker("option", valueAccessor());
    }
};

ko.bindingHandlers.jqDialog = {
    init: function (element, valueAccessor) {
        $(element).dialog(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).dialog("option", valueAccessor());
    }
};

ko.bindingHandlers.jqMenu = {
    init: function (element, valueAccessor) {
        $(element).menu(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).menu("option", valueAccessor());
    }
};

ko.bindingHandlers.jqProgressbar = {
    init: function (element, valueAccessor) {
        $(element).progressbar(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).progressbar("option", valueAccessor());
    }
};

ko.bindingHandlers.jqSlider = {
    init: function (element, valueAccessor) {
        $(element).slider(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).slider("option", valueAccessor());
    }
};

ko.bindingHandlers.jqSortable = {
    init: function (element, valueAccessor) {
        $(element).sortable(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).sortable("option", valueAccessor());
    }
}

ko.bindingHandlers.jqSpinner = {
    init: function (element, valueAccessor) {
        $(element).spinner(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).spinner("option", valueAccessor());
    }
};

ko.bindingHandlers.jqTabs = {
    init: function (element, valueAccessor) {
        $(element).tabs(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).tabs("option", valueAccessor()).tabs("refresh");
    }
};

ko.bindingHandlers.jqTooltip = {
    init: function (element, valueAccessor) {
        $(element).tooltip(valueAccessor());
    },
    update: function (element, valueAccessor) {
        $(element).tooltip("option", valueAccessor());
    }
};

