package libraryapp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import java.util.InputMismatchException;
import java.util.Scanner;


public class LibraryApp {


  public static void main(String args[]) throws SQLException {
    // Register the driver
    try {
      DriverManager.registerDriver(new org.postgresql.Driver());
    } catch (Exception cnfe) {
      System.out.println("Class not found");
    }

    String url = "jdbc:postgresql://comp421.cs.mcgill.ca:5432/cs421";
    String username = "cs421g06";
    String password = "g06comp421!";


    Connection con = DriverManager.getConnection(url, username, password);

    Statement statement =
        con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);


    Select select = new Select(statement);
    Modification modify = new Modification(statement);

    System.out.println("Welcome to the Group 06 SQL Console !");
    outer: while (true) {
      try {

        System.out.println(
            "Please select one of the following options by entering it's corresponding number");
        System.out.println("1. Check for the avaliability of a  book");
        System.out.println("2. View the location of a bookstore");
        System.out.println("3. Search for bill");
        System.out.println("4. Modify the customer record");
        System.out.println("5. Add or Delete a review to book");
        System.out.println("6. Exit\n");
        System.out.print("> ");

        Scanner scanner = new Scanner(System.in);
        switch (scanner.nextLine()) {
          case "1":
            select.BookAvailability();;
            break;
          case "2":
            select.storeLocation();
            break;
          case "3":
            select.getBill();;
            break;
          case "4":
            modify.addCustomer();;
            break;
          case "5":
            modify.modifyReview();;
            break;
          case "6":
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
    con.close();

  }

}
