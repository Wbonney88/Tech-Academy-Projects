<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SpyAssetTracker.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: x-large;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="Image1" runat="server" Height="200px" ImageUrl="epic-spies-logo.jpg" />
            <br />
            <br />
            <strong><span class="auto-style1">Asset Performance Tracker</span></strong></div>
        <p>
            <strong>Asset Name:</strong>&nbsp;
            <asp:TextBox ID="nameTextBox" runat="server"></asp:TextBox>
        </p>
        <p>
            <strong>Elections Rigged:&nbsp; </strong>
            <asp:TextBox ID="electionsTextBox" runat="server"></asp:TextBox>
        </p>
        <p style="font-weight: 700">
            Acts of Subterfuge Performed:&nbsp;
            <asp:TextBox ID="subterfugeTextBox" runat="server"></asp:TextBox>
        </p>
        <p style="font-weight: 700">
            <asp:Button ID="submitButton" runat="server" OnClick="submitButton_Click" Text="Add Asset" />
        </p>
        <p style="font-weight: 700">
            <asp:Label ID="resultLabel" runat="server"></asp:Label>
        </p>
    </form>
</body>
</html>
