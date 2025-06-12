/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package reviewModule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;;

/**
 *
 * @author Azuri
 */
public class reviewData {
    public static Connection getConnection(){
        Connection con = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/clotify", "root", "");
        }catch(Exception e){
            System.out.println(e);
        }
        return con;
    }
    
    public static int save(review e){
        int status = 0;
        try{
            Connection con = reviewData.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into review(userId,ratting,comment) values (?,?,?)");
            
            ps.setInt(1, e.getUserid());
            ps.setInt(2, e.getRatting());
            ps.setString(3, e.getComment());
            
            status = ps.executeUpdate();
            con.close();
            
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        return status;
    }

    
    public static int delete(int id){
        int status = 0;
        try{
            Connection con = reviewData.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM review WHERE reviewId = ?");
            
            ps.setInt(1, id);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }

    // Fetch all products
    public static List<review> getAllReview() {
        List<review> list = new ArrayList<>();
        String sql = "SELECT * FROM review";

        try (
            Connection con = reviewData.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {
            while (rs.next()) {
                review e = new review();
                e.setReviewid((rs.getInt("reviewId")));
                e.setUserid(rs.getInt("userId"));
                e.setRatting(rs.getInt("ratting"));
                e.setComment(rs.getString("comment"));

                list.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }
}
