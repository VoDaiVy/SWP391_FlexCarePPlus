package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import daos.BookingDAO;
import daos.BookingDetailDAO;
import models.Booking;
import models.BookingDetail;
import dtos.BookingDTO;
import java.util.List;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class BookingController extends HttpServlet {

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
        
        if (action == null || action.isEmpty()) {
            List<Booking> bookings = BookingDAO.getAll();
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/admin/booking/list.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            Booking booking = BookingDAO.getById(bookingID);
            List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(bookingID);
            request.setAttribute("booking", booking);
            request.setAttribute("bookingDetails", bookingDetails);
            request.getRequestDispatcher("/admin/booking/view.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            request.getRequestDispatcher("/admin/booking/add.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            Booking booking = BookingDAO.getById(bookingID);
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/admin/booking/edit.jsp").forward(request, response);
        }
    }    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            int userID = Integer.parseInt(request.getParameter("userID"));
            LocalDateTime bookingDate = LocalDateTime.now(); // Current date
            String status = request.getParameter("status");
            float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));
              Booking booking = new Booking();
            booking.setUserID(userID);
            booking.setDateBooked(bookingDate);
            booking.setState(status);
            booking.setStatus(true); // Active booking
            booking.setTotalPrice(totalPrice);
            
            boolean success = BookingDAO.create(booking);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/booking");
            } else {
                request.setAttribute("error", "Failed to create booking");
                request.getRequestDispatcher("/admin/booking/add.jsp").forward(request, response);
            }
        }
    }    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            String state = request.getParameter("state");
            float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));
            
            Booking booking = BookingDAO.getById(bookingID);
            booking.setUserID(userID);
            booking.setState(state);
            booking.setTotalPrice(totalPrice);
            
            boolean success = BookingDAO.update(booking);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/booking");
            } else {
                request.setAttribute("error", "Failed to update booking");
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("/admin/booking/edit.jsp").forward(request, response);
            }
        }
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        boolean success = BookingDAO.delete(bookingID);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/booking");
        } else {
            request.setAttribute("error", "Failed to delete booking");
            response.sendRedirect(request.getContextPath() + "/booking");
        }
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");
        
        if (action == null || action.isEmpty()) {
            List<Booking> bookings = BookingDAO.getByUserId(userID);
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/client/booking/list.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            Booking booking = BookingDAO.getById(bookingID);
            
            // Security check - only allow viewing own bookings
            if (booking != null && booking.getUserID() == userID) {
                List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(bookingID);
                request.setAttribute("booking", booking);
                request.setAttribute("bookingDetails", bookingDetails);
                request.getRequestDispatcher("/client/booking/view.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/booking");
            }
        } else if ("add".equals(action)) {
            request.getRequestDispatcher("/client/booking/add.jsp").forward(request, response);
        }
    }    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");
        
        if ("create".equals(action)) {
            LocalDateTime bookingDate = LocalDateTime.now(); // Current date
            String status = "pending"; // Default status for customer bookings
            float totalPrice = Float.parseFloat(request.getParameter("totalPrice"));
              Booking booking = new Booking();
            booking.setUserID(userID); // Use session userID for security
            booking.setDateBooked(bookingDate);
            booking.setState(status);
            booking.setStatus(true); // Active booking
            booking.setTotalPrice(totalPrice);
            
            boolean success = BookingDAO.create(booking);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/booking");
            } else {
                request.setAttribute("error", "Failed to create booking");
                request.getRequestDispatcher("/client/booking/add.jsp").forward(request, response);
            }
        }
    }    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");
        
        if ("cancel".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            Booking booking = BookingDAO.getById(bookingID);
            
            // Security check - only allow canceling own bookings
            if (booking != null && booking.getUserID() == userID) {
                booking.setState("canceled");
                
                boolean success = BookingDAO.update(booking);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/booking");
                } else {
                    request.setAttribute("error", "Failed to cancel booking");
                    response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingID);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/booking");
            }
        }
    }

    private void customerDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Customers typically don't delete bookings, just cancel them
        response.sendRedirect(request.getContextPath() + "/booking");
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
            List<Booking> bookings = BookingDAO.getAll();
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/staff/booking/list.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            Booking booking = BookingDAO.getById(bookingID);
            List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(bookingID);
            request.setAttribute("booking", booking);
            request.setAttribute("bookingDetails", bookingDetails);
            request.getRequestDispatcher("/staff/booking/view.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            Booking booking = BookingDAO.getById(bookingID);
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("/staff/booking/edit.jsp").forward(request, response);
        }
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Staff typically doesn't create new bookings
        response.sendRedirect(request.getContextPath() + "/booking");
    }    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("updateStatus".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            String state = request.getParameter("state");
            
            Booking booking = BookingDAO.getById(bookingID);
            booking.setState(state);
            
            boolean success = BookingDAO.update(booking);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/booking");
            } else {
                request.setAttribute("error", "Failed to update booking status");
                response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingID);
            }
        }
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Staff typically doesn't delete bookings
        response.sendRedirect(request.getContextPath() + "/booking");
    }
}
