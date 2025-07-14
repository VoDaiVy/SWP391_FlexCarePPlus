package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import daos.BookingDAO;
import daos.BookingDetailDAO;
import daos.RoomDAO;
import daos.ServiceDAO;
import models.Booking;
import models.BookingDetail;
import models.Room;
import dtos.BookingDetailDTO;
import java.util.List;
import java.util.Date;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import models.Service;

public class BookingDetailController extends HttpServlet {

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
            case "getBookingDetails" -> {
                int bookingID = Integer.parseInt(request.getParameter("bookingID"));
                List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(bookingID);
                Map<Integer, Service> services = ServiceDAO.getByBookingDetails(bookingID);
                Booking booking = BookingDAO.getById(bookingID);
                request.setAttribute("bookingDetails", bookingDetails);
                request.setAttribute("services", services);
                request.setAttribute("booking", booking);
                request.getRequestDispatcher("adminPages/bookingDetails.jsp").forward(request, response);
            }
        }
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            int serviceID = Integer.parseInt(request.getParameter("serviceID"));
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            
            // Parse dates properly from form
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            LocalDateTime startDate = null;
            LocalDateTime endDate = null;
            
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDateTime.parse(startDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDateTime.parse(endDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            float price = Float.parseFloat(request.getParameter("price"));
            
            BookingDetail bookingDetail = new BookingDetail();
            bookingDetail.setBookingID(bookingID);
            bookingDetail.setServiceID(serviceID);
            bookingDetail.setRoomID(roomID);
            bookingDetail.dateStartService = startDate;
            bookingDetail.dateEndService = endDate;
            bookingDetail.setUserPetID(userPetID);
            bookingDetail.setPrice(price);
            
            boolean success = BookingDetailDAO.create(bookingDetail);
            
            if (success) {
                // Update the booking total price
                updateBookingTotalPrice(bookingID);
                response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingID);
            } else {
                request.setAttribute("error", "Failed to create booking detail");
                request.setAttribute("bookingID", bookingID);
                request.getRequestDispatcher("/admin/bookingdetail/add.jsp").forward(request, response);
            }
        }
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            int bookingDetailID = Integer.parseInt(request.getParameter("bookingDetailID"));
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            int serviceID = Integer.parseInt(request.getParameter("serviceID"));
            int roomID = Integer.parseInt(request.getParameter("roomID"));
            
            // Parse dates properly from form
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            LocalDateTime startDate = null;
            LocalDateTime endDate = null;
            
            if (startDateStr != null && !startDateStr.isEmpty()) {
                startDate = LocalDateTime.parse(startDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            
            if (endDateStr != null && !endDateStr.isEmpty()) {
                endDate = LocalDateTime.parse(endDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            }
            
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            float price = Float.parseFloat(request.getParameter("price"));
            
            BookingDetail bookingDetail = BookingDetailDAO.getById(bookingDetailID);
            bookingDetail.setServiceID(serviceID);
            bookingDetail.setRoomID(roomID);
            bookingDetail.dateStartService = startDate;
            bookingDetail.dateEndService = endDate;
            bookingDetail.setUserPetID(userPetID);
            bookingDetail.setPrice(price);
            
            boolean success = BookingDetailDAO.update(bookingDetail);
            
            if (success) {
                // Update the booking total price
                updateBookingTotalPrice(bookingID);
                response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingID);
            } else {
                request.setAttribute("error", "Failed to update booking detail");
                request.setAttribute("bookingDetail", bookingDetail);
                request.getRequestDispatcher("/admin/bookingdetail/edit.jsp").forward(request, response);
            }
        }
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingDetailID = Integer.parseInt(request.getParameter("bookingDetailID"));
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        
        boolean success = BookingDetailDAO.delete(bookingDetailID);
        
        if (success) {
            // Update the booking total price
            updateBookingTotalPrice(bookingID);
            response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingID);
        } else {
            request.setAttribute("error", "Failed to delete booking detail");
            response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingID);
        }
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");
        
        if ("add".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            
            // Security check - only allow adding details to own bookings
            Booking booking = BookingDAO.getById(bookingID);
            if (booking != null && booking.getUserID() == userID) {
                List<Room> rooms = RoomDAO.getAll();
                request.setAttribute("bookingID", bookingID);
                request.setAttribute("rooms", rooms);
                request.getRequestDispatcher("/client/bookingdetail/add.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/booking");
            }
        } else if ("view".equals(action)) {
            int bookingDetailID = Integer.parseInt(request.getParameter("bookingDetailID"));
            BookingDetail bookingDetail = BookingDetailDAO.getById(bookingDetailID);
            
            if (bookingDetail != null) {
                Booking booking = BookingDAO.getById(bookingDetail.getBookingID());
                
                // Security check - only allow viewing details of own bookings
                if (booking != null && booking.getUserID() == userID) {
                    request.setAttribute("bookingDetail", bookingDetail);
                    request.getRequestDispatcher("/client/bookingdetail/view.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/booking");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/booking");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/booking");
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");
        
        if ("create".equals(action)) {
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));
            
            // Security check - only allow adding details to own bookings
            Booking booking = BookingDAO.getById(bookingID);
            if (booking != null && booking.getUserID() == userID) {
                int serviceID = Integer.parseInt(request.getParameter("serviceID"));
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                
                // Parse dates properly from form
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                LocalDateTime startDate = null;
                LocalDateTime endDate = null;
                
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = LocalDateTime.parse(startDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                }
                
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = LocalDateTime.parse(endDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                }
                
                int userPetID = Integer.parseInt(request.getParameter("userPetID"));
                float price = Float.parseFloat(request.getParameter("price"));
                
                BookingDetail bookingDetail = new BookingDetail();
                bookingDetail.setBookingID(bookingID);
                bookingDetail.setServiceID(serviceID);
                bookingDetail.setRoomID(roomID);
                bookingDetail.dateStartService = startDate;
                bookingDetail.dateEndService = endDate;
                bookingDetail.setUserPetID(userPetID);
                bookingDetail.setPrice(price);
                
                boolean success = BookingDetailDAO.create(bookingDetail);
                
                if (success) {
                    // Update the booking total price
                    updateBookingTotalPrice(bookingID);
                    response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingID);
                } else {
                    request.setAttribute("error", "Failed to add service");
                    request.setAttribute("bookingID", bookingID);
                    request.getRequestDispatcher("/client/bookingdetail/add.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/booking");
            }
        }
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Customers typically don't update booking details directly
        response.sendRedirect(request.getContextPath() + "/booking");
    }

    private void customerDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingDetailID = Integer.parseInt(request.getParameter("bookingDetailID"));
        int userID = (int) request.getSession().getAttribute("userID");
        
        BookingDetail bookingDetail = BookingDetailDAO.getById(bookingDetailID);
        
        if (bookingDetail != null) {
            Booking booking = BookingDAO.getById(bookingDetail.getBookingID());
            
            // Security check - only allow deleting details of own bookings
            if (booking != null && booking.getUserID() == userID && "pending".equals(booking.getState())) {
                boolean success = BookingDetailDAO.delete(bookingDetailID);
                
                if (success) {
                    // Update the booking total price
                    updateBookingTotalPrice(booking.getBookingID());
                }
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/booking");
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String dateParam = request.getParameter("date");
        java.time.LocalDate date;
        if (dateParam == null || dateParam.isEmpty()) {
            date = java.time.LocalDate.now();
        } else {
            date = java.time.LocalDate.parse(dateParam);
        }
        List<Service> services = ServiceDAO.getAll();
        List<BookingDetail> bookingDetails = BookingDetailDAO.getByDate(date);
        request.setAttribute("services", services);
        request.setAttribute("bookingDetails", bookingDetails);
        request.setAttribute("selectedDate", date.toString());
        request.getRequestDispatcher("/staff/managePage.jsp").forward(request, response);
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Staff typically doesn't create booking details directly
        response.sendRedirect(request.getContextPath() + "/booking");
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            int bookingDetailID = Integer.parseInt(request.getParameter("bookingDetailID"));
            BookingDetail bookingDetail = BookingDetailDAO.getById(bookingDetailID);
            
            if (bookingDetail != null) {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                
                // Parse dates properly from form
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");
                LocalDateTime startDate = null;
                LocalDateTime endDate = null;
                
                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = LocalDateTime.parse(startDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                }
                
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = LocalDateTime.parse(endDateStr, DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
                }
                
                bookingDetail.setRoomID(roomID);
                bookingDetail.dateStartService = startDate;
                bookingDetail.dateEndService = endDate;
                
                boolean success = BookingDetailDAO.update(bookingDetail);
                
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/booking?action=view&bookingID=" + bookingDetail.getBookingID());
                } else {
                    request.setAttribute("error", "Failed to update booking detail");
                    request.setAttribute("bookingDetail", bookingDetail);
                    request.getRequestDispatcher("/staff/bookingdetail/edit.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/booking");
            }
        }
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Staff typically doesn't delete booking details directly
        response.sendRedirect(request.getContextPath() + "/booking");
    }
    
    // Helper methods
    private void updateBookingTotalPrice(int bookingID) {
        List<BookingDetail> details = BookingDetailDAO.getByBookingId(bookingID);
        double totalPrice = 0;
        
        for (BookingDetail detail : details) {
            totalPrice += detail.getPrice();
        }
        
        Booking booking = BookingDAO.getById(bookingID);
        booking.setTotalPrice((float) totalPrice);
        BookingDAO.update(booking);
    }
}
