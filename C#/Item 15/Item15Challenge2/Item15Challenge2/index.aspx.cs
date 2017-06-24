using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Item15Challenge2
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void orderButton_Click(object sender, EventArgs e)
        {
            warningLabel.Text = "";
            ///To get size cost
            double sizeTotal = 0;
            if (smallRadioButton.Checked)
            {
                sizeTotal = sizeTotal + 10;
            }
            else if (mediumRadioButton.Checked)
            {
                sizeTotal = sizeTotal + 13;
            }
            else if (largeRadioButton.Checked)
            {
                sizeTotal = sizeTotal + 16;
            }
            else
            {
                warningLabel.Text = "Please pick a size";
            }

            ///To get additional crust charge.
            double crustTotal = 0;
            if(deepDishRadioButton.Checked)
            {
                crustTotal = crustTotal + 2;
            }
            else if(stuffedCrustRadioButton.Checked)
            {
                crustTotal = crustTotal + 3;
            }
            else
            {
                this.regularRadioButton.Checked = true;
            }

            ///To get toppings cost
            double toppingTotal = 0;
            int veggieCount = 0;
            if(pepperoniCheckBox.Checked)
            {
                toppingTotal = toppingTotal + 1.5;
            }
            if(onionCheckBox.Checked)
            {
                toppingTotal = toppingTotal + 0.75;
                veggieCount = veggieCount + 1;
            }
            if (greenPeppersCheckBox.Checked)
            {
                toppingTotal = toppingTotal + 0.50;
                veggieCount = veggieCount + 1;
            }
            if (mushroomCheckBox.Checked)
            {
                toppingTotal = toppingTotal + 0.75;
                veggieCount = veggieCount + 1;
            }
            if (pineappleCheckBox.Checked)
            {
                toppingTotal = toppingTotal + 0.50;
                veggieCount = veggieCount + 1;
            }
            if (candianBaconCheckBox.Checked)
            {
                toppingTotal = toppingTotal + 2.00;
            }

            ///To initalize total variable and check if special deal applies
            double total = sizeTotal + crustTotal + toppingTotal;
            if ((pepperoniCheckBox.Checked && candianBaconCheckBox.Checked) && (veggieCount >= 2))
            {
                total = total - 2;
            }

            ///To display order total
            totalLabel.Text = "$" + total.ToString();
        }
    }
}