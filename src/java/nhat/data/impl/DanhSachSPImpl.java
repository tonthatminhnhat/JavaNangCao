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
import nhat.data.dao.DanhSachSPDao;
import nhat.data.model.DanhSachSanPham;

public class DanhSachSPImpl implements DanhSachSPDao {

    Connection conn = MySQLDriver.getConnection();

    @Override
    public List<DanhSachSanPham> findAll() {
        String sql = "select * from dssanpham";
        List<DanhSachSanPham> listSP = new ArrayList<>();
        try {
            PreparedStatement sttm = conn.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                listSP.add(new DanhSachSanPham(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(DanhSachSPImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listSP;
    }

    @Override
    public Boolean InsertUpdatedmadssp(String namesp, String idmodel, int gia, int sale, boolean hethang, int soluongban, String loaivai, String path) {
            String sql = "CALL InsertUpdatemadssp(?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            // Thiết lập giá trị cho các tham số của câu lệnh SQL
            statement.setString(1, namesp);
            statement.setString(2, idmodel);
            statement.setInt(3, gia);
            statement.setInt(4, sale);
            statement.setBoolean(5, hethang);
            statement.setInt(6, soluongban);
            statement.setString(7, loaivai);
            statement.setString(8, path);
            return statement.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DanhSachSPImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public Boolean Delete(String madssp) {
        String sql = "DELETE FROM  dssanpham WHERE  madssp = ?";
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            statement.setString(1, madssp);
            return statement.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DanhSachSPImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    @Override
    public Boolean Update(String madssp, String namesp, String idmodel, int gia, int sale, boolean hethang, int soluongban, String loaivai, String path) {
        System.out.println("Path: "+path);
        String sql = "UPDATE dssanpham SET  namesp=?, idmodel=?, gia=?, sale=?, hethang=?,soluongban=?,loaivai=?,path=? WHERE madssp=?";     
        try (PreparedStatement statement = conn.prepareStatement(sql)) {
            // Thiết lập giá trị cho các tham số của câu lệnh SQL
            statement.setString(1, namesp);
            statement.setString(2, idmodel);
            statement.setInt(3, gia);
            statement.setInt(4, sale);
            statement.setBoolean(5, hethang);
            statement.setInt(6, soluongban);
            statement.setString(7, loaivai);
            statement.setString(8, path);
            statement.setString(9, madssp);
            return statement.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(DanhSachSPImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
