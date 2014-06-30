Imports System.Data.OleDb
Partial Class index
    Inherits System.Web.UI.Page
    Dim dbconn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            pnlMessage.Visible = False
        End If
    End Sub

    'Public Sub Bind_Dropdowns(ByVal ddl As DropDownList, ByVal value As Integer)
    '    Try
    '        ConnectDatabase()
    '        Dim sql = "Select * From tblCF_General Where Parent_id=" & value
    '        Dim dbcomm = New OleDbCommand(sql, dbconn)
    '        Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
    '        Dim ds As New DataSet
    '        adp.Fill(ds)
    '        ddl.DataSource = ds
    '        ddl.DataTextField = "Description"
    '        ddl.DataValueField = "Record_id"
    '        ddl.DataBind()
    '        ddl.Items.Insert(0, "No Value")
    '        ddl.Items(0).Value = "0"
    '        ddl.SelectedIndex = 0
    '    Catch ex As Exception
    '        lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
    '    End Try
    'End Sub

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnLogin.Click
        Try
            If (txtUserName.Text <> "") Then
                If (txtPassword.Text <> "") Then
                    If FormsAuthentication.Authenticate(txtUserName.Text, txtPassword.Text) Then
                        Session("District") = ddlDistrict.SelectedValue
                        Session("screenname") = User.Identity.Name
                        Session("IsLogin") = "true"
                        FormsAuthentication.RedirectFromLoginPage(txtUserName.Text, True)
                    Else
                        pnlMessage.Visible = True
                        lblMessage.Text = "<font color=red><strong>User Name or Password Incorrect !!!</strong></font>"
                    End If
                Else
                    lblMessage.Text = "UserName and password can't be blank"
                End If
            Else
                lblMessage.Text = "UserName and password can't be blank"
            End If
        Catch ex As Exception
            pnlMessage.Visible = True
            lblMessage.Text = "<font color=red><strong>" & ex.Message.ToString() & "</strong></font>"
        End Try
    End Sub

    Private Sub ConnectDatabase()
        dbconn = New OleDbConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
    End Sub
End Class
