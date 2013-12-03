<%@ Page Title="CFID-View" Language="VB" MasterPageFile="~/GMweb.master" MaintainScrollPositionOnPostback="true" AutoEventWireup="false" CodeFile="view_Record.aspx.vb" Inherits="Edit_Record" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
    <div class="body_part_cols">
    
        <div id="body_part_left_col">
        
        <div>
                 <h1 class="add_new_executive">
                    View Record
                   </h1>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 
              <asp:Button ID="lnkedit"  runat="server" CssClass="button4" Text="Edit Details"   /> &nbsp;&nbsp; | &nbsp;&nbsp;  
              <asp:Button ID="lnkprint"  runat="server" CssClass="button4" Text="Print Details"   />
               
              
            
            </div>
        
            <div id="executive_form">
                <b id="executive_form_top"></b>
                <div id="executive_form_center">
                    <div class="row">
                        <asp:Label runat="server" ID="lblMessage" />
                    </div>
                    <div class="row">
                    
                    <div class="row" style="cursor: pointer">
                    <h4>Collection Information</h4>
                    </div>
                 
                    
                    <div class="row">
                    <label class="executivelabeltest">
                           <b>Improvement ID :</b> </label>
                    <asp:Label runat="server" ID="lblID" 
                            Width="100px" />
                    </div>
                    
                    <div class="row">
                        <label class="executivelabeltest">
                           <b>  FDOT District :</b></label>
                        <asp:Label runat="server" ID="lblDistrict"
                            CssClass="executive_form_input" Width="288px" />
                          

                        <asp:DropDownList runat="server" ID="ddlDistrict" CssClass="executive_form_input" Visible="false">
                         </asp:DropDownList>
                      
                    </div>

                    <div class="row">
                       <label class="executivelabeltest">
                           <b> Corridor Name :</b></label>
                        <asp:label runat="server" ID="lblCorridorName" 
                            CssClass="executive_form_input" Width="288px" Visible="true" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Corridor Name:</b><br/>For improvements recommended from a Freight Corridor Screening Report. Use the name on the Corridor Screening report or other descriptive name identifier, such as US 98.<br/>Max Characters=255" />--%>
                        
                    </div>

                       <div class="row">
                        <label class="executivelabeltest">
                          <b> Site Description :</b></label>
                        <asp:label runat="server" ID="lblSiteLocation" CssClass="executive_form_input" 
                               Width="287px" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Site Location:</b><br/>Descriptive value representing exact location of improvement (US 19 and 54 Ave. North).<br/>Max Characters=100" />--%>
                        
                    </div>


                         <div class="row">
                        <label class="executivelabeltest">
                           <b>Issue Extent :</b> </label>
                                  <asp:Label runat= "server" ID="lblType"
                            CssClass="executive_form_input" Width="288px" />
                        <asp:DropDownList runat="server" ID="ddlType" CssClass="executive_form_input" 
                            AutoPostBack="True" Visible="false"  />

                       
                     </div>
                     
                    
                    <div class="row">
                        <label class="executivelabeltest">
                           <b>Collection
                            Source :</b> </label>
                        <asp:Label runat="server" ID="lblSource" CssClass="executive_form_input" />
                        <%--<img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Source</b><br/>Name of source where data comes from (ex.Hotspot surveys, Corridor Screening reports)." />--%>
                    </div>

                    <div class="row">
                        <label class="executivelabeltest">
                            <b>County :</b></label>
                        <asp:Label runat="server" ID="lblCounty" CssClass="executive_form_input" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>County:</b><br/>Name of county where improvement exists." />--%>
                    </div>
                      <div class="row">
                        <label class="executivelabeltest">
                          <b> Field Verified :</b> </label>
                     <%-- <asp:CheckBox ID="ChkboxVerified" runat="server" CssClass="executive_form_input" Checked="false"  />--%>
                           <asp:CheckBox runat="server" ID="chkFieldVerified" CssClass="executive_form_input" Enabled="false"  />
                            
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>County:</b><br/>Name of county where improvement exists." />--%>
                    </div>
                        <div class="row">
                        <label class="executivelabeltest">
                          <b>  Priority :</b></label>
                        <asp:label runat="server" ID="lblPriority" 
                            CssClass="executive_form_input">
                            
                        </asp:label>
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Improvement Stage:</b><br/>Current status of improvement." />--%>
                    </div>
                        <div class="row">
                        <label class="executivelabeltest">
                           <b> Implementation Ease :</b></label>
                        <asp:label runat="server" ID="lblEase" CssClass="executive_form_input" >
                           
                             </asp:label>
                        
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Improvement Stage:</b><br/>Current status of improvement." />--%>
                    </div>

                           <div class="row">
                        <label class="executivelabeltest">
                         <b>  Freight Need :</b> </label>
                        <asp:label runat="server" ID="lblFreightNeed" 
                            CssClass="executive_form_input">
                          

                        </asp:label>
                      
                        <%--<img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Definition Description:</b><br/>Details regarding the description of the recommended improvement." />--%>
                    </div>

                     <div class="row">
                        <label class="executivelabeltest">
                          <b>  Issue Description :</b></label>
                        <asp:label runat="server" ID="lblIssueDescription" 
                            CssClass="executive_form_input">
                         
                         </asp:label>
                        
                        <%--<img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Issue Description:</b><br/>Definition of issue at Specific Location or Corridor. Valid values contained in dropdown." />--%>
                    </div>


                    <div class="row bottom_boder">
                    </div>
                    <div class="row" style="cursor: pointer">
                        <h4>
                            Location Information
                        </h4>
                    </div>

                         <div class="row">
                        
                            <label class="executivelabeltest">
                               <b> Location Map :</b></label>
                           <asp:Image runat="server" Style="width: 400px" ID="Imgstaticmap" />
                        </div>
                   
                      <div class="row">
                        <label class="executivelabeltest">
                           <b> Issue Site Location :</b></label>

                             <asp:label runat="server" ID="lblIssueLoc" CssClass="executive_form_input"/>
                           
                      
                         
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Issue Site Location:</b><br/>Descriptive value representing exact location of improvement.<br/>Max Characters=100" />--%>
                 
                    </div>
                    <div class="row">
                        <label class="executivelabeltest">
                           <b> Segment From :</b></label>
                        <asp:label runat="server" ID="lblSegmentFrom" CssClass="executive_form_input" 
                            Width="290px" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Segment From:</b><br/>Descriptive value of start of Freight Corridor. Only use when referencing a Freight Corridor Screening Report corridor, (ex. US 19)." />--%>
                        
                    </div>
                    <div class="row">
                        <label class="executivelabeltest">
                          <b>  Segment To :</b></label>
                        <asp:label runat="server" ID="lblSegmentTo" CssClass="executive_form_input" 
                            Width="290px" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Segment To:</b><br/>Descriptive value of end of Freight Corridor. Only use when referencing a Freight Corridor Screening Report corridor, (ex. I-275)." />--%>
                        
                    </div>
                    <div class="row">
                        <label class="executivelabeltest">
                          <b> Primary Roadway Id :</b></label>
                        <asp:label runat="server" ID="lblRoadWayId" CssClass="executive_form_input" />
                        <%--<img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Roadway ID:</b><br/>FDOT Roadway value provided in TSO basemap, 8 digits (ex.02080001 or 15060000)." />--%>
                        
                    </div>
                    
                      <div class="row">
                        <label class="executivelabeltest">
                          <b> Secondary Roadway Id :</b></label>
                        <asp:label runat="server" ID="lblSecondRdwyID" CssClass="executive_form_input" />
                        <%--<img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Roadway ID:</b><br/>FDOT Roadway value provided in TSO basemap, 8 digits (ex.02080001 or 15060000)." />--%>
                        
                    </div>
                    
                    <div class="row">
                        <label class="executivelabeltest">
                          <b> Begin MP :</b> </label>
                        <asp:label runat="server" ID="lblBeginMP" CssClass="executive_form_input" />
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Beginning Mile Post:</b><br/>Beginning Milepost of Corridor (Only use if defining a corridor improvement. use up to 3 decimal places, ex. 2.135)" />--%>
                        
                    </div>
                    <div class="row">
                        <label class="executivelabeltest">
                           <b> Ending MP :</b></label>
                        <asp:label runat="server" ID="lblEndingMP" CssClass="executive_form_input" />
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>End Mile Post:</b><br/>Ending Milepost of Corridor (Only use if defining a corridor improvement. use up to 3 decimal places, ex. 3.335)" />--%>
                        
                    </div>
                    
                     <div class="row">
                        <label class="executivelabeltest">
                           <b> Location MP :</b></label>
                        <asp:label runat="server" ID="lblLocMP"/>
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>End Mile Post:</b><br/>Ending Milepost of Corridor (Only use if defining a corridor improvement. use up to 3 decimal places, ex. 3.335)" />--%>
                        
                    </div>
                    
                    <div class="row">
                        <label class="executivelabeltest">
                          <b>  Latitude :</b></label>
                        <asp:label runat="server" ID="lblLatitude" CssClass="executive_form_input" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Latitude:</b><br/>Latitude coordinate of site (required for all Specific Location recommended improvements)Ex: 28.798124." />--%>
                       
                    </div>
                    <div class="row">
                        <label class="executivelabeltest">
                         <b>   Longitude :</b></label>
                        <asp:label runat="server" ID="lblLongitude" CssClass="executive_form_input" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Longitude:</b><br/>Longitude coordinate of site (required for all Specific Location recommended improvements). Negative value, Ex:-82.87553" />--%>
                       
                    </div>

                         <div class="row">
                        <label class="executivelabeltest">
                          <b> Corridor Segment :</b> </label>
                        <asp:label runat="server" ID="lblCorridorSegment" Width="100px" CssClass="executive_form_input" />
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Corridor ID Segment:</b><br/>ID value of Corridor (Only use if defining an improvement from a Freight Corridor Screening Report, ex: 10-35)." />--%>
                       
                    </div>

                    <div class="row bottom_boder">
                    </div>
                    <div class="row" style="cursor: pointer">
                        <h4>
                            Improvement Information</h4>
                    </div>
                         <div class="row">
                       
                               <label class="executivelabeltest">
                          <b> Year Recommended :</b></label>
                        <asp:label runat="server" ID="lblDateYearRecommended" CssClass="executive_form_input" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Date/Year Recommended :</b><br/>The year or date when improvement recommended. " />--%>
                    </div>
                      
                     <%--<div class="row">
                        <label class="executive_form_label light11">
                           <b> Improvement Stage :</b></label>
                        <asp:label runat="server" ID="lblImprovementStage" 
                            CssClass="executive_form_input">
                            

                        </asp:label>
                       
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Improvement Stage:</b><br/>Current status of improvement." />
                    </div>--%>
                   

                        <div class="row">
                              <label class="executivelabeltest">
                                <b> Issue Contraints :</b> 
                              </label>
                            

                                <asp:CheckBox ID="ChkROW" runat="server" Text=" Right-of-Way" CssClass="executive_form_input" Enabled="false"  />
                                 
                                  <asp:CheckBox ID="ChkUTILITY" runat="server" Text=" Utility"  CssClass="executive_form_input" Enabled="false"/>
                                  <asp:CheckBox ID="ChkLIGHTPOLE" runat="server" Text=" Light Pole" CssClass="executive_form_input" Enabled="false" />
                              
                              <asp:CheckBox ID="ChkSIGNAGE" runat="server" Text=" Signage"  CssClass="executive_form_input" Enabled="false"/>
                              <asp:CheckBox ID="ChkSTRUCTURE" runat="server" Text=" Structure"  CssClass="executive_form_input" Enabled="false"/>
                              <asp:CheckBox ID="ChkOTHER" runat="server" Text=" Other"  CssClass="executive_form_input" Enabled="false"/>

                             <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                                  alt="" class="toolTip" title="<b>Freight Travel Markets:</b><br/>Defines the freight travel market where this improvement occurs. Check as many boxes as applicable." />--%>
                          </div>


                                <div class="row">
                        <label class="executivelabeltest">
                           <b> Transportation System :</b></label>
                        <asp:label runat="server" ID="lblTransSystem" 
                            CssClass="executive_form_input">
                            
                        </asp:label>
                       
                     <%--   <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Transportation System:</b><br/>Defines whether the corridor or specific location is located on or off the FDOT system." />--%>
                    </div>

                    <div class="row">
                        <label class="executive_form_label light11">
                            <span style="font-size: 11px"><b>Freight System :</b></span></label>
                        <asp:label runat="server" ID="lblFreightSystem" CssClass="executive_form_input" />
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Freight System Description:</b><br/>Defines whether the corridor or specific location is located on a Regional Freight Corridor, a Truck Route, or Both." />--%>
                    </div>

                  
                   
                    <div class="row bottom_boder">
                    </div>
                 
                   
                                   <div class="row" style="cursor: pointer">
                        <h3>
                            Additional Information</h3>
                    </div>
                           <div class="row">
                        <label class="executive_form_label light11">
                            <span style="font-size: 11px"><b>Recommendation Desc :</b></span></label>
                        <asp:textbox runat="server" ID="lblRecomendationDesc" Enabled="false" TextMode="MultiLine" CssClass="executive_form_input" 
                            Width="400px" Height="180px" />
                       <%-- <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Recommendation Description:</b><br/>Details regarding the description of the recommended improvement Add recommendation from source.<br/>Max Characters=255" />--%>
                   </div>
                   <br />
                    <div class="row">
                        <label class="executive_form_label light11">
                          <b> Field Notes :</b></label>
                        <asp:textbox runat="server" ID="lblFieldOBC" Enabled="false" TextMode="MultiLine" CssClass="executive_form_input" 
                            Width="400px" Height="180px" />
                        <%--<img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Field Observation:</b><br/>Field Observations noted from the source records.<br/>Max Characters=255" />--%>
                    </div>

                               
                           <div class="row">
                        <label class="executive_form_label light11">
                          <b>  Comments :</b></label>
                        <asp:textbox runat="server" ID="lblComments" Enabled="false" TextMode="MultiLine" CssClass="executive_form_input" 
                            Width="400px" Height="180px" />
                      <%--  <img src="images/question.png" style="vertical-align: middle; padding-left: 5px;"
                            alt="" class="toolTip" title="<b>Comments:</b><br/>Comments about the Specific Location or Corridor.<br/>Max Characters=255" />--%>
                    </div>
                       


 <div class="row">
                        <label class="executive_form_label light11">
                          <b> Project Dialog :</b></label>
<asp:GridView ID="GridView2" runat="server" AllowPaging="True"  PageSize="10"
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="10" 
        DataKeyNames="OBJECTID" DataSourceID="AccessDataSource1" ForeColor="#333333" EmptyDataText="There is no dialog associated with this issue."
        GridLines="None" Width="420px">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
           
            <asp:BoundField DataField="OBJECTID" HeaderText="Issue ID" 
                SortExpression="OBJECTID" Visible="false"/>
            <asp:BoundField DataField="COMMENT" HeaderText="Issue Comment" 
                SortExpression="COMMENT" />
            <asp:BoundField DataField="USERNAME" HeaderText="User" 
                SortExpression="USERNAME" />
            <asp:BoundField DataField="COMMENT_DATE" HeaderText="Date" 
                SortExpression="COMMENT_DATE" DataFormatString="{0:d}" />
            
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#efeded" Font-Bold="True" ForeColor="Black" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>

    <asp:AccessDataSource ID="AccessDataSource1" runat="server" 
        DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT * FROM [USER_COMMENT] WHERE ([OBJECTID] = ?)">
        <SelectParameters>
            <asp:ControlParameter ControlID="lblID" Name="OBJECTID" PropertyName="Text" 
                Type="Int32" />
        </SelectParameters>
    </asp:AccessDataSource>

<br />
<center>
<asp:HyperLink runat="server" ID="hypdialog" NavigateUrl="~/viewdialog.aspx" Text="Click to View All Project Dialog Comment's" />
</center>

 </div>
                         </div>
                </div>
                <b id="executive_form_bottom"></b>
            </div>
        </div>
    
    <script type="text/javascript"  src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/js.js"></script>
</asp:Content>

