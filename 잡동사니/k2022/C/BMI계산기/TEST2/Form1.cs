namespace TEST2
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button_calc_Click(object sender, EventArgs e)
        {
            // ����� �Է� �ޱ�
            double height = Double.Parse(textBox_height.Text);
            double weight = Double.Parse(textBox_weight.Text);

            if (combo_height.SelectedIndex == 0)   // ������ cm
            {
                height = height /100;             // m ������ ����
            }

            double bmi = weight / Math.Pow(height, 2);  // bmi ���� ���

            if (bmi < 18.5)
            {
                label_result.Text = "��ü��";
            } else if (bmi <23)
            {
                label_result.Text = "����";
            } else if (bmi < 25)
            {
                label_result.Text = "��ü��";
            } else
            {
                label_result.Text = "��";
            }
        }
    }
}