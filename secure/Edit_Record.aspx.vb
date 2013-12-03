Imports System.Data.OleDb
Imports System.Data
Imports System.Configuration

Partial Class Edit_Record
    Inherits System.Web.UI.Page
    Dim dbconn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
          
            Bind_Dropdowns(ddlCorridorSegment, 2)
            BindFreightTravelMarket()
            FillDetails()

            Me.lnkEdit.PostBackUrl = "~/view_Record.aspx?OID=" & Request("OID").ToString()
            Me.lnkPrint.PostBackUrl = "~/Print_Record.aspx?OID=" & Request("OID").ToString()

        End If
        lblMessage.Text = ""
    End Sub
    Private Sub BindFreightTravelMarket()

        'For i As Integer = 0 To 9
        '    chkLstFreightTravelmarket.Items.Insert(i, Convert.ToInt16(i + 1))
        'Next

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

            Me.lblTotalrecords.Text = ds.Tables(0).Rows(0)("OID").ToString()
            Me.ddlDistrict.Text = ds.Tables(0).Rows(0)("FDOT_District").ToString()
            ddlDistrict.SelectedValue = ds.Tables(0).Rows(0)("FDOT_District").ToString()

            Me.txtType.Text = ds.Tables(0).Rows(0)("ISSUE_EXTENT").ToString()
      

            txtSource.Text = ds.Tables(0).Rows(0)("SOURCE").ToString()

            'ddlSource.SelectedValue = ds.Tables(0).Rows(0)("SOURCE").ToString()


            txtCorridorName.Text = ds.Tables(0).Rows(0)("CORRIDOR").ToString()
            txtSiteLocation.Text = ds.Tables(0).Rows(0)("SITE_LOCATION").ToString()

            Me.ChkboxVerified.Checked = ds.Tables(0).Rows(0)("FIELD_VERIFIED").ToString()

            ddlFieldVerified.Text = ds.Tables(0).Rows(0)("FIELD_VERIFIED").ToString()

            txtBeginMP.Text = ds.Tables(0).Rows(0)("BEGMP").ToString()
            txtComments.Text = ds.Tables(0).Rows(0)("COMMENTS").ToString()
            txtDateYearRecommended.Text = ds.Tables(0).Rows(0)("DATE_RECOMMENDED").ToString()
            txtEndingMP.Text = ds.Tables(0).Rows(0)("ENDMP").ToString()
            txtLatitude.Text = ds.Tables(0).Rows(0)("LATY").ToString()
            txtLongitude.Text = ds.Tables(0).Rows(0)("LONX").ToString()
            txtRoadWayId.Text = ds.Tables(0).Rows(0)("ROADWAYID").ToString()
            Me.txtSecondaryRDWYID.Text = ds.Tables(0).Rows(0)("SECONDRDWYID").ToString()
            txtSegmentFrom.Text = ds.Tables(0).Rows(0)("SEGMENT_FROM").ToString()
            txtSegmentTo.Text = ds.Tables(0).Rows(0)("SEGMENT_TO").ToString()

            Me.txtNeed.Text = ds.Tables(0).Rows(0)("FREIGHT_NEED").ToString()
            ddlFreightNeed.SelectedValue = ds.Tables(0).Rows(0)("FREIGHT_NEED").ToString()



            Me.txtCounty.Text = ds.Tables(0).Rows(0)("COUNTY").ToString()
            ' ddlCounty.SelectedValue = ds.Tables(0).Rows(0)("COUNTY").ToString()
            ' ddlCounty_SelectedIndexChanged(Nothing, Nothing)

            ddlCorridorSegment.SelectedValue = ds.Tables(0).Rows(0)("CORRIDOR_SEGMENT").ToString()
            Me.txtCorridorSegment.Text = ds.Tables(0).Rows(0)("CORRIDOR_SEGMENT").ToString()

            Me.txtFreightSystem.Text = ds.Tables(0).Rows(0)("FREIGHT_SYSTEM").ToString()
            ' ddlFreightSystem.SelectedValue = ds.Tables(0).Rows(0)("FREIGHT_SYSTEM").ToString()

            Me.txtTransSystem.Text = ds.Tables(0).Rows(0)("TRANSPORT_SYSTEM").ToString()



            Me.txtPriority.Text = ds.Tables(0).Rows(0)("PRIORITY").ToString()

            '   ddlPriority.Text = ds.Tables(0).Rows(0)("PRIORITY").ToString()

            txtEase.Text = ds.Tables(0).Rows(0)("EASE").ToString()

            Me.txtIssueDesc.Text = ds.Tables(0).Rows(0)("ISSUE_DESCRIPTION").ToString()
            ' ddlIssueDescription.Text = ds.Tables(0).Rows(0)("ISSUE_DESCRIPTION").ToString()


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


            Dim freightvalue() = ds.Tables(0).Rows(0)("FRGHT_TRVL_MRKT").ToString().Split(",")
           

            txtRecomendationDesc.Text = ds.Tables(0).Rows(0)("RECOMMENDATION_DESC").ToString()

            txtFieldOBC.Text = ds.Tables(0).Rows(0)("FIELD_OBS").ToString()
            Dim IssueLocation As String
            IssueLocation = ds.Tables(0).Rows(0)("ISSUESITELOC").ToString()
            Dim IssueSiteLocation = IssueLocation.Split(";")

            For i = 0 To UBound(IssueSiteLocation)
                For j = 0 To chklistIssueLoc.Items.Count - 1
                    If chklistIssueLoc.Items(j).Text = IssueSiteLocation(i) Then
                        chklistIssueLoc.Items(j).Selected = True
                    End If
                Next
            Next

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
            ddl.DataValueField = "Description"
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

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs)
        Try
            ConnectToDatabase()
            Dim a As String
            For value As Integer = 0 To chklistIssueLoc.Items.Count - 1
                If (chklistIssueLoc.Items(value).Selected = True) Then
                    a += chklistIssueLoc.Items(value).Text & ";"
                End If
            Next
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

            Dim Query = "Update CFID_MASTER_TBL Set " & _
            " FDOT_District='" & ddlDistrict.SelectedValue & "'," & _
            " COUNTY = '" & Me.txtCounty.Text & "'," & _
            " CORRIDOR ='" & txtCorridorName.Text & "'," & _
            " SITE_LOCATION ='" & Me.txtSiteLocation.Text & "'," & _
            " ISSUE_EXTENT ='" & txtType.Text & "'," & _
            " ISSUESITELOC ='" & a & "'," & _
            " FREIGHT_NEED='" & Me.txtNeed.Text & "'," & _
            " ISSUE_DESCRIPTION='" & Me.txtIssueDesc.Text & "'," & _
            " CORRIDOR_SEGMENT ='" & Me.txtCorridorSegment.Text & "'," & _
            " PRIORITY = '" & Me.txtPriority.Text & "'," & _
            " EASE = '" & Me.txtEase.Text & "'," & _
            " FIELD_VERIFIED=" & Me.ChkboxVerified.Checked & "," & _
            " DATE_RECOMMENDED='" & txtDateYearRecommended.Text & "'," & _
            " SEGMENT_TO='" & txtSegmentTo.Text & "'," & _
            " SEGMENT_FROM ='" & txtSegmentFrom.Text & "'," & _
            " ROADWAYID='" & txtRoadWayId.Text & "'," & _
            "SECONDRDWYID='" & Me.txtSecondaryRDWYID.Text & "'," & _
            " BEGMP=" & BEGMP & "," & _
            " ENDMP=" & ENDMP & "," & _
            " LONX =" & txtLongitude.Text & "," & _
            " LATY =" & txtLatitude.Text & "," & _
            " TRANSPORT_SYSTEM = '" & Me.txtTransSystem.Text & "'," & _
            " FREIGHT_SYSTEM='" & Me.txtFreightSystem.Text & "'," & _
            " FIELD_OBS='" & txtFieldOBC.Text & "'," & _
            " RECOMMENDATION_DESC='" & txtRecomendationDesc.Text & "'," & _
            " COMMENTS ='" & txtComments.Text & "'," & _
            " SOURCE='" & txtSource.Text & "'"

            Query &= " Where OID = " & Request("OID").ToString() & ""
            Dim dbcommupdate = New OleDbCommand(Query, dbconn)
            dbcommupdate.CommandType = CommandType.Text
            Dim result = dbcommupdate.ExecuteNonQuery()
            If result <> 0 Then
                lblMessage.Text = "<font color=green><strong>Record has been Updated Successfully.</strong></font>"
            Else
                lblMessage.Text = "<font color=red><strong>An Error has been Occured while updating the record. Please try again.</strong></font>"
            End If

        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub


    



    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click

    End Sub

    Protected Sub ddlType_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlType.SelectedIndexChanged
        Me.txtType.Text = Me.ddlType.Text

    End Sub

    Protected Sub ddlCounty_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlCounty.SelectedIndexChanged
        Me.txtCounty.Text = Me.ddlCounty.Text

        If (ddlCounty.SelectedItem.Text.Trim() = "Citrus") Then
            Bind_CorridorSegment("02-")
        ElseIf (ddlCounty.SelectedItem.Text.Trim() = "Hernando") Then
            Bind_CorridorSegment("08-")
        ElseIf (ddlCounty.SelectedItem.Text.Trim() = "Hillsborough") Then
            Bind_CorridorSegment("10-")
        ElseIf (ddlCounty.SelectedItem.Text.Trim() = "Manatee") Then
            Bind_CorridorSegment("15-")
        ElseIf (ddlCounty.SelectedItem.Text.Trim() = "Pasco") Then
            Bind_CorridorSegment("14-")
        ElseIf (ddlCounty.SelectedItem.Text.Trim() = "Pinellas") Then
            Bind_CorridorSegment("15-")
        ElseIf (ddlCounty.SelectedItem.Text.Trim() = "Polk") Then
            Bind_CorridorSegment("13-")
        ElseIf (ddlCounty.SelectedItem.Text.Trim() = "Sarasota") Then
            Bind_CorridorSegment("16-")
        End If
    End Sub

    Public Sub Bind_CorridorSegment(ByVal str As String)
        Try
            ConnectToDatabase()
            Dim sql = "Select * From tblCF_General Where Parent_id=2 and Description like '" & str & "%'"
            Dim dbcomm = New OleDbCommand(sql, dbconn)
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim ds As New DataSet
            adp.Fill(ds)
            ddlCorridorSegment.DataSource = ds
            ddlCorridorSegment.DataTextField = "Description"
            ddlCorridorSegment.DataValueField = "Description"
            ddlCorridorSegment.DataBind()
            ddlCorridorSegment.Items.Insert(0, "No Value")
            ddlCorridorSegment.Items(0).Value = "0"
            ddlCorridorSegment.SelectedIndex = 0
        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnDelete.Click
        ConnectToDatabase()
        Dim query = "Delete From CFID_MASTER_TBL Where OID=" & Request("OID").ToString()
        Dim dbcommupdate = New OleDbCommand(query, dbconn)
        Dim result = dbcommupdate.ExecuteNonQuery()
        If result <> 0 Then
            Response.Redirect("ViewAll_Records.aspx")
        Else
            lblMessage.Text = "<font color=red><strong>An Error has been Occured while deleting the record. Please try again.</strong></font>"
        End If
    End Sub

   
    Protected Sub btnArchive_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnArchive.Click
        Dim strOID As String = lblTotalrecords.Text
        Dim strFDOTdistrict As String = ddlDistrict.Text
        Dim strCounty As String = Me.txtCounty.Text
        Dim strSource As String = Me.txtSource.Text
        Dim strCorridor As String = Me.txtCorridorName.Text
        Dim strIssueExt As String = Me.txtType.Text
        Dim strSiteLoc As String = Me.txtSiteLocation.Text
        Dim strIssueSiteLoc As String = Me.chklistIssueLoc.Text
        Dim strFreightNeed As String = Me.txtNeed.Text
        Dim strIssueDesc As String = Me.txtIssueDesc.Text
        Dim strCorrSeg As String = Me.txtCorridorSegment.Text
        Dim strPriority As String = Me.txtPriority.Text
        Dim strEase As String = Me.txtEase.Text
        Dim strROWcon As String = Me.ChkROW.Checked
        Dim strUtilCon As String = Me.ChkUTILITY.Checked
        Dim strLightCon As String = Me.ChkLIGHTPOLE.Checked
        Dim strSignageCon As String = Me.ChkSIGNAGE.Checked
        Dim strStructCon As String = Me.ChkSTRUCTURE.Checked
        Dim strOtherCon As String = Me.ChkOTHER.Checked
        Dim strFieldVer As Integer = Me.ChkboxVerified.Checked
        Dim strDateRecommend As String = Me.txtDateYearRecommended.Text
        Dim strSegmentTo As String = Me.txtSegmentTo.Text
        Dim strSegmentFrom As String = Me.txtSegmentFrom.Text
        Dim strRoadwayID As String = Me.txtRoadWayId.Text
        Dim strBegMP As String = Me.txtBeginMP.Text
        Dim strEndMP As String = Me.txtEndingMP.Text

        Dim strLat As String = Me.txtLatitude.Text
        Dim strLon As String = Me.txtLongitude.Text
        Dim strTransSys As String = Me.txtTransSystem.Text
        Dim strFreightSys As String = Me.txtFreightSystem.Text

        Dim strFieldObs As String = Me.txtFieldOBC.Text
        Dim strRecommdDesc As String = Me.txtRecomendationDesc.Text
        Dim StrComments As String = Me.txtComments.Text

        Me.AccessDataSource1.InsertCommand = "INSERT INTO CFID_MASTER_TBL_archive (OID, FDOT_District, COUNTY, SOURCE, CORRIDOR, ISSUE_EXTENT, SITE_LOCATION, ISSUESITELOC, FREIGHT_NEED, ISSUE_DESCRIPTION, CORRIDOR_SEGMENT, PRIORITY, EASE, ROWCONSTRAINT, UTILITYCONSTRAINT, LIGHTPOLECONSTRAINT, SIGNAGECONSTRAINT, STRUCTURECONSTRAINT, OTHERCONSTRAINT,  FIELD_VERIFIED, DATE_RECOMMENDED, SEGMENT_TO, SEGMENT_FROM, ROADWAYID, BEGMP, ENDMP, LAT, LON, TRANSPORT_SYSTEM, FREIGHT_SYSTEM, FIELD_OBS, RECOMMENDATION_DESC, COMMENTS) VALUES ('" & strOID & "','" & strFDOTdistrict & "','" & strCounty & "',  '" & strSource & "','" & strCorridor & "','" & strIssueExt & "','" & strSiteLoc & "','" & strIssueSiteLoc & "','" & strFreightNeed & "','" & strIssueDesc & "','" & strCorrSeg & "','" & strPriority & "','" & strEase & "','" & strROWcon & "','" & strUtilCon & "','" & strLightCon & "','" & strSignageCon & "','" & strStructCon & "','" & strOtherCon & "','" & strFieldVer & "','" & strDateRecommend & "','" & strSegmentTo & "','" & strSegmentFrom & "','" & strRoadwayID & "','" & strBegMP & "','" & strEndMP & "','" & strLat & "','" & strLon & "','" & strTransSys & "','" & strFreightSys & "','" & strFieldObs & "','" & strRecommdDesc & "','" & StrComments & "')"
        Me.AccessDataSource1.Insert()

        'Me.AccessDataSource1.DeleteCommand = "Delete From CFID_MASTER_TBL Where OID=" & strOID

        Me.lblMessage.Text = "<font color=green><strong>Record has been Archived Successfully.</strong></font>"

        '    Else
        '        Me.lblMessage.Text = "<font color=red><strong>An Error has occured while saving the record. Please try again.</strong></font>"
        '    End If

        ConnectToDatabase()
        Dim query = "Delete From CFID_MASTER_TBL Where OID=" & Request("OID").ToString()
        Dim dbcommupdate = New OleDbCommand(query, dbconn)
        Dim result = dbcommupdate.ExecuteNonQuery()
        If result <> 0 Then
            Response.Redirect("ViewAll_Records.aspx")
        Else
            lblMessage.Text = "<font color=red><strong>An Error has been Occured while deleting the record. Please try again.</strong></font>"
        End If
    End Sub



    Protected Sub ddlSource_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSource.SelectedIndexChanged
        Me.txtSource.Text = Me.ddlSource.Text
    End Sub

    Protected Sub ddlPriority_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlPriority.SelectedIndexChanged
        Me.txtPriority.Text = Me.ddlPriority.Text
    End Sub

    Protected Sub ddlEase_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlEase.SelectedIndexChanged
        Me.txtEase.Text = Me.ddlEase.Text
    End Sub

    Protected Sub ddlFreightNeed_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFreightNeed.SelectedIndexChanged
        Me.txtNeed.Text = Me.ddlFreightNeed.Text
    End Sub

    Protected Sub ddlIssueDescription_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlIssueDescription.SelectedIndexChanged
        Me.txtIssueDesc.Text = Me.ddlIssueDescription.Text
    End Sub

    Protected Sub ddlTransSystem_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlTransSystem.SelectedIndexChanged
        Me.txtTransSystem.Text = Me.ddlTransSystem.Text
    End Sub

    Protected Sub ddlFreightSystem_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlFreightSystem.SelectedIndexChanged
        Me.txtFreightSystem.Text = Me.ddlFreightSystem.Text
    End Sub


End Class
