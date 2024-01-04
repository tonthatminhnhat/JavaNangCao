package nhat.data.web;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import nhat.data.dao.Database;
import nhat.data.model.GioHang;
import nhat.data.model.User;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Login Page");
        request.getRequestDispatcher("./views/login.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String emailphone = request.getParameter("emailphone");
        String password = request.getParameter("password");
        User user = Database.getUserDao().findUser(emailphone, password);
        if (user == null) {
            request.getSession().setAttribute("error_login", "You information is incorrect!");
            response.sendRedirect("login");
        } else if (user.getAdmin()) {
            request.getSession().setAttribute("user", user);
            response.sendRedirect("admin");
        } else {

            List<GioHang> giohang ;
            
            int iduser = user.getIduser();
              System.out.println("Xuất xem iduser  :"+iduser);
                giohang = Database.getGioHangDao().findIdUser(iduser);
             System.out.println("Xuất xem giỏ hàng  :"+giohang);
            request.getSession().setAttribute("giohang", giohang);
            
            request.getSession().setAttribute("user", user);
            request.getSession().removeAttribute("error_login");
            response.sendRedirect("home");
        }
    }
}
