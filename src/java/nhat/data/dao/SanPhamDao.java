package nhat.data.dao;

import java.util.List;
import nhat.data.model.SanPham;

public interface SanPhamDao {

    public List<SanPham> findAll();

    public Boolean update(String masp, int soluong);

    public Boolean Insert(String maanh, String size, int soluong);

    public Boolean delete(String masp);

}
