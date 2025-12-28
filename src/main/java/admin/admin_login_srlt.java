    package admin;

    import javax.servlet.RequestDispatcher;
    import javax.servlet.ServletException;
    import javax.servlet.annotation.WebServlet;
    import javax.servlet.http.*;
    import java.io.IOException;
    import java.io.PrintWriter;
    import java.sql.*;

    @WebServlet("/admin_login_srlt")
    public class admin_login_srlt extends HttpServlet {

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            response.setContentType("text/html");
            PrintWriter out = response.getWriter();

            try {
                // 1. Load JDBC Driver
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/food_db", "root", "system");

                // 2. Get Login Parameters
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                // 3. Validate credentials
                String sql = "SELECT * FROM admin_login WHERE username = ? AND password = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    // ✅ Login successful
                    HttpSession session = request.getSession();
                    session.setAttribute("uname", username);  // store username in session
                    session.setAttribute("password", password); // store admin id if needed
                    session.setMaxInactiveInterval(30 * 60); // 30 min session timeout

                    response.sendRedirect(request.getContextPath() + "/admin/admin_dashboard.jsp");

                } else {
                    // ❌ Login failed
                    request.setAttribute("errorMsg", "Invalid username or password!");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/admin_login.jsp");
                    dispatcher.forward(request, response);
                }

                // 4. Close resources
                rs.close();
                stmt.close();
                conn.close();

            } catch (Exception e) {
                e.printStackTrace();
                out.println("<br>Error: " + e.getMessage());
            }
        }

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not supported.");
        }
    }
