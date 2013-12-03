<%@ Page Title="" Language="VB" MasterPageFile="~/GMweb.master" AutoEventWireup="false"
     ValidateRequest="false"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ContentPlaceHolderID="PlaceHolder" runat="server">
    <link href="css/Gride.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

   <div id="body_part">
        <div id="OuterBodyContent">
            <div class="RightPortion">
                <div class="innerRightPortion">
                    <asp:Label ID="Label6" runat="server" Text="ARCHIVE IMPROVEMENTS" 
                            
                            
                        style="font-weight: 700; text-decoration: underline; background-color: #FFFFFF;" ></asp:Label>  
                                <asp:GridView ID="GridView1" runat="server" AllowSorting="True" 
                                    AutoGenerateColumns="False" DataKeyNames="OID" DataSourceID="AccessDataSource1" 
                                    EnableModelValidation="True" CellPadding="4" ForeColor="#333333" 
                                    GridLines="Horizontal" AllowPaging="true" PageSize="50">
                                    <HeaderStyle CssClass="GridHeader"/>
                                    <RowStyle CssClass="GridRowStyle" />
                                <SelectedRowStyle CssClass="GridSelectedRow" />
                                <AlternatingRowStyle CssClass="GridAlternativeRow" />
                                <FooterStyle CssClass="GridFooterStyle" />
                                    
                                    
                                    <Columns>
                                        <asp:CommandField ShowDeleteButton="True" ControlStyle-Font-Underline="true" />
                                        <asp:BoundField DataField="COUNTY" HeaderText="COUNTY" InsertVisible="False" 
                                            ReadOnly="True" SortExpression="COUNTY" />
                                        <asp:BoundField DataField="CORRIDOR" HeaderText="CORRIDOR" 
                                            SortExpression="CORRIDOR" />
                                        <asp:BoundField DataField="ISSUE_EXTENT" HeaderText="ISSUE EXTENT" 
                                            SortExpression="ISSUE_EXTENT" />
                                        <asp:BoundField DataField="SITE_LOCATION" HeaderText="SITE LOCATION" 
                                            SortExpression="SITE_LOCATION" />
                                       
                                        <asp:BoundField DataField="FREIGHT_NEED" HeaderText="FREIGHT NEED" 
                                            SortExpression="FREIGHT_NEED" />
                                       
                                        <asp:BoundField DataField="PRIORITY" HeaderText="PRIORITY" 
                                            SortExpression="PRIORITY" />
                                        <asp:BoundField DataField="EASE" HeaderText="EASE" SortExpression="EASE" />
                                        
                                        <asp:HyperLinkField Text="Details" HeaderText="Details" DataNavigateUrlFields="ObjectID" 
                                            DataNavigateUrlFormatString="~/Archive_Record.aspx?ObjectID={0}" 
                                            NavigateUrl="~/Archive_Record.aspx?ObjectID={0}"  />
                                    </Columns>
                                    <EditRowStyle BackColor="#999999" />
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                </asp:GridView>
                <asp:HiddenField ID="HidSort" runat="server" />           <center>
                    </center>
              <asp:UpdatePanel ID="FilterUpdatePanelDIv" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <div style="width: 100%; height: 30px;">
                                <asp:Label ID="lblGrideError" runat="server" CssClass="lblError"></asp:Label>
                            </div>





                            <%--<div class="ExportButon">
                                <div style="width: 200px; height: 35px; float: left; text-align: left;">
                                    <asp:Label ID="lblSelectedRecord" runat="server"></asp:Label>
                                    Record selected out
                                    <asp:Label ID="lblTotalRecords" runat="server"></asp:Label>
                                </div><asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="button3" />
                                <asp:Button ID="btnExport" runat="server" Text="Export Result" CssClass="button3" />
                            </div>--%>
                            <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/CFID.mdb"
                                SelectCommand="SELECT * FROM [CFID_MASTER_TBL_archive]"
                                
                                UpdateCommand="UPDATE [CFID_MASTER_TBL_archive] SET [FDOT_District] = ?, [COUNTY] = ?, [CORRIDOR] = ?, [ISSUE_EXTENT] = ?, [SITE_LOCATION] = ?, [ISSUESITELOC] = ?, [FREIGHT_NEED] = ?, [ISSUE_DESCRIPTION] = ?, [CORRIDOR_SEGMENT] = ?, [FRGHT_TRVL_MRKT] = ?, [PRIORITY] = ?, [EASE] = ?, [ROWCONSTRAINT] = ?, [UTILITYCONSTRAINT] = ?, [LIGHTPOLECONSTRAINT] = ?, [SIGNAGECONSTRAINT] = ?, [STRUCTURECONSTRAINT] = ?, [OTHERCONSTRAINT] = ?, [FIELD_VERIFIED] = ?, [DATE_RECOMMENDED] = ?, [SEGMENT_TO] = ?, [SEGMENT_FROM] = ?, [ROADWAYID] = ?, [BEGMP] = ?, [ENDMP] = ?, [LAT] = ?, [LON] = ?, [TRANSPORT_SYSTEM] = ?, [FREIGHT_SYSTEM] = ?, [FIELD_OBS] = ?, [RECOMMENDATION_DESC] = ?, [COMMENTS] = ?, [IMPRVMNT_STAGE] = ?, [IMPRVMNT_STAGE_NAME] = ?, [SOURCE] = ?, [DATE_RECMDED_EVAL] = ?, [DATE_MODIFIED] = ?, [MISC_INFO] = ?, [LATY] = ?, [LONX] = ?, [Test] = ? WHERE [OID] = ?" 
                                DeleteCommand="DELETE FROM [CFID_MASTER_TBL_archive] WHERE [OID] = ?" 
                                InsertCommand="INSERT INTO [CFID_MASTER_TBL_archive] ([OID], [FDOT_District], [COUNTY], [CORRIDOR], [ISSUE_EXTENT], [SITE_LOCATION], [ISSUESITELOC], [FREIGHT_NEED], [ISSUE_DESCRIPTION], [CORRIDOR_SEGMENT], [FRGHT_TRVL_MRKT], [PRIORITY], [EASE], [ROWCONSTRAINT], [UTILITYCONSTRAINT], [LIGHTPOLECONSTRAINT], [SIGNAGECONSTRAINT], [STRUCTURECONSTRAINT], [OTHERCONSTRAINT], [FIELD_VERIFIED], [DATE_RECOMMENDED], [SEGMENT_TO], [SEGMENT_FROM], [ROADWAYID], [BEGMP], [ENDMP], [LAT], [LON], [TRANSPORT_SYSTEM], [FREIGHT_SYSTEM], [FIELD_OBS], [RECOMMENDATION_DESC], [COMMENTS], [IMPRVMNT_STAGE], [IMPRVMNT_STAGE_NAME], [SOURCE], [DATE_RECMDED_EVAL], [DATE_MODIFIED], [MISC_INFO], [LATY], [LONX], [Test]) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)">
                                <DeleteParameters>
                                    <asp:Parameter Name="OID" Type="Int32" />
                                </DeleteParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="OID" Type="Int32" />
                                    <asp:Parameter Name="FDOT_District" Type="String" />
                                    <asp:Parameter Name="COUNTY" Type="String" />
                                    <asp:Parameter Name="CORRIDOR" Type="String" />
                                    <asp:Parameter Name="ISSUE_EXTENT" Type="String" />
                                    <asp:Parameter Name="SITE_LOCATION" Type="String" />
                                    <asp:Parameter Name="ISSUESITELOC" Type="String" />
                                    <asp:Parameter Name="FREIGHT_NEED" Type="String" />
                                    <asp:Parameter Name="ISSUE_DESCRIPTION" Type="String" />
                                    <asp:Parameter Name="CORRIDOR_SEGMENT" Type="String" />
                                    <asp:Parameter Name="FRGHT_TRVL_MRKT" Type="String" />
                                    <asp:Parameter Name="PRIORITY" Type="String" />
                                    <asp:Parameter Name="EASE" Type="String" />
                                    <asp:Parameter Name="ROWCONSTRAINT" Type="String" />
                                    <asp:Parameter Name="UTILITYCONSTRAINT" Type="String" />
                                    <asp:Parameter Name="LIGHTPOLECONSTRAINT" Type="String" />
                                    <asp:Parameter Name="SIGNAGECONSTRAINT" Type="String" />
                                    <asp:Parameter Name="STRUCTURECONSTRAINT" Type="String" />
                                    <asp:Parameter Name="OTHERCONSTRAINT" Type="String" />
                                    <asp:Parameter Name="FIELD_VERIFIED" Type="Int16" />
                                    <asp:Parameter Name="DATE_RECOMMENDED" Type="String" />
                                    <asp:Parameter Name="SEGMENT_TO" Type="String" />
                                    <asp:Parameter Name="SEGMENT_FROM" Type="String" />
                                    <asp:Parameter Name="ROADWAYID" Type="String" />
                                    <asp:Parameter Name="BEGMP" Type="Double" />
                                    <asp:Parameter Name="ENDMP" Type="Double" />
                                    <asp:Parameter Name="LAT" Type="String" />
                                    <asp:Parameter Name="LON" Type="String" />
                                    <asp:Parameter Name="TRANSPORT_SYSTEM" Type="String" />
                                    <asp:Parameter Name="FREIGHT_SYSTEM" Type="String" />
                                    <asp:Parameter Name="FIELD_OBS" Type="String" />
                                    <asp:Parameter Name="RECOMMENDATION_DESC" Type="String" />
                                    <asp:Parameter Name="COMMENTS" Type="String" />
                                    <asp:Parameter Name="IMPRVMNT_STAGE" Type="String" />
                                    <asp:Parameter Name="IMPRVMNT_STAGE_NAME" Type="String" />
                                    <asp:Parameter Name="SOURCE" Type="String" />
                                    <asp:Parameter Name="DATE_RECMDED_EVAL" Type="String" />
                                    <asp:Parameter Name="DATE_MODIFIED" Type="String" />
                                    <asp:Parameter Name="MISC_INFO" Type="String" />
                                    <asp:Parameter Name="LATY" Type="Double" />
                                    <asp:Parameter Name="LONX" Type="Double" />
                                    <asp:Parameter Name="Test" Type="Boolean" />
                                </InsertParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="FDOT_District" Type="String" />
                                    <asp:Parameter Name="COUNTY" Type="String" />
                                    <asp:Parameter Name="CORRIDOR" Type="String" />
                                    <asp:Parameter Name="ISSUE_EXTENT" Type="String" />
                                    <asp:Parameter Name="SITE_LOCATION" Type="String" />
                                    <asp:Parameter Name="ISSUESITELOC" Type="String" />
                                    <asp:Parameter Name="FREIGHT_NEED" Type="String" />
                                    <asp:Parameter Name="ISSUE_DESCRIPTION" Type="String" />
                                    <asp:Parameter Name="CORRIDOR_SEGMENT" Type="String" />
                                    <asp:Parameter Name="FRGHT_TRVL_MRKT" Type="String" />
                                    <asp:Parameter Name="PRIORITY" Type="String" />
                                    <asp:Parameter Name="EASE" Type="String" />
                                    <asp:Parameter Name="ROWCONSTRAINT" Type="String" />
                                    <asp:Parameter Name="UTILITYCONSTRAINT" Type="String" />
                                    <asp:Parameter Name="LIGHTPOLECONSTRAINT" Type="String" />
                                    <asp:Parameter Name="SIGNAGECONSTRAINT" Type="String" />
                                    <asp:Parameter Name="STRUCTURECONSTRAINT" Type="String" />
                                    <asp:Parameter Name="OTHERCONSTRAINT" Type="String" />
                                    <asp:Parameter Name="FIELD_VERIFIED" Type="Int16" />
                                    <asp:Parameter Name="DATE_RECOMMENDED" Type="String" />
                                    <asp:Parameter Name="SEGMENT_TO" Type="String" />
                                    <asp:Parameter Name="SEGMENT_FROM" Type="String" />
                                    <asp:Parameter Name="ROADWAYID" Type="String" />
                                    <asp:Parameter Name="BEGMP" Type="Double" />
                                    <asp:Parameter Name="ENDMP" Type="Double" />
                                    <asp:Parameter Name="LAT" Type="String" />
                                    <asp:Parameter Name="LON" Type="String" />
                                    <asp:Parameter Name="TRANSPORT_SYSTEM" Type="String" />
                                    <asp:Parameter Name="FREIGHT_SYSTEM" Type="String" />
                                    <asp:Parameter Name="FIELD_OBS" Type="String" />
                                    <asp:Parameter Name="RECOMMENDATION_DESC" Type="String" />
                                    <asp:Parameter Name="COMMENTS" Type="String" />
                                    <asp:Parameter Name="IMPRVMNT_STAGE" Type="String" />
                                    <asp:Parameter Name="IMPRVMNT_STAGE_NAME" Type="String" />
                                    <asp:Parameter Name="SOURCE" Type="String" />
                                    <asp:Parameter Name="DATE_RECMDED_EVAL" Type="String" />
                                    <asp:Parameter Name="DATE_MODIFIED" Type="String" />
                                    <asp:Parameter Name="MISC_INFO" Type="String" />
                                    <asp:Parameter Name="LATY" Type="Double" />
                                    <asp:Parameter Name="LONX" Type="Double" />
                                    <asp:Parameter Name="Test" Type="Boolean" />
                                    <asp:Parameter Name="OID" Type="Int32" />
                                </UpdateParameters>
                            </asp:AccessDataSource>
                      </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
    </div>
         <script type="text/javascript">
             $("#accordion > li").click(function () {

                 //   if (false == $(this).next().is(':visible')) {
                 //     $('#accordion > ul').slideUp(300);
                 // }
                 $(this).next().slideToggle(300);
             });

             // $('#accordion > ul:eq(0)').show();

    </script>
</asp:Content> 
