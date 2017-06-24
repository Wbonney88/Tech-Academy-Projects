<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Item15Challenge2.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
        }
        .auto-style2 {
            text-decoration: underline;
            font-size: large;
        }
        .auto-style3 {
            text-decoration: underline;
        }
        .auto-style4 {
            color: #FF0000;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Image ID="logoImage" runat="server" ImageUrl="~/PapaBob.png" />
&nbsp; <strong><span class="auto-style1">Thomas&#39; Pizzaria<br />
            <br />
            </span><span class="auto-style2">Size</span><span class="auto-style1"><br />
            </span></strong>
            <asp:RadioButton ID="smallRadioButton" runat="server" GroupName="size" Text="Small(10&quot;)-$10" />
            <strong>
            <br />
            </strong>
            <asp:RadioButton ID="mediumRadioButton" runat="server" GroupName="size" Text="Medium(13&quot;)-13" />
            <br />
            <asp:RadioButton ID="largeRadioButton" runat="server" GroupName="size" Text="Large(16&quot;)-$16" />
            <br />
            <br />
            <span class="auto-style2"><strong>Crust</strong></span><br />
            <asp:RadioButton ID="regularRadioButton" runat="server" GroupName="crust" Text="Regular" />
            <br />
            <asp:RadioButton ID="thinCrustRadioButton" runat="server" GroupName="crust" Text="Thin Curst" />
            <br />
            <asp:RadioButton ID="deepDishRadioButton" runat="server" GroupName="crust" Text="Deep Dish(+$2)" />
            <br />
            <asp:RadioButton ID="stuffedCrustRadioButton" runat="server" GroupName="crust" Text="Stuffed Crust(+$3)" />
            <br />
            <br />
            <span class="auto-style3"><strong>Toppings</strong></span><br />
            <asp:CheckBox ID="pepperoniCheckBox" runat="server" Text="Pepperoni(+$1.50)" />
            <br />
            <asp:CheckBox ID="onionCheckBox" runat="server" Text="Onions(+$0.75)" />
            <br />
            <asp:CheckBox ID="greenPeppersCheckBox" runat="server" Text="Green Peppers($0.50)" />
            <br />
            <asp:CheckBox ID="mushroomCheckBox" runat="server" Text="Mushrooms(+$0.75)" />
            <br />
            <asp:CheckBox ID="pineappleCheckBox" runat="server" Text="Pineapple(+$0.50)" />
            <br />
            <asp:CheckBox ID="candianBaconCheckBox" runat="server" Text="Candian Bacon(+$2)" />
            <br />
            <br />
            <span class="auto-style4"><strong>Special</strong></span><br />
            Save $2.00 when you get two meats and two or more veggies.<br />
            <br />
            <asp:Button ID="orderButton" runat="server" OnClick="orderButton_Click" Text="Order" />
            <br />
            <br />
            Total:&nbsp; <asp:Label ID="totalLabel" runat="server"></asp:Label>
            <br />
            <br />
            Sorry, at this time you can only order one pizza online.&nbsp; No delivery.<br />
            <br />
            <asp:Label ID="warningLabel" runat="server" Font-Bold="True" Font-Size="Large"></asp:Label>
        </div>
    </form>
</body>
</html>
