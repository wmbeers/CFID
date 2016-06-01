Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration

Partial Public Class ViewRecords
    Inherits System.Web.UI.Page

    Dim dbconn As SqlConnection = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        dbconn = New SqlConnection(ConfigurationManager.ConnectionStrings("DefaultConnection").ToString())
        dbconn.Open()
        If Not Page.IsPostBack Then
            FillDetails()
        End If
    End Sub

    Private Sub FillDetails()
        Try
            If Request("issueIds") Is Nothing OrElse Request("issueIds") = "" Then
                Throw New Exception("CFID issue id not provided")
            End If
            Dim issueIds As String = Request("issueIds")
            'Sanitize to prevent SQL Injection attacks
            For Each issueId As String In issueIds.Split(",")
                Dim i As Integer
                If Not Integer.TryParse(issueId, i) Then
                    Throw New Exception("Only integers may be provided as CFID issue ids")
                End If
            Next

            Dim sql = "Select IssueID, FDOT_District, COUNTY, SITE_LOCATION, ISSUESITELOC, ISSUE_DESCRIPTION, CORRIDOR_SEGMENT, EASE, ROWCONSTRAINT, UTILITYCONSTRAINT, LIGHTPOLECONSTRAINT, SIGNAGECONSTRAINT, STRUCTURECONSTRAINT, OTHERCONSTRAINT, FIELD_VERIFIED, DATE_RECOMMENDED, ROADWAYID, SECONDRDWYID, LOCMP, Ydd, Xdd, TRANSPORT_SYSTEM, FIELD_OBS,MISC_INFO " &
                "From cfid_combined Where issueID in (" & issueIds & ") "
            Dim dbcomm = New SqlCommand(sql, dbconn)
            Dim adp As New SqlDataAdapter(dbcomm)
            Dim dt As New DataTable
            If adp.Fill(dt) > 0 Then
                RecordsRepeater.DataSource = dt
                RecordsRepeater.DataBind()
            Else
                MessageLiteral.Text = "Invalid Issue ID"
            End If
            dbconn.Close()
        Catch ex As Exception
            MessageLiteral.Text = ex.Message
            If dbconn IsNot Nothing Then
                If dbconn.State = ConnectionState.Open Then
                    dbconn.Close()
                End If
            End If


        End Try
    End Sub

    Protected Sub RecordsRepeater_ItemDataBound(sender As Object, e As RepeaterItemEventArgs) Handles RecordsRepeater.ItemDataBound
        'Check/uncheck/disable checkbox images based on data bound, for each of the following fields
        Dim dr As DataRowView = e.Item.DataItem

        For Each FieldName As String In New String() {"FIELD_VERIFIED", "ROWCONSTRAINT", "UTILITYCONSTRAINT", "LIGHTPOLECONSTRAINT", "SIGNAGECONSTRAINT", "STRUCTURECONSTRAINT", "OTHERCONSTRAINT"}
            Dim img As Image = e.Item.FindControl(FieldName)
            Dim fieldValue As String = dr(FieldName).ToString()
            If fieldValue = "Yes" Then
                img.ImageUrl = "~/images/checkbox-icon.png"
            ElseIf fieldValue = "Not Available" Then
                img.CssClass = "disabledImage"
            End If
        Next

    End Sub
End Class