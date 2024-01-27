namespace TextViewer
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
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
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label_path = new System.Windows.Forms.Label();
            this.groupBox_path = new System.Windows.Forms.GroupBox();
            this.openFileDialog_path = new System.Windows.Forms.OpenFileDialog();
            this.comboBox_numRow = new System.Windows.Forms.ComboBox();
            this.button = new System.Windows.Forms.Button();
            this.label_dummy1 = new System.Windows.Forms.Label();
            this.textBox_findRow = new System.Windows.Forms.TextBox();
            this.label_dummy2 = new System.Windows.Forms.Label();
            this.groupBox_seach = new System.Windows.Forms.GroupBox();
            this.textBox_result = new System.Windows.Forms.TextBox();
            this.groupBox_path.SuspendLayout();
            this.groupBox_seach.SuspendLayout();
            this.SuspendLayout();
            // 
            // label_path
            // 
            this.label_path.AutoSize = true;
            this.label_path.Location = new System.Drawing.Point(16, 41);
            this.label_path.Name = "label_path";
            this.label_path.Size = new System.Drawing.Size(68, 20);
            this.label_path.TabIndex = 1;
            this.label_path.Text = "Click me";
            this.label_path.Click += new System.EventHandler(this.label_path_Click);
            // 
            // groupBox_path
            // 
            this.groupBox_path.Controls.Add(this.label_path);
            this.groupBox_path.Location = new System.Drawing.Point(21, 12);
            this.groupBox_path.Name = "groupBox_path";
            this.groupBox_path.Size = new System.Drawing.Size(356, 78);
            this.groupBox_path.TabIndex = 2;
            this.groupBox_path.TabStop = false;
            this.groupBox_path.Text = "파일경로";
            // 
            // openFileDialog_path
            // 
            this.openFileDialog_path.FileName = "openFileDialog_path";
            // 
            // comboBox_numRow
            // 
            this.comboBox_numRow.FormattingEnabled = true;
            this.comboBox_numRow.Items.AddRange(new object[] {
            "10",
            "30",
            "50",
            "100"});
            this.comboBox_numRow.Location = new System.Drawing.Point(577, 78);
            this.comboBox_numRow.Name = "comboBox_numRow";
            this.comboBox_numRow.Size = new System.Drawing.Size(111, 28);
            this.comboBox_numRow.TabIndex = 4;
            // 
            // button
            // 
            this.button.Location = new System.Drawing.Point(713, 24);
            this.button.Name = "button";
            this.button.Size = new System.Drawing.Size(58, 82);
            this.button.TabIndex = 5;
            this.button.Text = "조회";
            this.button.UseVisualStyleBackColor = true;
            this.button.Click += new System.EventHandler(this.button_Click);
            // 
            // label_dummy1
            // 
            this.label_dummy1.AutoSize = true;
            this.label_dummy1.Location = new System.Drawing.Point(459, 28);
            this.label_dummy1.Name = "label_dummy1";
            this.label_dummy1.Size = new System.Drawing.Size(74, 20);
            this.label_dummy1.TabIndex = 6;
            this.label_dummy1.Text = "조회할 행";
            // 
            // textBox_findRow
            // 
            this.textBox_findRow.Location = new System.Drawing.Point(578, 27);
            this.textBox_findRow.Name = "textBox_findRow";
            this.textBox_findRow.Size = new System.Drawing.Size(110, 27);
            this.textBox_findRow.TabIndex = 7;
            // 
            // label_dummy2
            // 
            this.label_dummy2.AutoSize = true;
            this.label_dummy2.Location = new System.Drawing.Point(459, 86);
            this.label_dummy2.Name = "label_dummy2";
            this.label_dummy2.Size = new System.Drawing.Size(74, 20);
            this.label_dummy2.TabIndex = 6;
            this.label_dummy2.Text = "조회 개수";
            // 
            // groupBox_seach
            // 
            this.groupBox_seach.Controls.Add(this.textBox_result);
            this.groupBox_seach.Location = new System.Drawing.Point(35, 152);
            this.groupBox_seach.Name = "groupBox_seach";
            this.groupBox_seach.Size = new System.Drawing.Size(734, 262);
            this.groupBox_seach.TabIndex = 8;
            this.groupBox_seach.TabStop = false;
            this.groupBox_seach.Text = "조회결과";
            // 
            // textBox_result
            // 
            this.textBox_result.Location = new System.Drawing.Point(21, 26);
            this.textBox_result.Multiline = true;
            this.textBox_result.Name = "textBox_result";
            this.textBox_result.ReadOnly = true;
            this.textBox_result.ScrollBars = System.Windows.Forms.ScrollBars.Vertical;
            this.textBox_result.Size = new System.Drawing.Size(696, 211);
            this.textBox_result.TabIndex = 0;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.groupBox_seach);
            this.Controls.Add(this.textBox_findRow);
            this.Controls.Add(this.label_dummy2);
            this.Controls.Add(this.label_dummy1);
            this.Controls.Add(this.button);
            this.Controls.Add(this.comboBox_numRow);
            this.Controls.Add(this.groupBox_path);
            this.Name = "Form1";
            this.Text = "TextViewer";
            this.groupBox_path.ResumeLayout(false);
            this.groupBox_path.PerformLayout();
            this.groupBox_seach.ResumeLayout(false);
            this.groupBox_seach.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private Label label_path;
        private GroupBox groupBox_path;
        private OpenFileDialog openFileDialog_path;
        private ComboBox comboBox_numRow;
        private Button button;
        private Label label_dummy1;
        private TextBox textBox_findRow;
        private Label label_dummy2;
        private GroupBox groupBox_seach;
        private TextBox textBox_result;
    }
}