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
import nhat.data.dao.SanPhamDao;
import nhat.data.model.SanPham;

public  class SanPhamImpl implements SanPhamDao{
    
    Connection conn= MySQLDriver.getConnection();
    
    @Override
    public List<SanPham> findAll() {
       String sql="select * from sanpham";
        List<SanPham> listSP=new ArrayList<>();
         try {
             PreparedStatement sttm= conn.prepareStatement(sql);
             ResultSet rs=sttm.executeQuery();
             while(rs.next()){
                 listSP.add(new SanPham(rs));              
             }
         } catch (SQLException ex) {
             Logger.getLogger(SanPhamImpl.class.getName()).log(Level.SEVERE, null, ex);
         }
         return listSP;
         }
  

//    @Override
//    public Boolean Update(String idsp, String maanh, int gia, String size, int soluong, int sale) {
//        String sql = "UPDATE products SET id_category=?, price=?, name=?, image=?, quantity=?, status=? WHERE id=?";
//
//    try (PreparedStatement statement = conn.prepareStatement(sql)) {
//        // Thiết lập giá trị cho các tham số của câu lệnh SQL
//        statement.setInt(1, id_category);
//        statement.setDouble(2, price);
//        statement.setString(3, name);
//        statement.setString(4, image);
//        statement.setInt(5, quantity);
//        statement.setBoolean(6, status);
//        statement.setInt(7, id);
//        // Thực hiện câu lệnh SQL UPDATE
//        return statement.executeUpdate() > 0;
//    } catch (SQLException ex) {
//        Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
//    } 
//        return false;
//    }
//
//    @Override
//    public Boolean Insert(int id_category, double price, String name, String image, int quantity, boolean status) {
//      String sql = "INSERT INTO products (id_category, price, name, image, quantity, status) VALUES (?, ?, ?, ?, ?, ?)";
//
//    try (PreparedStatement statement = conn.prepareStatement(sql)) {
//        // Thiết lập giá trị cho các tham số của câu lệnh SQL
//        statement.setInt(1, id_category);
//        statement.setDouble(2, price);
//        statement.setString(3, name);
//        statement.setString(4, image);
//        statement.setInt(5, quantity);
//        statement.setBoolean(6, status);
//
//        // Thực hiện câu lệnh SQL INSERT
//        return statement.executeUpdate() > 0;
//    } catch (SQLException ex) {
//        Logger.getLogger(ProductImpl.class.getName()).log(Level.SEVERE, null, ex);
//    }
//    return false;
//    }

    @Override
    public Boolean Insert(String maanh, String size, int soluong) {
     String sql = "CALL InsertSP (?, ?, ?)";

    try (PreparedStatement statement = conn.prepareStatement(sql)) {
          System.out.println("addSize có hoạt động:"+maanh+"-"+soluong+"-"+size);
        statement.setString(1, maanh);
        statement.setString(2, size);
        statement.setInt(3, soluong);
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(SanPhamImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
    }

    @Override
    public Boolean update(String masp, int soluong) {
      String sql = "update  sanpham set soluong =? where masp=?";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
          System.out.println("update có hoạt động:"+soluong+"-"+masp);
        statement.setInt(1, soluong);
        statement.setString(2, masp);
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(SanPhamImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
    }

    @Override
    public Boolean delete(String masp) {
        String sql = "delete from sanpham where masp=?";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
          System.out.println("Xóa size có hoạt động:"+masp);
        statement.setString(1, masp);
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(SanPhamImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
     }

}
