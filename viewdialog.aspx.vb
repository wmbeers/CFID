Imports System.Data.OleDb
Imports System.Data
Imports System.Configuration
Partial Class viewdialog
    Inherits System.Web.UI.Page
    Dim dbconn
    Private Sub ConnectToDatabase()
        dbconn = New OleDbConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
    End Sub

    Private Sub FillDetails()

        Try
            ConnectToDatabase()
            Dim sql = "Select * From CFID_MASTER_TBL Where ObjectID=" & Request("OID").ToString()
            Dim dbcomm = New OleDbCommand(sql, dbconn)
            Dim adp As New OleDb.OleDbDataAdapter(dbcomm)
            Dim ds As New DataSet
            adp.Fill(ds)

            Me.lblID.Text = ds.Tables(0).Rows(0)("OID").ToString()
        Catch ex As Exception
            lblMessage.Text = "<font color=red><strong>" & ex.Message & "</strong></font>"
        End Try
    End Sub


End Class
