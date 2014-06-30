Imports Microsoft.VisualBasic

Public Class CFIDRecord
    Public OID As Integer
    Public FDOT_District As String
    Public COUNTY As String
    Public CORRIDOR As String
    Public ISSUE_EXTENT As String
    Public SITE_LOCATION As String
    Public SEGMENT_TO As String = ""
    Public SEGMENT_FROM As String = ""
    Public ISSUE_DESCRIPTION As String
    Public FREIGHT_NEED As String

    Public islNWcorner As Boolean
    Public islNEcorner As Boolean
    Public islSWcorner As Boolean
    Public islSEcorner As Boolean
    Public islNBapproach As Boolean
    Public islSBapproach As Boolean
    Public islEBapproach As Boolean
    Public islWBapproach As Boolean
    Public islNorthLegMedian As Boolean
    Public islSouthLegMedian As Boolean
    Public islWestLegMedian As Boolean
    Public islEastLegMedian As Boolean
    Public islNBlanes As Boolean
    Public islSBlanes As Boolean
    Public islEBlanes As Boolean
    Public islWBlanes As Boolean

    Public ReadOnly Property GetIssueSiteLocation As String
        Get
            Dim sb As New StringBuilder("")

            If Me.islNWcorner Then sb.Append("NW corner;")
            If Me.islNEcorner Then sb.Append("NE corner;")
            If Me.islSWcorner Then sb.Append("SW corner;")
            If Me.islSEcorner Then sb.Append("SE corner;")
            If Me.islNBapproach Then sb.Append("NB approach;")
            If Me.islSBapproach Then sb.Append("SB approach;")
            If Me.islEBapproach Then sb.Append("EB approach;")
            If Me.islWBapproach Then sb.Append("WB approach;")
            If Me.islNorthLegMedian Then sb.Append("North leg median;")
            If Me.islSouthLegMedian Then sb.Append("South leg median;")
            If Me.islWestLegMedian Then sb.Append("West leg median;")
            If Me.islEastLegMedian Then sb.Append("East leg median;")
            If Me.islNBlanes Then sb.Append("NB lanes;")
            If Me.islSBlanes Then sb.Append("SB lanes;")
            If Me.islEBlanes Then sb.Append("EB lanes;")
            If Me.islWBlanes Then sb.Append("WB lanes;")

            Return sb.ToString()
        End Get
    End Property


    Public PRIORITY As String
    Public EASE As String
    Public ROWCONSTRAINT As String
    Public UTILITYCONSTRAINT As String
    Public LIGHTPOLECONSTRAINT As String
    Public SIGNAGECONSTRAINT As String
    Public STRUCTURECONSTRAINT As String
    Public OTHERCONSTRAINT As String
    Public FieldVerified As Boolean
    Public YearRecommended As Integer
    Public ROADWAYID As String
    Public BEGMP As Decimal
    Public ENDMP As Decimal
    Public SECONDRDWYID As String = ""
    Public LOCMP As Decimal
    Public Xdd As Decimal
    Public Ydd As Decimal
    Public TRANSPORT_SYSTEM As String
    Public FREIGHT_SYSTEM As String
    Public FIELD_OBS As String = ""
    Public RECOMMENDATION_DESC As String = ""
    Public COMMENTS As String = ""
    Public IMPRVMNT_STAGE As String
    Public SOURCE As String
    'Public DATE_MODIFIED As String
    Public MISC_INFO As String

End Class
