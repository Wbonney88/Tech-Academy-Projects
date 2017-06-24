<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Item15_Challenge1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Your Note Taking Preferences<br />
            <br />
            <asp:RadioButton ID="pencilRadioButton" runat="server" Font-Bold="True" GroupName="preferences" OnCheckedChanged="RadioButton1_CheckedChanged" Text="Pencil" />
            <br />
            <asp:RadioButton ID="penRadioButton" runat="server" Font-Bold="True" GroupName="preferences" OnCheckedChanged="penRadioButton_CheckedChanged" Text="Pen" />
            <br />
            <asp:RadioButton ID="phoneRadioButton" runat="server" Font-Bold="True" GroupName="preferences" OnCheckedChanged="phoneRadioButton_CheckedChanged" Text="Phone" />
            <br />
            <asp:RadioButton ID="tabletRadioButton" runat="server" Font-Bold="True" GroupName="preferences" OnCheckedChanged="tabletRadioButton_CheckedChanged" Text="Tablet" />
            <br />
            <br />
            <asp:Button ID="submitButton" runat="server" Font-Bold="True" OnClick="submitButton_Click" Text="OK" Width="50px" />
            <br />
            <br />
            <asp:Image ID="resultImage" runat="server" />
            <br />
            <br />
            <asp:Label ID="resultLabel" runat="server"></asp:Label>
        </div>
    </form>
</body>
</html>
