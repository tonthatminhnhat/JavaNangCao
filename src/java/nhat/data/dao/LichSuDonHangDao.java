package nhat.data.dao;

import java.util.List;
import nhat.data.model.LichSuDonHang;

public interface LichSuDonHangDao {

    public List<LichSuDonHang> findAll();
    public List<LichSuDonHang> findIdUser(int iduser);
}
