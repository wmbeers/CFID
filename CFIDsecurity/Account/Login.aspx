<%@ Page Title="CFID Security Log In" Language="VB" MasterPageFile="~/site.Master" AutoEventWireup="true" CodeFile="Login.aspx.vb" Inherits="Account_Login" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<%--<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder1"> --%> 
  <asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
      <center>
      <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/logo-login-page-cfid.jpg" />
      <hgroup class="title">
        <h1><%: Title %>.</h1>
    </hgroup>
    
    <section id="loginForm">
       <%-- <h3>Profile log in.</h3>--%>
        <asp:Login runat="server" ViewStateMode="Disabled" BackColor="White" 
            BorderColor="#E6E2D8" BorderPadding="4" BorderStyle="Solid" BorderWidth="1px" 
            Font-Names="Verdana" Font-Size="0.8em" ForeColor="#333333" 
            TextLayout="TextOnTop" Width="406px">
            <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
            <LayoutTemplate>
                <p class="validation-summary-errors">
                    <asp:Literal runat="server" ID="FailureText" />
                </p>
                <fieldset>
                    <legend>Log in Form</legend>
                    <ol>
                        <li>
                            <asp:Label runat="server" AssociatedControlID="UserName">User name</asp:Label>
                            <asp:TextBox runat="server" ID="UserName" />
                            <br />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                                 CssClass="field-validation-error" ErrorMessage="The user name field is required." />
                        </li>
                        <li>
                            <asp:Label runat="server" AssociatedControlID="Password">Password</asp:Label>
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" />
                              <br />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                                 CssClass="field-validation-error" ErrorMessage="The password field is required." />
                        </li>
                        <li>
                            <asp:CheckBox runat="server" ID="RememberMe" />
                            <asp:Label runat="server" AssociatedControlID="RememberMe" CssClass="checkbox">Remember me?</asp:Label>
                        </li>
                    </ol>
                    <asp:Button runat="server" CommandName="Login" Text="Log in" Font-Bold="true" />
                </fieldset>
            </LayoutTemplate>
            <LoginButtonStyle BackColor="White" BorderColor="#C5BBAF" BorderStyle="Solid" 
                BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#1C5E55" />
            <TextBoxStyle Font-Size="0.8em" />
            <TitleTextStyle BackColor="#1C5E55" Font-Bold="True" Font-Size="0.9em" 
                ForeColor="White" />
        </asp:Login>
        <p>
            <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled" Visible="false">Register</asp:HyperLink>
          <%--  if you don't have an account.--%>
        </p>
       <%-- <h3>Use another service to log in.</h3>--%>
        <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" Visible="false" />
    </section>
    <section id="socialLoginForm" >
     
    </section>
        </center>
</asp:Content>