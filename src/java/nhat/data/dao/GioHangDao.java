package nhat.data.dao;

import java.util.List;
import nhat.data.model.GioHang;

public interface GioHangDao {

//    public List<GioHang> findAll();
    public List<GioHang> findIdUser(int iduser);
    public Boolean Insert(int iduser, String masp, int soluong);
    public Boolean Update(int iduser, String masp, int soluong);
     public Boolean Updatebyid(int idgiohang,  int soluong);
    public Boolean Delete(int idgiohang);
    public Boolean Clear(int iduser);
}
