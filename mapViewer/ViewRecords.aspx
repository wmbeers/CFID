<%@ Page Title="View CFID Records" Language="VB" AutoEventWireup="false" CodeFile="~/mapViewer/ViewRecords.aspx.vb"
    Inherits="ViewREcords" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../css/print.css" rel="Stylesheet" type="text/css" />
    <style type="text/css">
        img 
        {
            vertical-align: middle;
        }
        td {
            vertical-align: top;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <span class="error"><asp:Literal runat="server" ID="MessageLiteral"></asp:Literal></span>
        <asp:Repeater ID="RecordsRepeater" runat="server">
            <ItemTemplate>
                 <table width="660" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <div id="print">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Bdr1" style="background: #FFFFFF;">
                                    <tr>
                                        <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                            <strong>Collection Information</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="BdrBot3">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                                <tr>
                                                    <td width="50%" class="BdrRight Pad ">
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light11">
                                                            <tr>
                                                                <td width="29%">
                                                                    <strong>Issue ID : </strong>
                                                                </td>
                                                                <td width="71%">
                                                                    <%#Container.DataItem("IssueID")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="29%">
                                                                    <strong>Issue Extent : </strong>
                                                                </td>
                                                                <td width="71%">
                                                                    <%#Container.DataItem("ISSUE_EXTENT")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>FDOT District : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("FDOT_District")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="44%">
                                                                    <strong>Source :</strong>
                                                                </td>
                                                                <td width="56%">
                                                                    <%#Container.DataItem("SOURCE")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>County :</strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("COUNTY")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="50%" class="Pad">
                                                        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="Light11">
                                                            <tr>
                                                                <td>
                                                                    <strong>Freight Need : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("FREIGHT_NEED")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="40%">
                                                                    <strong>Issue Description : </strong>
                                                                </td>
                                                                <td width="60%">
                                                                    <%#Container.DataItem("ISSUE_DESCRIPTION")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Field Verified : </strong>
                                                                </td>
                                                                <td>
                                                                    <asp:Image ID="FIELD_VERIFIED" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Field Verified
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Year Recommended : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("DATE_RECOMMENDED")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <br />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                            <strong>Location Information </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="BdrBot3">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                                <tr>
                                                    <td width="50%" class="BdrRight Pad ">
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light11">
                                                            <tr>
                                                                <td>
                                                                    <strong>Site Location : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("SITE_LOCATION")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="35%">
                                                                    <strong>Corridor Name : </strong>
                                                                </td>
                                                                <td width="65%">
                                                                    <%#Container.DataItem("CORRIDOR")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Segment From : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("SEGMENT_FROM")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Segment To : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("SEGMENT_TO")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Primary RoadwayID : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("ROADWAYID")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Secondary RoadwayID : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("SECONDRDWYID")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="40%">
                                                                    <strong>Begin MP :</strong>
                                                                </td>
                                                                <td width="60%">
                                                                    <%#Container.DataItem("BEGMP")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Ending MP : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("ENDMP")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="50%" class="Pad">
                                                        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="Light11">
                                                            <tr>
                                                                <td>
                                                                    <strong>Transport System : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("TRANSPORT_SYSTEM")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td width="40%">
                                                                    <strong>Freight System : </strong>
                                                                </td>
                                                                <td width="60%">
                                                                    <%#Container.DataItem("FREIGHT_SYSTEM")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Latitude : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("LATY")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Longitude : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("LONX")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Location Milepost : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("LOCMP")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Corridor Segment : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("Corridor_Segment")%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <strong>Issue Location : </strong>
                                                                </td>
                                                                <td>
                                                                    <%#Container.DataItem("ISSUESITELOC")%>
                                                                </td>
                                                            </tr>
                                                        </table>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                            <strong>Constraints</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="Light11" valign="middle" align="center">
                                            <asp:Image ID="ROWCONSTRAINT" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Right
                                            of Way
                                            <asp:Image ID="UTILITYCONSTRAINT" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Utility
                                            <asp:Image ID="LIGHTPOLECONSTRAINT" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Light
                                            Pole
                                            <asp:Image ID="SIGNAGECONSTRAINT" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Signage
                                            <asp:Image ID="STRUCTURECONSTRAINT" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Structure
                                            <asp:Image ID="OTHERCONSTRAINT" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Other
                                        </td>
                    </tr>
                    <tr>
                        <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                            <strong>Improvement Information</strong>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                <tr>
                                    <td width="50%" class="Pad BdrBot3">
                                        <table width="100%" border="0" cellspacing="1" cellpadding="2" class="Light11">
                                            <tr>
                                                <td>
                                                    <strong>Field Observations : </strong>
                                                </td>
                                                <td>
                                                    <br />
                                                    <%#Container.DataItem("FIELD_OBS")%>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>Recommendation: </strong>
                                                </td>
                                                <td>
                                                    <%#Container.DataItem("RECOMMENDATION_DESC")%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <strong>Comments : </strong>
                                                </td>
                                                <td>
                                                    <%#Container.DataItem("COMMENTS")%>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <%--<tr>
                                        <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                            <strong>Additional Information</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                                <tr>
                                                    <td width="50%" class="BdrRight Pad BdrBot3">
                                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light11">
                                               
                                                            <tr>
                                                                <td>
                                                                    <strong>Misc Info : </strong>
                                                                </td>
                                                                <td>
                                                                    <asp:Label runat="server" ID="lblMiscInfo" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="50%" class="Pad BdrBot3">
                                                        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="Light11">
                                               
                                            
                                               
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>--%>
                    </table> </div> </td> </tr>
                    <br />
                    <tr>
                        <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light12 Gray">
                            <strong>Project Dialog</strong>
                        </td>
                    </tr>
                    <tr>
                        <td height="20" class="Bdr1">
                            <asp:GridView ID="UserCommentsGridView" runat="server" AutoGenerateColumns="False" 
                                AllowSorting="false" HorizontalAlign="Center" EmptyDataText="There are no user comments associated with this record"
                                EmptyDataRowStyle-CssClass="Light11"
                                Width="675px" CellPadding="4" ForeColor="#333333" GridLines="None">
                                <HeaderStyle CssClass="BgGray Light12" HorizontalAlign="Left" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" CssClass="Light11" HorizontalAlign="Left" />
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" CssClass="Light11" HorizontalAlign="Left" />
                                <Columns>
                                    <asp:BoundField DataField="COMMENT" HeaderText="Comment" />
                                    <asp:BoundField DataField="USERNAME" HeaderText="User" HeaderStyle-Width="6em" />
                                    <asp:BoundField DataField="CommentDate" HeaderText="Date" HeaderStyle-Width="5em" DataFormatString="{0:d}" />
                                </Columns>
                                
                            </asp:GridView>
                        </td>
                    </tr>
                </table>

            </ItemTemplate>

        </asp:Repeater>
   
    </form>
</body>
</html>
