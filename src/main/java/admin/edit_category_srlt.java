package admin;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/edit_category_srlt")
public class edit_category_srlt extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String oldName = request.getParameter("old_name");
        String newName = request.getParameter("new_name");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

            String sql = "UPDATE category SET ctg_name = ? WHERE ctg_name = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newName);
            ps.setString(2, oldName);

            int rows = ps.executeUpdate();
            conn.close();

            if (rows > 0) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/view_category.jsp?status=updated");
                dispatcher.forward(request, response);
            } else {
                response.sendRedirect("view_category.jsp?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_category.jsp?status=error");
        }
    }
}

