package admin;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/add_category_srlt")
public class add_category_srlt extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String ctg_name = request.getParameter("ctg_name");
        boolean success = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/food_db", "root", "system");

            String sql = "INSERT INTO category (ctg_name) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, ctg_name);

            int rows = ps.executeUpdate();
            success = (rows > 0);

            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ Redirect to JSP with status param
        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/add_category.jsp?status=success");

        } else {
            response.sendRedirect("add_category.jsp?status=fail");
        }
    }
}
