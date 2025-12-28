package user;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

@WebServlet("/Contact_Handler")
public class Contact_Handler extends HttpServlet {

    // 🔹 Database connection info
    private static final String URL = "jdbc:mysql://localhost:3306/food_db";
    private static final String USER = "root";     // DB username
    private static final String PASS = "system";   // DB password

    private Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String message = req.getParameter("message");

        // ✅ Validate input
        if(name == null || email == null || message == null ||
                name.trim().isEmpty() || email.trim().isEmpty() || message.trim().isEmpty()) {
            out.println("<script>alert('All fields are required!'); window.location='contact.jsp';</script>");
            return;
        }

        try (Connection con = getConnection()) {

            // Insert into database
            String sql = "INSERT INTO contact_us(name,email,message) VALUES(?,?,?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, message);
                ps.executeUpdate();
            }

            // Optional: send email to support/admin
            sendEmail("support@yourdomain.com", name, email, message);

            out.println("<script>alert('Message sent successfully!'); window.location='contact_us.jsp';</script>");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: "+e.getMessage()+"'); window.location='contact.jsp';</script>");
        }
    }

    // 🔹 Email sending method
    private void sendEmail(String to, String name, String fromEmail, String messageBody) {
        final String from = "yourgmail@gmail.com";        // your Gmail
        final String password = "your_app_password";      // Gmail App password

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            msg.setSubject("New Contact Us Message from " + name);
            msg.setText("Name: " + name + "\nEmail: " + fromEmail + "\nMessage:\n" + messageBody);

            Transport.send(msg);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
