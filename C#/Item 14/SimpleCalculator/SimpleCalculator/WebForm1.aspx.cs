using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SimpleCalculator
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void addButton_Click(object sender, EventArgs e)
        {
            float firstNumber = float.Parse(firstNumberTextBox.Text);
            float secondNumber = float.Parse(secondNumberTextBox.Text);
            float result = firstNumber + secondNumber;

            resultLabel.Text = result.ToString();
        }

        protected void subtractButton_Click(object sender, EventArgs e)
        {
            float firstNumber = float.Parse(firstNumberTextBox.Text);
            float secondNumber = float.Parse(secondNumberTextBox.Text);
            float result = firstNumber - secondNumber;

            resultLabel.Text = result.ToString();
        }

        protected void divideButton_Click(object sender, EventArgs e)
        {
            float firstNumber = float.Parse(firstNumberTextBox.Text);
            float secondNumber = float.Parse(secondNumberTextBox.Text);
            float result = firstNumber / secondNumber;

            resultLabel.Text = result.ToString();
        }

        protected void multiplyButton_Click(object sender, EventArgs e)
        {
            float firstNumber = float.Parse(firstNumberTextBox.Text);
            float secondNumber = float.Parse(secondNumberTextBox.Text);
            float result = firstNumber * secondNumber;

            resultLabel.Text = result.ToString();
        }
    }
}