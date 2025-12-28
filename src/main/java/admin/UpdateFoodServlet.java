package admin;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/UpdateFoodServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class UpdateFoodServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String foodName = request.getParameter("foodName");
        String price = request.getParameter("price");
        String description = request.getParameter("description");

        Part imagePart = request.getPart("image");
        String imageFileName = null;

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/food_db", "root", "system");

            // Check if new image is uploaded
            if (imagePart != null && imagePart.getSize() > 0) {
                // Save uploaded image in "uploads" folder
                String uploadPath = getServletContext().getRealPath("") + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();

                // Unique image name
                imageFileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
                imagePart.write(uploadPath + File.separator + imageFileName);

                // Update including new image
                ps = conn.prepareStatement(
                        "UPDATE foods SET food_name=?, price=?, description=?, image_path=? WHERE food_id=?"
                );
                ps.setString(1, foodName);
                ps.setDouble(2, Double.parseDouble(price));
                ps.setString(3, description);
                ps.setString(4, "uploads/" + imageFileName);
                ps.setInt(5, id);

            } else {
                // Update without changing image
                ps = conn.prepareStatement(
                        "UPDATE foods SET food_name=?, price=?, description=? WHERE food_id=?"
                );
                ps.setString(1, foodName);
                ps.setDouble(2, Double.parseDouble(price));
                ps.setString(3, description);
                ps.setInt(4, id);
            }

            int rows = ps.executeUpdate();

            if (rows > 0) {
                // Redirect to JSP with success message
                response.sendRedirect("admin/edit_food.jsp?msg=success");
            } else {
                // Redirect to JSP with error message
                response.sendRedirect("admin/edit_food.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin/edit_food.jsp?msg=error");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception ignored){}
            try { if (conn != null) conn.close(); } catch (Exception ignored){}
        }
    }
}
