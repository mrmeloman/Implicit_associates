import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Window extends JFrame {
  String[] sexes = {"М", "Ж"};

  JPanel jp = new JPanel();
  JLabel nameLabel = new JLabel("Имя:");
  JTextField nameField = new JTextField(40);
  JLabel sexLabel = new JLabel("Пол:");
  JComboBox sexBox = new JComboBox(sexes);
  JLabel ageLabel = new JLabel("Возраст:");
  JTextField ageField = new JTextField(2);
  JLabel facultyLabel = new JLabel("Направление:");
  JTextField facultyField = new JTextField(40);
  JLabel groupLabel = new JLabel("Группа:");
  JTextField groupField = new JTextField(15);
  JLabel numberLabel = new JLabel("Номер компьютера:");
  JTextField numberField = new JTextField(5);
  JButton okButton = new JButton("Поехали!");

  private String name;
  private String sex;
  private String age;
  private String faculty;
  private String group;
  private String compNumber;

  boolean filled = false;

  public Window() {
    setTitle("Данные испытуемого");
    setSize(800, 600);
    setDefaultCloseOperation(EXIT_ON_CLOSE);

    Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();
    this.setLocation(dim.width/2-this.getSize().width/2, dim.height/2-this.getSize().height/2);

    sexBox.setSelectedItem(null);


    jp.add(nameLabel);
    jp.add(nameField);
    jp.add(ageLabel);
    jp.add(ageField);
    jp.add(sexLabel);
    jp.add(sexBox);
    jp.add(facultyLabel);
    jp.add(facultyField);
    jp.add(groupLabel);
    jp.add(groupField);
    jp.add(numberLabel);
    jp.add(numberField);
    jp.add(okButton);



    okButton.addActionListener(new ActionListener() {
      public void actionPerformed(ActionEvent e) {
        name = nameField.getText();
        sex = (String) sexBox.getSelectedItem();
        age = ageField.getText();
        faculty = facultyField.getText();
        group = groupField.getText();
        compNumber = numberField.getText();

        filled = true;
        setVisible(false);
      }
    }
    );

    add(jp);
    setVisible(true);
  }

  public boolean isFilled() {
    return this.filled;
  }

  public String[] getValues() {
    String[] values = {name, sex, age, faculty, group, compNumber};
    return values;
  }
}
