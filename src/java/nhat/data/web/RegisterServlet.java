package nhat.data.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import nhat.data.dao.Database;
import nhat.data.model.User;
import nhat.utils.API;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("title", "Register Page");
        request.getRequestDispatcher("./views/register.jsp").include(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String repassword = request.getParameter("repassword");
        boolean err = false;
        //Kiểm tra email
        if (!email.matches( "^[\\w-\\+]+(\\.[\\w]+)*@[\\w-]+(\\.[\\w]+)*(\\.[a-z]{2,})$")) {
            System.out.println("Email:!!! " + email);
            request.getSession().setAttribute("err_email", "Email is invalid!");
            System.out.println("Email is invalid! - Attribute: " + request.getSession().getAttribute("err_email"));            
            err = true;
        } else {
            System.out.println("Email: " + email);
            request.getSession().removeAttribute("err_email");
        }
        //Kiểm tra SDT
        if (!phone.matches("^\\d{10}$")) {
            request.getSession().setAttribute("err_phone", "Phone has 10  digists!");
            err = true;
        } else {
            request.getSession().removeAttribute("err_phone");
        }
        //kiểm tra nhập lại pass
        if (!repassword.matches(password)) {            
            request.getSession().setAttribute("err_pass", "Not match password!");
            err = true;
        } else {
            request.getSession().removeAttribute("err_pass");
        }
        //check lỗi có tồn tại không
        if (err) {
            response.sendRedirect("register");
        } else {
        if(Database.getUserDao().findUser(email) !=null  
                || Database.getUserDao().findUser(phone)!=null){
            request.getSession().setAttribute("exits_user", "User has existed in Database");
            response.sendRedirect("register");
        }else{
            Database.getUserDao().Insert(name, email, phone, API.getMd5(password));
            User user = Database.getUserDao().findUser(email);
            request.getSession().setAttribute("user", user);        
            request.getSession().removeAttribute("exits_user");
            response.sendRedirect("home");
        }
        }
    }
}
