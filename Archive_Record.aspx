<%@ Page Language="VB" AutoEventWireup="false" CodeFile="~/Archive_Record.aspx.vb" Inherits="Print_Record" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: large;
            background-color: #FF0000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <table width="660" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="left" valign="top">
                &nbsp;</td>
        </tr>
        <tr>
            <td align="left" valign="top">
                <div id="print">
                    <link href="css/print.css" rel="stylesheet" type="text/css" />
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Bdr1" style="background: #FFFFFF;">
                        <tr>
                            <td align="left" valign="middle" class="BdrBot3 Pad2" height="100">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                    <tr>
                                        <td align="center" valign="top" class="Gray Light16">
                                            <strong>CFID</strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" valign="middle" class="Light11 Gray">
                                            <span class="auto-style1">Comprehensive Freight Improvement Database Archive Details
                                            </span> 
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                <strong>Collection Information</strong>
                                <asp:Label ID="lblOID" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top" class="BdrBot3">
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                    <tr>
                                        <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
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
                                            </table>
                                        </td>
                                        <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
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
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        
                        <tr>
                            <td align="left" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                <strong>Location Information</strong>
                            </td>
                        </tr>
                      
                        <tr>
                            <td align="left" valign="top" class="BdrBot3">
                                <table width="100%" border="1" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                    <tr>
                                         <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
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
                                                        <strong>Corridor Segment : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblCorridorSegment" />
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
                                                        <strong>Roadway Id : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblRoadwayId" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
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
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Site Location : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblSiteLocation" />
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
                                               
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                <strong>Improvement Information</strong>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <table width="100%" border="1" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                    <tr>
                                        <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
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
                                                        <strong>Improvement Stage : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblImporvementStage" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Date/Year Recommended : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblDateYearRecommended" />
                                                    </td>
                                                </tr>
                                               
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Transport System : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblTransSys" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                       <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
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
                                                        <strong>Comments : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblComments" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Issue Desc : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblDefinationDesc" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Recommendation : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblRecomDesc" />
                                                    </td>
                                                </tr>
                                              
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    
                        <tr>
                            <td align="left" valign="middle" class="Pad BdrRight BdrBot3 BgGray Light11 Gray">
                                <strong>Additional Information</strong>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" valign="top">
                                <table width="100%" border="1" cellspacing="0" cellpadding="0" class="Light12 Gray">
                                    <tr>
                                        <td width="50%" align="left" valign="top" class="Pad">
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
                                               
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Field Obs : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblFieldObs" />
                                                    </td>
                                                </tr>
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
                                            <table width="100%" border="1" cellspacing="1" cellpadding="0" class="Light11">
                                               
                                             
                                              
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Date Ending Recommend : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:Label runat="server" ID="lblDateEnding" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="left" valign="top">
                                                        <strong>Field Verified : </strong>
                                                    </td>
                                                    <td align="left" valign="middle">
                                                        <asp:CheckBox ID="chkFieldVerified" runat="server" />
                                                        
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
        <tr>
            <td height="20">
            </td>
        </tr>
        <tr>
            <td align="center" valign="top">
                <asp:Button ID="btnPrint" runat="server" OnClientClick="CallPrint('print');" CssClass="SubmitBt"
                    Text="Print" Width="60px" />
                <asp:Button ID="btnBack" runat="server" CssClass="SubmitBt" PostBackUrl="~/ViewArchive_Records.aspx"
                    Text="Back" Width="60px" />

                <script type="text/javascript" language="javascript">
                    function CallPrint(strid) {
                        var prtContent = document.getElementById(strid);
                        var WinPrint =
                        window.open('', '', 'left=0,top=0,width=1000,height=700,toolbar=0,scrollbars=1,status=0');
                        WinPrint.document.write(prtContent.innerHTML);
                        WinPrint.document.close();
                        WinPrint.focus();
                        WinPrint.print();
                        //WinPrint.close();
                        //prtContent.innerHTML=strOldOne;
                    }   
                </script>

            </td>
        </tr>
    </table>
    </form>
</body>
</html>
