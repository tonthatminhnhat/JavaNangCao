package nhat.data.model;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LichSuDonHang {
      private int iddonhang, iduser;
      private Date ngaydatdon;
     private String trangthai, diachigiao;
     private int tongtien;
     
        public LichSuDonHang(ResultSet rs) throws SQLException {
        this.iddonhang = rs.getInt("iddonhang");
       this.iduser=rs.getInt("iduser");
       this.ngaydatdon=rs.getDate("ngaydatdon");
       this.trangthai=rs.getString("trangthai");
       this.diachigiao=rs.getString("diachigiao");
       this.tongtien=rs.getInt("tongtien");
    }

    public LichSuDonHang(int iddonhang, int iduser, Date ngaydatdon, String trangthai, String diachigiao, int tongtien) {
        this.iddonhang = iddonhang;
        this.iduser = iduser;
        this.ngaydatdon = ngaydatdon;
        this.trangthai = trangthai;
        this.diachigiao = diachigiao;
        this.tongtien = tongtien;
    }

    public void setIddonhang(int iddonhang) {
        this.iddonhang = iddonhang;
    }

    public void setIduser(int iduser) {
        this.iduser = iduser;
    }

    public void setNgaydatdon(Date ngaydatdon) {
        this.ngaydatdon = ngaydatdon;
    }

    public void setTrangthai(String trangthai) {
        this.trangthai = trangthai;
    }

    public void setDiachigiao(String diachigiao) {
        this.diachigiao = diachigiao;
    }

    public void setTongtien(int tongtien) {
        this.tongtien = tongtien;
    }

    public int getIddonhang() {
        return iddonhang;
    }

    public int getIduser() {
        return iduser;
    }

    public Date getNgaydatdon() {
        return ngaydatdon;
    }

    public String getTrangthai() {
        return trangthai;
    }

    public String getDiachigiao() {
        return diachigiao;
    }

    public int getTongtien() {
        return tongtien;
    }

    
}
