using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Item15_Challenge1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if(pencilRadioButton.Checked)
            {
                resultLabel.Text = "You selected pencil";
                resultImage.ImageUrl = "pencil.png";
            }
            else if(penRadioButton.Checked)
            {
                resultLabel.Text = "You selected pen";
                resultImage.ImageUrl = "pen.png";
            }
            else if (phoneRadioButton.Checked)
            {
                resultLabel.Text = "You selected phone";
                resultImage.ImageUrl = "phone.png";
            }
            else if (tabletRadioButton.Checked)
            {
                resultLabel.Text = "You selected tablet";
                resultImage.ImageUrl = "tablet.png";
            }
            else
            {
                resultLabel.Text = "Please select an option";
            }
        }

        protected void RadioButton1_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void penRadioButton_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void phoneRadioButton_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void tabletRadioButton_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}