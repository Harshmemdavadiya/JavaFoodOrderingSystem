package admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;

@WebServlet("/AddFood_srlt")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class AddFood_srlt extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        // Set request encoding to handle special characters
        request.setCharacterEncoding("UTF-8");

        try {
            // 1️⃣ Get form data
            String foodName = request.getParameter("food_Name"); // must match JSP input name
            String priceParam = request.getParameter("price");
            String categoryParam = request.getParameter("category");
            String description = request.getParameter("description");

            // 2️⃣ Validate required fields
            if (foodName == null || foodName.trim().isEmpty() ||
                    priceParam == null || priceParam.trim().isEmpty() ||
                    categoryParam == null || categoryParam.trim().isEmpty()) {

                response.sendRedirect(request.getContextPath() + "/admin/add_food.jsp?error=Please+fill+all+required+fields");
                return;
            }

            double price = Double.parseDouble(priceParam);
            int categoryId = Integer.parseInt(categoryParam);

            // 3️⃣ Handle image upload
            Part filePart = request.getPart("image");
            if (filePart == null || filePart.getSize() == 0) {
                response.sendRedirect(request.getContextPath() + "/admin/add_food.jsp?error=Please+upload+an+image");
                return;
            }

            String originalFileName = filePart.getSubmittedFileName().replaceAll("\\s+", "_").toLowerCase();
            String uniqueFileName = UUID.randomUUID() + "_" + originalFileName;

            // 4️⃣ Save file to project folder
            String uploadPath = getServletContext().getRealPath("/food_images");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();

            filePart.write(uploadPath + File.separator + uniqueFileName);
            String dbPath = "food_images/" + uniqueFileName;

            // 5️⃣ Insert into database
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/food_db", "root", "system");
                 PreparedStatement ps = conn.prepareStatement(
                         "INSERT INTO foods (food_name, price, category_id, description, image_path) VALUES (?, ?, ?, ?, ?)")) {

                ps.setString(1, foodName);
                ps.setDouble(2, price);
                ps.setInt(3, categoryId);
                ps.setString(4, description);
                ps.setString(5, dbPath);

                int rows = ps.executeUpdate();

                if (rows > 0) {
                    // ✅ Redirect to JSP with success message
                    response.sendRedirect(request.getContextPath() + "/admin/add_food.jsp?success=Food+item+added+successfully");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/add_food.jsp?error=Failed+to+add+food+item");
                }
            }

        } catch (NumberFormatException nfe) {
            nfe.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/add_food.jsp?error=Invalid+number+format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/add_food.jsp?error=An+error+occurred");
        }
    }
}
