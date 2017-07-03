using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SpyAssetTracker
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            {
                string[] names = new string[0];
                int[] elections = new int[0];
                int[] subterfuge = new int[0];

                ViewState.Add("Assets", names);
                ViewState.Add("Elections", elections);
                ViewState.Add("Acts", subterfuge);
            }
        }

        protected void submitButton_Click(object sender, EventArgs e)
        {
            string[] names = (string[])ViewState["Assets"];
            int[] elections = (int[])ViewState["Elections"];
            int[] subterfuge = (int[])ViewState["Acts"];

            int newLength = names.Length + 1;

            Array.Resize(ref names, newLength);
            Array.Resize(ref elections, newLength);
            Array.Resize(ref subterfuge, newLength);

            int newIndex = names.GetUpperBound(0);

            names[newIndex] = nameTextBox.Text;
            elections[newIndex] = int.Parse(electionsTextBox.Text);
            subterfuge[newIndex] = int.Parse(subterfugeTextBox.Text);

            ViewState["Assets"] = names;
            ViewState["Elections"] = elections;
            ViewState["Acts"] = subterfuge;

            resultLabel.Text = String.Format("Total Elections Rigged: {0}" +
                "<br />Average Acts of Subterfuge per Asset: {1:N2}" +
                "<br />Last Asset Added: {2}",elections.Sum(), subterfuge.Average(), names[newIndex]);

            nameTextBox.Text = "";
            electionsTextBox.Text = "";
            subterfugeTextBox.Text = "";


        }
    }
}