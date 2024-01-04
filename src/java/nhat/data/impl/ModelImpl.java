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
import nhat.data.dao.ModelDao;
import nhat.data.model.Model;

public class ModelImpl implements ModelDao {
     Connection conn= MySQLDriver.getConnection();
    @Override
    public List<Model> findAll() {
       List<Model> listModel = new ArrayList<>();
       String sql="select * from model";
         try {
             PreparedStatement sttm= conn.prepareStatement(sql);
             ResultSet rs=sttm.executeQuery();
             while(rs.next()){
                 listModel.add(new Model(rs));
             }
         } catch (SQLException ex) {
             Logger.getLogger(ModelImpl.class.getName()).log(Level.SEVERE, null, ex);
         }
         return listModel;
    }

}
