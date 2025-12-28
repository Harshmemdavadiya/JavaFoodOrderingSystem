package user;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import java.util.Random;

@WebServlet("/forgerpassSrlt")
public class forgerpassSrlt extends HttpServlet {

    // 🔹 DB Connection details
    private static final String URL = "jdbc:mysql://localhost:3306/food_db"; // change db name
    private static final String USER = "root";   // your MySQL username
    private static final String PASS = "system";   // your MySQL password

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String email = req.getParameter("email");
        if (email == null || email.trim().isEmpty()) {
            out.println("<h3>⚠️ Email is required!</h3>");
            return;
        }

        // generate otp
        int otp = 100000 + new Random().nextInt(900000);

        HttpSession session = req.getSession();
        session.setAttribute("email", email);

        try (Connection con = getConnection()) {
            // remove old otp
            PreparedStatement psDel = con.prepareStatement("DELETE FROM otp_verification WHERE email=?");
            psDel.setString(1, email);
            psDel.executeUpdate();

            // insert new otp with 5 min expiry
            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO otp_verification(email, otp, expires_at) VALUES (?, ?, NOW() + INTERVAL 5 MINUTE)"
            );
            ps.setString(1, email);
            ps.setString(2, String.valueOf(otp));
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>❌ Database error while saving OTP.</h3>");
            return;
        }

        boolean sent = sendEmail(email, otp);

        out.println("<!DOCTYPE html>");
        out.println("<html>");
        out.println("<head>");
        out.println("<title>OTP Status</title>");
        out.println("<script src='https://cdn.jsdelivr.net/npm/sweetalert2@11'></script>");
        out.println("</head>");
        out.println("<body>");

        if (sent) {
            // ✅ Success alert + redirect after 3 sec
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'success',");
            out.println("  title: 'OTP Sent!',");
            out.println("  text: 'An OTP has been sent to your email.',");
            out.println("  timer: 3000,");
            out.println("  showConfirmButton: false");
            out.println("}).then(() => {");
            out.println("  window.location.href='user/verify_otp.jsp';");
            out.println("});");
            out.println("</script>");
        } else {
            // ❌ Failure alert
            out.println("<script>");
            out.println("Swal.fire({");
            out.println("  icon: 'error',");
            out.println("  title: 'Failed!',");
            out.println("  text: 'Unable to send OTP. Please try again.'");
            out.println("});");
            out.println("</script>");
        }

        out.println("</body>");
        out.println("</html>");
    }

    private boolean sendEmail(String to, int otp) {
        final String from = "deliciousfood392@gmail.com";    // your Gmail
        final String password = "csygbfncaobbwlvo";  // 16-char App password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject("Password Reset OTP");
            message.setText("Your OTP is: " + otp + "\n\nThis OTP is valid for 5 minutes.");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
