/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package productModule;

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
public class productData {
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
    
    public static int save(product e){
        int status = 0;
        try{
            Connection con = productData.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into product(name,description,category,imgURL,size,stock,price) values (?,?,?,?,?,?,?)");
            
            ps.setString(1, e.getName());
            ps.setString(2, e.getDescription());
            ps.setString(3, e.getCategory());
            ps.setString(4, e.getImgURL());
            ps.setString(5, e.getSize());
            ps.setInt(6, e.getStock());
            ps.setDouble(7, e.getPrice());
            
            status = ps.executeUpdate();
            con.close();
            
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        return status;
    }
    
    public static int update(product e) {
    int status = 0;
    try {
        Connection con = productData.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "UPDATE product SET name=?, description=?, category=?, imgURL=?, size=?, stock=?, price=? WHERE productId=?"
        );

        ps.setString(1, e.getName());
        ps.setString(2, e.getDescription());
        ps.setString(3, e.getCategory());
        ps.setString(4, e.getImgURL());
        ps.setString(5, e.getSize());
        ps.setInt(6, e.getStock());
        ps.setDouble(7, e.getPrice());
        ps.setInt(8, e.getProductId()); // make sure your product class has getProductId()

        status = ps.executeUpdate();
        con.close();
    } catch (Exception ex) {
        ex.printStackTrace();
    }
    return status;
}

    
    public static int delete(int id){
        int status = 0;
        try{
            Connection con = productData.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM product WHERE productId = ?");
            
            ps.setInt(1, id);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
    
        // Fetch product by ID
    public static product getProductById(int id){
        product e = new product();

        try {
            Connection con = productData.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM product WHERE productId = ?");
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                e.setProductId(rs.getInt("productId"));
                e.setName(rs.getString("name"));
                e.setDescription(rs.getString("description"));
                e.setCategory(rs.getString("category"));
                e.setImgURL(rs.getString("imgURL"));
                e.setSize(rs.getString("size"));
                e.setStock(rs.getInt("stock"));
                e.setPrice(rs.getDouble("price"));
            }
            con.close();
        } catch(Exception ex){
            ex.printStackTrace();
        }

        return e;
    }

    // Fetch all products
    public static List<product> getAllProducts() {
        List<product> list = new ArrayList<>();
        String sql = "SELECT * FROM product";

        try (
            Connection con = productData.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {
            while (rs.next()) {
                product e = new product();
                e.setProductId(rs.getInt("productId"));
                e.setName(rs.getString("name"));
                e.setDescription(rs.getString("description"));
                e.setCategory(rs.getString("category"));
                e.setImgURL(rs.getString("imgURL"));
                e.setSize(rs.getString("size"));
                e.setStock(rs.getInt("stock"));
                e.setPrice(rs.getDouble("price"));

                list.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return list;
    }

}
