package nhat.data.web;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CollectionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String collection = request.getParameter("collection");
        request.setAttribute("collection", collection);

        request.setAttribute("title", "Đồ bộ cao cấp");
        request.getRequestDispatcher("./views/collection.jsp").include(request, response);

    }

}
