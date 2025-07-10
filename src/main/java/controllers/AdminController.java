package controllers;

import daos.BookingDetailDAO;
import daos.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            getDashBoard(request, response);
        } else {
            switch (action) {
                case "getUsers" -> {
                    request.getRequestDispatcher("user").forward(request, response);
                }
                case "getUserDetail" -> {
                    request.getRequestDispatcher("user").forward(request, response);
                }
                case "getNotifications" -> {
                    request.getRequestDispatcher("notification").forward(request, response);
                }
                case "getPolicies" -> {
                    request.getRequestDispatcher("policy").forward(request, response);
                }
                case "getPolicyDetail" -> {
                    request.getRequestDispatcher("policy").forward(request, response);
                }
                case "getCategoryServices" -> {
                    request.getRequestDispatcher("categoryservice").forward(request, response);
                }
                case "getServices" -> {
                    request.getRequestDispatcher("service").forward(request, response);
                }
                case "getServiceDetail" -> {
                    request.getRequestDispatcher("service").forward(request, response);
                }
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "createNotification" -> {
                request.getRequestDispatcher("notification").forward(request, response);
            }
            case "deleteNotification" -> {
                request.getRequestDispatcher("notification").forward(request, response);
            }
            case "banUser" -> {
                request.getRequestDispatcher("user").forward(request, response);
            }
            case "allowUser" -> {
                request.getRequestDispatcher("user").forward(request, response);
            }
            case "updatePolicy" -> {
                request.getRequestDispatcher("policy").forward(request, response);
            }
            case "createPolicy" -> {
                request.getRequestDispatcher("policy").forward(request, response);
            }
            case "deletePolicy" -> {
                request.getRequestDispatcher("policy").forward(request, response);
            }
            case "createCategoryService" -> {
                request.getRequestDispatcher("categoryservice").forward(request, response);
            }
            case "updateCategoryService" -> {
                request.getRequestDispatcher("categoryservice").forward(request, response);
            }
            case "deleteCategoryService" -> {
                request.getRequestDispatcher("categoryservice").forward(request, response);
            }
        }
    }

    private void getDashBoard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. Lấy tháng và năm từ request, nếu không có thì lấy tháng/năm hiện tại
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");
        java.time.LocalDate now = java.time.LocalDate.now();
        int month = (monthParam != null && !monthParam.isEmpty()) ? Integer.parseInt(monthParam) : now.getMonthValue();
        int year = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : now.getYear();

        // 2. Lấy danh sách booking trong tháng/năm đó từ DAO
        java.util.List<models.Booking> bookings = daos.BookingDAO.getByMonthYear(month, year);
        int daysInMonth = java.time.Month.of(month).length(java.time.Year.isLeap(year));
        // Khởi tạo mảng mặc định 0 cho từng ngày trong tháng
        float[] revenueByDay = new float[daysInMonth];
        for (int i = 0; i < daysInMonth; i++) {
            revenueByDay[i] = 0;
        }

        float totalRevenue = 0;
        for (models.Booking booking : bookings) {
            if (booking.dateBooked != null) {
                int day = booking.dateBooked.getDayOfMonth();
                if (day >= 1 && day <= daysInMonth) {
                    revenueByDay[day - 1] += booking.getTotalPrice();
                    totalRevenue += booking.getTotalPrice();
                }
            }
        }

        // 3. Format data thành chuỗi JS array, đảm bảo đủ số ngày trong tháng
        StringBuilder revenueData = new StringBuilder();
        for (int i = 0; i < daysInMonth; i++) {
            if (i > 0) {
                revenueData.append(",");
            }
            revenueData.append((int) revenueByDay[i]);
        }
        request.setAttribute("revenueData", revenueData.toString());
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);
        request.setAttribute("totalRevenue", (int) totalRevenue);

        // 4. Đếm số lượng booking và user
        int numUsers = UserDAO.countCustomers();
        int numBookings = BookingDetailDAO.countBooking(); // Số lượng booking trong tháng/năm đã chọn
        request.setAttribute("numUsers", numUsers);
        request.setAttribute("numBookings", numBookings);
        request.getRequestDispatcher("adminPages/homepage.jsp").forward(request, response);
    }
}
