package controllers;

import daos.NotificationDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.Notification;

public class NotificationController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
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
                response.sendRedirect("./");
                break;
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
                    models.Notification notification = new models.Notification();
                    notification.setContent(content);
                    daos.NotificationDAO.create(notification);

                    // 3. Lấy danh sách userID của tất cả user KHÔNG phải admin
                    java.util.List<Integer> userIds = daos.UserDAO.getAllUserIds();
                    // 4. Gửi notification tới từng user (NotificationUser)
                    for (Integer userId : userIds) {
                        models.NotificationUser nu = new models.NotificationUser();
                        nu.setUserID(userId);
                        nu.setNotificationID(notification.getNotificationID());
                        nu.setStatus(true);
                        nu.setHasRead(false);
                        daos.NotificationUserDAO.create(nu);
                    }
                }
                // 5. Quay lại trang danh sách thông báo
                response.sendRedirect("admin?action=getNotifications");
            }
            case "deleteNotification" -> {
                // Xóa notification và các bản ghi liên quan trong NotificationUser
                int notificationId = Integer.parseInt(request.getParameter("notificationID"));

                // Xóa tất cả các bản ghi NotificationUser liên quan
                daos.NotificationUserDAO.deleteAllForNotification(notificationId);
                // Xóa notification
                daos.NotificationDAO.delete(notificationId);

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
        // To be implemented
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
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
        // To be implemented
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
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
