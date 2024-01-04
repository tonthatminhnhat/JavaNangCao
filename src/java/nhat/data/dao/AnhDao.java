package nhat.data.dao;

import java.util.List;
import nhat.data.model.Anh;

public interface AnhDao {

    public List<Anh> findAll();
    public boolean insert(String madssp, String mau, String path);
    public boolean updateAnh(String maanh, String madssp, String mau, String path);
    public boolean deleteAnh(String maanh);
    
}
