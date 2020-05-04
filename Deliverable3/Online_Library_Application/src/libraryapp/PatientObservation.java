package libraryapp;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.ResultSet;
import java.util.InputMismatchException;
import java.util.Scanner;


public class PatientObservation {


  public static void main(String args[]) throws SQLException {
    // Register the driver
    try {
      DriverManager.registerDriver(new org.postgresql.Driver());
    } catch (Exception cnfe) {
      System.out.println("Class not found");
    }

    String url = "jdbc:postgresql://comp421.cs.mcgill.ca:5432/cs421";
    String username = "hshu";
    String password = "bUE9ri6H";
    Scanner scanner = new Scanner(System.in);

    Connection con = DriverManager.getConnection(url, username, password);

    Statement statement =
        con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

    MyTools myTools = new MyTools(statement,"100"); //hosiptal id = args[0] as it is the first argument 



    try {
      myTools.checkHid(); //check if the hospital id exists
    } catch (Exception e) {
      System.err.println(e.getMessage());
      
      statement.close();
      con.close();
      System.exit(0);
    } ;

    outer: while (true) {
      try {

        System.out.println(
            "Please select one of the following options by entering it's corresponding number");
        System.out.println("1.enter a patient's observation");
        System.out.println("2. Exit\n");
        System.out.print("> ");

        switch (scanner.nextLine()) {
          case "1":
            myTools.recordObservation();;
            break;
          case "2":
            break outer;
          default:
            System.out.println("Invalid selection. Please try again");
            break;
        }

      } catch (Exception e) {
        System.out.println(e.getMessage());
      }
    }

    statement.close();
    con.close(); //close the connection

  }
}


class MyTools {

  private Statement stmt;
  private String hid;
  ResultSet result;
  Scanner scanner = new Scanner(System.in);


  public MyTools(Statement stmt, String hid) {
    this.stmt = stmt;
    this.hid =hid;
  }

  public boolean checkHid() throws Exception {

    String sql = "SELECT * FROM Healthcare_professional WHERE hospital_id = '" + hid + "'";

    try {
      result = stmt.executeQuery(sql);
    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
      throw new Exception("msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());

    }
    if (!result.isBeforeFirst()) {
      throw new Exception("The hospital id is not present in the database!");

    }
    return true;
  }

  public void recordObservation() {
    Scanner scanner = new Scanner(System.in);
    String oNum = null;
    String pid = null;
    String content = null;
    String o_date = null;
    String o_hour = null;


    System.out.println("Please enter the observation number");
    System.out.print("> ");

    oNum = scanner.nextLine();



    System.out.println("Please enter the patient's id");
    System.out.print("> ");

    pid = scanner.nextLine();

    try {
      checkPid(pid);   //Check if the patient id exists
    } catch (Exception e) {
      System.err.println(e.getMessage()); // if not, print the message
      return;
    }

    System.out.println("Please enter the content of the obervation");
    System.out.print("> ");

    content = scanner.nextLine();


    System.out.println("Please enter the date of the obervation (YYYY-MM-DD)");
    System.out.print("> ");

    o_date = scanner.nextLine();


    System.out.println("Please enter the hour of the observation (HH-MM-SS)");
    System.out.print("> ");

    o_hour = scanner.nextLine();



    String sql = "INSERT INTO observation (o_number,hospital_id,pid,contents,o_date,o_hour) VALUES ('"
        + oNum + "','" + hid + "','" + pid + "','" + content + "','" + o_date + "','" + o_hour
        + "')";



    try {

      stmt.executeUpdate(sql);//execute the query

      System.out.println("Observation added successful !");
      printObservation(oNum,hid,pid);// print the newly added review



    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }


  /**
   * This method checks if a patient id exists
   * @param pid
   * @return
   * @throws Exception
   */
  private boolean checkPid(String pid) throws Exception {
    

    String sql = "SELECT * FROM Patient WHERE pid = '" + pid + "'";

    try {
      result = stmt.executeQuery(sql);
    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());

    }
    if (!result.isBeforeFirst()) {
      throw new Exception("The patient id is not present in the database!");

    }
    return true;
  }

  
  /**
   * This method prints the newly added observation record
   * 
   * @param oNum
   * @param hid
   * @param pid
   */


  private  void printObservation(String oNum, String hid, String pid) {
    
    System.out.println(oNum+hid+pid);
    String sql = "SELECT * FROM observation where o_number ='"+ oNum+"'AND hospital_id = '"+ hid +"'AND pid ='"+pid+"'";
    try {
      ResultSet rs = stmt.executeQuery(sql);
      String[] header = {"o_number", "hospital_id", "pemail", "content", "o_date", "o_hour"};
      System.out.println("---------------------- Result -----------------------");
      System.out.format("%20s%20s%20s%20s%20s%20s\n", (Object[]) header);
      while (rs.next()) {

        String content = rs.getString("contents");
        String o_date = rs.getString("o_date");
        String o_hour = rs.getString("o_hour");


        String[] tuple = {oNum, hid, pid, content, o_date, o_hour};
        System.out.format("%20s%20s%20s%20s%20s%20s\n", (Object[]) tuple);

      }
      System.out.println("---------------------- End of Result ------------------------");

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }



}
