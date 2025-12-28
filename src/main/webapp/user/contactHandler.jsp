<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.Properties, javax.mail.*, javax.mail.internet.*" %>
<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String message = request.getParameter("message");

    if(name == null || email == null || message == null ||
            name.trim().isEmpty() || email.trim().isEmpty() || message.trim().isEmpty()) {
        out.println("<script>alert('All fields are required!'); window.location='contact.jsp';</script>");
        return;
    }

    // Database connection info
    String url = "jdbc:mysql://localhost:3306/food__db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    String user = "root";
    String password = "system";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection con = DriverManager.getConnection(url, user, password)) {

            // Insert data into contact_us
            String sql = "INSERT INTO contact_us(name,email,message) VALUES(?,?,?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, message);
                ps.executeUpdate();
            }

            // Optional: send email notification to admin
            final String from = "yourgmail@gmail.com";           // your Gmail
            final String fromPass = "your_app_password";         // Gmail app password
            String to = "support@yourdomain.com";               // your support email

            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session mailSession = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(from, fromPass);
                }
            });

            try {
                Message mailMsg = new MimeMessage(mailSession);
                mailMsg.setFrom(new InternetAddress(from));
                mailMsg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
                mailMsg.setSubject("New Contact Us Message from " + name);
                mailMsg.setText("Name: " + name + "\nEmail: " + email + "\nMessage:\n" + message);
                Transport.send(mailMsg);
            } catch(MessagingException me) {
                me.printStackTrace();
            }

            out.println("<script>alert('Message sent successfully!'); window.location='contact.jsp';</script>");
        }
    } catch(Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error: "+e.getMessage()+"'); window.location='contact.jsp';</script>");
    }
%>
