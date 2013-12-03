<%@ Page Title="" Language="VB" MasterPageFile="~/GMweb.master" AutoEventWireup="false" CodeFile="General_Master.aspx.vb" Inherits="General_Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div id="body_part">
        <div id="body_part_left_col">
            
            <div id="executive_form">
                <b id="executive_form_top"></b>
                <div id="executive_form_center">
                    <div class="row"><h4>
                            Manage the Lookup and Drop Down values.</h4>
                    </div>
                    
                    <div class="row bottom_boder">
                        <asp:Label runat="server" ID="lblMessage" />
                    </div>
                    <div class="row">
                    </div>
                    <div class="row">
                        <label class="executive_form_label">
                            Field to Add New Item :</label>
                        <asp:DropDownList runat="server" AutoPostBack="true" ID="ddlParentName" Width="250px" CssClass="executive_form_input" />
                    </div>
                    <div class="row">
                        <label class="executive_form_label">
                            Description :</label>
                        <asp:TextBox runat="server" ID="txtdescrption" CssClass="executive_form_input" />
                    </div>
                    <div class="row">
                        <label class="executive_form_label">
                            &nbsp;</label>
                        <label class="executive_form_label_1">
                            <asp:Button runat="server" ID="btnSubmit" CssClass="button1" Text="Submit"/></label>
                        <label class="executive_form_label_1">
                            <asp:Button runat="server" ID="btnCancel" CssClass="button1" Text="Cancel"/></label>
                    </div>
                    <div class="row bottom_boder">
                    </div>
                    <div class="row">
                     <label class="executive_form_label">
                            &nbsp;</label>
                        <asp:GridView ID="grdRecords" runat="server" AutoGenerateColumns="False"  Width="70%"
                            BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" 
                            CellPadding="3" GridLines="Horizontal">
                            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                            <HeaderStyle BackColor="#4A3C8C" Height="30px" Font-Bold="True" ForeColor="#F7F7F7" />
                            <AlternatingRowStyle BackColor="#F7F7F7" />
                            <Columns>
                                <asp:TemplateField HeaderText="Description" HeaderStyle-HorizontalAlign="Left">
                                    <ItemTemplate>
                                        <%#DataBinder.Eval(Container.DataItem, "Description")%>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <Columns>
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgbtnedit" ToolTip="Edit" runat="server" ImageUrl="images/edit.png" CommandName="ed" CommandArgument='<%# Eval("Record_id") %>'/> 
                                        <asp:ImageButton ID="imgbtndelete" Visible="false" ToolTip="Delete" runat="server" ImageUrl="images/delete.png" CommandName="del" CommandArgument='<%# Eval("Record_id") %>' OnClientClick='return confirm("Are you sure to delete the selected Record")' />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
                <b id="executive_form_bottom"></b>
            </div>
        </div>
        <div id="body_part_right_col">
            <div class="row">
                <b id="executive_box_top"></b>
                <div id="executive_box_center">
                    <p class="executive_box_heading">
                        Information</p>
                    <div class="row">
                        <p>
                             The purpose of the database is to provide engineers and planners at the Department, 
                             MPOs, local governments and transportation consultants with single source of 
                             information regarding all aspects of the Tampa Bay Regional Goods Movement System 
                             for use in project scoping, corridor analysis, sub-area analysis, project design 
                             requirements, input to the regional transportation model, and long range planning. </p>

 <p>

If you encounter any problems using this site, or cannot find the information you need, please <a href="mailto:Gmap@gc-inc.com"> Email</a> or call Mary Stallings at (813) 387-0084.

</p>
                       
                    </div>
                </div>
                <b id="executive_box_bottom"></b>
            </div>
        </div>
    </div>
</asp:Content>

