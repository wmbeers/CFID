Imports System.Web.Services
Imports System.Web.Script.Services
Imports System.Data.OleDb

Partial Class mapViewer_Default
    Inherits System.Web.UI.Page


   


    <WebMethod()> _
   <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function GetAttributeTableData(ByVal iDisplayStart As Integer, ByVal iDisplayLength As Integer, ByVal sSearch As String, ByVal bEscapeRegex As Boolean, ByVal iColuns As Integer, ByVal iSortingCols As Integer, ByVal iSortCol_0 As Integer, ByVal sSortDir_0 As String, ByVal sEcho As Integer, ByVal websiteId As Integer, ByVal categoryId As Integer)



    End Function


    Private Class DataTableResponse
        Public iTotalRecords As Integer
        Public iTotalDisplayRecords As Integer
        Public sEcho As String
        Public aaData As Generic.List(Of CfidRecord)
    End Class



    Private Class CfidRecord
        Public id As Integer
        Public SiteLocation As String
        'TODO: etc.
    End Class

End Class
