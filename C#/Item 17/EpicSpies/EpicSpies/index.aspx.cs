using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EpicSpies
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                previousAssignCalendar.SelectedDate = DateTime.Now.Date;
                newAssignCalendar.SelectedDate = DateTime.Now.Date.AddDays(14);
                newAssignCalendar.VisibleDate = DateTime.Now.Date.AddDays(14);
                endAssignCalendar.SelectedDate = DateTime.Now.Date.AddDays(21);
                endAssignCalendar.VisibleDate = DateTime.Now.Date.AddDays(21);
            }
        }

        protected void assignButton_Click(object sender, EventArgs e)
        {
            ///To test for at least 2 weeks inbetween assignments.
            TimeSpan daysBetweenAssignments = newAssignCalendar.SelectedDate.Subtract(previousAssignCalendar.SelectedDate);
            if (daysBetweenAssignments.TotalDays < 14)
            {
                DateTime earliestNewAssign = previousAssignCalendar.SelectedDate.AddDays(14);
                newAssignCalendar.SelectedDate = earliestNewAssign;
                newAssignCalendar.VisibleDate = earliestNewAssign;

                resultLabel.Text = String.Format("Error: You must allow at least two weeks of vacation between the previous assignment and the new assignment."
                    + " The earliest start date for the new assignment is {0:MM/d/yy}", earliestNewAssign);

                

            }
            else
            {
                ///To get budget cost of assignment.
                TimeSpan lengthOfAssignment = endAssignCalendar.SelectedDate.Subtract(newAssignCalendar.SelectedDate);
                double totalCost = lengthOfAssignment.TotalDays * 500;
                if (lengthOfAssignment.TotalDays > 21)
                {
                    totalCost = totalCost + 1000;
                }

                resultLabel.Text = String.Format("You are authorized to assign {0} to assignment {1}. Total budget: {2:C}", codeNameTextBox.Text, assignmentTextBox.Text, totalCost);
            }
        }
    }
}