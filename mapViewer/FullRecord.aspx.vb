Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration

Partial Public Class Print_Record
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillDetails()
        End If
    End Sub


    Private Sub FillDetails()
        Dim dbconn As SqlConnection = Nothing
        Try
            If Request("OID") Is Nothing Then
                Throw New Exception("CFID record # not provided")
            End If
            dbconn = New SqlConnection(ConfigurationManager.AppSettings("connectionString").ToString())
            dbconn.Open()
            Dim sql = "Select * From cfid_master_view Where OBJECTID=" & Request("OID").ToString()
            Dim dbcomm = New SqlCommand(sql, dbconn)
            Dim adp As New SqlDataAdapter(dbcomm)
            Dim dt As New DataTable
            If adp.Fill(dt) > 0 Then
                Dim dr As DataRow = dt.Rows(0)
                Me.lblID.Text = dr("OBJECTID").ToString()
                Me.lblFDOTDistrict.Text = dr("FDOT_District").ToString()
                lblCorridorName.Text = dr("CORRIDOR").ToString()
                lblBeginMP.Text = dr("BEGMP").ToString()
                lblComments.Text = dr("COMMENTS").ToString()
                lblDateYearRecommended.Text = dr("DATE_RECOMMENDED").ToString()
                lblEndingMP.Text = dr("ENDMP").ToString()
                lblLatitude.Text = dr("LATY").ToString()
                lblLongitude.Text = dr("LONX").ToString()
                lblRoadwayId.Text = dr("ROADWAYID").ToString()
                lblSegmentFrom.Text = dr("SEGMENT_FROM").ToString()
                lblSegmentTo.Text = dr("SEGMENT_TO").ToString()
                lblSiteLocation.Text = dr("SITE_LOCATION").ToString()

                Me.lblSecondRDWYID.Text = dr("SECONDRDWYID").ToString()

                lblType.Text = dr("ISSUE_EXTENT").ToString()
                lblCounty.Text = dr("COUNTY").ToString()
                lblCorridorSegment.Text = dr("Corridor_Segment").ToString()
                lblTransSys.Text = dr("TRANSPORT_SYSTEM").ToString()
                ' lblImporvementStage.Text = dr("IMPRVMNT_STAGE").ToString()
                lblIssueDescription.Text = dr("ISSUE_DESCRIPTION").ToString()

                lblSource.Text = dr("SOURCE").ToString()
                lblFreightSys.Text = dr("FREIGHT_SYSTEM").ToString()
                CheckImage(imgFieldVerified, dr("FIELD_VERIFIED").ToString())
                lblDefinationDesc.Text = dr("FREIGHT_NEED").ToString()


                lblRecomDesc.Text = dr("RECOMMENDATION_DESC").ToString()
                lblFieldObs.Text = dr("FIELD_OBS").ToString()
                Me.lblLOCMP.Text = dr("LOCMP").ToString()
                Me.lblIssueLoc.Text = dr("ISSUESITELOC").ToString()

                CheckImage(imgROW, dr("ROWCONSTRAINT").ToString())
                CheckImage(imgUtility, dr("UTILITYCONSTRAINT").ToString())
                CheckImage(imgLightPole, dr("LIGHTPOLECONSTRAINT").ToString())
                CheckImage(imgSignage, dr("SIGNAGECONSTRAINT").ToString())
                CheckImage(imgStructure, dr("STRUCTURECONSTRAINT").ToString())
                CheckImage(ImgOther, dr("OTHERCONSTRAINT").ToString())
            Else
                MessageLiteral.Text = "Invalid Record #"
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

    Private Sub CheckImage(ByVal img As System.Web.UI.WebControls.Image, ByVal fieldValue As String)
        If fieldValue = "Yes" Then
            img.ImageUrl = "~/images/checkbox-icon.png"
        ElseIf fieldValue = "Not Available" Then
            img.CssClass = "disabledImage"
        End If
    End Sub

End Class