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
            // 사용자 입력 받기
            double height = Double.Parse(textBox_height.Text);
            double weight = Double.Parse(textBox_weight.Text);

            if (combo_height.SelectedIndex == 0)   // 단위가 cm
            {
                height = height /100;             // m 단위로 수정
            }

            double bmi = weight / Math.Pow(height, 2);  // bmi 지수 계산

            if (bmi < 18.5)
            {
                label_result.Text = "저체중";
            } else if (bmi <23)
            {
                label_result.Text = "정상";
            } else if (bmi < 25)
            {
                label_result.Text = "과체중";
            } else
            {
                label_result.Text = "비만";
            }
        }
    }
}