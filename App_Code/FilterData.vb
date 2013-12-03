Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports System.Web.Script.Services
Imports System.Data
Imports System.Data.SqlClient
Imports System.Reflection

' To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")> _
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)> _
<ScriptService()> _
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Public Class FilterData
    Inherits System.Web.Services.WebService

    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function GetUniqueValues(ByVal FieldName As String) As Generic.List(Of String)
        Dim reply As New Generic.List(Of String)
        Dim dbconn As New SqlConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
        Dim dbcmd As New SqlCommand("select distinct [" + FieldName + "] FROM [cfid_master_view] where Archived = 0", dbconn)
        Dim rdr As SqlDataReader = dbcmd.ExecuteReader
        Do While rdr.Read
            reply.Add(rdr(0))
        Loop
        dbconn.Close()
        Return reply

    End Function

    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function GetFilterValues() As Generic.List(Of Filter)
        Dim reply As New Generic.List(Of Filter)

        'reply.Add(New Filter("District", "FDOT_District", "'District ' + [FDOT_District] as l, [FDOT_District] as v"))
        reply.Add(New Filter("District", "FDOT_District", New String() {"District 1", "District 7"}, New String() {"1", "7"}))
        reply.Add(New Filter("County", "COUNTY"))
        reply.Add(New Filter("Extent", "ISSUE_EXTENT"))

        reply.Add(New Filter("Priority", "PRIORITY"))
        reply.Add(New Filter("Implementation Ease", "EASE"))
        reply.Add(New Filter("Freight Need", "Freight_Need"))
        reply.Add(New Filter("Issue Description", "ISSUE_DESCRIPTION"))
        'SPECIAL CASE reply.Add(New Filter("Constraints", ""))
        'reply.Add(New Filter("Source", "SOURCE"))
        reply.Add(New Filter("Transport System", "TRANSPORT_SYSTEM"))
        reply.Add(New Filter("Freight System", "FREIGHT_SYSTEM"))
        'reply.Add(New Filter("Improvement Stage", "IMPRVMNT_STAGE"))

        reply.Add(New Filter("Improvement Stage", "IMPRVMNT_STAGE", New String() {"Issue Identified", "Issue Field Verified", "Strategy Identified", "Accepted/Assigned to Work Program", "Improvement in Progress", "Completed"}))

        Return reply
    End Function


    Public Class Filter
        Public Label As String
        Public FieldName As String
        Public Values As New Generic.List(Of FilterLabelValue)

        Public Sub New()

        End Sub

        Public Sub New(ByVal label As String, ByVal fieldName As String, ByVal labels As String())
            Me.Label = label
            Me.FieldName = fieldName
            For Each v As String In labels
                Me.Values.Add(New FilterLabelValue(v, v))
            Next
        End Sub

        Public Sub New(ByVal label As String, ByVal fieldName As String, ByVal labelsArray As String(), ByVal valuesArray As String())
            Me.Label = label
            Me.FieldName = fieldName
            For i As Integer = 0 To labelsArray.Length - 1
                Me.Values.Add(New FilterLabelValue(labelsArray(i), valuesArray(i)))
            Next

        End Sub

        Public Sub New(ByVal label As String, ByVal fieldName As String, Optional ByVal selectExpression As String = "")
            Dim dbconn As New SqlConnection(ConfigurationManager.AppSettings("connectionString").ToString())
            Me.Label = label
            Me.FieldName = fieldName

            If selectExpression = "" Then selectExpression = "[" + fieldName + "] as l, [" + fieldName + "] as v"

            Try
                dbconn.Open()
                Dim dbcmd As New SqlCommand("select distinct " + selectExpression + " FROM [cfid_master_view] where Archived = 0", dbconn)
                Dim rdr As SqlDataReader = dbcmd.ExecuteReader
                Do While rdr.Read
                    If rdr.IsDBNull(0) Or rdr.IsDBNull(1) Then
                        Values.Add(New FilterLabelValue("-null-", "<null>"))
                    Else
                        Values.Add(New FilterLabelValue(rdr("l"), rdr("v")))
                    End If
                Loop
                dbconn.Close()

            Catch ex As Exception
                System.Diagnostics.Debug.Print("Error querying field name " & fieldName & " with select expression '" & selectExpression & "'")
                System.Diagnostics.Debug.Print(ex.Message)
                Throw
            End Try

        End Sub
    End Class

    Public Class FilterLabelValue
        Public Label As String
        Public Value As String

        Public Sub New()

        End Sub

        Public Sub New(ByVal label As String, ByVal value As String)
            Me.Label = label
            Me.Value = value
        End Sub
    End Class

    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function GetRecordsByOIDs(ByVal OIDs As String()) As List(Of CFIDRecord) 'TODO: add paging and sorting, have signature return match jQuery.DataTable expectations
        Dim dbconn As New SqlConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()
        Dim cmd As New SqlCommand("select * from cfid_master_view where objectid in (" + Join(OIDs, ",") + ")", dbconn)
        Dim rdr As SqlDataReader = cmd.ExecuteReader
        Dim recs As New List(Of CFIDRecord)
        Do While rdr.Read
            recs.Add(GetRecordFromRow(rdr))
        Loop
        rdr.Close()
        dbconn.Close()
        Return recs
    End Function


    Private Function GetRecordFromRow(ByVal rdr As SqlDataReader) As CFIDRecord
        Dim r As New CFIDRecord

        'Special cases where my object has different data types from what's in the database
        ' r.FieldVerified = If(rdr("FIELD_VERIFIED") = 1, True, False)
        Integer.TryParse(rdr("DATE_RECOMMENDED"), r.YearRecommended)


        'ISSUE_SITE_LOCATION
        If Not rdr("ISSUESITELOC") Is DBNull.Value Then
            Dim isl As String = rdr("ISSUESITELOC")
            r.islNWcorner = isl.Contains("NW corner")
            r.islNEcorner = isl.Contains("NE corner")
            r.islSWcorner = isl.Contains("SW corner")
            r.islSEcorner = isl.Contains("SE corner")
            r.islNBapproach = isl.Contains("NB approach")
            r.islSBapproach = isl.Contains("SB approach")
            r.islEBapproach = isl.Contains("EB approach")
            r.islWBapproach = isl.Contains("WB approach")
            r.islNorthLegMedian = isl.Contains("North leg median")
            r.islSouthLegMedian = isl.Contains("South leg median")
            r.islWestLegMedian = isl.Contains("West leg median")
            r.islEastLegMedian = isl.Contains("East leg median")
            r.islNBlanes = isl.Contains("NB lanes")
            r.islSBlanes = isl.Contains("SB lanes")
            r.islEBlanes = isl.Contains("EB lanes")
            r.islWBlanes = isl.Contains("WB lanes")
        End If

        'Simple reflection for all remaining values
        For i As Integer = 0 To rdr.FieldCount - 1
            Dim FieldName As String = rdr.GetName(i)
            System.Diagnostics.Debug.Print(FieldName)

            Dim p As System.Reflection.FieldInfo = r.GetType().GetField(FieldName)

            If p Is Nothing Then
                Continue For
            End If
            If Not rdr.IsDBNull(i) Then
                p.SetValue(r, rdr(i))
            End If

        Next

        'special case for OBJECTID > OID
        r.OID = rdr("OBJECTID")



        Return r
    End Function



    <WebMethod()> _
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)> _
    Public Function SaveRecord(ByVal cfidRecord As CFIDRecord) As CFIDRecord
        Dim dbconn As New SqlConnection(ConfigurationManager.AppSettings("connectionString").ToString())
        dbconn.Open()

        Dim cmd As New SqlCommand
        cmd.Connection = dbconn

        If cfidRecord.OID = 0 Then
            cmd.CommandText = "INSERT INTO CFID_MASTER_TBL (FDOT_District, COUNTY, CORRIDOR, ISSUE_EXTENT, SITE_LOCATION, SEGMENT_TO, SEGMENT_FROM, ISSUESITELOC, FREIGHT_NEED, ISSUE_DESCRIPTION, PRIORITY, EASE, ROWCONSTRAINT, UTILITYCONSTRAINT, LIGHTPOLECONSTRAINT, SIGNAGECONSTRAINT, STRUCTURECONSTRAINT, OTHERCONSTRAINT, FIELD_VERIFIED, DATE_RECOMMENDED, ROADWAYID, BEGMP, ENDMP, SECONDRDWYID, LOCMP, Ydd, Xdd, TRANSPORT_SYSTEM, FREIGHT_SYSTEM, FIELD_OBS, RECOMMENDATION_DESC, COMMENTS, IMPRVMNT_STAGE, SOURCE, MISC_INFO) values (@FDOT_District, @COUNTY, @CORRIDOR, @ISSUE_EXTENT, @SITE_LOCATION, @SEGMENT_TO, @SEGMENT_FROM, @ISSUESITELOC, @FREIGHT_NEED, @ISSUE_DESCRIPTION, @PRIORITY, @EASE, @ROWCONSTRAINT, @UTILITYCONSTRAINT, @LIGHTPOLECONSTRAINT, @SIGNAGECONSTRAINT, @STRUCTURECONSTRAINT, @OTHERCONSTRAINT, @FIELD_VERIFIED, @DATE_RECOMMENDED, @ROADWAYID, @BEGMP, @ENDMP, @SECONDRDWYID, @LOCMP, @Ydd, @Xdd, @TRANSPORT_SYSTEM, @FREIGHT_SYSTEM, @FIELD_OBS, @RECOMMENDATION_DESC, @COMMENTS, @IMPRVMNT_STAGE, @SOURCE, @MISC_INFO) "
        Else
            cmd.CommandText = "UPDATE CFID_MASTER_TBL SET FDOT_District=@FDOT_District, COUNTY=@COUNTY, CORRIDOR=@CORRIDOR, ISSUE_EXTENT=@ISSUE_EXTENT, SITE_LOCATION=@SITE_LOCATION, SEGMENT_TO=@SEGMENT_TO, SEGMENT_FROM=@SEGMENT_FROM, ISSUESITELOC=@ISSUESITELOC, FREIGHT_NEED=@FREIGHT_NEED, ISSUE_DESCRIPTION=@ISSUE_DESCRIPTION, PRIORITY=@PRIORITY, EASE=@EASE, ROWCONSTRAINT=@ROWCONSTRAINT, UTILITYCONSTRAINT=@UTILITYCONSTRAINT, LIGHTPOLECONSTRAINT=@LIGHTPOLECONSTRAINT, SIGNAGECONSTRAINT=@SIGNAGECONSTRAINT, STRUCTURECONSTRAINT=@STRUCTURECONSTRAINT, OTHERCONSTRAINT=@OTHERCONSTRAINT, FIELD_VERIFIED=@FIELD_VERIFIED, DATE_RECOMMENDED=@DATE_RECOMMENDED, ROADWAYID=@ROADWAYID, BEGMP=@BEGMP, ENDMP=@ENDMP, SECONDRDWYID=@SECONDRDWYID, LOCMP=@LOCMP, Ydd=@Ydd, Xdd=@Xdd, TRANSPORT_SYSTEM=@TRANSPORT_SYSTEM, FREIGHT_SYSTEM=@FREIGHT_SYSTEM, FIELD_OBS=@FIELD_OBS, RECOMMENDATION_DESC=@RECOMMENDATION_DESC, COMMENTS=@COMMENTS, IMPRVMNT_STAGE=@IMPRVMNT_STAGE, SOURCE=@SOURCE, MISC_INFO=@MISC_INFO WHERE OBJECTID=@OID"
        End If

        Select Case cfidRecord.COUNTY
            Case "Charlotte"
                cfidRecord.FDOT_District = 1
            Case "Citrus"
                cfidRecord.FDOT_District = 7
            Case "Collier"
                cfidRecord.FDOT_District = 1
            Case "De Soto"
                cfidRecord.FDOT_District = 1
            Case "Glades"
                cfidRecord.FDOT_District = 1
            Case "Hardee"
                cfidRecord.FDOT_District = 1
            Case "Hendry"
                cfidRecord.FDOT_District = 1
            Case "Hernando"
                cfidRecord.FDOT_District = 7
            Case "Highlands"
                cfidRecord.FDOT_District = 1
            Case "Hillsborough"
                cfidRecord.FDOT_District = 7
            Case "Lee"
                cfidRecord.FDOT_District = 1
            Case "Manatee"
                cfidRecord.FDOT_District = 1
            Case "Okeechobee"
                cfidRecord.FDOT_District = 1
            Case "Pasco"
                cfidRecord.FDOT_District = 7
            Case "Pinellas"
                cfidRecord.FDOT_District = 7
            Case "Polk"
                cfidRecord.FDOT_District = 1
            Case "Sarasota"
                cfidRecord.FDOT_District = 1
        End Select

        cmd.Parameters.AddWithValue("FDOT_District", cfidRecord.FDOT_District)
        cmd.Parameters.AddWithValue("COUNTY", cfidRecord.COUNTY)
        cmd.Parameters.AddWithValue("CORRIDOR", cfidRecord.CORRIDOR)
        cmd.Parameters.AddWithValue("ISSUE_EXTENT", cfidRecord.ISSUE_EXTENT)
        cmd.Parameters.AddWithValue("SITE_LOCATION", cfidRecord.SITE_LOCATION)
        cmd.Parameters.AddWithValue("SEGMENT_TO", cfidRecord.SEGMENT_TO)
        cmd.Parameters.AddWithValue("SEGMENT_FROM", cfidRecord.SEGMENT_FROM)
        cmd.Parameters.AddWithValue("ISSUESITELOC", cfidRecord.GetIssueSiteLocation)
        cmd.Parameters.AddWithValue("FREIGHT_NEED", cfidRecord.FREIGHT_NEED)
        cmd.Parameters.AddWithValue("ISSUE_DESCRIPTION", cfidRecord.ISSUE_DESCRIPTION)
        cmd.Parameters.AddWithValue("PRIORITY", cfidRecord.PRIORITY)
        cmd.Parameters.AddWithValue("EASE", cfidRecord.EASE)
        cmd.Parameters.AddWithValue("ROWCONSTRAINT", cfidRecord.ROWCONSTRAINT)
        cmd.Parameters.AddWithValue("UTILITYCONSTRAINT", cfidRecord.UTILITYCONSTRAINT)
        cmd.Parameters.AddWithValue("LIGHTPOLECONSTRAINT", cfidRecord.LIGHTPOLECONSTRAINT)
        cmd.Parameters.AddWithValue("SIGNAGECONSTRAINT", cfidRecord.SIGNAGECONSTRAINT)
        cmd.Parameters.AddWithValue("STRUCTURECONSTRAINT", cfidRecord.STRUCTURECONSTRAINT)
        cmd.Parameters.AddWithValue("OTHERCONSTRAINT", cfidRecord.OTHERCONSTRAINT)
        cmd.Parameters.AddWithValue("FIELD_VERIFIED", If(cfidRecord.FieldVerified, 1, 0))
        cmd.Parameters.AddWithValue("DATE_RECOMMENDED", cfidRecord.YearRecommended)
        cmd.Parameters.AddWithValue("ROADWAYID", cfidRecord.ROADWAYID)
        cmd.Parameters.AddWithValue("BEGMP", cfidRecord.BEGMP)
        cmd.Parameters.AddWithValue("ENDMP", cfidRecord.ENDMP)
        cmd.Parameters.AddWithValue("SECONDRDWYID", cfidRecord.SECONDRDWYID)
        cmd.Parameters.AddWithValue("LOCMP", cfidRecord.LOCMP)
        cmd.Parameters.AddWithValue("Ydd", cfidRecord.Ydd)
        cmd.Parameters.AddWithValue("Xdd", cfidRecord.Xdd)
        cmd.Parameters.AddWithValue("TRANSPORT_SYSTEM", cfidRecord.TRANSPORT_SYSTEM)
        cmd.Parameters.AddWithValue("FREIGHT_SYSTEM", cfidRecord.FREIGHT_SYSTEM)
        cmd.Parameters.AddWithValue("FIELD_OBS", cfidRecord.FIELD_OBS)
        cmd.Parameters.AddWithValue("RECOMMENDATION_DESC", cfidRecord.RECOMMENDATION_DESC)
        cmd.Parameters.AddWithValue("COMMENTS", cfidRecord.COMMENTS)
        cmd.Parameters.AddWithValue("IMPRVMNT_STAGE", cfidRecord.IMPRVMNT_STAGE)
        cmd.Parameters.AddWithValue("SOURCE", cfidRecord.SOURCE)
        cmd.Parameters.AddWithValue("MISC_INFO", cfidRecord.MISC_INFO)

        If cfidRecord.OID > 0 Then
            cmd.Parameters.AddWithValue("OBJECTID", cfidRecord.OID)
        End If

        Try
            cmd.ExecuteNonQuery()
        Catch ex As Exception
            System.Diagnostics.Debug.Print(ex.Message)
            Throw
        End Try

        'get new OID
        If cfidRecord.OID = 0 Then
            cmd.CommandText = "SELECT @@IDENTITY"
            cfidRecord.OID = cmd.ExecuteScalar
        End If
        dbconn.Close()

        Return cfidRecord
    End Function




End Class