package nhat.data.web;

import jakarta.servlet.http.HttpServlet;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
import nhat.data.dao.Database;
import nhat.data.driver.MySQLDriver;
import nhat.data.model.GioHang;
import nhat.data.model.User;

public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int iduser = user.getIduser();
        List<Map<String, Object>> gioHangItems = null;
        try {
            gioHangItems = getGioHangItemsForUser(iduser);
        } catch (SQLException ex) {
            Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        if (request.getParameter("clear") != null) {
            Database.getGioHangDao().Clear(iduser);
            gioHangItems = null;
            request.getSession().setAttribute("gioHangItems", gioHangItems);
            List<GioHang> giohang = null;
            request.getSession().setAttribute("giohang", giohang);
        }
        request.setAttribute("gioHangItems", gioHangItems);
        request.setAttribute("title", "Cart Detail");
        request.getRequestDispatcher("./views/cart.jsp").include(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("removeItem".equals(action)) {
            try {
                removeItem(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        if ("updateQuantity".equals(action)) {
            try {
                System.out.println("hoạt dọngd  updateQuantity:");
                updateQuantity(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(CartServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    private List<Map<String, Object>> getGioHangItemsForUser(int iduser) throws SQLException {

        Connection conn = MySQLDriver.getConnection();
        String sql = "SELECT giohang.soluong, sanpham.size, anh.path, ds.namesp, anh.mau, ds.gia - ds.gia * ds.sale/100 as tien ,giohang.idgiohang "
                + "FROM giohang "
                + "JOIN sanpham ON giohang.masp = sanpham.masp "
                + "JOIN anh ON sanpham.maanh = anh.maanh "
                + "JOIN dssanpham AS ds ON sanpham.madssp = ds.madssp "
                + "WHERE giohang.iduser = " + iduser;
        PreparedStatement sttm = conn.prepareStatement(sql);
        List<Map<String, Object>> gioHangItems = new ArrayList<>();
        ResultSet resultSet = sttm.executeQuery();
        while (resultSet.next()) {
            Map<String, Object> gioHangItem = new HashMap<>();
            gioHangItem.put("soluong", resultSet.getInt("soluong"));
            gioHangItem.put("size", resultSet.getString("size"));
            gioHangItem.put("path", resultSet.getString("path"));
            gioHangItem.put("namesp", resultSet.getString("namesp"));
            gioHangItem.put("mau", resultSet.getString("mau"));
            gioHangItem.put("tien", resultSet.getInt("tien"));
            gioHangItem.put("idgiohang", resultSet.getInt("idgiohang"));
            gioHangItems.add(gioHangItem);
        }
        return gioHangItems;
    }
//  System.out.println("Anh dau tien  :"+anh.getMaanh());
///////////////// hàm xóa giỏ hàng

    private void removeItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        int Idgiohang = Integer.parseInt(request.getParameter("idgiohang"));

        Database.getGioHangDao().Delete(Idgiohang);
        User user = (User) request.getSession().getAttribute("user");
        List<GioHang> giohang = Database.getGioHangDao().findIdUser(user.getIduser());
        int cartsize = giohang.size();
        int tongtien = TongTien(user.getIduser());

        response.setContentType("application/json");
        response.getWriter().write("{\"count\": " + cartsize + ", \"tongtien\": " + tongtien + "}");
        request.getSession().setAttribute("giohang", giohang);
        System.out.println("Test lại giỏ hàng xóa:" + giohang);
    }

/////////////////// cập nhật lại số lượng giỏ hàng
    private void updateQuantity(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        User user = (User) request.getSession().getAttribute("user");
        int idgiohang = Integer.parseInt(request.getParameter("idgiohang"));
        int soluong = Integer.parseInt(request.getParameter("quantity"));

        Database.getGioHangDao().Updatebyid(idgiohang, soluong);
        List<GioHang> giohang = Database.getGioHangDao().findIdUser(user.getIduser());
        int tongtien = TongTien(user.getIduser());
        int totalprice = 0;
        System.out.println("Test lại giỏ hàng update:" + giohang);
        Connection conn = MySQLDriver.getConnection();
        String sql = "SELECT giohang.soluong * (ds.gia - ds.gia * ds.sale/100) as total "
                + "FROM giohang "
                + "JOIN sanpham ON giohang.masp = sanpham.masp "
                + "JOIN dssanpham AS ds ON sanpham.madssp = ds.madssp "
                + "WHERE giohang.idgiohang = ?";
        PreparedStatement sttm = conn.prepareStatement(sql);
        sttm.setInt(1, idgiohang);
        ResultSet resultSet = sttm.executeQuery();
        if (resultSet.next()) {
            totalprice = resultSet.getInt("total");
        }

        response.setContentType("application/json");
        response.getWriter().write("{ \"tongtien\": " + tongtien + ", \"totalprice\": " + totalprice + "}");
        request.getSession().setAttribute("giohang", giohang);
        System.out.println("Test lại giỏ hàng update:" + tongtien + "   " + totalprice);

    }

    private int TongTien(int iduser) throws SQLException {

        int tongtien = 0;
        Connection conn = MySQLDriver.getConnection();
        String sql = "SELECT SUM((ds.gia - ds.gia * ds.sale / 100) * giohang.soluong) as tongTien\n"
                + "FROM giohang "
                + "JOIN sanpham ON giohang.masp = sanpham.masp "
                + "JOIN dssanpham AS ds ON sanpham.madssp = ds.madssp "
                + "WHERE giohang.iduser = " + iduser + " AND iddonhang IS NULL";

        PreparedStatement sttm = conn.prepareStatement(sql);
        ResultSet resultSet = sttm.executeQuery();
        // Di chuyển con trỏ đến hàng dữ liệu đầu tiên
        if (resultSet.next()) {
            // Lấy giá trị từ cột "tongTien"
            tongtien = resultSet.getInt("tongTien");
            System.out.println("Test listsp  :" + tongtien);
        } else {
            // ResultSet không có dữ liệu
            System.out.println("ResultSet không có dữ liệu.");
        }
        return tongtien;
    }
}
