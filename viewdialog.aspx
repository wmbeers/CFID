<%@ Page Title="Dialog" Language="VB" MasterPageFile="~/GMweb.master" AutoEventWireup="false" CodeFile="viewdialog.aspx.vb" Inherits="viewdialog" %>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

 <asp:Label runat="server" ID="lblID" 
                            CssClass="executive_form_input" Width="100px" />
                             <asp:Label runat="server" ID="lblmessage" 
                            CssClass="executive_form_input" Width="100px" />

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True"  PageSize="130"
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="10" 
        DataKeyNames="OID" DataSourceID="AccessDataSource2" ForeColor="#333333"
        GridLines="None">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
           
            <asp:BoundField DataField="OBJECTID" HeaderText="Issue ID" 
                SortExpression="OBJECTID" />
            <asp:BoundField DataField="COMMENT" HeaderText="COMMENT" 
                SortExpression="COMMENT" />
            <asp:BoundField DataField="USERNAME" HeaderText="USERNAME" 
                SortExpression="USERNAME" />
            <asp:BoundField DataField="COMMENT_DATE" HeaderText="Comment Date" 
                SortExpression="COMMENT_DATE" DataFormatString="{0:d}" />
            
        </Columns>
        <FooterStyle BackColor="#999999" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>

    <asp:AccessDataSource ID="AccessDataSource2" runat="server" 
        DataFile="~/App_Data/CFID.mdb" 
        SelectCommand="SELECT * FROM [USER_COMMENT]">
    </asp:AccessDataSource>

</asp:Content>

