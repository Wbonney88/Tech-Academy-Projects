<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CS_006.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            color: #0000FF;
        }
        .auto-style2 {
            width: 100%;
        }
        .auto-style3 {
            background-color: #FFFF00;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Head Line 1</h1>
        <h2>Head Line 2</h2>
        <h3>Head Line 3</h3>
        <h4>Head Line 4</h4>
        <h5>Head Line 5</h5>
        <h6>Head Line 6</h6>
        <p style="font-family: Arial, Helvetica, sans-serif">
            This is some text that I want to <span class="auto-style1">apply</span> a style to.</p>
        <p style="font-family: Arial, Helvetica, sans-serif">
            &nbsp;</p>
        <p style="font-family: Arial, Helvetica, sans-serif">
            <a href="http://www.google.com">Add a hyperlink</a></p>
        <p style="font-family: Arial, Helvetica, sans-serif">
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="www.google.com" Target="_self">This is another hyperlink</asp:HyperLink>
        </p>
        <p style="font-family: Arial, Helvetica, sans-serif">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/mag_glass.gif" />
        </p>
    </form>
    <table class="auto-style2">
        <tr>
            <td>Player</td>
            <td>Year</td>
            <td>Home Runs</td>
        </tr>
        <tr>
            <td>Sammy Sosa</td>
            <td>2005</td>
            <td>100</td>
        </tr>
        <tr>
            <td>Mark MacGuire</td>
            <td>2005</td>
            <td>102</td>
        </tr>
    </table>
    <p style="font-family: Arial, Helvetica, sans-serif">
        &nbsp;</p>
    <ol>
        <li>
            <p style="font-family: Arial, Helvetica, sans-serif">
                First Item</p>
        </li>
        <li>
            <p style="font-family: Arial, Helvetica, sans-serif">
                Second Item</p>
        </li>
        <li>
            <p style="font-family: Arial, Helvetica, sans-serif">
                Third Item</p>
        </li>
    </ol>
    <ul>
        <li>
            <p class="auto-style3" style="font-family: Arial, Helvetica, sans-serif">
                This is an idea</p>
        </li>
        <li>
            <p class="auto-style3" style="font-family: Arial, Helvetica, sans-serif">
                This is an equally good idea</p>
        </li>
        <li>
            <p class="auto-style3" style="font-family: Arial, Helvetica, sans-serif">
                Yet one more idea to consider</p>
        </li>
    </ul>
</body>
</html>
