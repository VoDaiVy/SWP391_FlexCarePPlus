package controllers;

import com.google.gson.Gson;
import daos.BookingDAO;
import daos.BookingDetailDAO;
import daos.FeedbackServiceDAO;
import daos.ServiceDAO;
import dtos.UserDetailDTO;
import daos.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Booking;
import models.BookingDetail;
import models.FeedbackService;
import models.Service;
import models.User;


public class FeedbackServiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String)request.getSession().getAttribute("actor");
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
        String actor = (String)request.getSession().getAttribute("actor");
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
        String actor = (String)request.getSession().getAttribute("actor");
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
        String actor = (String)request.getSession().getAttribute("actor");
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
        String action = request.getParameter("action");
        switch (action) {
            case "getFeedbacks" -> {
                int serviceID = Integer.parseInt(request.getParameter("serviceID"));
                Service service = ServiceDAO.getById(serviceID);
                List<FeedbackService> feedbacks = FeedbackServiceDAO.adminGetByServiceId(serviceID);
                Map<Integer, User> users = UserDAO.getUserByFeedbackServiceID(serviceID);
                request.setAttribute("service", service);
                request.setAttribute("feedbacks", feedbacks);
                request.setAttribute("users", users);
                request.getRequestDispatcher("adminPages/feedbacks.jsp").forward(request, response);
            }
        }
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "toggleFeedbackStatus" -> {
                int feedbackServiceID = Integer.parseInt(request.getParameter("feedbackServiceID"));
                int serviceID = Integer.parseInt(request.getParameter("serviceID"));
                models.FeedbackService fb = daos.FeedbackServiceDAO.getById(feedbackServiceID);
                if (fb != null) {
                    fb.setStatus(!fb.isStatus());
                    daos.FeedbackServiceDAO.update(fb);
                }
                response.sendRedirect("admin?action=getFeedbacks&serviceID=" + serviceID);
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
            case "checkFeedbackStatus" ->
                checkFeedbackStatusAction(request, response);
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "submitFeedback" ->
                submitFeedbackAction(request, response);
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
    
    private void checkFeedbackStatusAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();
            
            Booking booking = BookingDAO.getById(bookingId);
            if (booking == null || booking.getUserID() != userId) {
                out.print("{\"success\": false, \"message\": \"Access denied\"}");
                return;
            }
            
            if (!"FINISHED".equals(booking.getState())) {
                out.print("{\"success\": false, \"message\": \"Can only provide feedback for completed bookings\"}");
                return;
            }
            
            List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(bookingId);
            List<Map<String, Object>> servicesWithoutFeedback = new ArrayList<>();
            
            for (BookingDetail detail : bookingDetails) {
                boolean hasFeedback = FeedbackServiceDAO.existsByBookingAndService(bookingId, detail.getServiceID());
                
                if (!hasFeedback) {
                    Service service = ServiceDAO.getById(detail.getServiceID());
                    Map<String, Object> serviceInfo = new HashMap<>();
                    serviceInfo.put("bookingDetailId", detail.getBookingDetailID());
                    serviceInfo.put("serviceId", detail.getServiceID());
                    serviceInfo.put("serviceName", service.getName());
                    serviceInfo.put("serviceImage", service.getImgURL());
                    servicesWithoutFeedback.add(serviceInfo);
                }
            }
            
            Map<String, Object> result = new HashMap<>();
            result.put("success", true);
            result.put("canProvideFeedback", !servicesWithoutFeedback.isEmpty());
            result.put("servicesWithoutFeedback", servicesWithoutFeedback);
            
            out.print(new Gson().toJson(result));
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error checking feedback status\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void submitFeedbackAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");
            
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();
            
            // Kiểm tra quyền truy cập
            Booking booking = BookingDAO.getById(bookingId);
            if (booking == null || booking.getUserID() != userId) {
                out.print("{\"success\": false, \"message\": \"Access denied\"}");
                return;
            }
            
            // Kiểm tra booking đã hoàn thành
            if (!"FINISHED".equals(booking.getState())) {
                out.print("{\"success\": false, \"message\": \"Can only provide feedback for completed bookings\"}");
                return;
            }
            
            // Kiểm tra đã có feedback chưa
            boolean hasFeedback = FeedbackServiceDAO.existsByBookingAndService(bookingId, serviceId);
            if (hasFeedback) {
                out.print("{\"success\": false, \"message\": \"Feedback already exists for this service in this booking\"}");
                return;
            }
            
            // Validate rating
            if (rating < 1 || rating > 5) {
                out.print("{\"success\": false, \"message\": \"Rating must be between 1 and 5\"}");
                return;
            }
            
            // Tạo feedback mới
            FeedbackService feedback = new FeedbackService();
            feedback.setUserID(userId);
            feedback.setBookingID(bookingId);
            feedback.setServiceID(serviceId);
            feedback.setRating(rating);
            feedback.setComment(comment != null ? comment.trim() : "");
            feedback.setDateCreated(LocalDateTime.now());
            feedback.setStatus(true);
            
            boolean success = FeedbackServiceDAO.create(feedback);
            
            if (success) {
                out.print("{\"success\": true, \"message\": \"Feedback submitted successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to submit feedback\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error submitting feedback: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}
