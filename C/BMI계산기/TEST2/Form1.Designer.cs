namespace TEST2
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
            this.label_height = new System.Windows.Forms.Label();
            this.label_weight = new System.Windows.Forms.Label();
            this.textBox_height = new System.Windows.Forms.TextBox();
            this.combo_height = new System.Windows.Forms.ComboBox();
            this.textBox_weight = new System.Windows.Forms.TextBox();
            this.button_calc = new System.Windows.Forms.Button();
            this.label_result = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label_height
            // 
            this.label_height.AutoSize = true;
            this.label_height.Location = new System.Drawing.Point(78, 68);
            this.label_height.Name = "label_height";
            this.label_height.Size = new System.Drawing.Size(55, 20);
            this.label_height.TabIndex = 0;
            this.label_height.Text = "Height";
            // 
            // label_weight
            // 
            this.label_weight.AutoSize = true;
            this.label_weight.Location = new System.Drawing.Point(78, 169);
            this.label_weight.Name = "label_weight";
            this.label_weight.Size = new System.Drawing.Size(58, 20);
            this.label_weight.TabIndex = 1;
            this.label_weight.Text = "Weight";
            // 
            // textBox_height
            // 
            this.textBox_height.Location = new System.Drawing.Point(251, 65);
            this.textBox_height.Name = "textBox_height";
            this.textBox_height.Size = new System.Drawing.Size(125, 27);
            this.textBox_height.TabIndex = 2;
            // 
            // combo_height
            // 
            this.combo_height.FormattingEnabled = true;
            this.combo_height.Items.AddRange(new object[] {
            "cm",
            "m"});
            this.combo_height.Location = new System.Drawing.Point(479, 63);
            this.combo_height.Name = "combo_height";
            this.combo_height.Size = new System.Drawing.Size(51, 28);
            this.combo_height.TabIndex = 3;
            // 
            // textBox_weight
            // 
            this.textBox_weight.Location = new System.Drawing.Point(251, 169);
            this.textBox_weight.Name = "textBox_weight";
            this.textBox_weight.Size = new System.Drawing.Size(123, 27);
            this.textBox_weight.TabIndex = 4;
            // 
            // button_calc
            // 
            this.button_calc.Cursor = System.Windows.Forms.Cursors.Hand;
            this.button_calc.Location = new System.Drawing.Point(78, 313);
            this.button_calc.Name = "button_calc";
            this.button_calc.Size = new System.Drawing.Size(115, 55);
            this.button_calc.TabIndex = 5;
            this.button_calc.Text = "calculate";
            this.button_calc.UseVisualStyleBackColor = true;
            this.button_calc.Click += new System.EventHandler(this.button_calc_Click);
            // 
            // label_result
            // 
            this.label_result.AutoSize = true;
            this.label_result.Font = new System.Drawing.Font("맑은 고딕", 24F, System.Drawing.FontStyle.Underline, System.Drawing.GraphicsUnit.Point);
            this.label_result.Location = new System.Drawing.Point(349, 316);
            this.label_result.Name = "label_result";
            this.label_result.Size = new System.Drawing.Size(0, 54);
            this.label_result.TabIndex = 6;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(9F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.label_result);
            this.Controls.Add(this.button_calc);
            this.Controls.Add(this.textBox_weight);
            this.Controls.Add(this.combo_height);
            this.Controls.Add(this.textBox_height);
            this.Controls.Add(this.label_weight);
            this.Controls.Add(this.label_height);
            this.Name = "Form1";
            this.Text = "TEST";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Label label_height;
        private Label label_weight;
        private TextBox textBox_height;
        private ComboBox combo_height;
        private TextBox textBox_weight;
        private Button button_calc;
        private Label label_result;
    }
}