package libraryapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.Scanner;


public class Select {
  private Statement stmt;

  public Select(Statement stmt) {
    this.stmt = stmt;
  }

  /********************************************************************************************************************/
  /* 1. Check for the avaliability of a book */
  public void BookAvailability() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("Which category of books are you looking for?");
      System.out.println("1. Horror");
      System.out.println("2. Memoir");
      System.out.println("3. Mystery");
      System.out.println("4. Textbook");
      System.out.println("5. Prayer");
      System.out.println("6. Religion");
      System.out.println("7. Back to main manu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          printAvailability("Horror");
          break;
        case "2":
          printAvailability("Memoir");
          break;
        case "3":
          printAvailability("Mystery");
          break;
        case "4":
          printAvailability("Textbook");
          break;
        case "5":
          printAvailability("Prayer");
          break;
        case "6":
          printAvailability("Religion");
          break;
        case "7":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }
  }

  private void printAvailability(String category) {
    Scanner scanner = new Scanner(System.in);
    System.out.println("What is the name of the book? (You can leave it blank)");
    String bname = scanner.nextLine();

    // Scanner scanner1 = new Scanner(System.in);
    System.out.println("What is the name of the ISBN of the book? (You can leave it blank)");
    String ISBN = scanner.nextLine();

    String sql = "SELECT bname , isbn ,stock_status, price, author, publisher ";
    sql = sql + "FROM book ";
    sql = sql + "WHERE category = '" + category + "'";

    System.out.println(sql);
    if (bname.length() > 0) {
      sql = sql + " AND bname= '" + bname + "'";
    }
    if (ISBN.length() > 0) {
      sql = sql + " AND isbn= '" + ISBN + "'";
    }


    try {
      ResultSet rs = stmt.executeQuery(sql);
      String[] Header = {"NAME", "ISBN", "Stock Status", "Price", "Author", "Publisher"};
      System.out.println("------------------ Matching Result ------------------  ");
      System.out.format("%25s%25s%25s%25s%25s%25s\n", (Object[]) Header);
      while (rs.next()) {
        String bname1 = rs.getString("bname");
        String isbn = rs.getString("isbn");
        String status = String.valueOf(rs.getInt("stock_status"));
        String price = String.valueOf(rs.getInt("price"));
        String author = rs.getString("author");
        String publisher = rs.getString("publisher");

        String[] tuple = {bname1, isbn, status, price, author, publisher};
        System.out.format("%25s%25s%25s%25s%25s%28s\n", (Object[]) tuple);

      }
      System.out.println("------------------ End of Result --------------------");

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }


  }

  /********************************************************************************************************************/
  /* 2. View the location of a bookstore */
  public void storeLocation() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("Search by Store ID or store Name?");
      System.out.println("1. Store ID");
      System.out.println("2. Store Name");
      System.out.println("3. Back to main menu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          locationByID();
          break;
        case "2":
          locationByName();
          break;

        case "3":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }
  }


  public void locationByID() {
    Scanner scanner = new Scanner(System.in);
    System.out.println("What is the ID of bookstore ? (You can leave it blank)");
    String sid = scanner.nextLine();
    String sql = "SELECT * FROM store ";
    if (sid.length() > 0) {
      sql = sql + "WHERE sid =" + sid;
    }
    printStoreLocation(sql);

  }



  private void locationByName() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("What is the name of the bookstore? ");
      System.out.println("1. Netus Et Malesuada Incorporated");
      System.out.println("2. At LLP");
      System.out.println("3. Nunc Ullamcorper Velit Corporation");
      System.out.println("4. Montes LLP");
      System.out.println("5. Sed Pharetra Felis Ltd");
      System.out.println("6. Back to previous menu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          printStoreLocation(
              "SELECT * FROM store WHERE sname = 'Netus Et Malesuada Incorporated';");
          break;
        case "2":
          printStoreLocation(" SELECT * FROM store WHERE sname ='At LLP';");
          break;
        case "3":
          printStoreLocation(
              "SELECT * FROM store WHERE sname ='Nunc Ullamcorper Velit Corporation'");
          break;
        case "4":
          printStoreLocation("SELECT * FROM store WHERE sname ='Montes LLP'");
          break;
        case "5":
          printStoreLocation("SELECT * FROM store WHERE sname ='Sed Pharetra Felis Ltd'");
          break;

        case "6":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }
  }

  private void printStoreLocation(String sql) {
    // String sql = "SELECT sname, location FROM store WHERE sname= '"+sname+"'";
    // ResultSet rs = stmt.executeQuery(sql);
    // String [] header = {"Store Name", "Location"};
    try {
      ResultSet rs = stmt.executeQuery(sql);
      String[] header = {"Sid", "Store Name", "Location"};
      System.out.println("----------------------- Matching Result -----------------------");
      System.out.format("%25s%25s%25s\n", (Object[]) header);
      while (rs.next()) {
        String sid = String.valueOf(rs.getInt("sid"));
        String sname = rs.getString("sname");
        String location = rs.getString("location");

        String[] tuple = {sid, sname, location};
        System.out.format("%25s%25s%25s\n", (Object[]) tuple);

      }
      System.out.println("----------------------- End of Result -------------------------");

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }


  /********************************************************************************************************************/
  /* 3. Search for bill */
  public void getBill() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("Search by Email, Bill Amount or Payment Type?");
      System.out.println("1. Email");
      System.out.println("2. Bill Amount");
      System.out.println("3. Payment Type");
      System.out.println("4. Return to main menu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          billByEmail();
          break;
        case "2":
          billByAmount();
          break;
        case "3":
          billByType();
          break;

        case "4":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }
  }

  private void billByEmail() {
    Scanner scanner = new Scanner(System.in);
    System.out.println("What is the Email of the Customer ? (You can leave it blank)");
    String email = scanner.nextLine();
    String sql = "SELECT payment_id, email,final_amount_paid,payment_type " + "FROM Bill ";
    if (email.length() > 0) {
      sql = sql + "WHERE email ='" + email + "'";
    }

    printBill(sql);

  }
  
  private void billByAmount() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("Which payment type that the Bill is?");
      System.out.println("1. 0 ~ 50 ");
      System.out.println("2. 50 ~ 100");
      System.out.println("3. > 100");
      System.out.println("4. Return to previous menu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          printBill(
              "SELECT payment_id,email,final_amount_paid,payment_type FROM Bill WHERE final_amount_paid <50");
          break;
        case "2":
          printBill(
              "SELECT payment_id,email,final_amount_paid,payment_type FROM Bill WHERE final_amount_paid >=50 AND final_amount_paid =<100");
          break;
        case "3":
          printBill(
              "SELECT payment_id,email,final_amount_paid,payment_type FROM Bill WHERE final_amount_paid >100");
          break;

        case "4":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }

  }

  private void billByType() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("Which is the Bill Amount Range?");
      System.out.println("1. visa ");
      System.out.println("2. debit");
      System.out.println("3. mastercard");
      System.out.println("4. Return to previous menu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          printBill(
              "SELECT payment_id,email,final_amount_paid,payment_type FROM Bill WHERE payment_type='visa'");
          break;
        case "2":
          printBill(
              "SELECT payment_id,email,final_amount_paid,payment_type FROM Bill WHERE payment_type='debit'");
          break;
        case "3":
          printBill(
              "SELECT payment_id,email,final_amount_paid,payment_type FROM Bill WHERE payment_type='mastercard'");
          break;

        case "4":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }

  }


  private void printBill(String sql) {
    try {
      ResultSet rs = stmt.executeQuery(sql);
      String[] header = {"Payment ID", "Email", "Amount", "Payment Type"};
      System.out.println("---------------------- Matching Result -----------------------");
      System.out.format("%20s%20s%20s%20s\n", (Object[]) header);
      while (rs.next()) {
        String paymentid = String.valueOf(rs.getInt("payment_id"));
        String email = rs.getString("email");
        String amount = String.valueOf(rs.getInt("final_amount_paid"));
        String type = rs.getString("payment_type");

        String[] tuple = {paymentid, email, amount, type};
        System.out.format("%20s%20s%20s%20s\n", (Object[]) tuple);

      }
      System.out.println("---------------------- End of Result ------------------------");

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }


}
