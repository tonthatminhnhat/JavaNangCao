package nhat.data.dao;

import java.util.List;
import nhat.data.model.DanhSachSanPham;

public interface DanhSachSPDao {
    public List<DanhSachSanPham> findAll();
    public Boolean InsertUpdatedmadssp(String namesp, String idmodel, int gia, int sale, boolean hethang, int soluongban, String loaivai, String path);
    public Boolean Delete(String madssp);
    public Boolean Update(String madssp, String namesp, String idmodel, int gia, int sale, boolean hethang, int soluongban, String loaivai, String path);
}
