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
            label_path.Text = "���õ� ���� ��";
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
                MessageBox.Show("�ش� ������ ����");
                Console.WriteLine("���� ����");
                return;
            }
            else if (!label_path.Text.ToUpper().Contains(".TXT"))
            {
                MessageBox.Show("�ؽ�Ʈ ���ϸ� ���� ����");
                Console.WriteLine("");
                return;
            }
            else if (textBox_findRow.Text == "")
            {
                MessageBox.Show("��ȸ�� ���� �Է��ϼ���");
                Console.WriteLine("�Է� ����");
                return;
            }
            else if (comboBox_numRow.Text == "")
            {
                MessageBox.Show("��ȸ�� �� ������ �����ϼ���");
                Console.WriteLine("�Է� ����");
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
                    MessageBox.Show("�ִ� {0}������� ��ȸ ����", nTotalRow.ToString());
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
