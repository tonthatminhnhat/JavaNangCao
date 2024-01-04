package nhat.data.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class SanPham {
      private int idsp,  sale,soluong,gia;
     private String masp, maanh,madssp, size;
     
        public SanPham(ResultSet rs) throws SQLException {
        this.idsp = rs.getInt("idsp");
       this.maanh=rs.getString("maanh");
       this.masp=rs.getString("masp");
       this.madssp=rs.getString("madssp");
       this.size=rs.getString("size");
       this.gia=rs.getInt("gia");
       this.soluong=rs.getInt("soluong");
       this.sale=rs.getInt("sale");
    }
    public SanPham(int idsp, int sale, int soluong, int gia, String masp, String maanh, String madssp, String size) {
        this.idsp = idsp;
        this.sale = sale;
        this.soluong = soluong;
        this.gia = gia;
        this.masp = masp;
        this.maanh = maanh;
        this.madssp = madssp;
        this.size = size;
    }

    public int getIdsp() {
        return idsp;
    }

    public int getSale() {
        return sale;
    }

    public int getSoluong() {
        return soluong;
    }

    public int getGia() {
        return gia;
    }

    public String getMasp() {
        return masp;
    }

    public String getMaanh() {
        return maanh;
    }

    public String getMadssp() {
        return madssp;
    }

    public String getSize() {
        return size;
    }

    public void setIdsp(int idsp) {
        this.idsp = idsp;
    }

    public void setSale(int sale) {
        this.sale = sale;
    }

    public void setSoluong(int soluong) {
        this.soluong = soluong;
    }

    public void setGia(int gia) {
        this.gia = gia;
    }

    public void setMasp(String masp) {
        this.masp = masp;
    }

    public void setMaanh(String maanh) {
        this.maanh = maanh;
    }

    public void setMadssp(String madssp) {
        this.madssp = madssp;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public void add(SanPham sp) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
   
}
