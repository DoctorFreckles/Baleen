namespace BaleenLib.UI
{
    partial class FormMain
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.Windows.Forms.TreeNode treeNode1 = new System.Windows.Forms.TreeNode("Security");
            System.Windows.Forms.TreeNode treeNode2 = new System.Windows.Forms.TreeNode("Email");
            System.Windows.Forms.TreeNode treeNode3 = new System.Windows.Forms.TreeNode("Folder");
            System.Windows.Forms.TreeNode treeNode4 = new System.Windows.Forms.TreeNode("Port");
            System.Windows.Forms.TreeNode treeNode5 = new System.Windows.Forms.TreeNode("RSS");
            System.Windows.Forms.TreeNode treeNode6 = new System.Windows.Forms.TreeNode("Listeners", new System.Windows.Forms.TreeNode[] {
            treeNode2,
            treeNode3,
            treeNode4,
            treeNode5});
            System.Windows.Forms.TreeNode treeNode7 = new System.Windows.Forms.TreeNode("Queries");
            System.Windows.Forms.TreeNode treeNode8 = new System.Windows.Forms.TreeNode("Email");
            System.Windows.Forms.TreeNode treeNode9 = new System.Windows.Forms.TreeNode("Folder");
            System.Windows.Forms.TreeNode treeNode10 = new System.Windows.Forms.TreeNode("Port");
            System.Windows.Forms.TreeNode treeNode11 = new System.Windows.Forms.TreeNode("Destinations", new System.Windows.Forms.TreeNode[] {
            treeNode8,
            treeNode9,
            treeNode10});
            System.Windows.Forms.TreeNode treeNode12 = new System.Windows.Forms.TreeNode("Ontologies");
            System.Windows.Forms.TreeNode treeNode13 = new System.Windows.Forms.TreeNode("Powershell Bench");
            System.Windows.Forms.TreeNode treeNode14 = new System.Windows.Forms.TreeNode("Prolog Bench");
            System.Windows.Forms.TreeNode treeNode15 = new System.Windows.Forms.TreeNode("Custom Forms");
            System.Windows.Forms.TreeNode treeNode16 = new System.Windows.Forms.TreeNode("Dendritica", new System.Windows.Forms.TreeNode[] {
            treeNode1,
            treeNode6,
            treeNode7,
            treeNode11,
            treeNode12,
            treeNode13,
            treeNode14,
            treeNode15});
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormMain));
            this.DendraTree = new System.Windows.Forms.TreeView();
            this.MainTable = new System.Windows.Forms.TableLayoutPanel();
            this.query1 = new BaleenLib.UI.UserControls.Query();
            this.MainTable.SuspendLayout();
            this.SuspendLayout();
            // 
            // DendraTree
            // 
            this.DendraTree.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.DendraTree.BackColor = System.Drawing.SystemColors.ControlDark;
            this.DendraTree.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.DendraTree.ForeColor = System.Drawing.SystemColors.Window;
            this.DendraTree.Location = new System.Drawing.Point(3, 3);
            this.DendraTree.Name = "DendraTree";
            treeNode1.Name = "Security";
            treeNode1.Text = "Security";
            treeNode2.Name = "LisEmail";
            treeNode2.Text = "Email";
            treeNode3.Name = "LisFolder";
            treeNode3.Text = "Folder";
            treeNode4.Name = "LisPort";
            treeNode4.Text = "Port";
            treeNode5.Name = "RSS";
            treeNode5.Text = "RSS";
            treeNode6.Name = "Listeners";
            treeNode6.Text = "Listeners";
            treeNode7.Name = "Queries";
            treeNode7.Text = "Queries";
            treeNode8.Name = "DestinationEmail";
            treeNode8.Text = "Email";
            treeNode9.Name = "DestFolder";
            treeNode9.Text = "Folder";
            treeNode10.Name = "DestPort";
            treeNode10.Text = "Port";
            treeNode11.Name = "Destinations";
            treeNode11.Text = "Destinations";
            treeNode12.Name = "Ontologies";
            treeNode12.Text = "Ontologies";
            treeNode13.Name = "Powershell";
            treeNode13.Text = "Powershell Bench";
            treeNode14.Name = "PrologBench";
            treeNode14.Text = "Prolog Bench";
            treeNode15.Name = "CustomForms";
            treeNode15.Text = "Custom Forms";
            treeNode16.Name = "Dendritica";
            treeNode16.Text = "Dendritica";
            this.DendraTree.Nodes.AddRange(new System.Windows.Forms.TreeNode[] {
            treeNode16});
            this.DendraTree.Size = new System.Drawing.Size(194, 550);
            this.DendraTree.TabIndex = 0;
            // 
            // MainTable
            // 
            this.MainTable.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.MainTable.ColumnCount = 2;
            this.MainTable.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 200F));
            this.MainTable.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 571F));
            this.MainTable.Controls.Add(this.DendraTree, 0, 0);
            this.MainTable.Controls.Add(this.query1, 1, 0);
            this.MainTable.Location = new System.Drawing.Point(3, 12);
            this.MainTable.Name = "MainTable";
            this.MainTable.RowCount = 1;
            this.MainTable.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.MainTable.Size = new System.Drawing.Size(754, 556);
            this.MainTable.TabIndex = 2;
            // 
            // query1
            // 
            this.query1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.query1.Font = new System.Drawing.Font("Arial", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.query1.Location = new System.Drawing.Point(203, 4);
            this.query1.Margin = new System.Windows.Forms.Padding(3, 4, 3, 4);
            this.query1.Name = "query1";
            this.query1.Size = new System.Drawing.Size(565, 548);
            this.query1.TabIndex = 1;
            // 
            // FormMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(769, 580);
            this.Controls.Add(this.MainTable);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "FormMain";
            this.Text = "Dendritica - Tribe Mind";
            this.Load += new System.EventHandler(this.FormMain_Load);
            this.MainTable.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TreeView DendraTree;
        private System.Windows.Forms.TableLayoutPanel MainTable;
        private BaleenLib.UI.UserControls.Query query1;


    }
}