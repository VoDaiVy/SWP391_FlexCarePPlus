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
                cleanupExpiredPendingPayments();
                autoFinishCompletedBookings();
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

    private void cleanupExpiredPendingPayments() {
        try {
            List<Booking> pendingPaymentBookings = BookingDAO.getByState(Booking.BookingState.PENDINGPAYMENT.toString());

            LocalDateTime now = LocalDateTime.now();

            for (Booking booking : pendingPaymentBookings) {
                if (booking.dateBooked.plusMinutes(5).isBefore(now)) {
                    System.out.println("Auto-cancelling expired pending payment booking ID " + booking.getBookingID()
                            + " (created: " + booking.getDateBooked() + ", timeout: 5 minutes)");
                    booking.setState(Booking.BookingState.CANCEL.toString());
                    BookingDAO.update(booking);
                }
            }
        } catch (Exception e) {
            System.err.println("Error in cleanupExpiredPendingPayments: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private void autoFinishCompletedBookings() {
        try {
            // Lấy danh sách booking IDs đã hoàn thành
            List<Integer> completedBookingIds = daos.BookingDetailDAO.getCompletedBookedBookings();

            if (!completedBookingIds.isEmpty()) {
                // Update state từ BOOKED sang FINISHED
                int updatedCount = daos.BookingDAO.updateCompletedBookingsToFinished(completedBookingIds);

                if (updatedCount > 0) {
                    System.out.println("Auto-finished " + updatedCount + " completed bookings: " + completedBookingIds);
                }
            }

        } catch (Exception e) {
            System.err.println("Error in autoFinishCompletedBookings: " + e.getMessage());
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
