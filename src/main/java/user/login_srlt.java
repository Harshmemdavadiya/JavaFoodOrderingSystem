package user;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login_srlt")
public class login_srlt extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean validUser = false;

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to DB
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/food_db", "root", "system");

            // Prepare SQL query
            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                validUser = true;
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
            }

            // Close resources
            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (validUser) {
            // ✅ Login success → redirect to items page
            response.sendRedirect(request.getContextPath() + "/user/all_items.jsp");
        } else {
            // ❌ Login failed → redirect back with status=fail
            response.sendRedirect(request.getContextPath() + "/user/user_login.jsp?status=fail");

        }
    }
}
