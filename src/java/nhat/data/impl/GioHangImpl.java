package nhat.data.impl;
import nhat.data.driver.MySQLDriver;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import nhat.data.dao.GioHangDao;
import nhat.data.model.GioHang;


public  class GioHangImpl implements GioHangDao{
    
    Connection conn= MySQLDriver.getConnection();
    
    @Override
    public List<GioHang> findIdUser(int iduser) {
       String sql="select * from giohang where iduser ="+iduser;
        List<GioHang> list=new ArrayList<>();
         try {
             PreparedStatement sttm= conn.prepareStatement(sql);
             ResultSet rs=sttm.executeQuery();
             while(rs.next()){
                 list.add(new GioHang(rs));              
             }
         } catch (SQLException ex) {
             Logger.getLogger(GioHangImpl.class.getName()).log(Level.SEVERE, null, ex);
         }
         return list;
         }
  
    @Override
    public Boolean Insert(int iduser, String masp, int soluong) {
      String sql = "INSERT INTO giohang (iduser, masp,soluong) VALUES (?, ?, ?)";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setInt(1, iduser);
        statement.setString(2, masp);
        statement.setInt(3, soluong);
        // Thực hiện câu lệnh SQL INSERT   
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(GioHangImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
    }
    @Override
    public Boolean Update(int iduser, String masp, int soluong) {
        String sql = "UPDATE giohang SET soluong = soluong + ? WHERE iduser = ? AND masp = ?";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setInt(1, soluong); // Giá trị mới của soluong
        statement.setInt(2, iduser);
        statement.setString(3, masp);       
        // Thực hiện câu lệnh SQL UPDATE
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(GioHangImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
            }

    @Override
    public Boolean Delete(int idgiohang) {
          String sql = "DELETE FROM giohang  WHERE idgiohang=?";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setInt(1, idgiohang); // Giá trị mới của soluong
        // Thực hiện câu lệnh SQL DELETE
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(GioHangImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
           }

    @Override
    public Boolean Updatebyid(int idgiohang, int soluong) {
          String sql = "UPDATE giohang SET soluong = ? WHERE idgiohang = ? ";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setInt(1, soluong); // Giá trị mới của soluong
        statement.setInt(2, idgiohang);
        // Thực hiện câu lệnh SQL UPDATE
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(GioHangImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;   }

    @Override
    public Boolean Clear(int iduser) {
           String sql = "DELETE FROM `giohang` WHERE iduser=? ";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setInt(1, iduser); 
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(GioHangImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;   
       }

}
