package utils;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

public class Email {

    static final String FROM = ConfigGetter.getProperty("mail.email");
    static final String PASSWORD = ConfigGetter.getProperty("mail.password");

    public static boolean sendEmail(String to, String tieuDe, String noiDung) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        //create Authenticator
        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        };

        //Phiên làm việc
        Session session = Session.getInstance(props, auth);

        //Tạo 1 tin nhắn
        MimeMessage msg = new MimeMessage(session);
        try {
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.setFrom(FROM);
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            //Tiêu đề email
            msg.setSubject(tieuDe);
            msg.setSentDate(new Date());
            //nội dung email
            msg.setContent(noiDung, "text/HTML; charset=UTF-8");
            Transport.send(msg);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static String noiDungRegis(String key) {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<head>\r\n"
                + "  <meta charset=\"UTF-8\">\r\n"
                + "  <style>\r\n"
                + "    body { font-family: Arial, sans-serif; background-color: #f9f9f9; padding: 20px; }\r\n"
                + "    .email-container {\r\n"
                + "      background-color: #ffffff;\r\n"
                + "      max-width: 600px;\r\n"
                + "      margin: auto;\r\n"
                + "      padding: 30px;\r\n"
                + "      border: 1px solid #ddd;\r\n"
                + "      border-radius: 10px;\r\n"
                + "      box-shadow: 0 4px 10px rgba(0,0,0,0.05);\r\n"
                + "    }\r\n"
                + "    h1 { color: #2c3e50; font-size: 22px; }\r\n"
                + "    p { font-size: 16px; color: #333; line-height: 1.5; }\r\n"
                + "    .code-box {\r\n"
                + "      margin-top: 20px;\r\n"
                + "      padding: 10px 20px;\r\n"
                + "      background-color: #e8f5e9;\r\n"
                + "      color: #2e7d32;\r\n"
                + "      font-size: 20px;\r\n"
                + "      font-weight: bold;\r\n"
                + "      border-radius: 6px;\r\n"
                + "      display: inline-block;\r\n"
                + "    }\r\n"
                + "  </style>\r\n"
                + "</head>\r\n"
                + "<body>\r\n"
                + "  <div class=\"email-container\">\r\n"
                + "    <h1>Chào mừng bạn đến với <span style=\"color:#28a745;\">FlexCareP+</span> 🐾</h1>\r\n"
                + "    <p>Cảm ơn bạn đã đăng ký. Vui lòng sử dụng mã xác thực bên dưới để hoàn tất việc xác minh địa chỉ email của bạn:</p>\r\n"
                + "    <div class=\"code-box\">" + key + "</div>\r\n"
                + "    <p>Nếu bạn không yêu cầu mã này, vui lòng bỏ qua email này.</p>\r\n"
                + "    <p style=\"margin-top: 30px; color: #888; font-size: 13px;\">Trân trọng,<br>Đội ngũ FlexCareP+</p>\r\n"
                + "  </div>\r\n"
                + "</body>\r\n"
                + "</html>";
    }

    public static String noiDungReset() {
        return "<!DOCTYPE html>\r\n"
                + "<html>\r\n"
                + "<head>\r\n"
                + "  <meta charset='UTF-8'>\r\n"
                + "  <style>\r\n"
                + "    body { font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; }\r\n"
                + "    .email-container {\r\n"
                + "      max-width: 600px;\r\n"
                + "      margin: auto;\r\n"
                + "      background-color: #ffffff;\r\n"
                + "      padding: 30px;\r\n"
                + "      border-radius: 10px;\r\n"
                + "      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);\r\n"
                + "      color: #333;\r\n"
                + "    }\r\n"
                + "    h1 { color: #d32f2f; font-size: 24px; }\r\n"
                + "    p { font-size: 16px; line-height: 1.6; }\r\n"
                + "    .btn {\r\n"
                + "      display: inline-block;\r\n"
                + "      padding: 10px 20px;\r\n"
                + "      background-color: #007bff;\r\n"
                + "      color: white;\r\n"
                + "      text-decoration: none;\r\n"
                + "      border-radius: 5px;\r\n"
                + "      margin-top: 15px;\r\n"
                + "    }\r\n"
                + "    .btn:hover { background-color: #0056b3; }\r\n"
                + "    .footer { font-size: 13px; color: #888; margin-top: 30px; }\r\n"
                + "  </style>\r\n"
                + "</head>\r\n"
                + "<body>\r\n"
                + "  <div class='email-container'>\r\n"
                + "    <h1>Xin chào!</h1>\r\n"
                + "    <p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản liên kết với địa chỉ email của bạn.</p>\r\n"
                + "    <p>Mật khẩu của bạn được đổi thành: 123</p>\r\n"
                + "    <div class='footer'>\r\n"
                + "      <p>Hotline hỗ trợ: <strong>1900 1 tông 1 dép</strong></p>\r\n"
                + "      <p>Email: <a href='mailto:flexcarepplus@gmail.com'>flexcarepplus@gmail.com</a></p>\r\n"
                + "      <p>Trân trọng,<br>Đội ngũ FlexCareP+</p>\r\n"
                + "    </div>\r\n"
                + "  </div>\r\n"
                + "</body>\r\n"
                + "</html>";
    }

    //Email Key Verify
    public static String generateRandomKey() {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < 6; i++) {
            int index = random.nextInt(characters.length());
            sb.append(characters.charAt(index));
        }
        return sb.toString();
    }
}
