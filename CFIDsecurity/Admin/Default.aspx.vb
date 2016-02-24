
Partial Class Admin_Default
    Inherits System.Web.UI.Page

    Public Class SimpleRoleModel
        Public Roles As New List(Of String)
        Public Users As New List(Of User)

        Public Class User
            Public UserName As String
            Public Email As String
            Public Enabled As Boolean
            Public Roles As List(Of String)
            Public Sub New()

            End Sub
            Public Sub New(u As MembershipUser)
                Me.UserName = u.UserName
                Me.Email = u.Email
            End Sub
        End Class
    End Class

    Public RoleModel As New SimpleRoleModel()

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        For Each role As String In Roles.GetAllRoles()
            RoleModel.Roles.Add(role)
        Next

        For Each u As MembershipUser In Membership.GetAllUsers
            Dim u2 As New SimpleRoleModel.User
        Next
        

    End Sub

    Public Sub DisableUser(UserName As String)

    End Sub

    Public Sub AddUserToRole(UserName As String, RoleName As String)

    End Sub

    Public Sub RemoveUserFromRole(UserName As String, RoleName As String)

    End Sub
End Class
