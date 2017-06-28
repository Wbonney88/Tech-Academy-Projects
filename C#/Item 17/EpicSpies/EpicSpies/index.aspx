<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EpicSpies.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="spyImage" runat="server" Height="190px" ImageUrl="epic-spies-logo.jpg" />
            <br />
            <br />
            Spy Code Name:&nbsp;
            <asp:TextBox ID="codeNameTextBox" runat="server"></asp:TextBox>
            <br />
            <br />
            New Assignment Name:&nbsp;
            <asp:TextBox ID="assignmentTextBox" runat="server"></asp:TextBox>
            <br />
            <br />
            End Date of Previous Assignment<asp:Calendar ID="previousAssignCalendar" runat="server"></asp:Calendar>
            <br />
            <br />
            Start Date of New Assignment<asp:Calendar ID="newAssignCalendar" runat="server"></asp:Calendar>
            <br />
            Projected End Date of New Assignment<br />
            <asp:Calendar ID="endAssignCalendar" runat="server"></asp:Calendar>
            <br />
            <br />
            <asp:Button ID="assignButton" runat="server" OnClick="assignButton_Click" Text="Assign Spy" />
            <br />
            <br />
            <asp:Label ID="resultLabel" runat="server"></asp:Label>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
