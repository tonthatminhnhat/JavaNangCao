
package nhat.data.web;

import com.google.gson.Gson;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import nhat.data.dao.Database;
import nhat.data.model.Anh;

import nhat.data.model.DanhSachSanPham;
import nhat.data.model.SanPham;
import nhat.data.model.User;

public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user == null || !user.getAdmin()) {
            response.sendRedirect("login");
        } else {
              List<DanhSachSanPham> listDSSP = Database.getDanhSachSPDao().findAll();
        request.getSession().setAttribute("listDSSP", listDSSP);
        request.setAttribute("title", "Admin Page");
        request.getRequestDispatcher("./views/admin.jsp").include(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (null == action) {
        } else {
            switch (action) {
                case "getAllSP":
                    getAllSP(request, response);
                    break;
                case "getAllAnh":
                    getAllAnh(request, response);
                    break;
                case "getAllSize":
                    getAllSize(request, response);
                    break;
                case "addSP":
                    AddSP(request, response);
                    break;
                case "deleteSP":
                    deleteSP(request, response);
                case "updateSP":
                    updateSP(request, response);
                    break;
                case "addAnh":
                    addAnh(request, response);
                    break;
                case "updateAnh":
                    updateAnh(request, response);
                    break;
                case "deleteAnh":
                    deleteAnh(request, response);
                    break;
                case "addSize":
                    addSize(request, response);
                    break;
                case "deleteSize":
                    deleteSize(request, response);
                    break;
                case "updateSize":
                    updateSize(request, response);
                    break;
                default:
                    break;
            }
        }
    }

    private void AddSP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String namesp = request.getParameter("namesp");
        int gia = Integer.parseInt(request.getParameter("gia"));
        int sale = Integer.parseInt(request.getParameter("sale"));
        boolean hethang = Boolean.parseBoolean(request.getParameter("hethang"));
        int soluongban = Integer.parseInt(request.getParameter("soluongban"));
        String loaivai = request.getParameter("loaivai");
        String idmodel = request.getParameter("idmodel");
        String path = request.getParameter("path");
        boolean what = Database.getDanhSachSPDao().InsertUpdatedmadssp(namesp, idmodel, gia, sale, hethang, soluongban, loaivai, path);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void getAllSP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<DanhSachSanPham> listDSSP = Database.getDanhSachSPDao().findAll();
        String json = new Gson().toJson(listDSSP);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    private void deleteSP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String madssp = request.getParameter("madssp");
        boolean what = Database.getDanhSachSPDao().Delete(madssp);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void updateSP(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String madssp = request.getParameter("madssp");
        String namesp = request.getParameter("namesp");
        int gia = Integer.parseInt(request.getParameter("gia"));
        int sale = Integer.parseInt(request.getParameter("sale"));
        boolean hethang = Boolean.parseBoolean(request.getParameter("hethang"));
        int soluongban = Integer.parseInt(request.getParameter("soluongban"));
        String loaivai = request.getParameter("loaivai");
        String idmodel = request.getParameter("idmodel");
        String path = request.getParameter("path");
        boolean what = Database.getDanhSachSPDao().Update(madssp, namesp, idmodel, gia, sale, hethang, soluongban, loaivai, path);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void getAllAnh(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Anh> listAnh = Database.getAnhDao().findAll();
        String madssp = request.getParameter("madssp");
        List<Anh> listDSAnh = new ArrayList<>();
        for (Anh anh : listAnh) {
            if (anh.getMadssp().equals(madssp)) {
                listDSAnh.add(anh);
            }
        }
        System.out.println("có chạy getAllAnh");
        System.out.println(listAnh);
        String json = new Gson().toJson(listDSAnh);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    private void addAnh(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String madsspAnh = request.getParameter("madsspAnh");
        String mau = request.getParameter("mau");
        String pathAnh = request.getParameter("pathAnh");
        System.out.println("con mẹ nó");
        boolean what = Database.getAnhDao().insert(madsspAnh, mau, pathAnh);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void updateAnh(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String maanh = request.getParameter("maanh");
        String madsspAnh = request.getParameter("madsspAnh");
        String mau = request.getParameter("mau");
        String pathAnh = request.getParameter("pathAnh");
        System.out.println("con mẹ nó");
        boolean what = Database.getAnhDao().updateAnh(maanh, madsspAnh, mau, pathAnh);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void deleteAnh(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String maanh = request.getParameter("maanh");
        boolean what = Database.getAnhDao().deleteAnh(maanh);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void getAllSize(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<SanPham> listSP = Database.getSanPhamDao().findAll();
        String maanh = request.getParameter("maanh");
        List<SanPham> listSize = new ArrayList<>();
        for (SanPham size : listSP) {
            if (size.getMaanh().equals(maanh)) {
                listSize.add(size);
            }
        }
        System.out.println("có chạy getAllSize");
        System.out.println(listSize);
        String json = new Gson().toJson(listSize);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    private void addSize(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String maspanh = request.getParameter("maspanh");
        int soluong = Integer.parseInt(request.getParameter("soluong"));
        String size = request.getParameter("size");
        boolean what = Database.getSanPhamDao().Insert(maspanh, size, soluong);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void deleteSize(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String masp = request.getParameter("masp");
        boolean what = Database.getSanPhamDao().delete(masp);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }

    private void updateSize(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String masp = request.getParameter("masp");
        int soluong = Integer.parseInt(request.getParameter("soluong"));
        boolean what = Database.getSanPhamDao().update(masp, soluong);
        response.setContentType("text/plain");
        if (what) {
            response.getWriter().write("true");
        }
    }
}
