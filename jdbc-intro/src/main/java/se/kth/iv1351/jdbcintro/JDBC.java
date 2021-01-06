package se.kth.iv1351.jdbcintro;

/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import java.sql.*;
import java.util.*;

/**
 * A small program that illustrates how to write a JDBC program for the
 * Soundgood Music School database.
 */

public class JDBC {

    public static void main(String[] args) throws SQLException {

        Connection connection = null;
        try {
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/musicschool", "postgres",
                    "example");
            connection.setAutoCommit(false);
            System.out.println("--------");
            System.out.println("LIST OF AVAILABLE INSTRUMENTS");

            Statement statement = connection.createStatement();
            ResultSet resultSet;

            resultSet = statement.executeQuery("SELECT instrument_type,monthly_rental_fee,brand\n"
                    + " FROM rental_instrument \n" + " WHERE access_instrument_type = 'Available'; ");

            while (resultSet.next()) {
                String type = resultSet.getString("instrument_type");
                String price = resultSet.getString("monthly_rental_fee");
                String brand = resultSet.getString("brand");
                System.out.println("Brand: " + brand + " | " + "Instrument: " + type + " | " + "Fee: " + price);

            }

            System.out.println("--------");
            System.out.println("RENT");
            System.out.println("Testing...");
            Scanner in = new Scanner(System.in);

            System.out.print("Insert student ID: ");
            String studentID = in.nextLine();

            String query1 = "SELECT student_id FROM rental WHERE student_id = ? AND nr_of_rentals > 1";
            PreparedStatement st = connection.prepareStatement(query1);
            st.setString(1, studentID);
            ResultSet res = st.executeQuery();

            if (res.next()) {
                System.out.println("Invalid rental, student has reached rental limit.");
                System.out.println("--------");

                System.out.println("TERMINATE RENTAL");
                Scanner in2 = new Scanner(System.in);

                System.out.println("Insert student ID: ");
                String studID = in2.nextLine();

                String query2 = "SELECT rental_id, nr_of_rentals FROM rental WHERE student_id = ?";
                PreparedStatement statement1 = connection.prepareStatement(query2);
                statement1.setString(1, studID);
                ResultSet res2 = statement1.executeQuery();

                while (res2.next() == true) {
                    String id = res2.getString("rental_id");
                    String rentals = res2.getString("nr_of_rentals");
                    System.out.println("Rental ID: " + id + ", " + "Ongoing rentals: " + rentals);
                }

                System.out.println("Insert rental ID: ");
                String rentalID = in2.nextLine();

                String query3 = "UPDATE rental SET nr_of_rentals = 1 WHERE rental_id = ?";
                PreparedStatement statement2 = connection.prepareStatement(query3);
                statement2.setString(1, rentalID);
                statement2.executeUpdate();
                connection.commit();
                System.out.println("A rental was successfully terminated!");
                System.exit(0);
            }

            System.out.print("Insert date in the format YYYY-MM-DD: ");
            String rentalDate = in.nextLine();
            System.out.print("Insert rental ID: ");
            String rentID = in.nextLine();
            System.out.print("Insert wished instrument ID to rent: ");
            String instrumentID = in.nextLine();

            String query = "INSERT INTO rental (rented_date, school_id, student_id, nr_of_rentals, rental_id, instrument_id)"
                    + " VALUES (?, 4450, ?, 1, ?, ?) ";
            PreparedStatement stmnt = connection.prepareStatement(query);
            stmnt.setString(1, rentalDate);
            stmnt.setString(2, studentID);
            stmnt.setString(3, rentID);
            stmnt.setString(4, instrumentID);
            stmnt.executeUpdate();
            connection.commit();

            System.out.println("Instrument was successfully rented!");

            System.out.println("--------");

            System.out.println("TERMINATE RENT");
            Scanner sc = new Scanner(System.in);

            System.out.println("Type in your student ID: ");
            String userInput = sc.nextLine();
            String query3 = "SELECT student_id, nr_of_rentals FROM rental WHERE student_id = ?";
            PreparedStatement statement3 = connection.prepareStatement(query3);
            statement3.setString(1, userInput);
            ResultSet res3 = statement3.executeQuery();

            while (res3.next() == true) {
                String id = res3.getString("student_id");
                String rentals = res3.getString("nr_of_rentals");
                System.out.println("Rental ID: " + id + ", " + "Ongoing rentals: " + rentals);

            }
            System.out.println("Type your rental ID: ");
            String rentalID = sc.nextLine();

            String query4 = "UPDATE rental SET nr_of_rentals = 1 WHERE rental_id = ?;";
            PreparedStatement statement4 = connection.prepareStatement(query4);
            statement4.setString(1, rentalID);
            statement4.executeUpdate();
            connection.commit();
            connection.close();

        } catch (SQLException sqlex) {
            connection.rollback();
            sqlex.printStackTrace();
        }
    }
}