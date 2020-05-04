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


  /**
   * This method updates different customer information by input type
   * 
   * @param type
   */
  private void verification(int type) {
    Scanner scanner = new Scanner(System.in);
    System.out.println("Please enter the current email address correctly.");
    System.out.print("> ");
    String email = scanner.nextLine();
    String sql = null;
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

  /**
   * This method deletes a review from database
   */
  private void deleteReview() {
    Scanner scanner = new Scanner(System.in);
    String rid = null;
    while (true) {
      System.out.println("Please enter the review ID");
      System.out.print("> ");

      rid = scanner.nextLine();
      break;

    }


    String sql = "DELETE FROM Review WHERE review_id = '" + rid + "'";

    try {

      stmt.executeUpdate(sql);
      System.out.println("Review deleted successful !");


    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }
  }



  /**
   * This method create a review in database
   */
  private void addReview() {
    Scanner scanner = new Scanner(System.in);
    String sid = null;
    String bookid = null;
    String reviewId = null;
    String comment = null;
    while (true) {
      System.out.println("Please enter the store id");
      System.out.print("> ");

      sid = scanner.nextLine();

      break;

    }

    while (true) {
      System.out.println("Please enter the store book ID");
      System.out.print("> ");

      bookid = scanner.nextLine();

      break;
    }


    String rating = null;

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
        addReview();
        break;
      default:
        System.out.println("This Option is not available. Please choose again.");
    }


    while (true) {
      System.out.println("Please enter comment of the review");
      System.out.print("> ");

      comment = scanner.nextLine();

      break;
    }



    try {
      String sql1 = "SELECT max(review_id) as m FROM Review";

      ResultSet rs = stmt.executeQuery(sql1);

      while (rs.next()) {
        reviewId = String.valueOf(rs.getInt("m") + 1);// Make sure no duplicated Id

      }

    } catch (SQLException e) {
      System.err.println(
          "msg: " + e.getMessage() + "code: " + e.getErrorCode() + "state: " + e.getSQLState());
    }



    String sql = "INSERT INTO review (sid,instore_bookId,review_id,rate,comment) VALUES ('" + sid
        + "','" + bookid + "','" + reviewId + "','" + rating + "','" + comment + "')";



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
      System.out.format("%20s%20s%20s%20s%20s\n", (Object[]) header);
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

    System.out.println(email);
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
