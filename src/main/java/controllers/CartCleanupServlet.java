/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import daos.BookingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import models.Booking;

/**
 *
 * @author PC
 */
public class CartCleanupServlet extends HttpServlet {

    private ScheduledExecutorService scheduler;
    
    @Override
    public void init() throws ServletException {
        super.init();
        
        // Tạo scheduler với một thread
        scheduler = Executors.newScheduledThreadPool(1);
        
        // Lên lịch cho task chạy mỗi 1 phút
        scheduler.scheduleAtFixedRate(() -> {
            try {
                cleanupExpiredCarts();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }, 0, 1, TimeUnit.MINUTES);
        
        System.out.println("Cart cleanup scheduler initialized.");
    }
    
    private void cleanupExpiredCarts() {
        try {
            // Lấy tất cả booking có trạng thái CART
            List<Booking> cartBookings = BookingDAO.getByState(Booking.BookingState.CART.toString());
            
            // Thời gian hiện tại
            LocalDateTime now = LocalDateTime.now();
            
            for (Booking booking : cartBookings) {
                // Kiểm tra nếu booking đã được tạo hơn 15 phút
                if (booking.dateBooked.plusMinutes(15).isBefore(now)) {
                    System.out.println("Changing expired cart ID " + booking.getBookingID() + " from CART to CANCEL");
                    booking.setState(Booking.BookingState.CANCEL.toString());
                    BookingDAO.update(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public void destroy() {
        // Dừng scheduler khi servlet bị hủy
        if (scheduler != null && !scheduler.isShutdown()) {
            scheduler.shutdown();
            System.out.println("Cart cleanup scheduler shutdown.");
        }
        super.destroy();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.getWriter().write("Cart cleanup service is running.");
    }

}
