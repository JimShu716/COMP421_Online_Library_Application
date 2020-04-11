package libraryapp;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class Modification {
  private Statement stmt;

  public Modification(Statement stmt) {
    this.stmt = stmt;
  }



  /********************************************************************************************************************/
  /* 4. Modify the customer record */
  public void addCustomer() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("Which record are you trying to modify? (email is not modifiable)");
      System.out.println("1. Address");
      System.out.println("2. Customer Name");
      System.out.println("3. Phone Number");

      System.out.println("4. Back to main manu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          verification(1);
          break;
        case "2":
          verification(2);
          break;
        case "3":
          verification(3);
          break;

        case "4":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }

  }

  private void verification(int type) {
    Scanner scanner = new Scanner(System.in);
    System.out.println("Please enter the current email address correctly.");
    System.out.print("> ");
    String email = scanner.nextLine();
    String sql = "";
    if (type == 1) {
      System.out.println("What is the New Address?");
      System.out.print("> ");
      String address = scanner.nextLine();
      sql = "UPDATE Customer SET address = '" + address + "'" + " WHERE email = '" + email + "'";
    } else if (type == 2) {
      System.out.println("What is the New Customer Name?");
      System.out.print("> ");
      String cname = scanner.nextLine();
      sql = "UPDATE Customer SET cname = '" + cname + "'" + " WHERE email = '" + email + "'";
    } else if (type == 3) {
      System.out.println("What is the New Phone Number?");
      System.out.print("> ");
      String phone = scanner.nextLine();
      sql = "UPDATE Customer SET phone_number = '" + phone + "'" + " WHERE email = '" + email + "'";
    }
    updateCustomer(sql, email);

  }

  private void updateCustomer(String sql, String email) {
    try {
      stmt.executeUpdate(sql);
      System.out.println("Customer information updated successful !");
      printCustomer(email);// print the corresponding customer information

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }


  /********************************************************************************************************************/
  /* 5. Add or Delete a review to book */
  public void modifyReview() {
    Scanner scanner = new Scanner(System.in);
    outer: while (true) {
      System.out.println("Do you wanna delete or add a review? ");
      System.out.println("1. Delete a Review");
      System.out.println("2. Add a Review");
      System.out.println("3. Back to main menu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          deleteReview();
          break;
        case "2":
          addReview();
          break;

        case "3":
          break outer;

        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }
  }

  private void deleteReview() {
    Scanner scanner = new Scanner(System.in);
    String rid = "";
    outer: while (true) {
      System.out.println("Please enter the review ID or press Q for returning to  previous menu");
      System.out.print("> ");
      if (scanner.nextLine().equals("Q")) {
        modifyReview();
        break outer;
      } else {
        rid = scanner.nextLine();
        break;
      }
    }


    String sql = "DELETE FROM Review WHERE review_id =" + rid;

    try {

      stmt.executeQuery(sql);
      System.out.println("Review deleted successful !");


    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }
  }

  private void addReview() {
    Scanner scanner = new Scanner(System.in);
    String sid = "";
    String bookid = "";
    String reviewId = "";
    String comment = "";
    outer: while (true) {
      System.out.println("Please enter the store id or press Q for returning to  previous menu");
      System.out.print("> ");
       if (scanner.nextLine().equals("Q")) {
        modifyReview();
        break outer;
      } else {
        sid = scanner.nextLine();
        break;
      }
    }

    outer: while (true) {
      System.out
          .println("Please enter the store book ID or press Q for returning to previous menu");
      System.out.print("> ");
     if (scanner.nextLine().equals("Q")) {
        break outer;
      } else {
        bookid = scanner.nextLine();
        break outer;
      }
    }


    String rating = "";
    outer: while (true) {
      System.out.println(" What is the rating? ");
      System.out.println("  1  ");
      System.out.println("  2  ");
      System.out.println("  3  ");
      System.out.println("  4  ");
      System.out.println("  5  ");
      System.out.println("6. Return to Previou menu");
      System.out.print("> ");
      switch (scanner.nextLine()) {
        case "1":
          rating = "1";
          break;
        case "2":
          rating = "2";
          break;
        case "3":
          rating = "3";
          break;
        case "4":
          rating = "4";
          break;
        case "5":
          rating = "5";
          break;
        case "6":
          break outer;
        default:
          System.out.println("This Option is not available. Please choose again.");
      }
    }

    outer: while (true) {
      System.out.println("Please enter comment of the review");
      System.out.print("> ");

      comment = scanner.nextLine();
      break outer;
    }



    try {
      String sql1 = "SELECT max(review_id) as m FROM Review";
      ResultSet rs = stmt.executeQuery(sql1);
      int max = rs.getInt("m");
      reviewId = String.valueOf(max + 1);



    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

    String sql = "INSERT INTO \"review\" (sid,instore_bookId,review_id,rate,comment) VALUES (" + sid
        + "," + bookid + "," + reviewId + "," + rating + ",'" + comment + "');";

    try {

      stmt.executeUpdate(sql);

      System.out.println("Review added successful !");
      printReview(reviewId);// print the newly added review



    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }

  /**
   * This method prints the query of target review
   * 
   * @author shuhao
   * @param sql
   */
  private void printReview(String reviewId) {

    String sql = "select * from review where review_id = " + reviewId + ";";
    try {
      ResultSet rs = stmt.executeQuery(sql);
      String[] header = {"sid", "instore_bookId", "reviewId", "rate", "comment"};
      System.out.println("---------------------- Matching Result -----------------------");
      System.out.format("%20s%20s%20s%20s\n", (Object[]) header);
      while (rs.next()) {
        String sid = String.valueOf(rs.getInt("sid"));
        String bookId = String.valueOf(rs.getInt("instore_bookId"));
        String rid = String.valueOf(rs.getInt("review_id"));
        String rate = String.valueOf(rs.getInt("rate"));
        String comment = rs.getString("comment");

        String[] tuple = {sid, bookId, rid, rate, comment};
        System.out.format("%20s%20s%20s%20s%20s\n", (Object[]) tuple);

      }
      System.out.println("---------------------- End of Result ------------------------");

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }


  /**
   * This method prints the query of target customer
   * 
   * @author shuhao
   * @param rs
   */
  private void printCustomer(String email) {

    String sql = "select * from customer where email = '" + email + "';";
    try {


      ResultSet rs = stmt.executeQuery(sql);
      String[] header = {"email", "address", "name", "phone_number"};
      System.out.println("---------------------- Matching Result -----------------------");
      System.out.format("%20s%20s%20s%20s\n", (Object[]) header);
      while (rs.next()) {
        String c_email = rs.getString("email");
        String address = rs.getString("address");
        String name = rs.getString("cname");
        String phoneNum = rs.getString("phone_number");


        String[] tuple = {c_email, address, name, phoneNum};
        System.out.format("%20s%20s%20s%20s\n", (Object[]) tuple);

      }
      System.out.println("---------------------- End of Result ------------------------");

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }

  }


}
