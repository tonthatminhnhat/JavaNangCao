package nhat.data.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class GioHang {
      private int idgiohang, iduser;
     private String masp;
     private int soluong, iddonhang;
     
        public GioHang(ResultSet rs) throws SQLException {
        this.idgiohang = rs.getInt("idgiohang");
       this.iduser=rs.getInt("iduser");
       this.masp=rs.getString("masp");
       this.soluong=rs.getInt("soluong");
       this.iddonhang=rs.getInt("iddonhang");
    }

    public GioHang(int idgiohang, int iduser, String masp, int soluong, int iddonbang) {
        this.idgiohang = idgiohang;
        this.iduser = iduser;
        this.masp = masp;
        this.soluong = soluong;
        this.iddonhang = iddonbang;
    }

    public void setIdgiohang(int idgiohang) {
        this.idgiohang = idgiohang;
    }

    public void setIduser(int iduser) {
        this.iduser = iduser;
    }

    public void setMasp(String masp) {
        this.masp = masp;
    }

    public void setSoluong(int soluong) {
        this.soluong = soluong;
    }

    public void setIddonbang(int iddonbang) {
        this.iddonhang = iddonbang;
    }

    public int getIdgiohang() {
        return idgiohang;
    }

    public int getIduser() {
        return iduser;
    }

    public String getMasp() {
        return masp;
    }

    public int getSoluong() {
        return soluong;
    }

    public int getIddonbang() {
        return iddonhang;
    }

    public String size() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
