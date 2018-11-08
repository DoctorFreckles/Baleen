namespace BaleenLib.UI.UserControls
{
    partial class Query
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.MainTab = new System.Windows.Forms.TabControl();
            this.tabDataView = new System.Windows.Forms.TabPage();
            this.tabGraphView = new System.Windows.Forms.TabPage();
            this.tabFilter = new System.Windows.Forms.TabPage();
            this.MainTab.SuspendLayout();
            this.SuspendLayout();
            // 
            // MainTab
            // 
            this.MainTab.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.MainTab.Controls.Add(this.tabFilter);
            this.MainTab.Controls.Add(this.tabDataView);
            this.MainTab.Controls.Add(this.tabGraphView);
            this.MainTab.Location = new System.Drawing.Point(3, 3);
            this.MainTab.Name = "MainTab";
            this.MainTab.SelectedIndex = 0;
            this.MainTab.Size = new System.Drawing.Size(505, 521);
            this.MainTab.TabIndex = 0;
            // 
            // tabDataView
            // 
            this.tabDataView.Location = new System.Drawing.Point(4, 22);
            this.tabDataView.Name = "tabDataView";
            this.tabDataView.Padding = new System.Windows.Forms.Padding(3);
            this.tabDataView.Size = new System.Drawing.Size(497, 495);
            this.tabDataView.TabIndex = 0;
            this.tabDataView.Text = "Data View";
            this.tabDataView.UseVisualStyleBackColor = true;
            // 
            // tabGraphView
            // 
            this.tabGraphView.Location = new System.Drawing.Point(4, 22);
            this.tabGraphView.Name = "tabGraphView";
            this.tabGraphView.Padding = new System.Windows.Forms.Padding(3);
            this.tabGraphView.Size = new System.Drawing.Size(497, 495);
            this.tabGraphView.TabIndex = 1;
            this.tabGraphView.Text = "Topology";
            this.tabGraphView.UseVisualStyleBackColor = true;
            // 
            // tabFilter
            // 
            this.tabFilter.Location = new System.Drawing.Point(4, 22);
            this.tabFilter.Name = "tabFilter";
            this.tabFilter.Size = new System.Drawing.Size(497, 495);
            this.tabFilter.TabIndex = 2;
            this.tabFilter.Text = "Filter";
            this.tabFilter.UseVisualStyleBackColor = true;
            // 
            // Query
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.Controls.Add(this.MainTab);
            this.Name = "Query";
            this.Size = new System.Drawing.Size(508, 524);
            this.MainTab.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl MainTab;
        private System.Windows.Forms.TabPage tabDataView;
        private System.Windows.Forms.TabPage tabGraphView;
        private System.Windows.Forms.TabPage tabFilter;
    }
}
