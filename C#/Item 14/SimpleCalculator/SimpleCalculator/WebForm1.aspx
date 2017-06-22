<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="SimpleCalculator.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <h1>Simple Calculator</h1>
    <form id="form1" runat="server">
        <div>
            First Value:&nbsp;
            <asp:TextBox ID="firstNumberTextBox" runat="server"></asp:TextBox>
            <br />
            Second Value:&nbsp;
            <asp:TextBox ID="secondNumberTextBox" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="addButton" runat="server" Height="25px" OnClick="addButton_Click" Text="+" Width="25px" />
&nbsp;<asp:Button ID="subtractButton" runat="server" Height="25px" OnClick="subtractButton_Click" Text="-" Width="25px" />
&nbsp;<asp:Button ID="divideButton" runat="server" Height="25px" OnClick="divideButton_Click" Text="/" Width="25px" />
&nbsp;<asp:Button ID="multiplyButton" runat="server" Height="25px" OnClick="multiplyButton_Click" Text="*" Width="25px" />
            <br />
            <br />
            <asp:Label ID="resultLabel" runat="server" BackColor="#00CCFF" Font-Bold="True"></asp:Label>
        </div>
    </form>
</body>
</html>
