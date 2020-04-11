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
        System.out.println("Please enter the email address correctly.");
        String email = scanner.nextLine();
        String sql="";
        if(type==1) {
            System.out.println("What is the New Address?");
            String address = scanner.nextLine();
            sql = "UPDATE Customer SET address = '"+address+"'"+" WHERE email = '"+email+"'";
        }else if(type==2) {
            System.out.println("What is the New Customer Name?");
            String cname = scanner.nextLine();
            sql = "UPDATE Customer SET cname = '"+cname+"'"+" WHERE email = '"+email+"'";
        }else if(type==3) {
            System.out.println("What is the New Phone Number?");
            String phone = scanner.nextLine();
            sql = "UPDATE Customer SET phone_number = '"+phone+"'"+" WHERE email = '"+email+"'";
        }
        update(sql);
        
    }
    private void update(String sql) {
        try {
            ResultSet rs = stmt.executeQuery(sql);
            
        }catch(SQLException e) {
            System.err.println("msg: "+ e.getMessage() + 
                    "code: " + e.getErrorCode() +
                    "state: " + e.getSQLState());
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
        Scanner scanner = new Scanner (System.in);
        String rid ="";
        outer: while (true) {
            System.out.println("Please enter the review ID or press Q for returning to  previous menu");
            System.out.print("> ");
            if(!scanner.nextLine().matches("[0-9][0-9]")) {
                System.out.println("Invalid review ID! Please Try again");
            }else if(scanner.nextLine().equals("Q")) {
                break outer;
            }else {
                rid = scanner.nextLine();
                break;
            }
        }
                
        
        String sql="DELETE FROM Review WHERE review_id ="+rid;
        
        try {
            
            ResultSet rs = stmt.executeQuery(sql);
            
                        
        }catch(SQLException e) {
            System.err.println("msg: "+ e.getMessage() + 
                    "code: " + e.getErrorCode() +
                    "state: " + e.getSQLState());
        }
    }
    
    private void addReview() {
        Scanner scanner = new Scanner (System.in);
        String sid = "";
        String bookid="";
        outer: while (true) {
            System.out.println("Please enter the store id or press Q for returning to  previous menu");
            System.out.print("> ");
            if(!scanner.nextLine().matches("[0-9][0-9]")) {
                System.out.println("Invalid store ID! Please Try again");
            }else if(scanner.nextLine().equals("Q")) {
                break outer;
            }else {
                sid = scanner.nextLine();
                break;
            }
        }
        
        outer: while (true) {
            System.out.println("Please enter the store book ID or press Q for returning to previous menu");
            System.out.print("> ");
            if(!scanner.nextLine().matches("[0-9][0-9]")) {
                System.out.println("Invalid book ID! Please Try again");
            }else if(scanner.nextLine().equals("Q")) {
                break outer;
            }else {
                bookid = scanner.nextLine();
                break;
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
                    rating ="2";
                    break;

                case "3":
                    rating ="3";
                    break;
                case "4":
                    rating ="4";
                    break;
                case "5":
                    rating ="5";
                    break;
                case "6":
                    break outer;
                default:
                    System.out.println("This Option is not available. Please choose again.");
            }
        }
                
       
        
        try {
            String sql1="SELECT max(review_id) as m FROM Review";
            ResultSet rs = stmt.executeQuery(sql1);
            int max=rs.getInt("m");
            
                        
        }catch(SQLException e) {
            System.err.println("msg: "+ e.getMessage() + 
                    "code: " + e.getErrorCode() +
                    "state: " + e.getSQLState());
        }
        
    }
    
    
    
    
    
}   