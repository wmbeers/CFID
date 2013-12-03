<%@ Page Title="CFID-New Record" Language="VB" MasterPageFile="~/secure/GMwebSecure.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="false" CodeFile="NewRecord.aspx.vb" Inherits="NewRecord" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="body_part">
        <div id="body_part_left_col">
            <div class="row">
                <h1 class="add_new_executive">
                    Add New Record</h1>
            </div>
            <div id="executive_form">
                <b id="executive_form_top"></b>
                <div id="executive_form_center">
                    <div class="row">
                        <asp:Label runat="server" ID="lblMessage" />
                    </div>
                    <div class="row" style="cursor: pointer">
                        <h3>
                            Collection Information
                        </h3>
                    </div>
                      <%-- NEW FIELD CALLED DISTIRCT--%>
                  <div class="row">
                        <label class="executive_form_label light11">
                            FDOT District :</label>
                        <asp:DropDownList runat="server" ID="ddlDistrict" CssClass="executive_form_input" Visible="true" AutoPostBack="true">
                            <asp:ListItem><--Select--></asp:ListItem>
                            <asp:ListItem Text="District 1" Value="1" />
                            <asp:ListItem Text="District 7" Value="7" />
                        </asp:DropDownList> 
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>County:</b><br/>FDOT District where improvement exists. District 1 or District 7" />
                    </div>
                    <div class="row">
                        <label class="executive_form_label light11">
                            Issue Extent :</label>
                        <asp:DropDownList runat="server" ID="ddlType" CssClass="executive_form_input" AutoPostBack="true" >
                            <asp:ListItem><--Select--></asp:ListItem>
                            <asp:ListItem>Specific Location</asp:ListItem>
                             <asp:ListItem>Corridor</asp:ListItem>
                        </asp:DropDownList>
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="Information" class="toolTip" title="<b>Type of Improvement:</b><br/>Specific Location: Refers to site specific issue, such as an intersection imrpovement. Corridor: Refers to an improvement recommended for an entire corridor, such as a safety, capacity, or maintenance improvement." />                       
                    </div>
                    <%-- FIELD MOVED--%>
                  <div class="row">
                        <label class="executive_form_label light11">
                            Collection Source :</label>
                        <asp:DropDownList runat="server" ID="ddlSource" CssClass="executive_form_input"  >
                            <asp:ListItem><--Select--></asp:ListItem>
                              <asp:ListItem>Consultant</asp:ListItem>
                                <asp:ListItem>FDOT</asp:ListItem>
                                <asp:ListItem>Freight Provider</asp:ListItem>
                                <asp:ListItem>Hotspot Survey</asp:ListItem>
                                <asp:ListItem>MPO/Local Gov't</asp:ListItem>
                                <asp:ListItem>Study Team/Screening</asp:ListItem>
                        </asp:DropDownList>
                       
                    
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Source</b><br/>Name of source where data comes from (ex.Hotspot surveys, Corridor Screening reports)." />
                    </div>
                  
                    
                    <div class="row">
                        <label class="executive_form_label light11">
                            Select a County :</label>
                        <asp:DropDownList runat="server" ID="ddlCounty" CssClass="executive_form_input" >
                            <asp:ListItem><--Select--></asp:ListItem>
                            <asp:ListItem>Citrus </asp:ListItem>
                    
                            <asp:ListItem>Hernando </asp:ListItem>
                            <asp:ListItem>Hillsborough </asp:ListItem>
                            <asp:ListItem>Manatee </asp:ListItem>
                            <asp:ListItem>Pasco </asp:ListItem>
                            <asp:ListItem>Pinellas </asp:ListItem>
                            <asp:ListItem>Polk </asp:ListItem>
                            <asp:ListItem>Sarasota </asp:ListItem>
                        </asp:DropDownList>
                        
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>County:</b><br/>Name of county where improvement exists." />
                    </div>   
                   
                     <div class="row">
                        <label class="executive_form_label light11">
                            Field Verified :</label>
                     <%-- <asp:CheckBox ID="ChkboxVerified" runat="server" CssClass="executive_form_input" Checked="false"  />--%>
                           <asp:DropDownList runat="server" ID="ddlFieldVerified" CssClass="executive_form_input"  >
                               <asp:ListItem><--Select--></asp:ListItem>
                                <asp:ListItem>Yes </asp:ListItem>
                            <asp:ListItem>No </asp:ListItem>
                             </asp:DropDownList>
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>County:</b><br/>Name of county where improvement exists." />
                    </div>
                    

                     
                         <hr />
                   
                    <div class="row" style="cursor: pointer">
                        <h3>
                            Location Information
                        </h3>
                    </div>
                   <div class="row">
                        <label class="executive_form_label light11">
                            Corridor / Site Name :</label>
                        <asp:TextBox runat="server" ID="txtCorridorName" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Corridor Name:</b><br/>For improvements recommended from a Freight Corridor Screening Report. Use the name on the Corridor Screening report or other descriptive name identifier, such as US 98.<br/>Max Characters=255" />
                      <%--  <asp:RequiredFieldValidator ID="rfvCorridorName" runat="server" ErrorMessage="Please Fill Corridor Name"
                            ControlToValidate="txtCorridorName" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce1" runat="server" TargetControlID="rfvCorridorName">
                        </cc1:ValidatorCalloutExtender>
                    --%>
                    </div>


                    <div class="row">
                        <label class="executive_form_label light11">
                            Site Description :</label>
                        <asp:TextBox runat="server" ID="txtSiteLocation" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Site Location:</b><br/>Descriptive value representing exact location of improvement (US 19 and 54 Ave. North).<br/>Max Characters=100" />
                       <%-- <asp:RequiredFieldValidator ID="rfvSiteLocation" runat="server" ErrorMessage="Please Fill Site Location"
                            ControlToValidate="txtSiteLocation" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce8" runat="server" TargetControlID="rfvSiteLocation">
                        </cc1:ValidatorCalloutExtender>--%>
                    </div> 
                              

                    <div class="row">
                        <label class="executive_form_label light11">
                            Issue Site Location :</label>
                        <asp:CheckBoxList runat="server" ID="chklistIssueLoc" CssClass="executive_form_input">
                           
                             <asp:ListItem>NW corner </asp:ListItem>
                             <asp:ListItem>NE corner </asp:ListItem>
                             <asp:ListItem>SW corner </asp:ListItem>
                             <asp:ListItem>SE corner </asp:ListItem>
                             <asp:ListItem>NB approach </asp:ListItem>
                             <asp:ListItem>SB approach </asp:ListItem>
                             <asp:ListItem>EB approach </asp:ListItem>
                             <asp:ListItem>WB approach </asp:ListItem>
                             <asp:ListItem>North leg median </asp:ListItem>
                             <asp:ListItem>South leg median </asp:ListItem>
                             <asp:ListItem>West leg median </asp:ListItem>
                             <asp:ListItem>East leg median </asp:ListItem>
                             <asp:ListItem>NB lanes </asp:ListItem>
                             <asp:ListItem>SB lanes </asp:ListItem>
                             <asp:ListItem>EB lanes </asp:ListItem>
                             <asp:ListItem>WB lanes </asp:ListItem>
                                       
                             </asp:CheckBoxList>
                         
                      <%--  <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Issue Site Location:</b><br/>Descriptive value representing exact location of improvement.<br/>Max Characters=100" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Please Fill Site Location"
                            ControlToValidate="txtSiteLocation" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" runat="server" TargetControlID="rfvSiteLocation">
                        </cc1:ValidatorCalloutExtender>--%>
                    </div>

                         <div class="row bottom_boder">
                    </div> 
                    <div class="row">
                        <label class="executive_form_label light11">
                            Segment From :</label>
                        <asp:TextBox runat="server" ID="txtSegmentFrom" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Segment From:</b><br/>Descriptive value of start of Freight Corridor. Only use when referencing a Freight Corridor Screening Report corridor, (ex. US 19)." />
                     <%--   <asp:RequiredFieldValidator ID="rfvSegmentFrom" runat="server" ErrorMessage="Please Fill Segment From"
                            ControlToValidate="txtSegmentFrom" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce6" runat="server" TargetControlID="rfvSegmentFrom">
                        </cc1:ValidatorCalloutExtender>--%>
                    </div>
                    <div class="row">
                        <label class="executive_form_label light11">
                            Segment To :</label>
                        <asp:TextBox runat="server" ID="txtSegmentTo" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Segment To:</b><br/>Descriptive value of end of Freight Corridor. Only use when referencing a Freight Corridor Screening Report corridor, (ex. I-275)." />
                     <%--   <asp:RequiredFieldValidator ID="rfvSegmentTo" runat="server" ErrorMessage="Please Fill Segment To"
                            ControlToValidate="txtSegmentTo" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce7" runat="server" TargetControlID="rfvSegmentTo">
                        </cc1:ValidatorCalloutExtender>--%>
                    </div> 
                   <div class="row bottom_boder">
                    </div> 
                    <div class="row">
                        <label class="executive_form_label light11">
                            Roadway Id :</label>
                        <asp:TextBox runat="server" ID="txtRoadWayId" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Roadway ID:</b><br/>FDOT Roadway value provided in TSO basemap, 8 digits (ex.02080001 or 15060000)." />
                       <%-- <asp:RequiredFieldValidator ID="rfvRoadwayId" runat="server" ErrorMessage="Please Fill Roadway Id"
                            ControlToValidate="txtRoadWayId" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce5" runat="server" TargetControlID="rfvRoadwayId">
                        </cc1:ValidatorCalloutExtender>--%>
                    </div>
                      <div class="row">
                        <label class="executive_form_label light11">
                            Begin MP :</label>
                        <asp:TextBox runat="server" ID="txtBeginMP" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Beginning Mile Post:</b><br/>Beginning Milepost of Corridor (Only use if defining a corridor improvement. use up to 3 decimal places, ex. 2.135)" />
                      <%--  <asp:RequiredFieldValidator ID="rfvBeginMP" runat="server" ErrorMessage="Please Fill Begin MP"
                            ControlToValidate="txtBeginMP" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce2" runat="server" TargetControlID="rfvBeginMP">
                        </cc1:ValidatorCalloutExtender>--%>
                    </div>
                    <div class="row">
                        <label class="executive_form_label light11">
                            Ending MP :</label>
                        <asp:TextBox runat="server" ID="txtEndingMP" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>End Mile Post:</b><br/>Ending Milepost of Corridor (Only use if defining a corridor improvement. use up to 3 decimal places, ex. 3.335)" />
                       <%-- <asp:RequiredFieldValidator ID="rfvEndingMP" runat="server" ErrorMessage="Please Fill Ending MP"
                            ControlToValidate="txtEndingMP" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce3" runat="server" TargetControlID="rfvEndingMP">
                        </cc1:ValidatorCalloutExtender>--%>
                    </div>
                         <div class="row bottom_boder">
                    </div> 
                      <div class="row">
                        <label class="executive_form_label light11">
                            Latitude :</label>
                        <asp:TextBox runat="server" ID="txtLatitude" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Latitude:</b><br/>Latitude coordinate of site (required for all Specific Location recommended improvements) Ex: 28.798124." />
                     <%--   <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" FilterType="Custom,Numbers"
                            ValidChars="-." TargetControlID="txtLatitude">
                        </cc1:FilteredTextBoxExtender>
                        <asp:RequiredFieldValidator ID="rfvLatitude" runat="server" ErrorMessage="Please Fill Latitude"
                            ControlToValidate="txtLatitude" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce9" runat="server" TargetControlID="rfvLatitude">
                        </cc1:ValidatorCalloutExtender>
                    </div>--%>
                    <div class="row">
                        <label class="executive_form_label light11">
                            Longitude :</label>
                        <asp:TextBox runat="server" ID="txtLongitude" CssClass="executive_form_input" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Longitude:</b><br/>Longitude coordinate of site (required for all Specific Location recommended improvements). Negative value, Ex:-82.87553" />
                      
                          <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Custom,Numbers"
                            ValidChars="-." TargetControlID="txtLongitude">
                        </cc1:FilteredTextBoxExtender>
                       
                      <%--   <asp:RequiredFieldValidator ID="rfvLongitude" runat="server" ErrorMessage="Please Fill Longitude"
                            ControlToValidate="txtLongitude" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce10" runat="server" TargetControlID="rfvLongitude">
                        </cc1:ValidatorCalloutExtender>--%>
                           <br />
                         </div>

                      <%-- <div class="row">
                        <label class="executive_form_label light11">
                            Corridor Segment :</label>
                        <asp:DropDownList runat="server" ID="ddlCorridorSegment" Width="100px" CssClass="executive_form_input" Visible="false" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Corridor ID Segment:</b><br/>ID value of Corridor (Only use if defining an improvement from a Freight Corridor Screening Report, ex: 10-35)." />
                       <asp:RequiredFieldValidator ID="rfvCorridorSegment" runat="server" ErrorMessage="Please Select Corridor Segment"
                            ControlToValidate="ddlCorridorSegment" InitialValue="0" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>
                        <cc1:ValidatorCalloutExtender ID="vce4" runat="server" TargetControlID="rfvCorridorSegment">
                        </cc1:ValidatorCalloutExtender>
                    </div> --%>
                        <br />   <br />
                    <hr />
                    <div class="row" style="cursor: pointer">
                        <h3>
                            Improvement Information</h3>
                    </div>
                             <div class="row">
                        <label class="executive_form_label light11">
                            <span style="font-size: 11px">Year Recommended : </span>
                        </label>
                        <asp:TextBox runat="server" ID="txtDateYearRecommended" 
                            CssClass="executive_form_input" Width="57px" Text="2013" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Date/Year Recommended :</b><br/>The year or date when improvement recommended. " />
                    </div>
                           <div class="row bottom_boder">
                    </div> 
                    <div class="row">
                        <label class="executive_form_label light11">
                            Freight Need :</label>
                        <asp:DropDownList runat="server" ID="ddlFreightNeed" 
                            CssClass="executive_form_input" AutoPostBack="true">
                           <%-- <asp:ListItem><--Select--></asp:ListItem>
                            <asp:ListItem> Capacity </asp:ListItem>
                            <asp:ListItem> Maintenance </asp:ListItem>
                            <asp:ListItem> Operational </asp:ListItem>
                            <asp:ListItem> Security </asp:ListItem>--%>

                        </asp:DropDownList>
                      
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Definition Description:</b><br/>Details regarding the description of the recommended improvement." />
                    </div>

                    <div class="row">
                        <label class="executive_form_label light11">
                            Issue Description :</label>
                        <asp:DropDownList runat="server" ID="ddlIssueDescription" CssClass="executive_form_input">
                           <%-- <asp:ListItem><--Select--></asp:ListItem>
                            <asp:ListItem>Access Management – median openings, driveways</asp:ListItem>
                            <asp:ListItem>Add New Signal</asp:ListItem>
                             <asp:ListItem>Drainage/Ponding</asp:ListItem>
                            <asp:ListItem>Lane Width</asp:ListItem>
                            <asp:ListItem>Left Turn Lane Length</asp:ListItem>
                            <asp:ListItem>Line of Sight</asp:ListItem>
                            <asp:ListItem>Queue Length</asp:ListItem>
                            <asp:ListItem>Right Turn lane length</asp:ListItem>
                            <asp:ListItem>RR Grade Crossing/replacement</asp:ListItem>
                            <asp:ListItem>Signage – navigational/directional</asp:ListItem>
                            <asp:ListItem>Signal Timing</asp:ListItem>
                            <asp:ListItem>Stop Bar Modification</asp:ListItem>
                            <asp:ListItem>Substandard Pavement</asp:ListItem>
                            <asp:ListItem>Turn Radii</asp:ListItem>
                            <asp:ListItem>Other Capacity Issues</asp:ListItem>
                            <asp:ListItem>Other Maintenance Issues</asp:ListItem>
                            <asp:ListItem>Other Operational Issues</asp:ListItem>
                            <asp:ListItem>Other Safety/security</asp:ListItem>--%>
                        </asp:DropDownList>
                        
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Issue Description:</b><br/>Definition of issue at Specific Location or Corridor. Valid values contained in dropdown." />
                        <asp:RequiredFieldValidator ID="rfvIssueDesc" runat="server" ErrorMessage="Please Select Issue Description"
                            ControlToValidate="ddlIssueDescription" InitialValue="0" Display="None" SetFocusOnError="True" ValidationGroup="Submit">*</asp:RequiredFieldValidator>

                    </div>
                           <div class="row bottom_boder">
                    </div> 
                   <%--<div class="row">
                        <label class="executive_form_label light11">
                            Improvement Stage :</label>--%>
                        <asp:DropDownList runat="server" ID="ddlImprovementStage" 
                            CssClass="executive_form_input"  Visible="false">
                           <asp:ListItem>N/A</asp:ListItem>
                            <asp:ListItem><--Select--></asp:ListItem>
                            <asp:ListItem>Improvement Recommendation Accepted</asp:ListItem>
                              <asp:ListItem>Improvement Funded</asp:ListItem>

                        </asp:DropDownList>
                       
                        <%--<img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Improvement Stage:</b><br/>Current status of improvement." />
                    </div>--%>
                    <div class="row">
                        <label class="executive_form_label light11">
                            Priority :</label>
                        <asp:DropDownList runat="server" ID="ddlPriority" 
                            CssClass="executive_form_input">
                            <asp:ListItem><--Select--></asp:ListItem>
                            <asp:ListItem>1-High</asp:ListItem>
                               <asp:ListItem>2-Medium</asp:ListItem>
                            <asp:ListItem>3-Low</asp:ListItem>
                        </asp:DropDownList>
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Improvement Stage:</b><br/>Current status of improvement." />
                    </div>
                         <div class="row bottom_boder">
                    </div>
                    <asp:UpdatePanel ID="MainUpdatePanel" runat="server">
                    <ContentTemplate>
                     <div class="row">
                        <label class="executive_form_label light11">
                            Implementation Ease :</label>
                     <asp:Label ID="lblValues" runat="server" Text="Easy" ToolTip="Please select a constraint to complete the Implementation Ease selection process." ></asp:Label>
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Ease of Implementation:</b><br/>Implementation Ease is calculated by amount of Constraints selected." /></div>
                   
                          
                        
                          <div class="row">
                              <label class="executive_form_label light11">
                                  Issue Contraints :
                              </label>
                              
                              <div>
                            
                         <asp:CheckBox ID="ChkROW" runat="server" Text=" Right-of-Way" Checked="false" AutoPostBack="true"/>
                                  <asp:CheckBox ID="ChkUTILITY" runat="server" Text=" Utility" Checked="false"  AutoPostBack="true"/>
                                  <asp:CheckBox ID="ChkLIGHTPOLE" runat="server" Text=" Light Pole" Checked="false"  AutoPostBack="true" />
                              </div>
                              <asp:CheckBox ID="ChkSIGNAGE" runat="server" Text=" Signage" Checked="false"  AutoPostBack="true"/>
                              <asp:CheckBox ID="ChkSTRUCTURE" runat="server" Text=" Structure" Checked="false"  AutoPostBack="true"/>
                              <asp:CheckBox ID="ChkOTHER" runat="server" Text=" Other" Checked="false"  AutoPostBack="true"/>

                        

                              <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                                  alt="" class="toolTip" title="<b>Freight Travel Markets:</b><br/>Defines the freight travel market where this improvement occurs. Check as many boxes as applicable." />
                          </div> 
                         <div class="row bottom_boder">
                    </div>
                 </ContentTemplate>                 
                    </asp:UpdatePanel>
                    
                    <div class="row">
                        <label class="executive_form_label light11">
                            Transportation System :</label>
                        <asp:DropDownList runat="server" ID="ddlTransSystem" 
                            CssClass="executive_form_input">
                            <asp:ListItem>On System - State Road</asp:ListItem>
                                <asp:ListItem>Off System - Local Road</asp:ListItem>
                                <asp:ListItem>NHS</asp:ListItem>
                                <asp:ListItem>SIS Corridor</asp:ListItem>
                                <asp:ListItem>SIS Connector</asp:ListItem>
                        </asp:DropDownList>
                       
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>On or Off System:</b><br/>Defines whether the corridor or specific location is located on or off the FDOT system." />
                    </div>
                    <div class="row">
                        <label class="executive_form_label light11">
                            <span style="font-size: 11px">Freight System :</span></label>
                        <asp:DropDownList runat="server" ID="ddlFreightSystem" 
                            CssClass="executive_form_input">
                                       <asp:ListItem>Freight Activity Center Street</asp:ListItem>
                                         <asp:ListItem>Freight Distribution Route</asp:ListItem>
                                          <asp:ListItem>Limited Access Facility</asp:ListItem>
                            <asp:ListItem>Regional Freight Mobility Corridor</asp:ListItem>

                        </asp:DropDownList>
                     
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Freight System Description:</b><br/>Defines whether the corridor or specific location is located on a Regional Freight Corridor, a Truck Route, or Both." />
                    </div>

                     <hr />
              
                    <div class="row" style="cursor: pointer">
                        <h3>
                            Additional Information</h3>
                    </div>
                           <div class="row">
                        <label class="executive_form_label light11">
                            <span style="font-size: 11px">Recommendation Desc :</span></label>
                        <asp:TextBox runat="server" ID="txtRecomendationDesc" CssClass="executive_form_input"
                            Width="400px" Height="51px" TextMode="MultiLine" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Recommendation Description:</b><br/>Details regarding the description of the recommended improvement Add recommendation from source.<br/>Max Characters=255" />
                         </div>
                        <div class="row bottom_boder">
                    </div>
                    <div class="row">
                        <label class="executive_form_label light11">
                            Field Notes :</label>
                        <asp:TextBox runat="server" ID="txtFieldOBC" CssClass="executive_form_input" 
                            Height="56px" Width="398px" TextMode="MultiLine" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Field Observation:</b><br/>Field Observations noted from the source records.<br/>Max Characters=255" />
                    </div>

                                <div class="row bottom_boder">
                    </div>
                           <div class="row">
                        <label class="executive_form_label light11">
                            Comments :</label>
                        <asp:TextBox runat="server" ID="txtComments" CssClass="executive_form_input" TextMode="MultiLine"
                            Width="400px" Height="61px" />
                        <img src="../images/question.PNG" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Comments:</b><br/>Comments about the Specific Location or Corridor.<br/>Max Characters=255" />
                    </div>

                 
                    <div class="row">
                        <label class="executive_form_label light11">
                            &nbsp;</label>
                        <label class="executive_form_label_1">
                            <asp:Button runat="server" ID="btnSubmit" Visible="true" OnClick="btnSubmit_Click"
                                CssClass="button1" Text="Submit" ValidationGroup="Submit" /></label>
                        <label class="executive_form_label_1">
                            <asp:Button runat="server" ID="btnCancel" OnClick="btnCancel_Click" CssClass="button1"
                                Text="Cancel" /></label>
                    </div>

                    <div class="row bottom_boder">
                    </div>

                  </div>
                </div>
            </div>
        </div>
           <b id="executive_form_bottom"></b>
            </div>
     
        </div>
               
    <script src="js/jquery.min.js"></script>

    <script src="js/js.js"></script>
 
</asp:Content>

