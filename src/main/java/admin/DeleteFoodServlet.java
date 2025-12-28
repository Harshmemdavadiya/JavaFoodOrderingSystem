package admin;

import java.io.File;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteFoodServlet")
public class DeleteFoodServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect("admin/delete_food.jsp?msg=error");
            return;
        }

        int foodId = Integer.parseInt(idParam);

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/food_db", "root", "system");

            // 1️⃣ First, get the image path to delete file
            ps = conn.prepareStatement("SELECT image_path FROM foods WHERE food_id=?");
            ps.setInt(1, foodId);
            rs = ps.executeQuery();

            String imagePath = null;
            if (rs.next()) {
                imagePath = rs.getString("image_path");
            }

            // Close previous statement
            rs.close();
            ps.close();

            // 2️⃣ Delete the record from database
            ps = conn.prepareStatement("DELETE FROM foods WHERE food_id=?");
            ps.setInt(1, foodId);
            int rows = ps.executeUpdate();

            if (rows > 0) {
                // 3️⃣ Delete image file from server if exists
                if (imagePath != null && !imagePath.isEmpty()) {
                    String fullPath = getServletContext().getRealPath("") + imagePath;
                    File imgFile = new File(fullPath);
                    if (imgFile.exists()) {
                        imgFile.delete();
                    }
                }
                response.sendRedirect("admin/delete_food.jsp?msg=deleted");
            } else {
                response.sendRedirect("admin/delete_food.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/delete_food.jsp?msg=error");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
