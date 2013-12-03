<%@ Page Title="CFID - Contact Us" Language="VB" MasterPageFile="~/GMweb.master" AutoEventWireup="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Import namespace = "System.net.mail" %>

<script runat="server">

    Protected Sub Wizard1_FinishButtonClick(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.WizardNavigationEventArgs)
        
        SendEmail(Me.txtEmail.Text, Me.txtComment.Text)
        
    End Sub
    
    
    Private Sub SendEmail(ByVal from As String, ByVal body As String)
        Dim mail As New MailMessage()
       
        Dim mailbody As New StringBuilder
        mail.From = New MailAddress("jkrolick@dev.gc-inc.com")
        mail.To.Add("jkrolick@gc-inc.com")
        ' mail.To.Add("mstallings@gc-inc.com")
        ' mail.To.Add("fkalpakis@citiesthatwork.com")
        ' mail.To.Add("brian.hunter@dot.state.fl.us")
        '  mail.To.Add("bob.odonnell@urs.com")
        
        
        mail.Subject = "CFID feedback has been sent to you for review."
        mail.IsBodyHtml = True
        mailbody.Append("<html>")
   
        mailbody.Append("<br /><br />")
        mailbody.Append("<strong>Name:</strong>&nbsp;" & Me.txtName.Text)
        mailbody.Append("<br /><br />")
        mailbody.Append("<strong>Email Address:</strong>&nbsp;" & Me.txtEmail.Text)
        mailbody.Append("<br /><br />")
        mailbody.Append("<strong>Commentor wants to be contacted:</strong>&nbsp;" & Me.chkcontact.Checked)
        mailbody.Append("<br /><br />")
        mailbody.Append("<strong>Phone:</strong>&nbsp;" & Me.txtPhone.Text)
        mailbody.Append("<br /><br />")
        
        mailbody.Append("<strong>Zip Code:</strong>&nbsp;" & Me.txtZipCode.Text)
        mailbody.Append("<br /><br />")
        mailbody.Append("<strong>Type of comment</strong>&nbsp;" & Me.ddlCommentType.Text)
        mailbody.Append("<br /><br />")
        mailbody.Append("<strong>Message:</strong>&nbsp;" & Me.txtComment.Text)
        mailbody.Append("<br /><br />")
        
        
        mail.Body = mailbody.ToString()
        Dim smtp As New SmtpClient("66.118.142.62")
        
        Try
            smtp.Send(mail)
            
        Catch ex As Exception

        End Try
        
        
        smtp.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis
        
        
    End Sub
    
    
    
    
    
    
    
    
    
    
    
    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


<%--<script language="javascript" type="text/javascript">


    function ValidateComments(Sender, Args)
{
if (args.isvalid.length > 15)
args.isvalid = false
esle
args.isvalid = true

}

</script>--%>



    <div id="body_part">
        <div>
            <div class="row">
                <center>
                    <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="0" BackColor="#EFF3FB" 
                        BorderColor="#B5C7DE" BorderWidth="1px" Font-Names="Verdana" Font-Size="Medium" 
                        Height="374px" Width="836px" 
                        onfinishbuttonclick="Wizard1_FinishButtonClick">
                        <StepStyle Font-Size="0.8em" ForeColor="#333333" VerticalAlign="Top" />
                        <WizardSteps>
                            <asp:WizardStep runat="server" Title="Contact Info">
                                <table style="width: 100%; height: 174px;">
                                    <tr>
                                        <td>
                                            <label class="executive_form_label light11">
                                            <big>Your Name :</big>
                                            </label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtName" runat="server" AutoCompleteType="DisplayName" 
                                                CssClass="executive_form_input" Width="200px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:RequiredFieldValidator ID="RFVname" runat="server" 
                                                ControlToValidate="txtName" ErrorMessage="Please enter a name">*</asp:RequiredFieldValidator>
                                        </td>
                                       
                                    </tr>
                                    <tr>
                                        <td>
                                            <label class="executive_form_label light11">
                                            <big>Email :</big>
                                            </label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtEmail" runat="server" AutoCompleteType="Email" 
                                                CssClass="executive_form_input" Width="200px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <%--<asp:RegularExpressionValidator ID="RFVemail" runat="server" ControlToValidate="txtEmail"  ErrorMessage="Please enter a valid email address" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}">
                                            *</asp:RegularExpressionValidator>--%>
                                           
                                            <asp:RequiredFieldValidator ID="RFVemail" runat="server"  
                                                ControlToValidate="txtEmail"   ErrorMessage="Please enter a email address">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td>
                                            <label class="executive_form_label light11">
                                            <big>Phone Number :</big>
                                            </label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPhone" runat="server" AutoCompleteType="BusinessPhone"
                                                CssClass="executive_form_input" Width="200px"></asp:TextBox>
                                        </td>
                                        <td>
                                           <%-- <asp:RegularExpressionValidator ID="RFVphone" runat="server" ControlToValidate="txtPhone"  ErrorMessage="Please enter a valid US phone number" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$">
                                            *</asp:RegularExpressionValidator>--%>
                                            <asp:RequiredFieldValidator ID="RFVphone" runat="server" ControlToValidate="txtPhone"  ErrorMessage="Please enter a valid US phone number">*</asp:RequiredFieldValidator>
                                           
                                        </td>
                                    </tr>
                                   
                                        <br />
                                        <br />
                                        <tr>
                                            <td>
                                                <label class="executive_form_label light11">
                                                <big>Zip Code :</big>
                                                </label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtZipCode" runat="server" AutoCompleteType="BusinessZipCode" 
                                                    CssClass="executive_form_input" Width="200px"></asp:TextBox>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        
                                            <br />
                                            <br />
                                            <tr>
                                                <td>
                                                    <label class="executive_form_label light11">
                                                    <big>Would you like to be contacted? :</big>
                                                    </label>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkcontact" CssClass="executive_form_label light11" runat="server" Text="Please check, if YES." />
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
                                                </td>
                                                <td>
                                                </td>
                                            </tr>
                                       
                                </table>
                               
                            </asp:WizardStep>
                            <asp:WizardStep runat="server" Title="Comments">
                            <br />
                               <br />
                                <label class="executive_form_label light11"><big>Type of comment :</big> </label>&nbsp;
                               <asp:DropDownList runat="server" ID="ddlCommentType" CssClass="DropDownBox">
                              <asp:ListItem>Project Idea</asp:ListItem>
                               <asp:ListItem>Public Interest</asp:ListItem>
                              <asp:ListItem>Technical Issue</asp:ListItem>
                              <asp:ListItem>Stakeholder Comment</asp:ListItem>
                              <asp:ListItem>Other Comment</asp:ListItem>
                              </asp:DropDownList>
                              
                              <br />
                               <br />
                               <table>
                                 <tr>
                                 <td>
                                   <label class="executive_form_label light11"><big>Comments :</big> </label>
                                    </td>
                                   <td>
                                        <asp:TextBox runat="server" ID="txtComment" AutoCompleteType="Notes" CssClass="executive_form_input" TextMode="MultiLine"
                                            Width="385px" Height="119px" />
                                 </td>
                                <td>
                                  </td>
                                    </tr>
                                    
                                    <tr>
                                    <td></td>
                                    <td><asp:CustomValidator ID="CommentValidator" runat="server" ControlToValidate="txtComment" ErrorMessage="CustomValidator" ClientValidationFunction="ValidateComments"></asp:CustomValidator>  
                                </td>
                                    <td></td>
                                    </tr>
                                    
                                </table> 
                                <table>
                                <tr>
                                <td>
                                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" />
                                </td>
                                <td>
                                </td>
                                </tr>
                                 </table>
                            </asp:WizardStep>
                            <asp:WizardStep runat="server" StepType="Finish" Title="Summary">
                            <center>
                                <asp:Label ID="Label1" runat="server" Text="Label" CssClass="executive_form_label"> Thank you for filling out our contact form. Please submit your comment by pressing Finish.</asp:Label>
                            </center>
                            </asp:WizardStep>
                            <asp:WizardStep runat="server" StepType="Complete" Title="Complete">
                            <center>
                            <asp:Label ID="Label2" runat="server" Text="Label" CssClass="executive_form_label"> Thank you, your comment has been submitted.</asp:Label><br />
                            <asp:Button ID="btnViewall" runat="server" PostBackUrl="~/ViewAll_Records.aspx" Text="Return to Main Page" CssClass="button4"/>
                            </center>
                            </asp:WizardStep>
                        </WizardSteps>
                        <SideBarButtonStyle Font-Names="Verdana" 
                            ForeColor="White" />
                        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" 
                            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" 
                            ForeColor="#284E98" />
                        <SideBarStyle BackColor="#2E4D7B" Font-Size="0.9em" VerticalAlign="Top" 
                            Width="150px" />
                        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" 
                            BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" 
                            HorizontalAlign="Center" />
                    </asp:Wizard>
               
                
                </center>
                </div>
            
                </div>
                
            </div>
                
   
</asp:Content>

