Imports System.Data
Imports System.Configuration
Imports System.Data.OleDb

Partial Class General_Master
    Inherits System.Web.UI.Page
    Dim dbconn

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            CheckDisctrict()
            Bind_Parents()
        End If
        lblMessage.Text = ""
    End Sub

    Private Sub ConnectToDatabase()
        dbconn = New OleDbConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
    End Sub

    Public Sub Bind_Parents()
        Try
            ConnectToDatabase()
            Dim sql = "Select * From " + ViewState("GenTable") + " Where Parent_id=0"
            Dim dbcomm = New OleDbCommand(sql, dbconn)
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim ds As New DataSet
            adp.Fill(ds)
            ddlParentName.DataSource = ds
            ddlParentName.DataTextField = "Description"
            ddlParentName.DataValueField = "Record_id"
            ddlParentName.DataBind()
            ddlParentName.Items.Insert(0, "<--Select Category-->")
            ddlParentName.Items(0).Value = "0"
            ddlParentName.SelectedIndex = 0
        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub

    Private Sub CheckDisctrict()
        If (Session("District") = "1") Then
            ViewState("MainTable") = "D1_CFID_MASTER_TBL"
            ViewState("GenTable") = "tblCF_General_D1"
        ElseIf (Session("District") = "7") Then
            ViewState("MainTable") = "CFID_MASTER_TBL"
            ViewState("GenTable") = "tblCF_General"
        End If
    End Sub

    Public Sub Bind_SubCategory()
        Try
            If (ddlParentName.SelectedIndex > 0) Then
                ConnectToDatabase()
                Dim sql = "Select * From " + ViewState("GenTable") + " Where Parent_id=" & ddlParentName.SelectedValue
                Dim dbcomm = New OleDbCommand(sql, dbconn)
                Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
                Dim ds As New DataSet
                adp.Fill(ds)
                grdRecords.DataSource = ds
                grdRecords.DataBind()
            End If
        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSubmit.Click
        Try
            If btnSubmit.Text = "Submit" Then
                ConnectToDatabase()
                Dim query = "INSERT INTO " + ViewState("GenTable") + "(Parent_id,Description) VALUES ('" & ddlParentName.SelectedValue & "','" & txtdescrption.Text & "'" & ")"
                Dim dbcommupdate = New OleDbCommand(query, dbconn)
                Dim result = dbcommupdate.ExecuteNonQuery()
                If result <> 0 Then
                    Dim sql = "Select * From " + ViewState("GenTable") + " Where Parent_id=" & ddlParentName.SelectedValue
                    Dim dbcomm = New OleDbCommand(sql, dbconn)
                    Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
                    Dim ds As New DataSet
                    adp.Fill(ds)
                    grdRecords.DataSource = ds
                    grdRecords.DataBind()
                    Reset()
                    lblMessage.Text = "<font color=green><strong>Category has been Added Successfully.</strong></font>"
                Else
                    lblMessage.Text = "<font color=red><strong>An Error has been Occured while saving the record. Please try again.</strong></font>"
                End If
            ElseIf btnSubmit.Text = "Update" Then
                ConnectToDatabase()
                Dim query = "Update " + ViewState("GenTable") + " Set Description='" & txtdescrption.Text & "' Where Record_id = " & ViewState("EditIndex").ToString()
                Dim dbcommupdate = New OleDbCommand(query, dbconn)
                Dim result = dbcommupdate.ExecuteNonQuery()
                If result <> 0 Then
                    Dim sql = "Select * From " + ViewState("GenTable") + " Where Parent_id=" & ddlParentName.SelectedValue
                    Dim dbcomm = New OleDbCommand(sql, dbconn)
                    Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
                    Dim ds As New DataSet
                    adp.Fill(ds)
                    grdRecords.DataSource = ds
                    grdRecords.DataBind()
                    Reset()
                    lblMessage.Text = "<font color=green><strong>Category has been Updated Successfully.</strong></font>"
                Else
                    lblMessage.Text = "<font color=red><strong>An Error has been Occured while updating the record. Please try again.</strong></font>"
                End If
            End If

        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try

    End Sub

    Private Sub Reset()
        txtdescrption.Text = ""
        btnSubmit.Text = "Submit"
    End Sub

    Protected Sub ddlParentName_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs) Handles ddlParentName.SelectedIndexChanged
        Bind_SubCategory()
        Reset()
    End Sub

    Protected Sub grdRecords_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles grdRecords.RowCommand
        If e.CommandName = "ed" Then
            ConnectToDatabase()
            Dim sql = "Select * From " + ViewState("GenTable") + " Where Record_id=" & e.CommandArgument.ToString()
            Dim dbcomm = New OleDbCommand(sql, dbconn)
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim ds As New DataSet
            adp.Fill(ds)
            ddlParentName.SelectedValue = ds.Tables(0).Rows(0)("Parent_id").ToString()
            txtdescrption.Text = ds.Tables(0).Rows(0)("Description").ToString()
            btnSubmit.Text = "Update"
            ViewState("EditIndex") = e.CommandArgument.ToString()

        ElseIf e.CommandName = "del" Then
            ConnectToDatabase()
            Dim query = "Delete From " + ViewState("GenTable") + " Where Record_id=" & e.CommandArgument.ToString()
            Dim dbcommupdate = New OleDbCommand(query, dbconn)
            Dim result = dbcommupdate.ExecuteNonQuery()
            If result <> 0 Then
                Reset()
                Bind_SubCategory()
                lblMessage.Text = "<font color=green><strong>Category has been Deleted Successfully.</strong></font>"
            Else
                lblMessage.Text = "<font color=red><strong>An Error has been Occured while deleting the record. Please try again.</strong></font>"
            End If
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnCancel.Click
        Reset()
    End Sub
End Class
