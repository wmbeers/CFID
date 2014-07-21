<%@ Application Language="VB" %>
<%@ Import Namespace="System.Web.Optimization" %>

<script runat="server">

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        BundleConfig.RegisterBundles(BundleTable.Bundles)
        AuthConfig.RegisterOpenAuth()
        
        'create initial roles if not already created--this is a one-time block of code when first running this on a new server
        If Roles.GetAllRoles().Length < 1 Then
            Roles.CreateRole("Admin")
            Roles.CreateRole("Editor")
            Roles.CreateRole("Contributor")
            Dim Admin As MembershipUser = Membership.CreateUser("Administrator", "ej9dee0h")
            Roles.AddUserToRole("Administrator", "Admin")
            
            Dim Editor As MembershipUser = Membership.CreateUser("Editor", "cfidEd1t0r")
            Roles.AddUserToRole("Editor","Editor")
            
        End If
        
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

</script>