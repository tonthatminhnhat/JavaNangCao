package nhat.data.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Anh {
      private int idanh;
    public String madssp;
    public String mau;
     public String path;
     public String maanh;
     private boolean hethang;
     
        public Anh(ResultSet rs) throws SQLException {
        this.idanh = rs.getInt("idanh");
       this.madssp=rs.getString("madssp");
       this.mau=rs.getString("mau");
       this.path=rs.getString("path");
       this.maanh=rs.getString("maanh");
       this.hethang=rs.getBoolean("hethang");
    }

    public Anh(int idanh, String madssp, String mau, String path, String maanh, boolean hethang) {
        this.idanh = idanh;
        this.madssp = madssp;
        this.mau = mau;
        this.path = path;
        this.maanh = maanh;
        this.hethang = hethang;
    }

    public int getIdanh() {
        return idanh;
    }

    public String getMadssp() {
        return madssp;
    }

    public String getMau() {
        return mau;
    }

    public String getPath() {
        return path;
    }

    public String getMaanh() {
        return maanh;
    }

    public boolean isHethang() {
        return hethang;
    }

    public void setIdanh(int idanh) {
        this.idanh = idanh;
    }

    public void setMadssp(String madssp) {
        this.madssp = madssp;
    }

    public void setMau(String mau) {
        this.mau = mau;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public void setMaanh(String maanh) {
        this.maanh = maanh;
    }

    public void setHethang(boolean hethang) {
        this.hethang = hethang;
    }
     
   
}
