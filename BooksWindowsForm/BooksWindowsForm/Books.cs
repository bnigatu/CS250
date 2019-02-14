using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace BooksWindowsForm
{
    public partial class Books : Form
    {
        public Books()
        {
            InitializeComponent();
        }

        private void authorsBindingNavigatorSaveItem_Click(object sender, EventArgs e)
        {
            this.Validate();
            this.authorsBindingSource.EndEdit();
            this.tableAdapterManager.UpdateAll(this.dataSet1);

        }

        private void Books_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'dataSet1.titles' table. You can move, or remove it, as needed.
            this.titlesTableAdapter.Fill(this.dataSet1.titles,this.au_idTextBox.Text);
            // TODO: This line of code loads data into the 'dataSet1.authors' table. You can move, or remove it, as needed.
            this.authorsTableAdapter.Fill(this.dataSet1.authors);

        }

        private void refresh_title(object sender, EventArgs e)
        {
            this.titlesTableAdapter.Fill(this.dataSet1.titles, this.au_idTextBox.Text);
        }

    }
}
