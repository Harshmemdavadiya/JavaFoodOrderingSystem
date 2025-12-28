package user;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/Registration_srlt")
public class Registration_srlt extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        String username = request.getParameter("username");
        String firstName = request.getParameter("first_name");
        String lastName = request.getParameter("last_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String address = request.getParameter("address");

        boolean success = false;
        boolean emailExists = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/food_db", "root", "system");

            // ✅ 1. Check if email already exists
            String checkSql = "SELECT email FROM users WHERE email = ?";
            PreparedStatement checkPs = conn.prepareStatement(checkSql);
            checkPs.setString(1, email);
            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                emailExists = true;  // Duplicate email
            }
            rs.close();
            checkPs.close();

            // ✅ 2. Insert only if email is unique
            if (!emailExists) {
                String sql = "INSERT INTO users (username, first_name, last_name, email, phone, password, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, username);
                ps.setString(2, firstName);
                ps.setString(3, lastName);
                ps.setString(4, email);
                ps.setString(5, phone);
                ps.setString(6, password);  // Consider hashing
                ps.setString(7, address);

                int rows = ps.executeUpdate();
                success = (rows > 0);

                ps.close();
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // ✅ Redirect based on result
        if (emailExists) {

            response.sendRedirect(request.getContextPath() + "/user/registration.jsp?status=email_exists");
        } else if (success) {

            response.sendRedirect(request.getContextPath() + "/user/registration.jsp?status=success");
        } else {

            response.sendRedirect(request.getContextPath() + "/user/registration.jsp?status=fail");


        }
    }
}
