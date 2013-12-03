Imports System.Data.OleDb
Imports System.Data
Imports System.Configuration

Partial Public Class Print_Record
    Inherits System.Web.UI.Page
    Dim dbconn


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillDetails()
        End If
    End Sub


    Private Sub FillDetails()
        Try
            ConnectToDatabase()
            Dim sql = "Select * From CFID_MASTER_TBL_archive Where ObjectID=" & Request("ObjectID").ToString()
            Dim dbcomm = New OleDbCommand(sql, dbconn)
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim ds As New DataSet
            adp.Fill(ds)



            Me.lblOID.Text = ds.Tables(0).Rows(0)("ObjectID").ToString()
            lblCorridorName.Text = ds.Tables(0).Rows(0)("CORRIDOR").ToString()
            lblBeginMP.Text = ds.Tables(0).Rows(0)("BEGMP").ToString()
            lblComments.Text = ds.Tables(0).Rows(0)("COMMENTS").ToString()
            lblDateYearRecommended.Text = ds.Tables(0).Rows(0)("DATE_RECOMMENDED").ToString()
            lblEndingMP.Text = ds.Tables(0).Rows(0)("ENDMP").ToString()
            lblLatitude.Text = ds.Tables(0).Rows(0)("LATY").ToString()
            lblLongitude.Text = ds.Tables(0).Rows(0)("LONX").ToString()
            lblRoadwayId.Text = ds.Tables(0).Rows(0)("ROADWAYID").ToString()
            lblSegmentFrom.Text = ds.Tables(0).Rows(0)("SEGMENT_FROM").ToString()
            lblSegmentTo.Text = ds.Tables(0).Rows(0)("SEGMENT_TO").ToString()
            lblSiteLocation.Text = ds.Tables(0).Rows(0)("SITE_LOCATION").ToString()


            lblType.Text = ds.Tables(0).Rows(0)("ISSUE_EXTENT").ToString()
            lblCounty.Text = ds.Tables(0).Rows(0)("COUNTY").ToString()
            lblCorridorSegment.Text = ds.Tables(0).Rows(0)("Corridor_Segment").ToString()
            lblTransSys.Text = ds.Tables(0).Rows(0)("TRANSPORT_SYSTEM").ToString()
            lblImporvementStage.Text = ds.Tables(0).Rows(0)("IMPRVMNT_STAGE").ToString()
            lblIssueDescription.Text = ds.Tables(0).Rows(0)("ISSUE_DESCRIPTION").ToString()

            lblSource.Text = ds.Tables(0).Rows(0)("SOURCE").ToString()
            lblFreightSys.Text = ds.Tables(0).Rows(0)("FREIGHT_SYSTEM").ToString()
            Me.chkFieldVerified.Checked = ds.Tables(0).Rows(0)("FIELD_VERIFIED").ToString()
            lblDefinationDesc.Text = ds.Tables(0).Rows(0)("FREIGHT_NEED").ToString()


            lblRecomDesc.Text = ds.Tables(0).Rows(0)("RECOMMENDATION_DESC").ToString()
            lblFieldObs.Text = ds.Tables(0).Rows(0)("FIELD_OBS").ToString()
          
            lblMiscInfo.Text = ds.Tables(0).Rows(0)("MISC_INFO").ToString()


        Catch ex As Exception
            'lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub


    Private Sub ConnectToDatabase()
        dbconn = New OleDbConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
    End Sub
End Class