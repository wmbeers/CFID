<%@ Page Title="CFID-View All" Language="VB" MasterPageFile="~/GMweb.master" AutoEventWireup="false"
    CodeFile="ViewAll_Records.aspx.vb" Inherits="ViewAll_Records" ValidateRequest="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ContentPlaceHolderID="PlaceHolder" runat="server">
    <link href="css/Gride.css" rel="stylesheet" type="text/css" />
    <link href="css/Modepop.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
    <script language="javascript" type="text/javascript">

        function ShowModalPopup(ModalBehaviour) {
            $find(ModalBehaviour).show();
        }

        function HideModalPopup(ModalBehaviour) {
            $find(ModalBehaviour).hide();
        }
    </script>
    
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="body_part">
        <div id="OuterBodyContent">
            <div class="Left-Menupart">
                <cc1:Accordion ID="Accordion1" runat="server" FadeTransitions="True" SelectedIndex="0"
                    RequireOpenedPane="true" TransitionDuration="300" HeaderCssClass="accordionHeader"
                    ContentCssClass="accordionContent">
                    <Panes runat="Server">
                        <cc1:AccordionPane ID="AccordionPane1" runat="server">
                            <Header>
                                <table width="100%">
                                    <tr>
                                        <td class="Heading" colspan="4" style="color: White;">
                                            Filters
                                        </td>
                                    </tr>
                                </table>
                            </Header>
                            <Content>
                                <div class="ContentInner">
                                    <ul id="accordion">
                                        <li>District (Select One)</li>
                                        <ul>
                                            <li>
                                                <asp:DropDownList ID="ddlDistrict" runat="server" CssClass="DropDownBox" DataTextField="FDOT_District"
                                                    AutoPostBack="true" Visible="false">
                                                </asp:DropDownList>
                                                <asp:CheckBoxList ID="chkDistrict" runat="server" RepeatLayout="Flow" DataTextField="FDOT_District"
                                                    DataValueField="FDOT_District" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                                
                                            </li>
                                        </ul>
                                        <li>County</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkCounty" runat="server" RepeatLayout="Flow" DataTextField="COUNTY"
                                                    DataValueField="COUNTY" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Extent</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChKISSUE_EXTENT" runat="server" RepeatLayout="Flow" DataTextField="ISSUE_EXTENT"
                                                    DataValueField="ISSUE_EXTENT" AutoPostBack="true" Visible="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Priority</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="chkboxListPriority" runat="server" RepeatLayout="Flow" DataTextField="PRIORITY"
                                                    DataValueField="PRIORITY" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Implementation Ease</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkImplementEase" runat="server" RepeatLayout="Flow" DataTextField="EASE"
                                                    DataValueField="EASE" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Freight Need</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkFreightNeed" runat="server" RepeatLayout="Flow" DataTextField="Freight_Need"
                                                    DataValueField="Freight_Need" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Issue Description</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkIssueDescription" runat="server" RepeatLayout="Flow" DataTextField="ISSUE_DESCRIPTION"
                                                    DataValueField="ISSUE_DESCRIPTION" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Constraints</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkConstraints" runat="server" RepeatLayout="Flow" AutoPostBack="true">
                                                    <asp:ListItem Value="row">ROW Constraint</asp:ListItem>
                                                    <asp:ListItem Value="lightpole">Light Pole Constraint </asp:ListItem>
                                                    <asp:ListItem Value="signage">Signage Constraint</asp:ListItem>
                                                    <asp:ListItem Value="structure">Structure Constraint</asp:ListItem>
                                                    <asp:ListItem Value="Other">Other Constraint</asp:ListItem>
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Source</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkSource" runat="server" RepeatLayout="Flow" DataTextField="SOURCE"
                                                    DataValueField="SOURCE" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Transport System</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkTransportSystem" runat="server" RepeatLayout="Flow" DataTextField="TRANSPORT_SYSTEM"
                                                    DataValueField="TRANSPORT_SYSTEM" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                        <li>Freight System</li>
                                        <ul>
                                            <li>
                                                <asp:CheckBoxList ID="ChkFreightSystem" runat="server" RepeatLayout="Flow" DataTextField="FREIGHT_SYSTEM"
                                                    DataValueField="FREIGHT_SYSTEM" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </li>
                                        </ul>
                                    </ul>
                                </div>
                            </Content>
                        </cc1:AccordionPane>
                        <cc1:AccordionPane ID="AccordionPane2" runat="server">
                            <Header>
                                <table width="100%">
                                    <tr>
                                        <td style="width: 225px;" colspan="4">
                                            <div class="Heading" style="color: White;">
                                                Search
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </Header>
                            <Content>
                                <div class="ContentInner">
                                    <div class="heading">
                                        Search Text
                                    </div>
                                    <div class="dropdownboxouterBox">
                                        <asp:TextBox ID="txtSearchText" runat="server" CssClass="textBox"></asp:TextBox>
                                    </div>
                                    <div class="heading">
                                        Search RdwyID
                                    </div>
                                    <div class="dropdownboxouterBox">
                                        <asp:TextBox ID="txtRdwyID" runat="server" CssClass="textBox"></asp:TextBox>
                                    </div>
                                    <div class="dropdownboxouterBox">
                                        Beg MP &nbsp;&nbsp;<asp:TextBox ID="txtBegMP" runat="server" CssClass="textBox" Width="50px"></asp:TextBox>
                                        &nbsp;&nbsp; End MP &nbsp;&nbsp;<asp:TextBox ID="txtEndMP" runat="server" CssClass="textBox"
                                            Width="50px"></asp:TextBox>
                                    </div>
                                    <div class="dropdownboxouterBox" style="margin-top: 10px;">
                                        <asp:Button ID="btnSearch" runat="server" CssClass="button3" Text="Search" />
                                    </div>
                                </div>
                            </Content>
                        </cc1:AccordionPane>
                    </Panes>
                </cc1:Accordion>
                <div class="ExportButon">
                    <center>
                        <asp:Button ID="btnReset" runat="server" Text="Reset Results" CssClass="button3" />
                        <asp:Button ID="Button1" runat="server" Text="Search" CssClass="button3" Visible="false" OnClick="FilterR" />
                            
                        <asp:Button ID="btnExport" runat="server" Text="Export Table" Visible="false" CssClass="button3"
                            PostBackUrl="~/CFID_MASTER_TBL_xls.zip" />
                    </center>
                    <div style="width: 200px; height: 35px; float: left; text-align: right;">
                        <asp:Label ID="lblSelectedRecord" runat="server"></asp:Label>
                        Record selected out
                        <asp:Label ID="lblTotalRecords" runat="server"></asp:Label>
                    </div>
                </div>
                <div class="dropdownboxouterBox">
                    <asp:Label ID="lblError" runat="server" CssClass="lblError"></asp:Label>
                </div>
            </div>
            <div class="RightPortion">
                <div class="innerRightPortion">
                    <asp:HiddenField ID="HidSort" runat="server" />
                
                            <div style="width: 100%; height: 30px;">
                                <asp:Label ID="lblGrideError" runat="server" CssClass="lblError"></asp:Label></div>
                            <asp:GridView runat="server" Width="100%" ID="grdRecords" AllowSorting="True" ShowFooter="True"
                                OnSorting="SortRecords" CellPadding="2" GridLines="Horizontal" AllowPaging="True"
                                PageSize="653" DataKeyNames="OID" OnRowCancelingEdit="gvPerson_RowCancelingEdit"
                                OnRowDataBound="grdRecords_OnRowDataBound" OnRowEditing="grdRecords_RowEditing"
                                OnRowUpdating="grdRecords_RowUpdating" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging">
                                <HeaderStyle CssClass="GridHeader" />
                                <RowStyle CssClass="GridRowStyle" />
                                <SelectedRowStyle CssClass="GridSelectedRow" />
                                <AlternatingRowStyle CssClass="GridAlternativeRow" />
                                <FooterStyle CssClass="GridFooterStyle" />
                                <Columns>
                                    <asp:CommandField HeaderText="Edit" ShowEditButton="True" ShowHeader="True" Visible="false" EditText="Edit">
                                    </asp:CommandField>
                                    <%--<asp:HyperLinkField DataNavigateUrlFields="OID" DataTextField="SITE_LOCATION"  HeaderText="test"  DataNavigateUrlFormatString="~/view_Record.aspx?OID={0}" />--%>
                                    <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="OID" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="LabelOID" runat="server" Text='<%# Bind("OID") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:Label ID="lblOID" runat="server" Text='<%# Eval("OID") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderImageUrl="~/images/delete.png" Visible="false" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <%-- <asp:Label ID="lblRemove" runat="server" Text="Remove"></asp:Label>--%>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlRemove" runat="server">
                                                <asp:ListItem>Active</asp:ListItem>
                                                <asp:ListItem>Archive</asp:ListItem>
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:HyperLinkField DataNavigateUrlFields="OID" DataTextField="SITE_LOCATION" HeaderText="Site Name"
                                        DataNavigateUrlFormatString="~/view_Record.aspx?OID={0}" ItemStyle-HorizontalAlign="Center" Target="_blank">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:HyperLinkField>
                                    <asp:TemplateField HeaderText="" SortExpression="SITE_LOCATION" ItemStyle-HorizontalAlign="Center">
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtSiteLocation" runat="server" Text='<%# Bind("SITE_LOCATION") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="County" SortExpression="COUNTY" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("COUNTY") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="HidCOUNTY" runat="server" Value='<%# Eval("COUNTY") %>' />
                                            <asp:DropDownList ID="DropDownlistCounty" runat="server" DataTextField="COUNTY" DataValueField="COUNTY">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Priority" SortExpression="PRIORITY" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrtority" runat="server" Text='<%# Eval("PRIORITY") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="HidlblPrtority" runat="server" Value='<%# Eval("PRIORITY") %>' />
                                            <asp:DropDownList ID="DropDownPrority" runat="server" DataTextField="PRIORITY" DataValueField="PRIORITY">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Need" SortExpression="FREIGHT_NEED" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("FREIGHT_NEED") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:HiddenField ID="HidFREIGHT_NEED" runat="server" Value='<%# Eval("FREIGHT_NEED") %>' />
                                            <asp:DropDownList ID="DropDownFrightNeed" runat="server" DataTextField="FREIGHT_NEED"
                                                DataValueField="FREIGHT_NEED">
                                            </asp:DropDownList>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Extent" SortExpression="ISSUE_EXTENT" Visible="false"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("ISSUE_EXTENT") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtIssue" runat="server" Text='<%# Bind("ISSUE_EXTENT") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Verified" SortExpression="FIELD_VERIFIED" ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("FIELD_VERIFIED") %>'
                                                Enabled="false" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:CheckBox ID="ChkVerified" runat="server" ItemStyle-HorizontalAlign="Center"
                                                Checked='<%# Bind("FIELD_VERIFIED") %>' />
                                        </EditItemTemplate>
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:TemplateField>
                               <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="btnComments" runat="server" Text="Dialog" OnClick="btnComments_Click" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                            <asp:AccessDataSource ID="AccessDataSource1" runat="server" DataFile="~/App_Data/CFID.mdb"
                                SelectCommand="SELECT [OID], [COUNTY], [PRIORITY], [FREIGHT_NEED], [SITE_LOCATION], [ISSUE_EXTENT], [FIELD_VERIFIED] FROM [CFID_MASTER_TBL] ORDER BY [PRIORITY], [COUNTY]"
                                UpdateCommand="UPDATE [FIELD_VERIFIED] "></asp:AccessDataSource>
                      
                    
                        
                       <asp:Button runat="server" ID="btnShowModalPopup" Style="display: none" />
                    <cc1:ModalPopupExtender TargetControlID="btnShowModalPopup" ID="ModalPopupExtender2"
                        BehaviorID="pload" runat="server" DynamicServicePath="" Enabled="True" BackgroundCssClass="modalBackground"
                        PopupControlID="Panel3" CancelControlID="LinkButton1" DropShadow="false">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="Panel3" runat="server" CssClass="modalPopup" Style="display: none;">
                        <div id="RegistrationDIV" class="InnerPopupDiv" runat="server">
                            <div class="HeadingPOpup">
                                Project Dialog:</div>
                            <div class="Topheading">
                                <div class="popupCancelButton" onclick="return false;" id="LinkButton1" tooltip="Close">
                                </div>
                            </div>
                            <div class="PopupBody" style="height:205px;">
                                <div class="PopupContent">
                                    <div class="popuprow" style="height: 150px;">
                                        <div class="Popup-Font2">
                                            Comments
                                        </div>
                                        <div class="PopupTextOuter1" style="width: 530px;">
                                            <asp:TextBox ID="txtComments" runat="server" CssClass="PopupTextbox1" ValidationGroup="aaaaa"
                                                TextMode="MultiLine"></asp:TextBox>
                                        </div>
                                        <asp:RequiredFieldValidator ID="requiredUsername" runat="server" ValidationGroup="aaaaa"
                                            CssClass="Validation" ErrorMessage="*" ControlToValidate="txtComments"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="popuprow">
                                        <div class="Popup-Font2">
                                            <asp:Label ID="lblPopuError" runat="server"></asp:Label>
                                        </div>
                                        <div class="PopupTextOuter">
                                            <asp:Button ID="btnSave" runat="server" Text="Submit" ValidationGroup="aaaaa" OnClick="btnSave_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <asp:HiddenField ID="HidOID" runat="server" />
                            <div class="PopupBody" style="height:210px; float:left;">
                            <asp:UpdatePanel ID="BtnPopuUpUpdatePanel" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                                <asp:GridView ID="gvPopupup" runat="server" AutoGenerateColumns="False"
                                EnableModelValidation="True" PageSize="10" AllowPaging="true" GridLines="None" Width="100%">
                                    <HeaderStyle CssClass="GridHeader" />
                                    <RowStyle CssClass="GridRowStyle" />
                                    <SelectedRowStyle CssClass="GridSelectedRow" />
                                    <AlternatingRowStyle CssClass="GridAlternativeRow" />
                                    <FooterStyle CssClass="GridFooterStyle" />
                                    <Columns>
                                        <asp:BoundField DataField="OBJECTID" HeaderText="OBJECTID" SortExpression="OBJECTID" />
                                        <asp:BoundField DataField="USERNAME" HeaderText="USERNAME" SortExpression="USERNAME" />
                                        <asp:BoundField DataField="COMMENT" HeaderText="COMMENT" SortExpression="COMMENT" />
                                        <asp:BoundField DataField="COMMENT_DATE" HeaderText="COMMENT_DATE" SortExpression="COMMENT_DATE" />
                                    </Columns>
                                </asp:GridView>
                                <asp:AccessDataSource ID="DSPopupComment" runat="server" DataFile="~/App_Data/CFID.mdb"
                                    SelectCommand="SELECT [OBJECTID], [USERNAME], [COMMENT], [COMMENT_DATE] FROM [USER_COMMENT]">
                                </asp:AccessDataSource>
                                
                     </ContentTemplate>
                    </asp:UpdatePanel>
                            </div>
                            <asp:HiddenField ID="HidUserName" runat="server" />
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </div>
    <asp:AccessDataSource ID="DSDistrict" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [FDOT_District] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSPRIORITY" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [PRIORITY] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSPEASE" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [EASE] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSCounty" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [COUNTY] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSISSUE_EXTENT" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [ISSUE_EXTENT] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSFreight_Need" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [Freight_Need] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSIssueDescription" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [ISSUE_DESCRIPTION] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSSource" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [SOURCE] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSTRANSPORT_SYSTEM" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [TRANSPORT_SYSTEM] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSFreightSystem" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT [FREIGHT_SYSTEM] FROM [CFID_MASTER_TBL]"></asp:AccessDataSource>
    <asp:AccessDataSource ID="DSCountry2" runat="server" DataFile="~/App_Data/CFID.mdb"
        SelectCommand="SELECT DESCRIPTION as COUNTY FROM  LU_COUNTY"></asp:AccessDataSource>
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
