package nhat.data.model;

import java.sql.ResultSet;
import java.sql.SQLException;

public class DanhSachSanPham {

    private int iddssp, sale, gia, soluongban;
    private String madssp, namesp, idmodel, loaivai, path;
    private Boolean hethang;

    public DanhSachSanPham(ResultSet rs) throws SQLException {
        this.iddssp = rs.getInt("iddssp");
        this.sale = rs.getInt("sale");
        this.gia = rs.getInt("gia");
        this.madssp = rs.getString("madssp");
        this.namesp = rs.getString("namesp");
        this.idmodel = rs.getString("idmodel");
        this.hethang = rs.getBoolean("hethang");
        this.soluongban = rs.getInt("soluongban");
        this.loaivai = rs.getString("loaivai");
        this.path = rs.getString("path");
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public int getSoluongban() {
        return soluongban;
    }

    public void setLoaivai(String loaivai) {
        this.loaivai = loaivai;
    }

    public String getLoaivai() {
        return loaivai;
    }

    public void setSoluongban(int soluongban) {
        this.soluongban = soluongban;
    }

    public void setIddssp(int iddssp) {
        this.iddssp = iddssp;
    }

    public void setSale(int sale) {
        this.sale = sale;
    }

    public void setGia(int gia) {
        this.gia = gia;
    }

    public void setMadssp(String madssp) {
        this.madssp = madssp;
    }

    public void setNamesp(String namesp) {
        this.namesp = namesp;
    }

    public void setIdmodel(String idmodel) {
        this.idmodel = idmodel;
    }

    public void setHethang(Boolean hethang) {
        this.hethang = hethang;
    }

    public int getIddssp() {
        return iddssp;
    }

    public int getSale() {
        return sale;
    }

    public int getGia() {
        return gia;
    }

    public String getMadssp() {
        return madssp;
    }

    public String getNamesp() {
        return namesp;
    }

    public String getIdmodel() {
        return idmodel;
    }

    public Boolean getHethang() {
        return hethang;
    }
//UPDATE dssanpham SET loaivai = 'Lụa Latin' WHERE namesp COLLATE utf8mb4_bin LIKE '%lụa Latin%';
}
