Imports System.Data.OleDb
Imports System.Data
Imports System.Configuration
Imports System.IO
Imports System.Text

Partial Class ViewAll_Records
    Inherits System.Web.UI.Page
    Dim dbconn
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            fn_LoadControl()
            fn_bindgride()
            lblSelectedRecord.Text = "0"
            TotalRecord()
            HidUserName.Value = Session("screenname")
            DSPopupComment.SelectCommand = "Select * from USER_COMMENT"
            gvPopupup.DataSource = DSPopupComment
            gvPopupup.DataBind()
        End If
    End Sub
    Private Sub fn_ConenctDatabase()
        Try
            lblGrideError.Text = ""
            dbconn.close()
            dbconn = New OleDbConnection(ConfigurationManager.AppSettings("connectionString").ToString())
            dbconn.open()
        Catch ex As Exception
            lblGrideError.Text = "Connection not establish" & ex.Message
        End Try
    End Sub
    Private Sub fn_bindgride()
        Try
            lblGrideError.Text = ""
            AccessDataSource1.SelectCommand = "SELECT [OID], [COUNTY], [PRIORITY], [FREIGHT_NEED], [SITE_LOCATION], [ISSUE_EXTENT], [FIELD_VERIFIED] FROM [CFID_MASTER_TBL] ORDER BY [COUNTY], [PRIORITY]"
            grdRecords.DataSource = AccessDataSource1
            grdRecords.DataBind()
        Catch ex As Exception
            lblGrideError.Text = "DataSource is not working" & ex.Message
        End Try
    End Sub
    Private Sub fn_LoadControl()
        Try

            lblGrideError.Text = ""

            ' district chkbox
            DSDistrict.SelectCommand = "SELECT DISTINCT FDOT_District FROM CFID_MASTER_TBL  where (FDOT_District <>'')"
            Me.chkDistrict.DataSource = DSDistrict
            chkDistrict.DataBind()

            ' Priority
            DSPRIORITY.SelectCommand = "SELECT DISTINCT [PRIORITY] FROM [CFID_MASTER_TBL] where (PRIORITY <>'')"
            chkboxListPriority.DataSource = DSPRIORITY
            chkboxListPriority.DataBind()

            ' ChkImplementEase
            DSPEASE.SelectCommand = "SELECT DISTINCT [EASE] FROM [CFID_MASTER_TBL] where (EASE <>'')"
            ChkImplementEase.DataSource = DSPEASE
            ChkImplementEase.DataBind()

            'COUNTY
            DSCounty.SelectCommand = "SELECT DISTINCT [COUNTY] FROM [CFID_MASTER_TBL] where (COUNTY <>'')"
            ChkCounty.DataSource = DSCounty
            ChkCounty.DataBind()

            'ISSUE_EXTENT
            DSISSUE_EXTENT.SelectCommand = "SELECT DISTINCT [ISSUE_EXTENT] FROM [CFID_MASTER_TBL] where (ISSUE_EXTENT <>'')"
            ChKISSUE_EXTENT.DataSource = DSISSUE_EXTENT
            ChKISSUE_EXTENT.DataBind()

            'Freight_Need
            DSFreight_Need.SelectCommand = "SELECT DISTINCT [Freight_Need] FROM [CFID_MASTER_TBL] where (Freight_Need <>'')"
            ChkFreightNeed.DataSource = DSFreight_Need
            ChkFreightNeed.DataBind()

            'ISSUE_DESCRIPTION
            DSIssueDescription.SelectCommand = "SELECT DISTINCT [ISSUE_DESCRIPTION] FROM [CFID_MASTER_TBL] where (ISSUE_DESCRIPTION <>'')"
            ChkIssueDescription.DataSource = DSIssueDescription
            ChkIssueDescription.DataBind()
            'SOURCE
            DSSource.SelectCommand = "SELECT DISTINCT [SOURCE] FROM [CFID_MASTER_TBL] where (SOURCE <>'')"
            ChkSource.DataSource = DSSource
            ChkSource.DataBind()

            'TRANSPORT_SYSTEM
            DSTRANSPORT_SYSTEM.SelectCommand = "SELECT DISTINCT [TRANSPORT_SYSTEM] FROM [CFID_MASTER_TBL] where (TRANSPORT_SYSTEM <>'')"
            ChkTransportSystem.DataSource = DSTRANSPORT_SYSTEM
            ChkTransportSystem.DataBind()
            'FREIGHT_SYSTEM
            DSFreightSystem.SelectCommand = "SELECT DISTINCT [FREIGHT_SYSTEM] FROM [CFID_MASTER_TBL] where (FREIGHT_SYSTEM <>'')"
            ChkFreightSystem.DataSource = DSFreightSystem
            ChkFreightSystem.DataBind()
        Catch ex As Exception
            lblGrideError.Text = "Load Control " & ex.Message
        End Try
    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            lblGrideError.Text = ""
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = "Search Error " & ex.Message
        End Try

    End Sub
    Sub grdRecords_OnRowDataBound(ByVal sender As Object, ByVal e As GridViewRowEventArgs)
      
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                lblGrideError.Text = ""
                'fn_ConenctDatabase()
                ' Display the company name in italics.
                Dim dropprority As DropDownList = e.Row.FindControl("DropDownPrority")
                If dropprority IsNot Nothing Then
                    Dim lblPrtority As HiddenField = e.Row.FindControl("HidlblPrtority")
                    DSPRIORITY.SelectCommand = "SELECT DISTINCT [PRIORITY] FROM [CFID_MASTER_TBL]"
                    dropprority.DataSource = DSPRIORITY
                    dropprority.DataBind()
                    dropprority.Items.Insert(0, "<---Select--->")
                    dropprority.SelectedValue = lblPrtority.Value
                End If
                'DSFreight_Need
                Dim DropDownFrightNeed As DropDownList = e.Row.FindControl("DropDownFrightNeed")
                If DropDownFrightNeed IsNot Nothing Then
                    Dim HidFREIGHT_NEED As HiddenField = e.Row.FindControl("HidFREIGHT_NEED")
                    DSFreight_Need.SelectCommand = "SELECT DISTINCT [FREIGHT_NEED] FROM [CFID_MASTER_TBL]"
                    DropDownFrightNeed.DataSource = DSFreight_Need
                    DropDownFrightNeed.DataBind()
                    DropDownFrightNeed.Items.Insert(0, "<---Select--->")
                    DropDownFrightNeed.SelectedValue = HidFREIGHT_NEED.Value
                End If
                'Load County
                Dim DropDownlistCounty As DropDownList = e.Row.FindControl("DropDownlistCounty")
                If DropDownlistCounty IsNot Nothing Then
                    Dim HidCOUNTY As HiddenField = e.Row.FindControl("HidCOUNTY")
                    Dim Query As String = "SELECT DESCRIPTION as COUNTY FROM  LU_COUNTY"
                    Dim con As OleDbConnection = New OleDbConnection()
                    con.ConnectionString = ConfigurationManager.AppSettings("connectionString").ToString()
                    Dim cmd As OleDbCommand = New OleDbCommand(Query, con)
                    con.Open()
                    Dim Adapter As OleDbDataAdapter = New OleDbDataAdapter(cmd)
                    Dim dt As Data.DataTable = New Data.DataTable()
                    Adapter.Fill(dt)
                    'With DropDownlistCounty
                    DropDownlistCounty.DataSource = dt
                    DropDownlistCounty.DataTextField = "COUNTY"
                    DropDownlistCounty.DataValueField = "COUNTY"
                    DropDownlistCounty.DataBind()
                    'End With
                    DropDownlistCounty.Items.Insert(0, "<---Select--->")
                    DropDownlistCounty.SelectedValue = HidCOUNTY.Value
                    dbconn.close()
                End If

            End If

        Catch ex As Exception
            lblGrideError.Text = "Data Bound" & ex.Message
        End Try
    End Sub

    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Try
    '        AccessDataSource1.SelectCommand = "SELECT [OID], [COUNTY], [PRIORITY], [FREIGHT_NEED], [SITE_LOCATION], [ISSUE_EXTENT], [FIELD_VERIFIED] FROM [CFID_MASTER_TBL] where [OID]=33"
    '        grdRecords.DataBind()
    '    Catch ex As Exception
    '    End Try
    'End Sub
    'End Class
    Protected Sub grdRecords_RowUpdating(ByVal sender As Object, ByVal e As GridViewUpdateEventArgs)
        Try
            Dim CheckVerify As String
            lblGrideError.Text = ""
            Dim row As GridViewRow = DirectCast(grdRecords.Rows(e.RowIndex), GridViewRow)
            Dim lblOID As Label = DirectCast(row.FindControl("lblOID"), Label)
            Dim txtSiteLocation As TextBox = DirectCast(row.FindControl("txtSiteLocation"), TextBox)
            Dim DropCounty As DropDownList = DirectCast(row.FindControl("DropDownlistCounty"), DropDownList)
            Dim ddlRemove As DropDownList = DirectCast(row.FindControl("ddlRemove"), DropDownList)
            Dim DropDownPrority As DropDownList = DirectCast(row.FindControl("DropDownPrority"), DropDownList)
            Dim DropDownFrightNeed As DropDownList = DirectCast(row.FindControl("DropDownFrightNeed"), DropDownList)
            Dim txtIssue As TextBox = DirectCast(row.FindControl("txtIssue"), TextBox)
            Dim ChkVerified As CheckBox = DirectCast(row.FindControl("ChkVerified"), CheckBox)
            If (ChkVerified.Checked = True) Then
                CheckVerify = 1
            Else
                CheckVerify = 0
            End If
            Dim Connection As OleDbConnection = New OleDbConnection()
            Connection.ConnectionString = ConfigurationManager.AppSettings("connectionString").ToString()
            Dim cmd As New OleDbCommand("update  CFID_MASTER_TBL set SITE_LOCATION='" & txtSiteLocation.Text & "', COUNTY='" & DropCounty.Text & "', PRIORITY='" & DropDownPrority.Text & "', FREIGHT_NEED='" & DropDownFrightNeed.Text & "', ISSUE_EXTENT='" & txtIssue.Text & "', FIELD_VERIFIED='" & CheckVerify & "' where (OID=" & lblOID.Text & ")", Connection)
            Connection.Open()
            cmd.ExecuteNonQuery()

            If (ddlRemove.Text = "Archive") Then
                InsertintoArchive(lblOID.Text)
            End If

            grdRecords.EditIndex = -1
            ' FilterRecord("ASC", "")
            'grdRecords.DataBind()
            fn_bindgride()
            lblGrideError.Text = "Update Record Successful"
        Catch ex As Exception
            lblGrideError.Text = "Error on Update Record" & ex.Message
        End Try
    End Sub
    Protected Sub gvPerson_RowCancelingEdit(ByVal sender As Object, ByVal e As GridViewCancelEditEventArgs)
        ' Exit edit mode.
        grdRecords.EditIndex = -1
        ' Rebind the GridView control to show data in view mode.
        fn_bindgride()
    End Sub
    Protected Sub grdRecords_RowEditing(ByVal sender As Object, ByVal e As GridViewEditEventArgs)
       
        If grdRecords.EditIndex = e.NewEditIndex Then
            e.Cancel = True
            Exit Sub
        End If
        grdRecords.EditIndex = e.NewEditIndex

        FilterRecord("ASC", "")

    End Sub

    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles grdRecords.PageIndexChanging

        grdRecords.PageIndex = e.NewPageIndex
        fn_bindgride()

    End Sub
    Protected Sub ddlDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDistrict.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub chkDistrict_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkDistrict.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub




    Protected Sub chkboxListPriority_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkboxListPriority.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub
    Protected Sub FilterRecord(ByVal Sorting As String, ByVal Order As String)
        Try
            ' District Filter
            lblGrideError.Text = ""
            Dim Query = "SELECT [OID], [FDOT_District], [COUNTY], [PRIORITY], [FREIGHT_NEED], [SITE_LOCATION], [ISSUE_EXTENT], [FIELD_VERIFIED] FROM [CFID_MASTER_TBL]"



            Dim District As String = ""
            Dim where As String = ""

            'If (ddlDistrict.Text <> "<---Select--->") Then
            '    District &= "AND FDOT_District='" & ddlDistrict.Text & "'"
            'End If

            If (Me.chkDistrict.Text <> "") Then
                District &= "AND FDOT_District='" & chkDistrict.Text & "'"
            End If


            ' test chkdistrict

            'If (Me.chkDistrict.SelectedValue <> "") Then
            '    Dim values As [String] = ""
            '    Dim count As Integer

            '    For i As Integer = 0 To chkDistrict.Items.Count - 1
            '        If chkDistrict.Items(i).Selected Then
            '            values += chkDistrict.Items(i).Text + ","
            '            count += 1
            '        End If
            '    Next

            '    If (count >= 2) Then
            '        Dim words As String() = values.Split(New Char() {","c})
            '        For Each word In words
            '            If (word <> "") Then
            '                District &= "FDOT_District='" & word & "'"
            '            End If
            '        Next
            '    Else
            '        Dim words As String() = values.Split(New Char() {","c})
            '        For Each word In words
            '            If (word <> "") Then
            '                District &= "FDOT_District='" & word & "'"
            '            End If
            '        Next
            '    End If



            'original 
            'If (count >= 2) Then
            '    Dim words As String() = values.Split(New Char() {","c})
            '    For Each word In words
            '        If (word <> "") Then
            '            District &= " OR PRIORITY='" & word & "'"
            '        End If
            '    Next
            'Else
            '    Dim words As String() = values.Split(New Char() {","c})
            '    For Each word In words
            '        If (word <> "") Then
            '            District &= "AND PRIORITY='" & word & "'"
            '        End If
            '    Next
            'End If
            ' End If





            ' Checkbox Prioritys


            If (chkboxListPriority.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To chkboxListPriority.Items.Count - 1
                    If chkboxListPriority.Items(i).Selected Then
                        'prori &= "OR PRIORITY='" & chkboxListPriority.Items(i).Value & "'"
                        values += chkboxListPriority.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR PRIORITY='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND PRIORITY='" & word & "'"
                        End If
                    Next
                End If
            End If
            ' Checkbox ImplementEase
            If (ChkImplementEase.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkImplementEase.Items.Count - 1
                    If ChkImplementEase.Items(i).Selected Then
                        'prori &= "OR PRIORITY='" & chkboxListPriority.Items(i).Value & "'"
                        values += ChkImplementEase.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR EASE='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND EASE='" & word & "'"
                        End If
                    Next
                End If
            End If
            ' End Ease

            ' Checkbox County
            If (ChkCounty.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkCounty.Items.Count - 1
                    If ChkCounty.Items(i).Selected Then
                        'prori &= "OR PRIORITY='" & chkboxListPriority.Items(i).Value & "'"
                        values += ChkCounty.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR COUNTY='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND COUNTY='" & word & "'"
                        End If
                    Next
                End If
            End If
            ' End County

            ' Checkbox Extent
            If (ChKISSUE_EXTENT.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChKISSUE_EXTENT.Items.Count - 1
                    If ChKISSUE_EXTENT.Items(i).Selected Then
                        values += ChKISSUE_EXTENT.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR ISSUE_EXTENT='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND ISSUE_EXTENT='" & word & "'"
                        End If
                    Next
                End If
            End If
            ' End Extent

            'ChkFreightNeed Start
            If (ChkFreightNeed.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkFreightNeed.Items.Count - 1
                    If ChkFreightNeed.Items(i).Selected Then
                        values += ChkFreightNeed.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR Freight_Need='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND Freight_Need='" & word & "'"
                        End If
                    Next
                End If
            End If
            'ChkFreightNeed End
            'ChkIssueDescription Start
            If (ChkIssueDescription.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkIssueDescription.Items.Count - 1
                    If ChkIssueDescription.Items(i).Selected Then
                        values += ChkIssueDescription.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR ISSUE_DESCRIPTION='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND ISSUE_DESCRIPTION='" & word & "'"
                        End If
                    Next
                End If
            End If
            'ChkIssueDescription End
            'ChkConstraints Start

            If (ChkConstraints.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkConstraints.Items.Count - 1
                    If ChkConstraints.Items(i).Selected Then
                        values += ChkConstraints.Items(i).Value + ","
                        count += 1
                    End If
                Next
                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            If (word = "row") Then
                                District &= "AND ROWCONSTRAINT='Yes'"
                            End If
                            If (word = "lightpole") Then
                                District &= "AND LIGHTPOLECONSTRAINT='Yes'"
                            End If
                            If (word = "signage") Then
                                District &= "AND SIGNAGECONSTRAINT='Yes'"
                            End If
                            If (word = "structure") Then
                                District &= "AND STRUCTURECONSTRAINT='Yes'"
                            End If
                            If (word = "Other") Then
                                District &= "AND OTHERCONSTRAINT='Yes'"
                            End If
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            If (word = "row") Then
                                District &= "AND ROWCONSTRAINT='Yes'"
                            End If
                            If (word = "lightpole") Then
                                District &= "AND LIGHTPOLECONSTRAINT='Yes'"
                            End If
                            If (word = "signage") Then
                                District &= "AND SIGNAGECONSTRAINT='Yes'"
                            End If
                            If (word = "structure") Then
                                District &= "AND STRUCTURECONSTRAINT='Yes'"
                            End If
                            If (word = "Other") Then
                                District &= "AND OTHERCONSTRAINT='Yes'"
                            End If
                        End If
                    Next
                End If
            End If
            'ChkConstraints End

            'ChkSource Start
            If (ChkSource.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkSource.Items.Count - 1
                    If ChkSource.Items(i).Selected Then
                        values += ChkSource.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR SOURCE='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND SOURCE='" & word & "'"
                        End If
                    Next
                End If
            End If
            'ChkSource End
            'ChkTransportSystem Start
            If (ChkTransportSystem.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkTransportSystem.Items.Count - 1
                    If ChkTransportSystem.Items(i).Selected Then
                        values += ChkTransportSystem.Items(i).Text + ","
                        count += 1
                    End If
                Next

                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR TRANSPORT_SYSTEM='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND TRANSPORT_SYSTEM='" & word & "'"
                        End If
                    Next
                End If
            End If
            'ChkTransportSystem End

            'ChkFreightSystem Start
            If (ChkFreightSystem.SelectedValue <> "") Then
                Dim values As [String] = ""
                Dim count As Integer

                For i As Integer = 0 To ChkFreightSystem.Items.Count - 1
                    If ChkFreightSystem.Items(i).Selected Then
                        values += ChkFreightSystem.Items(i).Text + ","
                        count += 1
                    End If
                Next
                If (count >= 2) Then
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= " OR FREIGHT_SYSTEM='" & word & "'"
                        End If
                    Next
                Else
                    Dim words As String() = values.Split(New Char() {","c})
                    For Each word In words
                        If (word <> "") Then
                            District &= "AND FREIGHT_SYSTEM='" & word & "'"
                        End If
                    Next
                End If
            End If
            'ChkFreightSystem End

            'txtbox Search field Start
            If (txtSearchText.Text <> "") Then
                District &= "AND OID like '%" & txtSearchText.Text & "%' OR FDOT_District like '%" & txtSearchText.Text & "%' OR COUNTY like '%" & txtSearchText.Text & "%' OR CORRIDOR like '%" & txtSearchText.Text & "%' OR  ISSUE_EXTENT like '%" & txtSearchText.Text & "%' OR SITE_LOCATION like '%" & txtSearchText.Text & "%' OR ISSUESITELOC like '%" & txtSearchText.Text & "%' OR FREIGHT_NEED like '%" & txtSearchText.Text & "%' OR ISSUE_DESCRIPTION like '%" & txtSearchText.Text & "%' OR CORRIDOR_SEGMENT like'%" & txtSearchText.Text & "%' OR FRGHT_TRVL_MRKT like '%" & txtSearchText.Text & "%' OR PRIORITY like '%" & txtSearchText.Text & "%' OR EASE like '%" & txtSearchText.Text & "%' OR SEGMENT_TO ='%" & txtSearchText.Text & "%' OR SEGMENT_FROM like '%" & txtSearchText.Text & "%' OR ROADWAYID like '%" & txtSearchText.Text & "%' OR BEGMP like '%" & txtSearchText.Text & "%' OR ENDMP like'%" & txtSearchText.Text & "%' OR TRANSPORT_SYSTEM like '%" & txtSearchText.Text & "%' OR FREIGHT_SYSTEM like '%" & txtSearchText.Text & "%' OR RECOMMENDATION_DESC like '%" & txtSearchText.Text & "%' OR FIELD_OBS like '%" & txtSearchText.Text & "%' OR COMMENTS like'%" & txtSearchText.Text & "%' OR IMPRVMNT_STAGE_NAME like '%" & txtSearchText.Text & "%' OR SOURCE like '%" & txtSearchText.Text & "%' OR DATE_RECMDED_EVAL like '%" & txtSearchText.Text & "%' OR  DATE_MODIFIED like '%" & txtSearchText.Text & "%' OR MISC_INFO like '%" & txtSearchText.Text & "%'"
            End If
            If (txtRdwyID.Text <> "") Then
                District &= "AND ROADWAYID = '" & txtRdwyID.Text & "'"
            End If
            'txtbox Search End

            ' Beg MP and END MP
            If (txtBegMP.Text <> "") Then
                If (txtEndMP.Text <> "") Then
                    District &= "AND BEGMP >='" & txtBegMP.Text & "' AND ENDMP <= '" & txtEndMP.Text & "'"
                End If
                District &= "AND BEGMP='" & txtBegMP.Text & "'"
            End If
            If (txtEndMP.Text <> "") Then
                District &= "AND BEGMP >='" & txtBegMP.Text & "' AND ENDMP <= '" & txtEndMP.Text & "'"
            End If

            If (District <> "") Then
                District = District.Remove(0, 3)
                Query &= "Where " & District
            End If
            If (Sorting <> "" And Order <> "") Then
                Query &= " Order By " & Order & " " & Sorting
            End If
            AccessDataSource1.SelectCommand = Query
            grdRecords.DataSource = AccessDataSource1
            grdRecords.DataBind()
            lblSelectedRecord.Text = grdRecords.Rows.Count
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub ChkImplementEase_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkImplementEase.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub ChkCounty_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkCounty.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub ChKISSUE_EXTENT_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChKISSUE_EXTENT.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblError.Text = ex.Message
        End Try
    End Sub

    Protected Sub ChkFreightNeed_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkFreightNeed.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub ChkIssueDescription_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkIssueDescription.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub
    Protected Sub ChkSource_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkSource.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub
    Protected Sub ChkFreightSystem_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkFreightSystem.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub ChkTransportSystem_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkTransportSystem.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub ChkConstraints_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ChkConstraints.SelectedIndexChanged
        Try
            FilterRecord("ASC", "")
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub
    Protected Sub btnExport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExport.Click


        Try
            Dim Path As String = "C:\WorkSpace\CFID_file_" & DateTime.Now.Day.ToString() & "_" & DateTime.Now.Month.ToString() & ".xls"


            Response.Redirect(Path)



            Dim FI As New FileInfo(Path)
            Dim stringWriter As New StringWriter()
            Dim htmlWrite As New HtmlTextWriter(stringWriter)
            Dim DataGrd As New DataGrid()
            ' DataGrd.DataSource = grdRecords
            '  DataGrd.DataBind()

            '    grdRecords.RenderControl(htmlWrite)
            '    Dim directory__1 As String = Path.Substring(0, Path.LastIndexOf("\"))
            '    ' GetDirectory(Path);
            '    If Not Directory.Exists(directory__1) Then
            '        Directory.CreateDirectory(directory__1)
            '    End If

            '    Dim vw As New System.IO.StreamWriter(Path, True)
            '    stringWriter.ToString().Normalize()
            '    vw.Write(stringWriter.ToString())
            '    vw.Flush()
            '    vw.Close()
            '    WriteAttachment(FI.Name, "application/vnd.ms-excel", stringWriter.ToString())
            '    lblGrideError.Text = "Export Record Successfull"
        Catch ex As Exception
            lblGrideError.Text = "Error in export the result " & ex.Message
        End Try
    End Sub
    Public Shared Sub WriteAttachment(ByVal FileName As String, ByVal FileType As String, ByVal content As String)
        Dim Response As HttpResponse = System.Web.HttpContext.Current.Response
        Response.ClearHeaders()
        Response.AppendHeader("Content-Disposition", "attachment; filename=" & FileName)
        Response.ContentType = FileType
        Response.Write(content)
        Response.[End]()

    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
    End Sub

    Private Sub TotalRecord()
        Try
            'fn_ConenctDatabase()
            Dim connection As OleDbConnection = New OleDbConnection()
            connection.ConnectionString = ConfigurationManager.AppSettings("connectionString").ToString()
            Dim cmd As New OleDbCommand("select count(OID) as ID from CFID_MASTER_TBL", connection)
            cmd.CommandType = CommandType.Text
            cmd.Connection = connection
            connection.Open()
            Dim Adapter As OleDbDataAdapter = New OleDbDataAdapter(cmd)
            Dim dt As Data.DataTable = New Data.DataTable()
            Adapter.Fill(dt)
            lblTotalRecords.Text = dt.Rows(0)("ID")

        Catch ex As Exception
            lblGrideError.Text = "Total Record ,load error" & ex.Message
        End Try
    End Sub
    Protected Sub SortRecords(ByVal sender As Object, ByVal e As GridViewSortEventArgs)
        Try
            Dim Order As String = ""
            If ViewState("SortDirection") Is Nothing Then

                ViewState("SortDirection") = " ASC "
                Order = " ASC "
                HidSort.Value = Order
            Else

                If (ViewState("SortDirection") = " ASC ") Then
                    ViewState("SortDirection") = " DESC "
                    Order = " DESC "
                Else
                    ViewState("SortDirection") = " ASC "
                    Order = " ASC "
                End If
            End If
            Select Case e.SortExpression
                Case "COUNTY"
                    FilterRecord(Order, "COUNTY")
                Case "PRIORITY"
                    FilterRecord(Order, "PRIORITY")
                Case "OID"
                    FilterRecord(Order, "OID")
                Case "SITE_LOCATION"
                    FilterRecord(Order, "SITE_LOCATION")
                Case "FREIGHT_NEED"
                    FilterRecord(Order, "FREIGHT_NEED")
                Case "ISSUE_EXTENT"
                    FilterRecord(Order, "ISSUE_EXTENT")
                Case "FIELD_VERIFIED"
                    FilterRecord(Order, "FIELD_VERIFIED")
            End Select

        Catch ex As Exception
            lblGrideError.Text = "Sorting Error " & ex.Message
        End Try
    End Sub

    Protected Sub btnReset_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReset.Click
        Response.Redirect("viewall_records.aspx")
    End Sub

    Private Sub InsertintoArchive(ByVal ID As String)
        Try

            Dim connection As OleDbConnection = New OleDbConnection()
            connection.ConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=|DataDirectory|\CFID.mdb;User Id=admin;Password=;"
           
            Dim sql = "Select * From CFID_MASTER_TBL Where OID=" + ID
            Dim dbcomm = New OleDbCommand(sql, connection)
            dbcomm.Connection = connection
            connection.Open()
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim dt As New DataTable
            adp.Fill(dt)
            Dim BEGMP As String
            If (IsDBNull(dt.Rows(0)("BEGMP"))) Then
                BEGMP = 0
            Else
                BEGMP = dt.Rows(0)("BEGMP").ToString()
            End If

            Dim ENDMP As String
            If (IsDBNull(dt.Rows(0)("ENDMP"))) Then
                ENDMP = 0
            Else
                ENDMP = dt.Rows(0)("ENDMP").ToString()
            End If

            Dim LATY As String
            If (IsDBNull(dt.Rows(0)("LATY"))) Then
                LATY = 0
            Else
                LATY = dt.Rows(0)("LATY").ToString()
            End If

            Dim LONX As String
            If (IsDBNull(dt.Rows(0)("LONX"))) Then
                LONX = 0
            Else
                LONX = dt.Rows(0)("LONX").ToString()
            End If
            'lblTotalRecords.Text = dt.Rows(0)("ID")
            Dim Query As String = "INSERT INTO CFID_MASTER_TBL_archive" & _
                         "(ID, FDOT_District, COUNTY, CORRIDOR, ISSUE_EXTENT, SITE_LOCATION, ISSUESITELOC, FREIGHT_NEED, ISSUE_DESCRIPTION," & _
                         "CORRIDOR_SEGMENT, FRGHT_TRVL_MRKT, PRIORITY, EASE, ROWCONSTRAINT, UTILITYCONSTRAINT, LIGHTPOLECONSTRAINT, SIGNAGECONSTRAINT, " & _
                         "STRUCTURECONSTRAINT, OTHERCONSTRAINT, FIELD_VERIFIED, DATE_RECOMMENDED, SEGMENT_TO, SEGMENT_FROM, ROADWAYID, BEGMP, " & _
                         "ENDMP, LAT, LON, TRANSPORT_SYSTEM, FREIGHT_SYSTEM, FIELD_OBS, RECOMMENDATION_DESC, COMMENTS, IMPRVMNT_STAGE, " & _
                         "IMPRVMNT_STAGE_NAME, SOURCE, DATE_RECMDED_EVAL, DATE_MODIFIED, MISC_INFO, LATY, LONX, Test)" & _
            "VALUES(" & dt.Rows(0)("ID") & ",'" & dt.Rows(0)("FDOT_District") & "','" & dt.Rows(0)("COUNTY") & "','" & dt.Rows(0)("CORRIDOR") & _
        "','" & dt.Rows(0)("ISSUE_EXTENT") & "','" & dt.Rows(0)("SITE_LOCATION") & "','" & dt.Rows(0)("ISSUESITELOC") & "','" & dt.Rows(0)("FREIGHT_NEED") & _
        "','" & dt.Rows(0)("ISSUE_DESCRIPTION") & "','" & dt.Rows(0)("CORRIDOR_SEGMENT") & "','" & dt.Rows(0)("FRGHT_TRVL_MRKT") & "','" & dt.Rows(0)("PRIORITY") & _
        "','" & dt.Rows(0)("EASE") & "','" & dt.Rows(0)("ROWCONSTRAINT") & "','" & dt.Rows(0)("UTILITYCONSTRAINT") & "','" & dt.Rows(0)("LIGHTPOLECONSTRAINT") & _
        "','" & dt.Rows(0)("SIGNAGECONSTRAINT") & "','" & dt.Rows(0)("STRUCTURECONSTRAINT") & "','" & dt.Rows(0)("OTHERCONSTRAINT") & "'," & dt.Rows(0)("FIELD_VERIFIED") & _
        ",'" & dt.Rows(0)("DATE_RECOMMENDED") & "','" & dt.Rows(0)("SEGMENT_TO") & "','" & dt.Rows(0)("SEGMENT_FROM") & "','" & dt.Rows(0)("ROADWAYID") & _
        "'," & BEGMP & "," & ENDMP & ",'" & dt.Rows(0)("LAT") & "','" & dt.Rows(0)("LON") & "','" & dt.Rows(0)("TRANSPORT_SYSTEM") & _
        "','" & dt.Rows(0)("FREIGHT_SYSTEM") & "','" & dt.Rows(0)("FIELD_OBS") & "','" & dt.Rows(0)("RECOMMENDATION_DESC") & "','" & dt.Rows(0)("COMMENTS") & _
        "','" & dt.Rows(0)("IMPRVMNT_STAGE") & "','" & dt.Rows(0)("IMPRVMNT_STAGE_NAME") & "','" & dt.Rows(0)("SOURCE") & "','" & dt.Rows(0)("DATE_RECMDED_EVAL") & _
        "','" & dt.Rows(0)("DATE_MODIFIED") & "','" & dt.Rows(0)("MISC_INFO") & "'," & LATY & "," & LONX & "," & dt.Rows(0)("Test") & ")"

            Dim InsertCmd As New OleDbCommand(Query, connection)
            Dim adapter As New OleDbDataAdapter(Query, connection)

            InsertCmd.CommandType = CommandType.Text
            InsertCmd.Connection = connection
            connection.Close()
            connection.Open()
            Dim result = InsertCmd.ExecuteNonQuery()
            If result <> 0 Then
                Reset()
                lblGrideError.Text = "<font color=green><strong>Record has been Submited Successfully.</strong></font>"
            Else
                lblGrideError.Text = "<font color=red><strong>An Error has been Occured while saving the record. Please try again.</strong></font>"
            End If

            Dim query1 = "Delete From CFID_MASTER_TBL Where OID=" & ID
            Dim dbcommupdate = New OleDbCommand(query1, connection)
            dbcommupdate.Connection = connection
            connection.Close()
            connection.Open()
            Dim result1 = dbcommupdate.ExecuteNonQuery()
            If result1 <> 0 Then
                lblGrideError.Text = "<font color=green><strong>Record has been Archive.</strong></font>"
                'Response.Redirect("ViewAll_Records.aspx")
            Else
                lblGrideError.Text = "<font color=red><strong>An Error has been Occured while deleting the record. Please try again.</strong></font>"
            End If
        Catch ex As Exception
            lblGrideError.Text = "Total Record ,load error" & ex.Message
        End Try
    End Sub

    'Populate all the values in modelpop
    Protected Sub btnComments_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            ModalPopupExtender2.Show()
            Dim row As GridViewRow = DirectCast(DirectCast(sender, Control).NamingContainer, GridViewRow)
            Dim test As GridViewRow = grdRecords.Rows(grdRecords.EditIndex = 0)
            Dim lblOID As Label = DirectCast(grdRecords.Rows(row.RowIndex).FindControl("LabelOID"), Label)
            lblPopuError.Text = lblOID.Text

            DSPopupComment.SelectCommand = "Select * from USER_COMMENT where (OBJECTID=" & lblPopuError.Text & ")"
            gvPopupup.DataSource = DSPopupComment
            gvPopupup.DataBind()
            BtnPopuUpUpdatePanel.Update()

        Catch ex As Exception
            lblError.Text = ex.Message
        End Try
    End Sub

    ' Insert the comments 
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            If (lblPopuError.Text <> "") Then
                Dim Query As String = "Insert into USER_COMMENT (OBJECTID, COMMENT,COMMENT_DATE,ID, USERNAME) VALUES ('" & lblPopuError.Text & "','" & txtComments.Text & "','" & Date.Now & "','" & lblPopuError.Text & "','" & HidUserName.Value & "') "
                Dim connection As OleDbConnection = New OleDbConnection()
                connection.ConnectionString = ConfigurationManager.AppSettings("connectionString").ToString()
                Dim InsertCmd As New OleDbCommand(Query, connection)
                InsertCmd.CommandType = CommandType.Text
                InsertCmd.Connection = connection
                connection.Close()
                connection.Open()
                Dim result = InsertCmd.ExecuteNonQuery()
                If result <> 0 Then
                    Reset()
                    lblGrideError.Text = "<font color=green><strong>Record has been Submited Successfully.</strong></font>"
                Else
                    lblGrideError.Text = "<font color=red><strong>An Error has been Occured while saving the record. Please try again.</strong></font>"
                End If
                gvPopupup.DataBind()
            Else
                lblPopuError.Text = "Please type the comments "
                Return
            End If
           
        Catch ex As Exception
            lblGrideError.Text = ex.Message
        End Try
    End Sub

    Protected Sub FilterR(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click



    End Sub


End Class
