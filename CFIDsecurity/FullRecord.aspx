<%@ Page Title="CFID-Print" Language="VB" AutoEventWireup="false" CodeFile="FullRecord.aspx.vb"
    Inherits="Print_Record" %>

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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <span class="error"><asp:Literal runat="server" ID="MessageLiteral"></asp:Literal></span>
    <table width="660" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="left" valign="top">
                <div id="print">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Bdr1" style="background: #FFFFFF;">
                        <tr>
                            <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                <strong><u>Collection Information</u></strong>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" class="BdrBot3">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                    <tr>
                                        <td width="50%" align="left" valign="top" class="BdrRight Pad ">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light11">
                                                <tr>
                                                    <td width="29%" align="left" valign="top">
                                                        <strong>Improvement ID : </strong>
                                                    </td>
                                                    <td width="71%" align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblID" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="29%" align="left" valign="top">
                                                        <strong>Issue Extent : </strong>
                                                    </td>
                                                    <td width="71%" align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblType" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>FDOT District : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblFDOTDistrict" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="44%" align="left" valign="middle">
                                                        <strong>Source :</strong>
                                                    </td>
                                                    <td width="56%" align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblSource" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="middle">
                                                        <strong>County :</strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblCounty" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="0" cellspacing="1" cellpadding="0" class="Light11">
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Freight Need : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblDefinationDesc" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="40%" align="left" valign="top">
                                                        <strong>Issue Description : </strong>
                                                    </td>
                                                    <td width="60%" align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblIssueDescription" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Field Verified : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Image ID="imgFieldVerified" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Field Verified
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Year Recommended : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblDateYearRecommended" />
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
                                <strong><u>Location Information </u></strong>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" class="BdrBot3">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                    <tr>
                                        <td width="50%" align="left" valign="top" class="BdrRight Pad ">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light11">
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Site Location : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblSiteLocation" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="35%" align="left" valign="top">
                                                        <strong>Corridor Name : </strong>
                                                    </td>
                                                    <td width="65%" align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblCorridorName" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Segment From : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblSegmentFrom" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Segment To : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblSegmentTo" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Primary RoadwayID : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblRoadwayId" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Secondary RoadwayID : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblSecondRDWYID" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="40%" align="left" valign="middle">
                                                        <strong>Begin MP :</strong>
                                                    </td>
                                                    <td width="60%" align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblBeginMP" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Ending MP : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblEndingMP" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="0" cellspacing="1" cellpadding="0" class="Light11">
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Transport System : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblTransSys" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="40%" align="left" valign="top">
                                                        <strong>Freight System : </strong>
                                                    </td>
                                                    <td width="60%" align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblFreightSys" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Latitude : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblLatitude" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Longitude : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblLongitude" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Location Milepost : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblLOCMP" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Corridor Segment : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblCorridorSegment" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Issue Location : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblIssueLoc" />
                                                    </td>
                                                </tr>
                                            </table>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                <strong><u>Constraints</u></strong>
                            </td>
                        </tr>
                        <tr>
                            <td class="Light11" valign="middle" align="center">
                                <asp:Image ID="imgROW" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Right
                                of Way
                                <asp:Image ID="imgUtility" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Utility
                                <asp:Image ID="imgLightPole" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Light
                                Pole
                                <asp:Image ID="imgSignage" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Signage
                                <asp:Image ID="imgStructure" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Structure
                                <asp:Image ID="ImgOther" runat="server" ImageUrl="~/images/unchecked-checkbox-icon.png" />&nbsp;Other
                            </td>
        </tr>
        <tr>
            <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                <strong><u>Improvement Information</u></strong>
                <br />
            </td>
        </tr>
        <tr>
            <td align="left" valign="top">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                    <tr>
                        <td width="50%" align="left" valign="top" class="Pad BdrBot3">
                            <table width="100%" border="0" cellspacing="1" cellpadding="0" class="Light11">
                                <tr>
                                    <td align="left" valign="top">
                                        <strong>Field Observations : </strong>
                                    </td>
                                    <td align="left" valign="middle">
                                        <br />
                                        <asp:Label runat="server" ID="lblFieldObs" />
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <strong>Recommendation: </strong>
                                    </td>
                                    <td align="left" valign="middle">
                                        <br />
                                        <asp:Label runat="server" ID="lblRecomDesc" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" valign="top">
                                        <strong>Comments : </strong>
                                    </td>
                                    <td align="left" valign="middle">
                                        <br />
                                        <asp:Label runat="server" ID="lblComments" />
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
                                <strong><u>Additional Information</u></strong>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                    <tr>
                                        <td width="50%" align="left" valign="top" class="BdrRight Pad BdrBot3">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light11">
                                               
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Misc Info : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblMiscInfo" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="50%" align="left" valign="top" class="Pad BdrBot3">
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
            <td align="center" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                <strong><u>Project Dialog</u></strong>
            </td>
        </tr>
        <tr>
            <td height="20">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="OID"
                    AllowSorting="true" HorizontalAlign="Center" DataSourceID="ADSdialog" EmptyDataText="Currently, there is no dialog associated with this record"
                    Width="675px" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                    <Columns>
                        <asp:BoundField DataField="COMMENT" ItemStyle-HorizontalAlign="Center" HeaderText="Comment"
                            SortExpression="COMMENT" />
                        <asp:BoundField DataField="USERNAME" ItemStyle-HorizontalAlign="Center" HeaderText="User"
                            SortExpression="USERNAME" />
                        <asp:BoundField DataField="COMMENT_DATE" ItemStyle-HorizontalAlign="Center" HeaderText="Date"
                            SortExpression="COMMENT_DATE" DataFormatString="{0:D}" />
                    </Columns>
                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#999999" />
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                </asp:GridView>
                <asp:AccessDataSource ID="ADSdialog" runat="server" DataFile="~/App_Data/CFID.mdb"
                    SelectCommand="SELECT * FROM [USER_COMMENT] WHERE ([OBJECTID] = ?)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblID" Name="OBJECTID" PropertyName="Text" Type="Int32" />
                    </SelectParameters>
                </asp:AccessDataSource>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
