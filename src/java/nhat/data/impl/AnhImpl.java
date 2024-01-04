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
import nhat.data.dao.AnhDao;
import nhat.data.model.Anh;


public  class AnhImpl implements AnhDao{
    
    Connection conn= MySQLDriver.getConnection();
    
    @Override
    public List<Anh> findAll() {
       String sql="select * from anh";
        List<Anh> listanh=new ArrayList<>();
         try {
             PreparedStatement sttm= conn.prepareStatement(sql);
             ResultSet rs=sttm.executeQuery();
             while(rs.next()){
                 listanh.add(new Anh(rs));              
             }
         } catch (SQLException ex) {
             Logger.getLogger(AnhImpl.class.getName()).log(Level.SEVERE, null, ex);
         }
         return listanh;
         }
    @Override
    public boolean insert(String madssp, String mau, String path) {
         String sql = "CALL InsertAnh(?,?,?)";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setString(1, madssp);
        statement.setString(2, mau);
        statement.setString(3, path);
        // Thực hiện câu lệnh SQL INSERT
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(AnhImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
    }

    @Override
    public boolean updateAnh(String maanh, String madssp, String mau, String path) {
                 String sql = "UPDATE anh SET madssp = ?, mau=?,path=? WHERE maanh = ? ";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
         System.out.println("Có  update nhé:"+sql);
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setString(1, madssp);
        statement.setString(2, mau);
        statement.setString(3, path);
        statement.setString(4, maanh);
        // Thực hiện câu lệnh SQL INSERT
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(AnhImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
    }

    @Override
    public boolean deleteAnh(String maanh) {
           String sql = "DELETE FROM anh  WHERE maanh = ? ";
    try (PreparedStatement statement = conn.prepareStatement(sql)) {
         System.out.println("Có  delete nhé:"+sql);
        // Thiết lập giá trị cho các tham số của câu lệnh SQL
        statement.setString(1, maanh);
        // Thực hiện câu lệnh SQL INSERT
        return statement.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(AnhImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
      }

}
