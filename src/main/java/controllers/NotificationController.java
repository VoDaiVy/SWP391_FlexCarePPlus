package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import daos.NotificationDAO;
import daos.NotificationUserDAO;
import daos.UserDAO;
import dtos.NotificationDTO;
import dtos.NotificationUserDTO;
import dtos.UserDetailDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import models.Notification;
import models.NotificationUser;
import utils.LocalDateTimeAdapter;

public class NotificationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String actor = (String) request.getSession().getAttribute("actor");
            if (actor == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
                out.print("[]");
                out.flush();
                return;
            }

            switch (actor) {
                case "admin":
                    adminGet(request, response);
                    break;
                case "customer":
                    customerGet(request, response);
                    break;
                case "staff":
                    staffGet(request, response);
                    break;
                default:
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400
                    out.print("[]");
                    out.flush();
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
            out.print("[]");
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin":
                adminPost(request, response);
                break;
            case "customer":
                customerPost(request, response);
                break;
            case "staff":
                staffPost(request, response);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin":
                adminPut(request, response);
                break;
            case "customer":
                customerPut(request, response);
                break;
            case "staff":
                staffPut(request, response);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin":
                adminDelete(request, response);
                break;
            case "customer":
                customerDelete(request, response);
                break;
            case "staff":
                staffDelete(request, response);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    // Admin role methods
    private void adminGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tất cả thông báo từ DAO
        List<Notification> notifications = NotificationDAO.getAll();
        // Đưa vào request scope
        request.setAttribute("notifications", notifications);
        // Forward tới trang JSP hiển thị danh sách thông báo
        request.getRequestDispatcher("adminPages/notifications.jsp").forward(request, response);
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "createNotification" -> {
                // 1. Lấy nội dung thông báo từ form
                String content = request.getParameter("content");
                if (content != null && !content.trim().isEmpty()) {
                    // 2. Tạo notification mới
                    Notification notification = new models.Notification();
                    notification.setContent(content);
                    NotificationDAO.create(notification);

                    // 3. Lấy danh sách userID của tất cả user KHÔNG phải admin
                    List<Integer> userIds = UserDAO.getAllUserIds();
                    // 4. Gửi notification tới từng user (NotificationUser)
                    for (Integer userId : userIds) {
                        NotificationUser nu = new NotificationUser();
                        nu.setUserID(userId);
                        nu.setNotificationID(notification.getNotificationID());
                        nu.setStatus(true);
                        nu.setHasRead(false);
                        NotificationUserDAO.create(nu);
                    }
                }
                // 5. Quay lại trang danh sách thông báo
                response.sendRedirect("admin?action=getNotifications");
            }
            case "deleteNotification" -> {
                // Xóa notification và các bản ghi liên quan trong NotificationUser
                int notificationId = Integer.parseInt(request.getParameter("notificationID"));

                // Xóa tất cả các bản ghi NotificationUser liên quan
                NotificationUserDAO.deleteAllForNotification(notificationId);
                // Xóa notification
                NotificationDAO.delete(notificationId);

                response.sendRedirect("admin?action=getNotifications");
            }
        }
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        switch (action) {
            case "getNotificationForUser" -> {
                response.setContentType("application/json; charset=UTF-8");
                response.setCharacterEncoding("UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                    if (userDetailDTO == null || userDetailDTO.getUser() == null) {
                        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
                        out.print("[]");
                        out.flush();
                        return;
                    }

                    List<NotificationDTO> notifications = NotificationUserDAO.getForUser(userDetailDTO.getUser().getUserId());
                    if (notifications == null) {
                        notifications = new ArrayList<>(); // Đảm bảo không null
                    }

                    Gson gson = new GsonBuilder()
                            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                            .create();
                    String data = gson.toJson(notifications);

                    out.print(data);
                    out.flush();
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
                    response.getWriter().print("[]");
                    response.getWriter().flush();
                }
            }
            case "countUnreadNotifications" -> {
                response.setContentType("application/json; charset=UTF-8");
                response.setCharacterEncoding("UTF-8");
                UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                int countUnreadNotification = 0;
                if (userDetailDTO != null && userDetailDTO.getUser() != null) {
                    countUnreadNotification = NotificationUserDAO.getUnreadCountForUser(userDetailDTO.getUser().getUserId());
                }
                try (PrintWriter out = response.getWriter()) {
                    out.print("{" + "\"count\":" + countUnreadNotification + "}");
                    out.flush();
                }
            }
        }

    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        switch (action) {
            case "readNotification" -> {
                int notificationID = Integer.parseInt(request.getParameter("notificationID"));
                UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                int userId = userDetailDTO.getUser().getUserId();
                NotificationUserDAO.markAsRead(userId, notificationID);
            }
            case "readAllMessage" -> {
                UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                int userId = userDetailDTO.getUser().getUserId();
                NotificationUserDAO.markAllAsRead(userId);
            }
        }
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void customerDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getNotificationForUser" -> {
                response.setContentType("application/json; charset=UTF-8");
                response.setCharacterEncoding("UTF-8");
                try (PrintWriter out = response.getWriter()) {
                    UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                    if (userDetailDTO == null || userDetailDTO.getUser() == null) {
                        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
                        out.print("[]");
                        out.flush();
                        return;
                    }

                    List<NotificationDTO> notifications = NotificationUserDAO.getForUser(userDetailDTO.getUser().getUserId());
                    if (notifications == null) {
                        notifications = new ArrayList<>(); // Đảm bảo không null
                    }

                    Gson gson = new GsonBuilder()
                            .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                            .create();
                    String data = gson.toJson(notifications);

                    out.print(data);
                    out.flush();
                } catch (Exception e) {
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500
                    response.getWriter().print("[]");
                    response.getWriter().flush();
                }
            }
            case "countUnreadNotifications" -> {
                response.setContentType("application/json; charset=UTF-8");
                response.setCharacterEncoding("UTF-8");
                UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                int countUnreadNotification = 0;
                if (userDetailDTO != null && userDetailDTO.getUser() != null) {
                    countUnreadNotification = NotificationUserDAO.getUnreadCountForUser(userDetailDTO.getUser().getUserId());
                }
                try (PrintWriter out = response.getWriter()) {
                    out.print("{" + "\"count\":" + countUnreadNotification + "}");
                    out.flush();
                }
            }
        }
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        switch (action) {
            case "readNotification" -> {
                int notificationID = Integer.parseInt(request.getParameter("notificationID"));
                UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                int userId = userDetailDTO.getUser().getUserId();
                NotificationUserDAO.markAsRead(userId, notificationID);
            }
            case "readAllMessage" -> {
                UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
                int userId = userDetailDTO.getUser().getUserId();
                NotificationUserDAO.markAllAsRead(userId);
            }
        }
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }
}
