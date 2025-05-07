namespace TextViewer
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label_path_Click(object sender, EventArgs e)
        {
            label_path.Text = "선택된 파일 無";
            openFileDialog_path.InitialDirectory = "C:\\";
            if (openFileDialog_path.ShowDialog() == DialogResult.OK)
            {
                label_path.Text = openFileDialog_path.FileName;
            }

        }

        private void button_Click(object sender, EventArgs e)
        {
            string result = "";

            if (!File.Exists(label_path.Text))
            {
                MessageBox.Show("해당 파일이 없음");
                Console.WriteLine("파일 없음");
                return;
            }
            else if (!label_path.Text.ToUpper().Contains(".TXT"))
            {
                MessageBox.Show("텍스트 파일만 열기 가능");
                Console.WriteLine("");
                return;
            }
            else if (textBox_findRow.Text == "")
            {
                MessageBox.Show("조회할 행을 입력하세요");
                Console.WriteLine("입력 오류");
                return;
            }
            else if (comboBox_numRow.Text == "")
            {
                MessageBox.Show("조회할 행 개수를 선택하세요");
                Console.WriteLine("입력 오류");
                return;
            }
            else
            {
                IEnumerable<string> lines = File.ReadLines(label_path.Text);
                long nTotalRow = lines.Count();
                long start = Int64.Parse(textBox_findRow.Text);
                long nSearch = Int64.Parse(comboBox_numRow.Text);
                if (nSearch > nTotalRow - start)
                {
                    nSearch = nTotalRow - start;
                }

                if (start > nTotalRow)
                {
                    MessageBox.Show("최대 {0}행까지만 조회 가능", nTotalRow.ToString());
                    return;
                }

                List<string> selectedItems = lines.Skip((int)start-1).Take((int)nSearch).ToList();
                foreach (string item in selectedItems)
                {
                    result += (item + "\r\n");
                }
                textBox_result.Text = result;
                return;
            }
        }
    }
}
