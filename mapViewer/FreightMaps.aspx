<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FreightMaps.aspx.vb" Inherits="mapViewer_FreightMaps" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Freight Moves Tampa Bay Map Viewer</title>
    <link rel="stylesheet" href="https://js.arcgis.com/3.7/js/esri/css/esri.css" />
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.10.3/themes/flick/jquery-ui.css" />
    <link rel="Stylesheet" href="css/jquery.dataTables.css" />
    <link rel="stylesheet" href="agsjs/css/agsjs.css" />
    <style type="text/css">
        html, body, #container, #mapDiv, #leftBarDiv
        {
            font-family: Verdana, Arial, sans-serif;
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
        
        #leftBarDiv
        {
            margin-left: 0;
            margin-top: 0;
            margin-bottom: 20px;
            width: 20%;
            float: left;
            background-color: #E3F4FD;
            overflow: auto;
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
    <script src="../Scripts/knockout-2.3.0.js" type="text/javascript"></script>
    <script src="../Scripts/knockout.validation.debug.js" type="text/javascript"></script>
    <script src="../Scripts/knockout-jQueryUI-Bindings.js" type="text/javascript"></script>
    <script type="text/javascript">
        var djConfig = {
            paths: {
                "agsjs": location.pathname.replace(/\/[^/]+$/, "") + '/agsjs'
            }
        };
    </script>
    <script type="text/javascript" src="https://js.arcgis.com/3.7/"></script> <!--NOTE: it's very important that djConfig is defined before referencing js.arcgis.com-->
    <script type="text/javascript">
        var map, freightMap, toc, identifyParams, toolBar, clickHandler;
        
        require(["dojo/_base/connect",
			 "dojo/dom", "dojo/parser","dojo/on", "dojo/_base/Color",
			 "esri/map",
			 "esri/geometry/Extent", 
			 "esri/layers/FeatureLayer",
			 "esri/layers/ArcGISTiledMapServiceLayer", 
			 "esri/layers/ArcGISDynamicMapServiceLayer",
			 "esri/symbols/SimpleFillSymbol",
			 "esri/renderers/ClassBreaksRenderer",
			 "agsjs/dijit/TOC", 
			 "dijit/layout/BorderContainer", 
			 "dijit/layout/ContentPane", 
			 "dojo/fx", "dojo/domReady!"], function (connect, dom, parser, on, Color,
			 Map, Extent, FeatureLayer, ArcGISTiledMapServiceLayer, ArcGISDynamicMapServiceLayer,
			 SimpleFillSymbol, ClassBreaksRenderer,
			 TOC) {

			     parser.parse();

			     map = new esri.Map("mapDiv", {
			         extent: new esri.geometry.Extent({ "xmin": -9353446.277197964, "ymin": 3101203.111585402, "xmax": -8942520.813137054, "ymax": 3380656.8869958716, "spatialReference": { "wkid": 102100 } }),
			         nav: true,
			         sliderStyle: "large",
			         basemap: "gray"
			     });

			     map.showZoomSlider();



			     //Hides the loading message 
			     dojo.connect(map, "onUpdateEnd", function () {
			         esri.hide(dojo.byId("status"));
			     });

			     //Shows the loading message when the map update process begins
			     dojo.connect(map, "onUpdateStart", function () {
			         esri.show(dojo.byId("status"));
			     });

			     //Initialize dynamic layers
			     var imageParameters = new esri.layers.ImageParameters();
			     //imageParameters.layerOption = esri.layers.ImageParameters.LAYER_OPTION_SHOW;
			     //imageParameters.transparent = true;

			     //TODO: point to correct service, and add any parameters
			     freightMapServiceLayer = new esri.layers.ArcGISDynamicMapServiceLayer(
                     "http://webgis.ursokr.com/arcgis/rest/services/TAL/FreightMovesTampaBay2/MapServer",
                     {"imageParameters": imageParameters}
                 );

			     toc = new TOC({
			         map: map,
			         layerInfos: [{
			             layer: freightMapServiceLayer, title: ""
			         }]
			     }, 'tocDiv');
			     toc.startup();
                 
			     //Add layer to map
			     map.addLayer(freightMapServiceLayer);

			 });

        
        
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
                    //TODO feature.setInfoTemplate(infoTemplate);
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
    </script>
</head>
<body>
    <div id="container">
        <div id="leftBarDiv">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/images/FDOTLogo.png" />
            <h2>Interactive Freight Maps</h2>
            <div id="tocDiv"></div>
        </div>
        <div id="mapDiv">
        </div>
        <span id="status" style="position: absolute; z-index: 1000; right: 5px; top: 5px;">Loading...
        </span>
    </div>
</body>
</html>
