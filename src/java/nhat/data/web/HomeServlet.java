package nhat.data.web;

import nhat.data.dao.Database;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import nhat.data.driver.MySQLDriver;
import nhat.data.model.Anh;
import nhat.data.model.DanhSachSanPham;
import nhat.data.model.Model;


public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        List<Model> listModel = Database.getModelDao().findAll();
        List<DanhSachSanPham> listDSSP = Database.getDanhSachSPDao().findAll();
        List<Anh> listAnh = Database.getAnhDao().findAll();
       
        Map<String, List<String>> loaiVaiMap = new HashMap<>();
// Lặp qua danh sách và lọc ra các loại vải
        for (Model model : listModel) {
            String idmodel = model.getIdmodel();
            // Lọc danh sách sản phẩm có idmodel tương ứng
            List<DanhSachSanPham> filteredDSSP = new ArrayList<>();
            for (DanhSachSanPham dssp : listDSSP) {
                if (dssp.getIdmodel().equals(idmodel)) {
                    filteredDSSP.add(dssp);
                }
            }
            // Lọc và bỏ đi các giá trị loaivai trùng lặp
            List<String> loaiVaiList = new ArrayList<>();
            for (DanhSachSanPham dssp : filteredDSSP) {
                String loaivai = dssp.getLoaivai();
                if (!loaiVaiList.contains(loaivai)) {
                    loaiVaiList.add(loaivai);
                }
            }
            // Lưu danh sách loại vải vào Map
            loaiVaiMap.put(idmodel, loaiVaiList);
        }
// Lưu Map vào request để sử dụng trong JSP
        session.setAttribute("listModel", listModel);
        session.setAttribute("listDSSP", listDSSP);
        session.setAttribute("listAnh", listAnh);
        session.setAttribute("loaiVaiMap", loaiVaiMap);
        /// lấy ảnh con
        Map<String, List<String>> productImages = new HashMap<>();
        for (DanhSachSanPham dssp : listDSSP) {
            List<String> images = new ArrayList<>();
            for (Anh anh : listAnh) {
                if (anh.getMadssp().equals(dssp.getMadssp())) {
                    images.add(anh.getPath());
                }
            }
            productImages.put(dssp.getMadssp(), images);
        }
        session.setAttribute("productImages", productImages);
        try {
            List<Integer> listSale = yourSaleQueryMethod();
            session.setAttribute("listSale", listSale);
        } catch (SQLException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            List<SaleAndImage> SaleAndImages = yourAnhQueryMethod();
                session.setAttribute("SaleAndImages", SaleAndImages);
        } catch (SQLException ex) {
            Logger.getLogger(HomeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    

        request.setAttribute("title", "Đồ bộ cao cấp");
        request.getRequestDispatcher("./views/home.jsp").include(request, response);
    }

    private List<Integer> yourSaleQueryMethod() throws SQLException {
        Connection conn = MySQLDriver.getConnection();
        List<Integer> listSale = new ArrayList<>();
        String sql = "SELECT DISTINCT sale FROM dssanpham WHERE sale <> 0 ORDER BY sale DESC";
        PreparedStatement sttm = conn.prepareStatement(sql);
        ResultSet resultSet = sttm.executeQuery();
        while (resultSet.next()) {
            int sale = resultSet.getInt("sale");
            listSale.add(sale);
        }
        return listSale;

    }

    private List<SaleAndImage> yourAnhQueryMethod() throws SQLException {
        Connection conn = MySQLDriver.getConnection();
        List<SaleAndImage> SaleAndImages = new ArrayList<>();
        String sql = "SELECT dssanpham.sale, anh.* FROM dssanpham LEFT JOIN anh ON dssanpham.madssp = anh.madssp WHERE dssanpham.sale <> 0 ORDER BY dssanpham.sale DESC;";
        PreparedStatement sttm = conn.prepareStatement(sql);
        ResultSet rs = sttm.executeQuery();
        while (rs.next()) {
            int sale = rs.getInt("sale");
            String madssp = rs.getString("madssp");
            String mau = rs.getString("mau");
            String path = rs.getString("path");
            String maanh = rs.getString("maanh");      
            
            SaleAndImage a = new SaleAndImage(sale, mau,maanh,madssp,path);
            SaleAndImages.add(a);
        }
        System.out.println("xuất thử xem :" + SaleAndImages);
        return SaleAndImages;
    }

    public class SaleAndImage {
        private int sale; private String mau;  private String maanh; private String madssp; private String path;

        public SaleAndImage(int sale, String mau, String maanh, String madssp, String path) {
            this.sale = sale;
            this.mau = mau;
            this.maanh = maanh;
            this.madssp = madssp;
            this.path = path;
        }
        public int getSale() {
            return sale;
        }
        public String getMau() {
            return mau;
        }
        public String getMaanh() {
            return maanh;
        }
        public String getMadssp() {
            return madssp;
        }
        public String getPath() {
            return path;
        }

    }
}
