package user;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/verifyOTPsrlt")
public class verifyOTPsrlt extends HttpServlet {

    private static final String URL = "jdbc:mysql://localhost:3306/food_db";
    private static final String USER = "root";
    private static final String PASS = "system";

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String otp = req.getParameter("otp");
        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("email");

        if (email == null) {
            showAlert(out, "warning", "Session expired! Please try again.",
                    req.getContextPath() + "/user/forgot_password.jsp", 2500);
            return;
        }

        try (Connection con = getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM otp_verification WHERE email=? AND otp=? AND expires_at > NOW()"
            );
            ps.setString(1, email);
            ps.setString(2, otp);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ OTP valid → redirect to reset page
                showAlert(out, "success", "OTP verified! Redirecting...",
                        req.getContextPath() + "/user/f_pass.jsp", 2000);
            } else {
                // ❌ OTP invalid
                showAlert(out, "error", "Invalid or expired OTP.",
                        req.getContextPath() + "/user/verify_otp.jsp", 2500);
            }

        } catch (Exception e) {
            e.printStackTrace();
            showAlert(out, "error", "Database error while verifying OTP.",
                    req.getContextPath() + "/user/verify_otp.jsp", 2500);
        }
    }

    // 🔹 SweetAlert2 Toast Alerts
    private void showAlert(PrintWriter out, String icon, String message, String redirectPage, int timer) {
        out.println("<!doctype html><html><head>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head><body>");
        out.println("<script>");
        out.println("Swal.fire({");
        out.println("toast:true,");
        out.println("position:'top-end',");
        out.println("icon:'" + icon + "',");
        out.println("title:'" + message + "',");
        out.println("showConfirmButton:false,");
        out.println("timer:" + timer);
        out.println("});");
        out.println("setTimeout(function(){ window.location = '" + redirectPage + "'; }, " + timer + ");");
        out.println("</script></body></html>");
    }
}
