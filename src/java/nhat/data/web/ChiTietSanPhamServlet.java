package nhat.data.web;

import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import nhat.data.dao.Database;
import nhat.data.model.Anh;
import nhat.data.model.DanhSachSanPham;
import nhat.data.model.GioHang;
import nhat.data.model.SanPham;
import nhat.data.model.User;

public class ChiTietSanPhamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idsp = request.getParameter("idsp");
       
//// lấy thông tin trong dssp
        List<DanhSachSanPham> listDSSP = Database.getDanhSachSPDao().findAll();
        DanhSachSanPham chitietdssp = null;

        for (DanhSachSanPham sanPham : listDSSP) {
            if (sanPham.getMadssp().equals(idsp)) {

                chitietdssp = sanPham;
                break;
            }
        }
        request.setAttribute("chitietdssp", chitietdssp);
        /// lấy tất cả list ảnh
        List<Anh> listAnh = Database.getAnhDao().findAll();
        List<Anh> chitietanh = new ArrayList<>();

        for (Anh anh : listAnh) {
            if (anh.getMadssp().equals(idsp)) {
                chitietanh.add(anh);
            }
        }
        request.setAttribute("chitietanh", chitietanh);
        //lấy các size (sanpham)
        List<SanPham> listSP = Database.getSanPhamDao().findAll();
        List<SanPham> chitietsp = new ArrayList<>();

        for (SanPham sp : listSP) {
            if (sp.getMadssp().equals(idsp)) {
                chitietsp.add(sp);
            }
        }
        request.setAttribute("chitietsp", chitietsp);
        String maanh = request.getParameter("maanh");
        Anh anhdautien = null;
        if (maanh !=null) {

            for (Anh anh : chitietanh) {
                if (anh.maanh.equals(maanh)) {
                    anhdautien = anh;
                    break;
                }
            }
        }else {
        for (Anh anh : chitietanh) {
            if (anh != null) {
                anhdautien = anh;
                break;
            }
        }}
        
        request.setAttribute("anhdautien", anhdautien);
        request.setAttribute("title", "Đồ bộ cao cấp");
        request.getRequestDispatcher("./views/chitietsanpham.jsp").include(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("getSizes".equals(action)) {
            List<String> sizes = new ArrayList<>();
            List<SanPham> listSP = Database.getSanPhamDao().findAll();
            String maanh = request.getParameter("maanh");
            for (SanPham SanPham : listSP) {

                if (SanPham.getMaanh() == null ? maanh == null : SanPham.getMaanh().equals(maanh)
                        && SanPham.getSoluong() != 0) {
                    sizes.add(SanPham.getSize());
                }
            }
            String json = new Gson().toJson(sizes);
            // Gửi chuỗi JSON về phía client
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        }
        if ("addToCart".equals(action)) {
            addToCart(request, response);
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String masp = request.getParameter("masp");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        int iduser = user.getIduser();
        List<GioHang> giohang = (List<GioHang>) request.getSession().getAttribute("giohang");

        if (giohang == null) {
            if (Database.getGioHangDao().Insert(iduser, masp, 1)) {
                giohang = Database.getGioHangDao().findIdUser(iduser);
                request.getSession().setAttribute("giohang", giohang);
            } else {
                System.out.println("Null thất bại ");
            }

        } else {
            Boolean check = false;
            for (GioHang gh : giohang) {
                if (gh.getMasp().equals(masp)) {
                    Database.getGioHangDao().Update(iduser, masp, 1);
                    check = true;
                    break;
                }
            }
            if (!check) {
                Database.getGioHangDao().Insert(iduser, masp, 1);
                giohang = Database.getGioHangDao().findIdUser(iduser);
                request.getSession().setAttribute("giohang", giohang);
            }
        }
        response.setContentType("application/json");
        response.getWriter().write("{\"count\": " + giohang.size() + "}");
        request.getSession().setAttribute("giohang", giohang);

    }
}
