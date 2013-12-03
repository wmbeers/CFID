Imports System.Data.OleDb
Imports System.Data
Imports System.Configuration

Partial Class Edit_Record
    Inherits System.Web.UI.Page
    Dim dbconn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillDetails()

            lnkedit.PostBackUrl = "secure/Edit_Record.aspx?OID=" & Request("OID").ToString()
            lnkprint.PostBackUrl = "~/Print_Record.aspx?OID=" & Request("OID").ToString()

            'loads google static
            Me.StaticMap()


        End If
        lblMessage.Text = ""
    End Sub
    Private Sub BindFreightTravelMarket()

        
    End Sub

    Private Sub ConnectToDatabase()
        dbconn = New OleDbConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
    End Sub

    Private Sub FillDetails()

        Try
            ConnectToDatabase()
            Dim sql = "Select * From CFID_MASTER_TBL Where OID=" & Request("OID").ToString()
            Dim dbcomm = New OleDbCommand(sql, dbconn)
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim ds As New DataSet
            adp.Fill(ds)

            Me.lblID.Text = ds.Tables(0).Rows(0)("OID").ToString()
            Me.lblDistrict.Text = ds.Tables(0).Rows(0)("FDOT_District").ToString()

            Me.lblType.Text = ds.Tables(0).Rows(0)("ISSUE_EXTENT").ToString()

            Me.lblCorridorName.Text = ds.Tables(0).Rows(0)("CORRIDOR").ToString()

            Me.lblSource.Text = ds.Tables(0).Rows(0)("SOURCE").ToString()
            lblCounty.Text = ds.Tables(0).Rows(0)("COUNTY").ToString()
            Me.chkFieldVerified.Checked = ds.Tables(0).Rows(0)("FIELD_VERIFIED").ToString()

            Me.lblPriority.Text = ds.Tables(0).Rows(0)("PRIORITY").ToString()
            Me.lblEase.Text = ds.Tables(0).Rows(0)("EASE").ToString()
            lblFreightNeed.Text = ds.Tables(0).Rows(0)("FREIGHT_NEED").ToString()
            lblIssueDescription.Text = ds.Tables(0).Rows(0)("ISSUE_DESCRIPTION").ToString()

            lblCorridorName.Text = ds.Tables(0).Rows(0)("CORRIDOR").ToString()
            lblSiteLocation.Text = ds.Tables(0).Rows(0)("SITE_LOCATION").ToString()

            Me.lblIssueLoc.Text = ds.Tables(0).Rows(0)("ISSUESITELOC").ToString()

            Me.lblSegmentFrom.Text = ds.Tables(0).Rows(0)("SEGMENT_FROM").ToString()
            Me.lblSegmentTo.Text = ds.Tables(0).Rows(0)("SEGMENT_TO").ToString()

            Me.lblRoadWayId.Text = ds.Tables(0).Rows(0)("ROADWAYID").ToString()
            Me.lblSecondRdwyID.Text = ds.Tables(0).Rows(0)("SECONDRDWYID").ToString()

            lblBeginMP.Text = ds.Tables(0).Rows(0)("BEGMP").ToString()
            lblEndingMP.Text = ds.Tables(0).Rows(0)("ENDMP").ToString()
            Me.lblLocMP.Text = ds.Tables(0).Rows(0)("LOCMP").ToString()
            lblLatitude.Text = ds.Tables(0).Rows(0)("LATY").ToString()
            lblLongitude.Text = ds.Tables(0).Rows(0)("LONX").ToString()
            lblCorridorSegment.Text = ds.Tables(0).Rows(0)("CORRIDOR_SEGMENT").ToString()

            lblDateYearRecommended.Text = ds.Tables(0).Rows(0)("DATE_RECOMMENDED").ToString()
            'lblImprovementStage.Text = ds.Tables(0).Rows(0)("IMPRVMNT_STAGE").ToString()
            If (ds.Tables(0).Rows(0)("ROWCONSTRAINT") = "No") Then
                ChkROW.Checked = False
            Else
                ChkROW.Checked = True
            End If
            If (ds.Tables(0).Rows(0)("UTILITYCONSTRAINT") = "No") Then
                ChkUTILITY.Checked = False
            Else
                ChkUTILITY.Checked = True
            End If
            If (ds.Tables(0).Rows(0)("LIGHTPOLECONSTRAINT") = "No") Then
                ChkLIGHTPOLE.Checked = False
            Else
                ChkLIGHTPOLE.Checked = True
            End If
            If (ds.Tables(0).Rows(0)("SIGNAGECONSTRAINT") = "No") Then
                ChkSIGNAGE.Checked = False
            Else
                ChkSIGNAGE.Checked = True
            End If
            If (ds.Tables(0).Rows(0)("STRUCTURECONSTRAINT") = "No") Then
                ChkSTRUCTURE.Checked = False
            Else
                ChkSTRUCTURE.Checked = True
            End If
            If (ds.Tables(0).Rows(0)("OTHERCONSTRAINT") = "No") Then
                ChkOTHER.Checked = False
            Else
                ChkOTHER.Checked = True
            End If

            Me.lblTransSystem.Text = ds.Tables(0).Rows(0)("TRANSPORT_SYSTEM").ToString()
            Me.lblFreightSystem.Text = ds.Tables(0).Rows(0)("FREIGHT_SYSTEM").ToString()

            Me.lblRecomendationDesc.Text = ds.Tables(0).Rows(0)("RECOMMENDATION_DESC").ToString()
            Me.lblFieldOBC.Text = ds.Tables(0).Rows(0)("FIELD_OBS").ToString()
            lblComments.Text = ds.Tables(0).Rows(0)("COMMENTS").ToString()



        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub

    Public Sub Bind_Dropdowns(ByVal ddl As DropDownList, ByVal value As Integer)
        Try
            ConnectToDatabase()
            Dim sql = "Select * From tblCF_General Where Parent_id=" & value
            Dim dbcomm = New OleDbCommand(sql, dbconn)
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim ds As New DataSet
            adp.Fill(ds)
            ddl.DataSource = ds
            ddl.DataTextField = "Description"
            ddl.DataValueField = "Record_id"
            ddl.DataBind()
            ddl.Items.Insert(0, "No Value")
            ddl.Items(0).Value = "0"
            ddl.SelectedIndex = 0
        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub

    Private Function IsNumber(ByVal str As String) As String
        If (str = String.Empty) Then
            Return str = "0"
        Else
            Return str
        End If
    End Function


    Private Sub StaticMap()


        Dim Lat As String = lblLatitude.Text
        Dim Lon As String = lblLongitude.Text

        Me.Imgstaticmap.ImageUrl = "http://maps.googleapis.com/maps/api/staticmap?center=" + Lat + "," + Lon + "&zoom=12&size=400x400&Scale=2&markers=color:blue%7Clabel:x%7C" + Lat + "," + Lon + "&maptype=hybrid&sensor=false&key=AIzaSyC6iFkdBobz7s7Tcn6K5szQwNS0Ucr1H7g"

    End Sub


End Class
