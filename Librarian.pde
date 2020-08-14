import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;


class Librarian
{
  File table, table0;
  PrintWriter out;
  String id;

  Librarian(String fileName)
  {
    this.id = fileName;
    table = new File(fileName + ".csv");
    try {
      //проверяем, что если файл не существует то создаем его
      if (!table.exists()) {
        table.createNewFile();
      }
      //PrintWriter обеспечит возможности записи в файл
      out = new PrintWriter(table.getAbsoluteFile());
      try {
        //Записываем текст в файл
        out.print("ID, ACTION, TIME, SESSION, STIMNUMSES, STIMNUMLIST, CORANS\n");
      } 
      finally {
        //После чего мы должны закрыть файл
        //Иначе файл не запишется
        out.flush();
      }
    } 
    catch(IOException e) {
      throw new RuntimeException(e);
    }
  }

  void table0(String[] participant) {
    System.out.println("table0 start");

    table0 = new File("table0.csv");
    if (table0.exists()) {
      try{
      PrintWriter out0 = new PrintWriter(new BufferedWriter(new FileWriter(table0.getPath(), true)));
      String buf = id + "," + participant[0] + "," + participant[1] + "," + participant[2] + "," + participant[3] + "," + participant[4] + "," + participant[5];
      out0.print(buf);
      out0.flush();
      out0.close();
      } catch (IOException e){
        System.err.println(e);
      }
    } else {
      try {
        table0.createNewFile();
        PrintWriter out0 = new PrintWriter(table0.getAbsoluteFile());
        String buf = id + "," + participant[0] + "," + participant[1] + "," + participant[2] + "," + participant[3] + "," + participant[4] + "," + participant[5];
        out0.print("ID, NAME, GENDER, AGE, FIELD, GROUP\n" + buf);
        out0.flush();
        out0.close();
      } 
      catch (Exception e) {
        System.out.println(e);
      }
    }
  }

  void write(String text)
  {
    out.print(text + "\n");
    out.flush();
  }

  void close()
  {
    out.close();
  }
}
