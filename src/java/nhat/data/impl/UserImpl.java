package nhat.data.impl;

import nhat.data.dao.UserDao;
import nhat.data.driver.MySQLDriver;
import nhat.utils.API;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import nhat.data.model.User;

public class UserImpl implements UserDao {

    Connection conn = MySQLDriver.getConnection();

    @Override
    public List<User> findAll() {
        List<User> listUser = new ArrayList<>();
        String sql = "select * from users";
        try {
            PreparedStatement sttm = conn.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            while (rs.next()) {
                
                          listUser.add(new User(rs));
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listUser;
    }

    @Override
    public User findUser(String emailphone, String password) {
        String sql;
        String passMd5=API.getMd5(password);
           if (emailphone.contains("@")) {
            sql = "select * from users where email='" +emailphone + "' and password='" + passMd5+"'";
        } else {
            sql = "select * from users where phone='" + emailphone + "' and password='" + passMd5+"'";
        }
        try {
                 PreparedStatement sttm  = conn.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            if (rs.next()) {
                return new User(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public User findUser(String emailphone) {
        String sql;
        if (emailphone.contains("@")) {
            sql = "select * from users where email='" + emailphone + "'";
        } else {
            sql = "select * from users where phone='" + emailphone + "'";
        }
        PreparedStatement sttm;
        try {
            sttm = conn.prepareStatement(sql);
            ResultSet rs = sttm.executeQuery();
            if (rs.next()) {
                return new User(rs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    @Override
    public boolean Insert(String name, String email, String phone, String password) {
        String sql = "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)";
    try {
        PreparedStatement sttm = conn.prepareStatement(sql);
        sttm.setString(1, name);
        sttm.setString(2, email);
        sttm.setString(3, phone);
        sttm.setString(4, password);
        return sttm.executeUpdate() > 0;
    } catch (SQLException ex) {
        Logger.getLogger(UserImpl.class.getName()).log(Level.SEVERE, null, ex);
    }
    return false;
    }

}

//Nếu name là "John", thì không có vấn đề gì. Nhưng nếu name là "John'); DROP TABLE users; --", thì câu lệnh SQL của bạn sẽ trở thành:
//
//SQL
//Mã do AI tạo ra. Xem lại và sử dụng cẩn thận. Thông tin thêm về Câu hỏi thường gặp.
//
//INSERT INTO users (name) VALUES ('John'); DROP TABLE users; --'