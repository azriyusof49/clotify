/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package cartModule;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Azuri
 */
public class cartData {
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

    public int addToCart(int userId, int productId) {
        int status = 0;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = cartData.getConnection();

            // Check if the item already exists in the cart
            ps = conn.prepareStatement("SELECT * FROM cart WHERE userId = ? AND productId = ?");
            ps.setInt(1, userId);
            ps.setInt(2, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Item exists, update quantity
                try (PreparedStatement update = conn.prepareStatement(
                        "UPDATE cart SET quantity = quantity + 1 WHERE userId = ? AND productId = ?")) {
                    update.setInt(1, userId);
                    update.setInt(2, productId);
                    status = update.executeUpdate();
                }
            } else {
                // Item doesn't exist, insert new row
                try (PreparedStatement insert = conn.prepareStatement(
                        "INSERT INTO cart (userId, productId, quantity) VALUES (?, ?, 1)")) {
                    insert.setInt(1, userId);
                    insert.setInt(2, productId);
                    status = insert.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }

        return status;
    }

    public List<cart> getCartItems(int userId) throws SQLException {
        Connection conn = cartData.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "SELECT p.productId, p.name, p.price, p.imgURL, p.size, c.quantity FROM cart c " +
            "JOIN product p ON c.productId = p.productId WHERE c.userId = ?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        List<cart> items = new ArrayList<>();
        while (rs.next()) {
            cart item = new cart(
                rs.getInt("productId"),
                rs.getString("name"),
                rs.getDouble("price"),
                rs.getString("imgURL"),
                rs.getInt("quantity"),
                rs.getString("size")
            );
            items.add(item);
        }
        return items;
    }

    
    public static int delete(int cartId, int productId){
        int status = 0;
        try{
            Connection con = cartData.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM cart WHERE userId = ? AND productId = ?");
            
            ps.setInt(1, cartId);
            ps.setInt(2, productId);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
}
