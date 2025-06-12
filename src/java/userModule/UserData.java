package userModule;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Azuri
 */
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Azuri
 */

import java.util.*;
import java.sql.*;

public class UserData {
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
    
    public static int save(User e){
        int status = 0;
        try{
            Connection con = UserData.getConnection();
            PreparedStatement ps = con.prepareStatement("insert into users(username,email,password,role,birthdate) values (?,?,?,?,?)");
            
            ps.setString(1, e.getUsername());
            ps.setString(2, e.getEmail());
            ps.setString(3, e.getPassword());
            ps.setString(4, "user");
            ps.setString(5, e.getDate());
            
            status = ps.executeUpdate();
            con.close();
            
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        return status;
    }
    
    public static int update(User e){
        int status = 0;
        try{
            Connection con = UserData.getConnection();
            PreparedStatement ps = con.prepareStatement("update users set username=?, email=?, password=?, role=?, birthdate=? where id=?");
            
            ps.setString(1, e.getUsername());
            ps.setString(2, e.getEmail());
            ps.setString(3, e.getPassword());
            ps.setString(4, e.getRole());
            ps.setString(5, e.getDate());
            ps.setInt(6, e.getId());
            
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
            Connection con = UserData.getConnection();
            PreparedStatement ps = con.prepareStatement("DELETE FROM users WHERE id = ?");
            
            ps.setInt(1, id);
            
            status = ps.executeUpdate();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return status;
    }
    
    public static User getUserByUsername(String username){
        User e = new User();
        
        try{
            Connection con = UserData.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from users where username=?");
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                e.setId(rs.getInt(1));
                e.setUsername(rs.getString(2));
                e.setEmail(rs.getString(3));
                e.setPassword(rs.getString(4));
                e.setRole(rs.getString(5));
                e.setDate(rs.getString(6));
                e.setTimestamp(rs.getTimestamp("timestamp"));
            }
            con.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        return e;
    }

    public static User getUserById(int id){
        User e = new User();
        
        try{
            Connection con = UserData.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from users where id=?");
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                e.setId(rs.getInt(1));
                e.setUsername(rs.getString(2));
                e.setEmail(rs.getString(3));
                e.setPassword(rs.getString(4));
                e.setRole(rs.getString(5));
                e.setDate(rs.getString(6));
                e.setTimestamp(rs.getTimestamp("timestamp"));
            }
            con.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
        
        return e;
    }

    public static int Auth(String username, String password){
        int status = 0;
        try{
            Connection con = UserData.getConnection();
            PreparedStatement ps = con.prepareStatement("select * from users where username=? and password=?");
            
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                status = 1;
            }
            con.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
        return status;
    }
    
    public static List<User> getAllUsers() {
    List<User> list = new ArrayList<>();

    // It’s better to spell out your column names (and match exactly your schema)
    String sql = "SELECT id, username, email, password, role, birthdate, timestamp FROM users";

    // Use try‑with‑resources so everything is closed automatically
    try (
        Connection con = UserData.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
    ) {
        while (rs.next()) {
            User e = new User();
            e.setId(rs.getInt("id"));
            e.setUsername(rs.getString("username"));
            e.setEmail(rs.getString("email"));
            e.setPassword(rs.getString("password"));
            e.setRole(rs.getString("role"));    // match your column name
            e.setDate(rs.getString("birthdate"));
            e.setTimestamp(rs.getTimestamp("timestamp")); // Correct usage for Timestamp



            // ←────────────── MISSING IN YOUR ORIGINAL ──────────────→
            list.add(e);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return list;
    }
    
    public static Map<String, Integer> getUserGrowthData() {
        Map<String, Integer> growthMap = new LinkedHashMap<>();
        String sql = "SELECT DATE(timestamp) as date, COUNT(*) as count FROM users WHERE timestamp >= NOW() - INTERVAL 30 DAY GROUP BY DATE(timestamp) ORDER BY date ASC";

        try (
            Connection con = getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {
            while (rs.next()) {
                String date = rs.getString("date");
                int count = rs.getInt("count");
                growthMap.put(date, count);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return growthMap;
    }


}

