package nhat.data.dao;

import nhat.data.impl.AnhImpl;
import nhat.data.impl.DanhSachSPImpl;
import nhat.data.impl.GioHangImpl;
import nhat.data.impl.ModelImpl;
import nhat.data.impl.SanPhamImpl;
import nhat.data.impl.UserImpl;
public class Database {
    public static ModelDao getModelDao(){
        return new ModelImpl();
    }
     public static SanPhamDao getSanPhamDao(){
        return new SanPhamImpl();
    }
     public static DanhSachSPDao getDanhSachSPDao(){
         return new DanhSachSPImpl();
     }
     public static UserDao getUserDao(){
        return new UserImpl();
    }
     public static GioHangDao getGioHangDao(){
         return new GioHangImpl();
     }
     public static AnhDao getAnhDao(){
         return new AnhImpl() ;
     }
}
