<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/index.aspx.vb" Inherits="index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CFID - Comprehensive Freight Improvement Database</title>
    <link href="css/style.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
        //window.location = "mapViewer/default.aspx";
    </script>
</head>
<body id="body_login_page">
    <form id="form1" runat="server">
    <div id="wrapper">
        <div id="login_position">
            <div id="logo">
            </div>
            
            <div id="login_box">
                <div id="login_box_top">
                </div>
                <div id="login_box_center">
                    <div id="login_box_form">
                        <asp:Panel runat="server" ID="pnlMessage">
                            <div class="login_box_form_row">
                                <asp:Label runat="server" ID="lblMessage" />
                            </div>
                        </asp:Panel>
                        <div class="login_box_form_row">
                            Username
                        </div>
                        <div class="login_box_form_row">
                            <asp:TextBox runat="server" ID="txtUserName" CssClass="login_box_form_input" Width="300px" />
                        </div>
                        <div class="login_box_form_row">
                            Password</div>
                        <div class="login_box_form_row">
                            <asp:TextBox runat="server" ID="txtPassword" CssClass="login_box_form_input" TextMode="Password"
                                Width="300px" />
                        </div>
                       <%-- <div class="login_box_form_row">
                            Select District
                        </div>--%>
                       <%-- Once uncompiled this tool can be removed.--%>
                        <div class="login_box_form_row">
                            <asp:DropDownList ID="ddlDistrict" Visible="false" runat="server" CssClass="login_box_form_input" >
                                <asp:ListItem Text="District 1" Value="1" />
                                <asp:ListItem Text="District 7" Value="7" />
                            </asp:DropDownList>
                        </div>
                        <div class="login_box_form_row">
                            <label class="login_box_form_label left_float" style="padding-top: 8px; margin-right: 5px;">
                                &nbsp;</label>
                            <label class="login_box_form_label right_float">
                                <asp:ImageButton runat="server" ID="btnLogin" ImageUrl="images/login.gif" alt="Login"
                                    Style="outline: none" /></label>
                        </div>
                         <div class="login_box_form_row">
                           
                           <%-- <label class="login_box_form_input"><asp:Button ID="Button1" runat="server" CssClass="button3" Text="View Disclaimer" PostBackUrl="~/ViewAll_Records.aspx" Height="30px" Width="117px" />
                               </label>--%>
                        </div>
                    </div>
                </div>
                <div id="login_box_bottam">
                </div>
                <div class="login_box_row">
                    <p>
                        <a href="mailto:jkrolick@gc-inc.com&subject=CFID Password Reset">Reset Password?</a>
                </div>
                
                
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
    </form>
</body> 
</html>
