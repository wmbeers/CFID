Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.Data.OleDb

Partial Class mapViewer_Default
    Inherits System.Web.UI.Page

    Protected CanEdit As Boolean = False

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        'Check if user has Edit role
        Me.CanEdit = User.IsInRole("Editor")
    End Sub
End Class
