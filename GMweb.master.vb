
Partial Class GMweb
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If (Session("screenname") = String.Empty) Then
            'Response.Redirect("~/index.aspx")
        End If
        ScriptManager.RegisterClientScriptBlock(Me, GetType(Page), "validationAlert", """, 0);", True)


    End Sub
    Protected Sub lnkLogout_Click(ByVal sender As Object, ByVal e As EventArgs)

        Session.Abandon()
    End Sub
End Class

