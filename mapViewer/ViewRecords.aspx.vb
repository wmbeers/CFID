Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration

Partial Public Class ViewRecords
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillDetails()
        End If
    End Sub


    Private Sub FillDetails()
        Dim dbconn As SqlConnection = Nothing
        Try
            If Request.Form("issueIds") Is Nothing OrElse Request.Form("issueIds") = "" Then
                Throw New Exception("CFID record # not provided")
            End If
            dbconn = New SqlConnection(ConfigurationManager.AppSettings("connectionString").ToString())
            dbconn.Open()
            'TODO: leaves us open to SQL Injection attack!
            Dim sql = "Select IssueID, FDOT_District, COUNTY, CORRIDOR, ISSUE_EXTENT, SITE_LOCATION, SEGMENT_TO, SEGMENT_FROM, ISSUESITELOC, FREIGHT_NEED, ISSUE_DESCRIPTION, CORRIDOR_SEGMENT, PRIORITY, EASE, ROWCONSTRAINT, UTILITYCONSTRAINT, LIGHTPOLECONSTRAINT, SIGNAGECONSTRAINT, STRUCTURECONSTRAINT, OTHERCONSTRAINT, FIELD_VERIFIED, DATE_RECOMMENDED, ROADWAYID, BEGMP, ENDMP, SECONDRDWYID, LOCMP, LATY, LONX, LAT, LON, TRANSPORT_SYSTEM, FREIGHT_SYSTEM, FIELD_OBS, RECOMMENDATION_DESC, COMMENTS, IMPRVMNT_STAGE, IMPRVMNT_STAGE_NAME, SOURCE, DATE_MODIFIED, MISC_INFO " & _
                "From cfid_point Where issueID in (" & Request.Form("issueIds").ToString() & ") union " & _
                "Select IssueID, FDOT_District, COUNTY, CORRIDOR, ISSUE_EXTENT, SITE_LOCATION, SEGMENT_TO, SEGMENT_FROM, ISSUESITELOC, FREIGHT_NEED, ISSUE_DESCRIPTION, CORRIDOR_SEGMENT, PRIORITY, EASE, ROWCONSTRAINT, UTILITYCONSTRAINT, LIGHTPOLECONSTRAINT, SIGNAGECONSTRAINT, STRUCTURECONSTRAINT, OTHERCONSTRAINT, FIELD_VERIFIED, DATE_RECOMMENDED, ROADWAYID, BEGMP, ENDMP, SECONDRDWYID, LOCMP, LATY, LONX, LAT, LON, TRANSPORT_SYSTEM, FREIGHT_SYSTEM, FIELD_OBS, RECOMMENDATION_DESC, COMMENTS, IMPRVMNT_STAGE, IMPRVMNT_STAGE_NAME, SOURCE, DATE_MODIFIED, MISC_INFO  " & _
                "From cfid_line Where issueID in (" & Request.Form("issueIds").ToString() & ")"
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

        'TODO: this is where we data-bind the user comments grid based on the issue ID
        Dim gv As GridView = e.Item.FindControl("UserCommentsGridView")
        Dim dbconn As SqlConnection = New SqlConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
        Dim adp As New SqlDataAdapter("select * from CFID_COMMENT where IssueID = @issueID order by CommentDate", dbconn)
        adp.SelectCommand.Parameters.AddWithValue("issueID", dr("IssueID"))
        Dim UserCommentsDataTable As New DataTable
        adp.Fill(UserCommentsDataTable)
        dbconn.Close()
        gv.DataSource = UserCommentsDataTable
        gv.DataBind()


    End Sub
End Class