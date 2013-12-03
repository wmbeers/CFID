Imports System.Data.OleDb
Imports System.Data
Imports System.Configuration

Partial Class NewRecord
    Inherits System.Web.UI.Page
    Dim dbconn
    Public Shared Counter As Integer = 0
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            '    ddlDistrict.SelectedValue = Session("District")
            '    ddlDistrict_SelectedIndexChanged(Nothing, Nothing)
            '    FillDropDowns()
            '    BindFreightTravelMarket()

            Me.ddlFreightNeed.Items.Add(New ListItem("<--Select-->"))
            Me.ddlFreightNeed.Items.Add(New ListItem("Capacity"))
            ddlFreightNeed.Items.Add(New ListItem("Maintenance"))
            ddlFreightNeed.Items.Add(New ListItem("Operational"))
            ddlFreightNeed.Items.Add(New ListItem("Safety/Security"))
        End If
        lblMessage.Text = ""
    End Sub
  
    Private Sub FillDropDowns()
    
    End Sub

    Private Sub CheckDisctrict()
       
    End Sub

    Private Sub BindFreightTravelMarket()
        For i As Integer = 0 To 9
            'chkLstFreightTravelmarket.Items.Insert(i, Convert.ToInt16(i + 1))
        Next
    End Sub

    Public Sub Bind_Dropdowns(ByVal ddl As DropDownList, ByVal value As Integer)
      
    End Sub

    Public Sub Bind_CorridorSegment(ByVal str As String)
     
    End Sub

    Private Sub ConnectToDatabase()
        dbconn = New OleDbConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
    End Sub


    Private Function IsNumber(ByVal str As String) As String
        If (str = String.Empty) Then
            Return str = "0"
        Else
            Return str
        End If
    End Function

    Private Sub Reset()
       
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click
        Reset()
    End Sub

    Protected Sub ddlType_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlType.SelectedIndexChanged
        If (ddlType.SelectedIndex > 0) Then

            If (ddlType.SelectedItem.Text.Trim() = "Corridor") Then
                ' rfvCorridorName.Enabled = True
                '            rfvBeginMP.Enabled = True
                '            rfvCorridorSegment.Enabled = True
                '            rfvSegmentFrom.Enabled = True
                '            rfvSegmentTo.Enabled = True
                '  rfvRoadwayId.Enabled = True
                '            rfvEndingMP.Enabled = True

                '            rfvSiteLocation.Enabled = False
                '            rfvLongitude.Enabled = False
                '            rfvLatitude.Enabled = False

                '            txtCorridorName.CssClass = "highlight_input"
                '            txtBeginMP.CssClass = "highlight_input"
                ' ddlCorridorSegment.CssClass = "highlight_input"
                '            txtSegmentFrom.CssClass = "highlight_input"
                '            txtSegmentTo.CssClass = "highlight_input"
                '            txtRoadWayId.CssClass = "highlight_input"
                '            txtEndingMP.CssClass = "highlight_input"

                '  txtSiteLocation.CssClass = "executive_form_input"
                '            txtLongitude.CssClass = "executive_form_input"
                '            txtLatitude.CssClass = "executive_form_input"


            ElseIf (ddlType.SelectedItem.Text.Trim() = "Specific Location") Then
                '            rfvCorridorName.Enabled = False
                '            rfvBeginMP.Enabled = False
                '   rfvCorridorSegment.Enabled = False
                '            rfvSegmentFrom.Enabled = False
                '            rfvSegmentTo.Enabled = False
                ' rfvRoadwayId.Enabled = False
                '            rfvEndingMP.Enabled = False

                '            rfvSiteLocation.Enabled = True
                '            rfvLongitude.Enabled = True
                '            rfvLatitude.Enabled = True

                '            txtCorridorName.CssClass = "executive_form_input"
                '            txtBeginMP.CssClass = "executive_form_input"
                ' ddlCorridorSegment.CssClass = "executive_form_input"
                '            txtSegmentFrom.CssClass = "executive_form_input"
                '            txtSegmentTo.CssClass = "executive_form_input"
                '            txtRoadWayId.CssClass = "executive_form_input"
                '            txtEndingMP.CssClass = "executive_form_input"

                '  txtSiteLocation.CssClass = "highlight_input"
                '            txtLongitude.CssClass = "highlight_input"
                '            txtLatitude.CssClass = "highlight_input"
            End If
        End If
    End Sub


    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            ConnectToDatabase()
         

            Dim BEGMP As Integer
            If (txtBeginMP.Text <> "") Then
                BEGMP = txtBeginMP.Text
            Else
                BEGMP = 0
            End If

            Dim ENDMP As Integer
            If (txtEndingMP.Text <> "") Then
                ENDMP = txtEndingMP.Text
            Else
                ENDMP = 0
            End If


            Dim LATY As Double
            If (txtLatitude.Text <> "") Then
                LATY = txtLatitude.Text
            Else
                LATY = 0
            End If


            Dim LONX As Double
            If (txtLongitude.Text <> "") Then
                LONX = txtLongitude.Text
            Else
                LONX = 0
            End If


            Dim Verify = ""
            If (ddlFieldVerified.Text <> "<--Select-->") Then
                Verify = ddlFieldVerified.Text
            End If
            Dim a As String
            For value As Integer = 0 To chklistIssueLoc.Items.Count - 1
                If (chklistIssueLoc.Items(value).Selected = True) Then
                    a += chklistIssueLoc.Items(value).Text & ";"
                End If
            Next

            Dim query = "INSERT INTO [CFID_MASTER_TBL] ([FDOT_District], [ISSUE_EXTENT], [SOURCE], [COUNTY], [FIELD_VERIFIED], [CORRIDOR], [SITE_LOCATION], [ISSUESITELOC] , [SEGMENT_FROM] , [SEGMENT_TO] , [ROADWAYID], [BEGMP] , [ENDMP] , [LAT], [LON] , [DATE_RECOMMENDED], [FREIGHT_NEED] ,  [ISSUE_DESCRIPTION] , [IMPRVMNT_STAGE], [PRIORITY] , [EASE], [ROWCONSTRAINT], [UTILITYCONSTRAINT] , [LIGHTPOLECONSTRAINT], [SIGNAGECONSTRAINT], [STRUCTURECONSTRAINT], [OTHERCONSTRAINT]  , [TRANSPORT_SYSTEM] , [FREIGHT_SYSTEM] , [RECOMMENDATION_DESC] , [FIELD_OBS], [COMMENTS],[LATY],[LONX] ) VALUES ('" & ddlDistrict.SelectedValue & "', '" & ddlType.SelectedValue & "', '" & ddlSource.SelectedValue & "', '" & ddlCounty.SelectedValue & "' , " & Verify & " ,'" & txtCorridorName.Text & "' , '" & txtSiteLocation.Text & "' , '" & a & "' , '" & txtSegmentFrom.Text & "' , '" & txtSegmentTo.Text & "' , '" & txtRoadWayId.Text & "' , " & BEGMP & " , " & ENDMP & " , '" & txtLatitude.Text & "' , ' " & txtLongitude.Text & "' , '" & txtDateYearRecommended.Text & "' , '" & ddlFreightNeed.SelectedValue & "' , '" & ddlIssueDescription.SelectedValue & "' , '" & ddlImprovementStage.SelectedValue & "' ,'" & ddlPriority.SelectedValue & "' , '" & lblValues.Text & "' , '" & ChkROW.Checked & "' , '" & ChkUTILITY.Checked & "' ,  '" & ChkLIGHTPOLE.Checked & "' , '" & ChkSIGNAGE.Checked & "' ,  '" & ChkSTRUCTURE.Checked & "' , '" & ChkOTHER.Checked & "' ,  '" & ddlTransSystem.SelectedValue & "' , '" & ddlFreightSystem.SelectedValue & "'  , '" & txtRecomendationDesc.Text & "' , '" & txtFieldOBC.Text & "', '" & txtComments.Text & "','" & LATY & "','" & LONX & "')"

            Dim dbcommupdate = New OleDbCommand(query, dbconn)
            Dim result = dbcommupdate.ExecuteNonQuery()
            If result <> 0 Then
                Reset()
                lblMessage.Text = "<font color=green><strong>Record has been Submited Successfully.</strong></font>"
            Else
                lblMessage.Text = "<font color=red><strong>An Error has been Occured while saving the record. Please try again.</strong></font>"
            End If
        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try

        ' dbconn.close()
    End Sub


    Private Sub LoadConstraintVlues()
        If (Counter >= 1 And Counter <= 2) Then
            lblValues.Text = "3-Easy"
        End If
        If (Counter >= 3 And Counter <= 4) Then
            lblValues.Text = "2-Medium"
        End If
        If (Counter >= 5 And Counter <= 6) Then
            lblValues.Text = "1-Difficult"
        End If
        If (Counter > 6) Then
            Counter = 1
        End If
    End Sub

    Protected Sub ChkROW_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkROW.CheckedChanged
        CountCheckBoxList()
        LoadConstraintVlues()
    End Sub

    Protected Sub ChkUTILITY_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkUTILITY.CheckedChanged
        CountCheckBoxList()
        LoadConstraintVlues()
    End Sub

    Protected Sub ChkLIGHTPOLE_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkLIGHTPOLE.CheckedChanged
        CountCheckBoxList()
        LoadConstraintVlues()
    End Sub

    Protected Sub ChkSIGNAGE_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkSIGNAGE.CheckedChanged
        CountCheckBoxList()
        LoadConstraintVlues()
    End Sub

    Protected Sub ChkSTRUCTURE_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkSTRUCTURE.CheckedChanged
        CountCheckBoxList()
        LoadConstraintVlues()
    End Sub

    Protected Sub ChkOTHER_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkOTHER.CheckedChanged
        CountCheckBoxList()
        LoadConstraintVlues()
    End Sub
    Private Sub CountCheckBoxList()
        Counter = 0
        If (ChkLIGHTPOLE.Checked) Then
            Counter += 1
        End If
        If (ChkOTHER.Checked) Then
            Counter += 1
        End If
        If (ChkROW.Checked) Then
            Counter += 1
        End If
        If (ChkSIGNAGE.Checked) Then
            Counter += 1
        End If
        If (ChkSTRUCTURE.Checked) Then
            Counter += 1
        End If
        If (ChkUTILITY.Checked) Then
            Counter += 1
        End If
    End Sub

    Protected Sub ddlFreightNeed_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlFreightNeed.SelectedIndexChanged

        Me.ddlIssueDescription.Items.Clear()

        If ddlFreightNeed.SelectedIndex = 0 Then
            Me.ddlIssueDescription.Items.Add(New ListItem("<--Select-->"))

        ElseIf ddlFreightNeed.SelectedIndex = 1 Then
            Me.ddlIssueDescription.Items.Add(New ListItem("<--Select-->"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Left Turn Lane Length"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Other Capacity Issues"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Queue Length"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Right Turn lane length"))

        ElseIf ddlFreightNeed.SelectedIndex = 2 Then
            Me.ddlIssueDescription.Items.Add(New ListItem("<--Select-->"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Drainage/Ponding"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Other maintenance issues"))
            Me.ddlIssueDescription.Items.Add(New ListItem("RR Grade Crossing/replacement"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Substandard Pavement"))

        ElseIf ddlFreightNeed.SelectedIndex = 3 Then
            Me.ddlIssueDescription.Items.Add(New ListItem("<--Select-->"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Access Management – median openings, driveways"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Add New Signal"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Lane Width"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Line of Sight"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Signage – navigational/directional"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Signal Timing"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Stop Bar Modification"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Turn Radii"))

        ElseIf ddlFreightNeed.SelectedIndex = 4 Then
            Me.ddlIssueDescription.Items.Add(New ListItem("<--Select-->"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Parking/Staging"))
            Me.ddlIssueDescription.Items.Add(New ListItem("Other Safety/Security"))

        End If

    End Sub
End Class
