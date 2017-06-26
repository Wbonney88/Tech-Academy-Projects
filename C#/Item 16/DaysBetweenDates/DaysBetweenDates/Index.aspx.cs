using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DaysBetweenDates
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            firstDateLabel.Text = Calendar1.SelectedDate.ToShortDateString();
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            secondDateLabel.Text = Calendar2.SelectedDate.ToShortDateString();
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            if(Calendar1.SelectedDate > Calendar2.SelectedDate)
            {
                resultLabel.Text = Calendar1.SelectedDate.Subtract(Calendar2.SelectedDate)
                    .TotalDays.ToString(); 
            }
            else
            {
                resultLabel.Text = Calendar2.SelectedDate.Subtract(Calendar1.SelectedDate)
                    .TotalDays.ToString();
            }
        }
    }
}