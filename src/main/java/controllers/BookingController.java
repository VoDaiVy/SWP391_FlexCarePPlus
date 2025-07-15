package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import daos.BookingDAO;
import daos.BookingDetailDAO;
import models.BookingDetail;
import java.util.List;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import daos.RoomDAO;
import daos.ServiceDAO;
import daos.UserDAO;
import daos.UserDetailDAO;
import daos.WalletDAO;
import dtos.BookingDetailDTO;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;
import java.util.Map;
import models.Room;
import dtos.UserDetailDTO;
import models.Booking;
import models.User;
import models.UserDetail;
import models.Service;
import models.Wallet;
import utils.Common;

public class BookingController extends HttpServlet {

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
        String action = request.getParameter("action");

        switch (action) {
            case "getBookings" -> {
                String selectedDate = request.getParameter("selectedDate");
                LocalDate date;
                if (selectedDate == null || selectedDate.isEmpty()) {
                    date = LocalDate.now();
                    selectedDate = date.toString();
                } else {
                    date = LocalDate.parse(selectedDate);
                }
                int day = date.getDayOfMonth();
                int month = date.getMonthValue();
                int year = date.getYear();

                List<Booking> bookings = BookingDAO.getByDate(day, month, year);
                Map<Integer, User> users = UserDAO.adminGetByBookingID(day, month, year);
                Map<Integer, UserDetail> userDetails = UserDetailDAO.adminGetByBookingID(day, month, year);

                request.setAttribute("bookings", bookings);
                request.setAttribute("users", users);
                request.setAttribute("userDetails", userDetails);
                request.setAttribute("selectedDate", selectedDate);
                request.getRequestDispatcher("adminPages/bookings.jsp").forward(request, response);
            }
        }
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
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
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
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
        UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
        int userID = userDetailDTO.getUser().getUserId();

        if (action == null || action.isEmpty()) {
            List<Booking> bookings = BookingDAO.getByUserId(userID);
            request.setAttribute("bookings", bookings);
            request.getRequestDispatcher("/client/booking/list.jsp").forward(request, response);
        } else if ("viewBooking".equals(action)) {
            viewBookingAction(request, response);
        } else if ("viewBookingDetail".equals(action)) {
            viewBookingDetailAction(request, response);
        } else if ("viewBookingDetailHTML".equals(action)) {
            viewBookingDetailActionHTML(request, response);
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
        } else if ("getTimeAvaliable".equals(action)) {
            getTimeAvailableAction(request, response);
        } else if ("addToCart".equals(action)) {
            addToCartAction(request, response);
        } else if ("viewCart".equals(action)) {
            viewCartAction(request, response);
        } else if ("removeFromCart".equals(action)) {
            removeFromCartAction(request, response);
        } else if ("getCartCount".equals(action)) {
            getCartCountAction(request, response);
        }
    }

    // Phương thức để xử lý việc lấy thời gian bận (không đặt được)
    private void getTimeAvailableAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String dateStr = request.getParameter("date");
            int categoryServiceId = Integer.parseInt(request.getParameter("categoryServiceId"));

            LocalDate date = LocalDate.parse(dateStr);

            List<Room> rooms = RoomDAO.getByCategoryServiceId(categoryServiceId);

            List<BookingDetail> bookingDetails = BookingDetailDAO.getByDateAndStates(
                    date,
                    new String[]{Booking.BookingState.BOOKED.toString(), Booking.BookingState.CART.toString(), Booking.BookingState.NEXTBOOKING.toString(), Booking.BookingState.PENDINGPAYMENT.toString()}
            );

            Map<String, Set<Integer>> timeSlotBusyRooms = new HashMap<>();

            // Với mỗi booking detail, đánh dấu phòng bận trong khoảng thời gian tương ứng
            for (BookingDetail detail : bookingDetails) {
                // Kiểm tra nếu room thuộc danh sách các phòng phục vụ cho category service
                boolean roomInCategory = false;
                for (Room room : rooms) {
                    if (room.getRoomID() == detail.getRoomID()) {
                        roomInCategory = true;
                        break;
                    }
                }

                if (roomInCategory && detail.startTime != null && detail.endTime != null) {
                    // Tạo key cho khoảng thời gian này
                    String timeRange = detail.startTime.format(DateTimeFormatter.ofPattern("HH:mm"))
                            + "-" + detail.endTime.format(DateTimeFormatter.ofPattern("HH:mm"));

                    // Thêm room ID vào set các phòng bận trong khoảng thời gian này
                    timeSlotBusyRooms.computeIfAbsent(timeRange, k -> new HashSet<>())
                            .add(detail.getRoomID());
                }
            }

            // Tạo danh sách các khoảng thời gian bận (chỉ khi TẤT CẢ phòng đều bận)
            List<Map<String, String>> busyTimeRanges = new ArrayList<>();

            for (Map.Entry<String, Set<Integer>> entry : timeSlotBusyRooms.entrySet()) {
                // Chỉ thêm vào danh sách bận nếu số phòng bận >= tổng số phòng có thể phục vụ
                if (entry.getValue().size() >= rooms.size()) {
                    String[] timeParts = entry.getKey().split("-");
                    Map<String, String> busyRange = new HashMap<>();
                    busyRange.put("start", timeParts[0]);
                    busyRange.put("end", timeParts[1]);
                    busyTimeRanges.add(busyRange);
                }
            }

            // Trả về object chứa thông tin cần thiết
            Map<String, Object> result = new HashMap<>();
            result.put("busyTimeRanges", busyTimeRanges);
            result.put("workingHours", "08:00-17:30");
            result.put("totalRooms", rooms.size());

            out.print(new com.google.gson.Gson().toJson(result));

        } catch (Exception e) {
            // Trả về JSON rỗng nếu có lỗi
            out.print("{\"busyTimeRanges\":[], \"workingHours\":\"08:00-17:30\", \"totalRooms\":0}");
            e.printStackTrace();
        } finally {
            out.flush();
            out.close();
        }
    }

    // Phương thức để xử lý việc thêm vào giỏ hàng
    private void addToCartAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            // Lấy thông tin từ request
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String dateStr = request.getParameter("bookingDate");
            String timeStr = request.getParameter("bookingTime");
            int userPetId = Integer.parseInt(request.getParameter("userPetId"));
            String note = request.getParameter("note");

            // Parse ngày và giờ
            LocalDate bookingDate = LocalDate.parse(dateStr);
            LocalTime bookingTime = LocalTime.parse(timeStr);

            LocalDateTime now = LocalDateTime.now();
            LocalDateTime bookingDateTime = LocalDateTime.of(bookingDate, bookingTime);
            LocalDateTime minAllowedTime = now.plusMinutes(30);

            if (bookingDateTime.isBefore(minAllowedTime)) {
                out.print("{\"success\": false, \"message\": \"Booking time must be at least 30 minutes from now to allow preparation time.\"}");
                return;
            }

            // Lấy thông tin người dùng hiện tại
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            // Lấy thông tin dịch vụ
            models.Service service = ServiceDAO.getById(serviceId);
            float servicePrice = service.getPrice();

            // Tính thời gian kết thúc dịch vụ
            LocalTime endTime = bookingTime.plusMinutes(service.getTime());

            boolean isPetBusy = BookingDetailDAO.isPetBusy(userPetId, bookingDate, bookingTime, endTime,
                    new String[]{Booking.BookingState.BOOKED.toString(), Booking.BookingState.CART.toString(),
                        Booking.BookingState.NEXTBOOKING.toString(), Booking.BookingState.PENDINGPAYMENT.toString()});

            if (isPetBusy) {
                out.print("{\"success\": false, \"message\": \"Pet is already scheduled for another service at this time. Please select a different time or pet.\"}");
                return;
            }

            // Kiểm tra xem đã có giỏ hàng (booking với state="CART") cho user này chưa
            List<Booking> userCarts = BookingDAO.getByUserIdAndState(userId, Booking.BookingState.CART.toString());
            Booking cartBooking;

            if (userCarts.isEmpty()) {
                // Tạo booking mới với state là CART
                cartBooking = new Booking();
                cartBooking.setUserID(userId);
                cartBooking.setDateBooked(LocalDateTime.now());
                cartBooking.setState(Booking.BookingState.CART.toString());
                cartBooking.setStatus(true);
                cartBooking.setTotalPrice(servicePrice);
                cartBooking.setNote(note);

                // Lưu booking vào database và lấy ID
                boolean success = BookingDAO.create(cartBooking);
                if (!success) {
                    out.print("{\"success\": false, \"message\": \"Failed to create cart booking\"}");
                    return;
                }

                List<Booking> newUserCarts = BookingDAO.getByUserIdAndState(userId, Booking.BookingState.CART.toString());
                if (newUserCarts.isEmpty()) {
                    out.print("{\"success\": false, \"message\": \"Failed to retrieve cart booking\"}");
                    return;
                }
                cartBooking = newUserCarts.get(0);
            } else {
                // Sử dụng cart booking đã có
                cartBooking = userCarts.get(0);

                // Cập nhật tổng giá
                cartBooking.setTotalPrice(cartBooking.getTotalPrice() + servicePrice);
                cartBooking.setDateBooked(now);
                BookingDAO.update(cartBooking);
            }

            // Tạo booking detail cho service đã chọn
            BookingDetail bookingDetail = new BookingDetail();
            bookingDetail.setBookingID(cartBooking.getBookingID());
            bookingDetail.setServiceID(serviceId);

            // Tìm phòng phù hợp với service và còn trống trong khung giờ đã chọn
            List<Room> availableRooms = RoomDAO.getByCategoryServiceId(service.getCategoryServiceID());
            List<BookingDetail> bookingDetails = BookingDetailDAO.getByDateAndStates(
                    bookingDate,
                    new String[]{Booking.BookingState.BOOKED.toString(), Booking.BookingState.CART.toString(),
                        Booking.BookingState.NEXTBOOKING.toString(), Booking.BookingState.PENDINGPAYMENT.toString()}
            );

            int selectedRoomId = -1;
            for (Room room : availableRooms) {
                boolean isRoomAvailable = true;
                for (BookingDetail detail : bookingDetails) {
                    if (detail.getRoomID() == room.getRoomID()
                            && detail.startTime != null && detail.endTime != null) {

                        boolean isOverlap = (bookingTime.isBefore(detail.endTime)
                                && endTime.isAfter(detail.startTime));

                        if (isOverlap) {
                            isRoomAvailable = false;
                            break;
                        }
                    }
                }

                if (isRoomAvailable) {
                    selectedRoomId = room.getRoomID();
                    break;
                }
            }

            if (selectedRoomId == -1) {
                out.print("{\"success\": false, \"message\": \"No room available for selected time slot\"}");
                return;
            }

            // Thiết lập thông tin cho booking detail
            bookingDetail.setRoomID(selectedRoomId);
            bookingDetail.setStockBooking(1); // Giá trị mặc định nếu không dùng
            LocalDateTime startDateTime = LocalDateTime.of(bookingDate, bookingTime);
            bookingDetail.setDateStartService(startDateTime);
            LocalDateTime endDateTime = LocalDateTime.of(bookingDate, endTime);
            bookingDetail.setDateEndService(endDateTime);
            bookingDetail.setStartTime(bookingTime);
            bookingDetail.setEndTime(endTime);
            bookingDetail.setPrice(servicePrice);
            bookingDetail.setUserPetID(userPetId);

            boolean success = BookingDetailDAO.create(bookingDetail);

            if (success) {
                out.print("{\"success\": true, \"message\": \"Service added to cart successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to add service to cart\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"" + Common.escapeJsonString(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void addToCartLodgingAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String dateStr = request.getParameter("bookingDate");
            String timeStr = request.getParameter("bookingTime");
            int userPetId = Integer.parseInt(request.getParameter("userPetId"));
            String note = request.getParameter("note");
            int lodgingDays = Integer.parseInt(request.getParameter("lodgingDays"));

            if (lodgingDays < 1) {
                out.print("{\"success\": false, \"message\": \"Minimum stay is 1 day\"}");
                return;
            }

            LocalDate bookingDate = LocalDate.parse(dateStr);
            LocalTime bookingTime = LocalTime.parse(timeStr);

            LocalDateTime now = LocalDateTime.now();
            LocalDateTime bookingDateTime = LocalDateTime.of(bookingDate, bookingTime);
            LocalDateTime minAllowedTime = now.plusMinutes(30);

            if (bookingDateTime.isBefore(minAllowedTime)) {
                out.print("{\"success\": false, \"message\": \"Booking time must be at least 30 minutes from now to allow preparation time.\"}");
                return;
            }

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            models.Service service = ServiceDAO.getById(serviceId);
            float servicePrice = service.getPrice() * lodgingDays;

            LocalTime endTime = bookingTime; // Cùng thời gian nhưng ngày khác nhau

            // Tính toán ngày kết thúc
            LocalDate endDate = bookingDate.plusDays(lodgingDays);

            boolean isPetBusy = false;

            for (int i = 0; i < lodgingDays; i++) {
                LocalDate currentDate = bookingDate.plusDays(i);

                LocalTime currentStart, currentEnd;
                if (i == 0) { // Ngày đầu tiên
                    currentStart = bookingTime;
                    currentEnd = LocalTime.of(23, 59, 59);
                } else if (i == lodgingDays - 1) { // Ngày cuối cùng
                    currentStart = LocalTime.MIN;
                    currentEnd = endTime;
                } else { // Ngày ở giữa
                    currentStart = LocalTime.MIN;
                    currentEnd = LocalTime.of(23, 59, 59);
                }

                boolean busyOnThisDay = BookingDetailDAO.isPetBusyLodging(
                        userPetId,
                        currentDate,
                        currentStart,
                        currentEnd,
                        new String[]{
                            Booking.BookingState.BOOKED.toString(),
                            Booking.BookingState.CART.toString(),
                            Booking.BookingState.NEXTBOOKING.toString(),
                            Booking.BookingState.PENDINGPAYMENT.toString()
                        }
                );

                if (busyOnThisDay) {
                    isPetBusy = true;
                    break;
                }
            }

            if (isPetBusy) {
                out.print("{\"success\": false, \"message\": \"Pet is already scheduled for another service during the selected lodging period. Please select a different time or pet.\"}");
                return;
            }

            List<Booking> userCarts = BookingDAO.getByUserIdAndState(userId, Booking.BookingState.CART.toString());
            Booking cartBooking;

            if (userCarts.isEmpty()) {
                cartBooking = new Booking();
                cartBooking.setUserID(userId);
                cartBooking.setDateBooked(LocalDateTime.now());
                cartBooking.setState(Booking.BookingState.CART.toString());
                cartBooking.setStatus(true);
                cartBooking.setTotalPrice(servicePrice);
                cartBooking.setNote(note);

                boolean success = BookingDAO.create(cartBooking);
                if (!success) {
                    out.print("{\"success\": false, \"message\": \"Failed to create cart booking\"}");
                    return;
                }

                List<Booking> newUserCarts = BookingDAO.getByUserIdAndState(userId, Booking.BookingState.CART.toString());
                if (newUserCarts.isEmpty()) {
                    out.print("{\"success\": false, \"message\": \"Failed to retrieve cart booking\"}");
                    return;
                }
                cartBooking = newUserCarts.get(0);
            } else {
                cartBooking = userCarts.get(0);

                cartBooking.setTotalPrice(cartBooking.getTotalPrice() + servicePrice);
                cartBooking.setDateBooked(now);
                BookingDAO.update(cartBooking);
            }

            // Tạo booking detail cho service đã chọn
            BookingDetail bookingDetail = new BookingDetail();
            bookingDetail.setBookingID(cartBooking.getBookingID());
            bookingDetail.setServiceID(serviceId);

            List<Room> availableRooms = RoomDAO.getByCategoryServiceId(service.getCategoryServiceID());

            int selectedRoomId = -1;
            roomSearch:
            for (Room room : availableRooms) {
                for (int i = 0; i < lodgingDays; i++) {
                    LocalDate currentDate = bookingDate.plusDays(i);
                    List<BookingDetail> bookingDetails = BookingDetailDAO.getByDateAndStatesForBooking(
                            currentDate,
                            new String[]{
                                Booking.BookingState.BOOKED.toString(),
                                Booking.BookingState.CART.toString(),
                                Booking.BookingState.NEXTBOOKING.toString(),
                                Booking.BookingState.PENDINGPAYMENT.toString()
                            }
                    );

                    LocalTime currentStart, currentEnd;
                    if (i == 0) { // Ngày đầu tiên
                        currentStart = bookingTime;
                        currentEnd = LocalTime.of(23, 59, 59);
                    } else if (i == lodgingDays - 1) { // Ngày cuối cùng
                        currentStart = LocalTime.MIN;
                        currentEnd = endTime;
                    } else { // Ngày ở giữa
                        currentStart = LocalTime.MIN;
                        currentEnd = LocalTime.of(23, 59, 59);
                    }

                    LocalDateTime dateStart = LocalDateTime.of(currentDate, currentStart);
                    LocalDateTime dateEnd = LocalDateTime.of(currentDate, currentEnd);

                    for (BookingDetail detail : bookingDetails) {
                        if (detail.getRoomID() == room.getRoomID()
                                && detail.startTime != null && detail.endTime != null) {
                            LocalDateTime bookingStart = detail.dateStartService;
                            LocalDateTime bookingEnd = detail.dateEndService;
                            if (!(dateEnd.isBefore(bookingStart) || dateStart.isAfter(bookingEnd))) {
                                continue roomSearch; // Phòng này đã bận vào ngày nào đó, kiểm tra phòng tiếp theo
                            }
                        }
                    }
                }

                // Nếu đến được đây, phòng này khả dụng cho tất cả các ngày lưu trú
                selectedRoomId = room.getRoomID();
                break;
            }

            if (selectedRoomId == -1) {
                out.print("{\"success\": false, \"message\": \"No room available for the selected lodging period\"}");
                return;
            }

            // Thiết lập thông tin cho booking detail
            bookingDetail.setRoomID(selectedRoomId);
            bookingDetail.setStockBooking(lodgingDays);
            LocalDateTime startDateTime = LocalDateTime.of(bookingDate, bookingTime);
            bookingDetail.setDateStartService(startDateTime);
            LocalDateTime endDateTime = LocalDateTime.of(endDate, endTime);
            bookingDetail.setDateEndService(endDateTime);
            bookingDetail.setStartTime(bookingTime);
            bookingDetail.setEndTime(endTime);
            bookingDetail.setPrice(servicePrice);
            bookingDetail.setUserPetID(userPetId);

            boolean success = BookingDetailDAO.create(bookingDetail);

            if (success) {
                out.print("{\"success\": true, \"message\": \"Lodging service added to cart successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to add lodging service to cart\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"" + Common.escapeJsonString(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    // Phương thức để xem giỏ hàng
    private void viewCartAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin người dùng hiện tại
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            // Lấy booking có state="CART" của user
            List<Booking> userCarts = BookingDAO.getByUserIdAndState(userId, Booking.BookingState.CART.toString());

            if (userCarts.isEmpty()) {
                // Không có giỏ hàng, hiển thị giỏ hàng trống
                request.setAttribute("cartItems", null);
                request.setAttribute("totalPrice", 0.0f);
                request.getRequestDispatcher("/client/cart.jsp").forward(request, response);
                return;
            }

            // Lấy booking đầu tiên (giả sử mỗi user chỉ có một cart)
            Booking cartBooking = userCarts.get(0);

            // Lấy tất cả các chi tiết booking (dịch vụ trong giỏ hàng)
            List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(cartBooking.getBookingID());

            // Tạo danh sách các item trong giỏ hàng với thông tin đầy đủ
            List<BookingDetailDTO> cartItems = new ArrayList<>();

            for (BookingDetail detail : bookingDetails) {
                BookingDetailDTO detailDTO = new BookingDetailDTO(detail);
                cartItems.add(detailDTO);
            }

            // Đặt thuộc tính và chuyển hướng tới trang giỏ hàng
            request.setAttribute("cartItems", cartItems);
            request.setAttribute("cartBooking", cartBooking);
            request.getRequestDispatcher("/client/cart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải giỏ hàng: " + e.getMessage());
            request.getRequestDispatcher("/client/cart.jsp").forward(request, response);
        }
    }

    // Phương thức để xóa item khỏi giỏ hàng
    private void removeFromCartAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int bookingDetailId = Integer.parseInt(request.getParameter("bookingDetailId"));

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            BookingDetail bookingDetail = BookingDetailDAO.getById(bookingDetailId);

            // Kiểm tra security - chỉ cho phép xóa booking detail của mình
            Booking booking = BookingDAO.getById(bookingDetail.getBookingID());
            if (booking.getUserID() != userId || !Booking.BookingState.CART.toString().equals(booking.getState())) {
                out.print("{\"success\": false, \"message\": \"Unauthorized access\"}");
                return;
            }

            float servicePrice = bookingDetail.getPrice();

            boolean success = BookingDetailDAO.delete(bookingDetailId);

            if (success) {
                booking.setTotalPrice(booking.getTotalPrice() - servicePrice);
                BookingDAO.update(booking);

                List<BookingDetail> remainingDetails = BookingDetailDAO.getByBookingId(booking.getBookingID());
                if (remainingDetails.isEmpty()) {
                    booking.setState(Booking.BookingState.CANCEL.toString());
                    BookingDAO.update(booking);
                }

                out.print("{\"success\": true}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to remove item from cart\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error removing item from cart: " + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "addToCart" -> {
                String serviceType = request.getParameter("serviceType");
                if ("lodging".equals(serviceType)) {
                    addToCartLodgingAction(request, response);
                } else {
                    addToCartAction(request, response);
                }
            }
            case "bookService" -> {
                String serviceType = request.getParameter("serviceType");
                if ("lodging".equals(serviceType)) {
                    handleDirectLodgingBooking(request, response);
                } else {
                    handleDirectRegularBooking(request, response);
                }
            }
            case "removeFromCart" ->
                removeFromCartAction(request, response);
            case "updateCartPet" ->
                updateCartPetAction(request, response);
            case "updateLodgingCartPet" ->
                updateLodgingCartPetAction(request, response);
            case "cancelBooking" ->
                cancelBookingAction(request, response);
            case "payBooking" ->
                payBookingAction(request, response);
            case "checkout" ->
                checkoutAction(request, response);
        }
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
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
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
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

    private void getCartCountAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            if (userDetailDTO == null) {
                out.print("{\"count\": 0}");
                return;
            }

            int userId = userDetailDTO.getUser().getUserId();

            List<Booking> userCarts = BookingDAO.getByUserIdAndState(userId, Booking.BookingState.CART.toString());

            if (userCarts.isEmpty()) {
                out.print("{\"count\": 0}");
                return;
            }

            Booking cartBooking = userCarts.get(0);

            List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(cartBooking.getBookingID());
            int itemCount = bookingDetails.size();

            out.print("{\"count\": " + itemCount + "}");

        } catch (Exception e) {
            out.print("{\"count\": 0, \"error\": \"" + e.getMessage() + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void updateCartPetAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int bookingDetailId = Integer.parseInt(request.getParameter("bookingDetailId"));
            int userPetId = Integer.parseInt(request.getParameter("userPetId"));

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            BookingDetail bookingDetail = BookingDetailDAO.getById(bookingDetailId);

            if (bookingDetail == null) {
                out.print("{\"success\": false, \"message\": \"Booking detail not found\"}");
                return;
            }

            Booking booking = BookingDAO.getById(bookingDetail.getBookingID());

            if (booking.getUserID() != userId || !Booking.BookingState.CART.toString().equals(booking.getState())) {
                out.print("{\"success\": false, \"message\": \"Unauthorized access\"}");
                return;
            }

            // Kiểm tra xem pet mới có bị trùng lịch không
            LocalTime startTime = bookingDetail.startTime;
            LocalTime endTime = bookingDetail.endTime;
            LocalDate bookingDate = bookingDetail.dateStartService.toLocalDate();

            boolean isPetBusy = BookingDetailDAO.isPetBusy(userPetId, bookingDate, startTime, endTime,
                    new String[]{Booking.BookingState.BOOKED.toString(), Booking.BookingState.CART.toString(),
                        Booking.BookingState.NEXTBOOKING.toString(), Booking.BookingState.PENDINGPAYMENT.toString()},
                    bookingDetailId);  // Truyền bookingDetailId để loại trừ chính nó

            if (isPetBusy) {
                out.print("{\"success\": false, \"message\": \"This pet already has another appointment at the selected time\"}");
                return;
            }

            // Cập nhật pet ID cho booking detail
            bookingDetail.setUserPetID(userPetId);
            boolean success = BookingDetailDAO.update(bookingDetail);

            if (success) {
                out.print("{\"success\": true, \"message\": \"Pet updated successfully\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to update pet\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error updating pet: " + Common.escapeJsonString(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void updateLodgingCartPetAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int bookingDetailId = Integer.parseInt(request.getParameter("bookingDetailId"));
            int userPetId = Integer.parseInt(request.getParameter("userPetId"));

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            BookingDetail bookingDetail = BookingDetailDAO.getById(bookingDetailId);

            if (bookingDetail == null) {
                out.print("{\"success\": false, \"message\": \"Booking detail not found\"}");
                return;
            }

            Booking booking = BookingDAO.getById(bookingDetail.getBookingID());
            if (booking.getUserID() != userId || !Booking.BookingState.CART.toString().equals(booking.getState())) {
                out.print("{\"success\": false, \"message\": \"Unauthorized access\"}");
                return;
            }

            models.Service service = ServiceDAO.getById(bookingDetail.getServiceID());
            if (service == null || service.getCategoryServiceID() != 3) {
                out.print("{\"success\": false, \"message\": \"This is not a lodging service\"}");
                return;
            }

            LocalDate checkInDate = bookingDetail.dateStartService.toLocalDate();
            LocalDate checkOutDate = bookingDetail.dateEndService.toLocalDate();
            LocalTime checkInTime = bookingDetail.startTime;

            long lodgingDays = java.time.temporal.ChronoUnit.DAYS.between(checkInDate, checkOutDate);

            boolean isPetBusy = false;

            for (int i = 0; i <= lodgingDays; i++) {
                LocalDate currentDate = checkInDate.plusDays(i);

                LocalTime currentStart, currentEnd;
                if (i == 0) { // Ngày đầu tiên
                    currentStart = checkInTime;
                    currentEnd = LocalTime.of(23, 59, 59);
                } else if (i == lodgingDays - 1) { // Ngày cuối cùng
                    currentStart = LocalTime.MIN;
                    currentEnd = checkInTime;
                } else { // Ngày ở giữa
                    currentStart = LocalTime.MIN;
                    currentEnd = LocalTime.of(23, 59, 59);
                }

                boolean busyOnThisDay = BookingDetailDAO.isPetBusyLodging(
                        userPetId,
                        currentDate,
                        currentStart,
                        currentEnd,
                        new String[]{
                            Booking.BookingState.BOOKED.toString(),
                            Booking.BookingState.CART.toString(),
                            Booking.BookingState.NEXTBOOKING.toString(),
                            Booking.BookingState.PENDINGPAYMENT.toString()
                        },
                        bookingDetailId
                );

                if (busyOnThisDay) {
                    isPetBusy = true;
                    break;
                }
            }

            if (isPetBusy) {
                out.print("{\"success\": false, \"message\": \"This pet already has another appointment during the selected lodging period. Please select a different pet.\"}");
                return;
            }

            bookingDetail.setUserPetID(userPetId);
            boolean success = BookingDetailDAO.update(bookingDetail);

            if (success) {
                out.print("{\"success\": true, \"message\": \"Pet updated successfully for lodging service\"}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to update pet for lodging service\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"Error updating pet: " + Common.escapeJsonString(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void handleDirectLodgingBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String dateStr = request.getParameter("bookingDate");
            String timeStr = request.getParameter("bookingTime");
            int userPetId = Integer.parseInt(request.getParameter("userPetId"));
            String note = request.getParameter("note");
            int lodgingDays = Integer.parseInt(request.getParameter("lodgingDays"));

            if (lodgingDays < 1) {
                out.print("{\"success\": false, \"message\": \"Minimum stay is 1 day\"}");
                return;
            }

            LocalDate bookingDate = LocalDate.parse(dateStr);
            LocalTime bookingTime = LocalTime.parse(timeStr);

            LocalDateTime now = LocalDateTime.now();
            LocalDateTime bookingDateTime = LocalDateTime.of(bookingDate, bookingTime);
            LocalDateTime minAllowedTime = now.plusMinutes(30);

            if (bookingDateTime.isBefore(minAllowedTime)) {
                out.print("{\"success\": false, \"message\": \"Booking time must be at least 30 minutes from now to allow preparation time.\"}");
                return;
            }

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            models.Service service = ServiceDAO.getById(serviceId);
            float servicePrice = service.getPrice() * lodgingDays;

            LocalDate endDate = bookingDate.plusDays(lodgingDays);
            boolean isPetBusy = false;

            for (int i = 0; i < lodgingDays; i++) {
                LocalDate currentDate = bookingDate.plusDays(i);

                LocalTime currentStart, currentEnd;
                if (i == 0) { // Ngày đầu tiên
                    currentStart = bookingTime;
                    currentEnd = LocalTime.of(23, 59, 59);
                } else if (i == lodgingDays - 1) { // Ngày cuối cùng
                    currentStart = LocalTime.MIN;
                    currentEnd = bookingTime;
                } else { // Ngày ở giữa
                    currentStart = LocalTime.MIN;
                    currentEnd = LocalTime.of(23, 59, 59);
                }

                boolean busyOnThisDay = BookingDetailDAO.isPetBusyLodging(
                        userPetId,
                        currentDate,
                        currentStart,
                        currentEnd,
                        new String[]{
                            Booking.BookingState.BOOKED.toString(),
                            Booking.BookingState.CART.toString(),
                            Booking.BookingState.NEXTBOOKING.toString(),
                            Booking.BookingState.PENDINGPAYMENT.toString()
                        }
                );

                if (busyOnThisDay) {
                    isPetBusy = true;
                    break;
                }
            }

            if (isPetBusy) {
                out.print("{\"success\": false, \"message\": \"Pet is already scheduled for another service during the selected lodging period. Please select a different time or pet.\"}");
                return;
            }

            Booking booking = new Booking();
            booking.setUserID(userId);
            booking.setDateBooked(LocalDateTime.now());
            booking.setState(Booking.BookingState.PENDINGPAYMENT.toString());
            booking.setStatus(true);
            booking.setTotalPrice(servicePrice);
            booking.setNote(note);

            boolean success = BookingDAO.create(booking);
            if (!success) {
                out.print("{\"success\": false, \"message\": \"Failed to create booking\"}");
                return;
            }

            int bookingId = booking.getBookingID();
            if (bookingId <= 0) {
                out.print("{\"success\": false, \"message\": \"Failed to retrieve booking ID\"}");
                return;
            }

            // Tìm phòng available
            List<Room> availableRooms = RoomDAO.getByCategoryServiceId(service.getCategoryServiceID());
            int selectedRoomId = -1;

            roomSearch:
            for (Room room : availableRooms) {
                for (int i = 0; i < lodgingDays; i++) {
                    LocalDate currentDate = bookingDate.plusDays(i);
                    List<BookingDetail> bookingDetails = BookingDetailDAO.getByDateAndStatesForBooking(
                            currentDate,
                            new String[]{
                                Booking.BookingState.BOOKED.toString(),
                                Booking.BookingState.CART.toString(),
                                Booking.BookingState.NEXTBOOKING.toString(),
                                Booking.BookingState.PENDINGPAYMENT.toString()
                            }
                    );
                    
                    LocalTime currentStart, currentEnd;
                    if (i == 0) { // Ngày đầu tiên
                        currentStart = bookingTime;
                        currentEnd = LocalTime.of(23, 59, 59);
                    } else if (i == lodgingDays - 1) { // Ngày cuối cùng
                        currentStart = LocalTime.MIN;
                        currentEnd = bookingTime;
                    } else { // Ngày ở giữa
                        currentStart = LocalTime.MIN;
                        currentEnd = LocalTime.of(23, 59, 59);
                    }

                    LocalDateTime dateStart = LocalDateTime.of(currentDate, currentStart);
                    LocalDateTime dateEnd = LocalDateTime.of(currentDate, currentEnd);

                    for (BookingDetail detail : bookingDetails) {
                        if (detail.getRoomID() == room.getRoomID()
                                && detail.startTime != null && detail.endTime != null) {
                            LocalDateTime bookingStart = detail.dateStartService;
                            LocalDateTime bookingEnd = detail.dateEndService;
                            if (!(dateEnd.isBefore(bookingStart) || dateStart.isAfter(bookingEnd))) {
                                continue roomSearch; // Phòng này đã bận vào ngày nào đó, kiểm tra phòng tiếp theo
                            }
                        }
                    }
                }

                selectedRoomId = room.getRoomID();
                break;
            }

            if (selectedRoomId == -1) {
                out.print("{\"success\": false, \"message\": \"No room available for the selected lodging period\"}");
                return;
            }

            BookingDetail bookingDetail = new BookingDetail();
            bookingDetail.setBookingID(booking.getBookingID());
            bookingDetail.setServiceID(serviceId);
            bookingDetail.setRoomID(selectedRoomId);
            bookingDetail.setStockBooking(lodgingDays);

            LocalDateTime startDateTime = LocalDateTime.of(bookingDate, bookingTime);
            LocalDateTime endDateTime = LocalDateTime.of(endDate, bookingTime);

            bookingDetail.setDateStartService(startDateTime);
            bookingDetail.setDateEndService(endDateTime);
            bookingDetail.setStartTime(bookingTime);
            bookingDetail.setEndTime(bookingTime);
            bookingDetail.setPrice(servicePrice);
            bookingDetail.setUserPetID(userPetId);

            boolean detailSuccess = BookingDetailDAO.create(bookingDetail);

            if (detailSuccess) {
                out.print("{\"success\": true, \"message\": \"Lodging booking created successfully\", \"bookingId\": " + booking.getBookingID() + "}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to create booking detail\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"" + Common.escapeJsonString(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void handleDirectRegularBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            String dateStr = request.getParameter("bookingDate");
            String timeStr = request.getParameter("bookingTime");
            int userPetId = Integer.parseInt(request.getParameter("userPetId"));
            String note = request.getParameter("note");

            LocalDate bookingDate = LocalDate.parse(dateStr);
            LocalTime bookingTime = LocalTime.parse(timeStr);

            int timeMinutes = bookingTime.getHour() * 60 + bookingTime.getMinute();
            int workingStartMinutes = 8 * 60;
            int workingEndMinutes = 17 * 60 + 30;

            if (timeMinutes < workingStartMinutes || timeMinutes >= workingEndMinutes) {
                out.print("{\"success\": false, \"message\": \"Please select a time within working hours (8:00 AM - 5:30 PM)\"}");
                return;
            }

            LocalDateTime now = LocalDateTime.now();
            LocalDateTime bookingDateTime = LocalDateTime.of(bookingDate, bookingTime);
            LocalDateTime minAllowedTime = now.plusMinutes(30);

            if (bookingDateTime.isBefore(minAllowedTime)) {
                out.print("{\"success\": false, \"message\": \"Booking time must be at least 30 minutes from now to allow preparation time.\"}");
                return;
            }

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            models.Service service = ServiceDAO.getById(serviceId);
            float servicePrice = service.getPrice();

            LocalTime endTime = bookingTime.plusMinutes(service.getTime());

            int endTimeMinutes = endTime.getHour() * 60 + endTime.getMinute();
            if (endTimeMinutes > workingEndMinutes) {
                out.print("{\"success\": false, \"message\": \"Service would end after working hours (5:30 PM). Please choose an earlier time.\"}");
                return;
            }

            boolean isPetBusy = BookingDetailDAO.isPetBusy(userPetId, bookingDate, bookingTime, endTime,
                    new String[]{Booking.BookingState.BOOKED.toString(), Booking.BookingState.CART.toString(),
                        Booking.BookingState.NEXTBOOKING.toString(), Booking.BookingState.PENDINGPAYMENT.toString()});

            if (isPetBusy) {
                out.print("{\"success\": false, \"message\": \"Pet is already scheduled for another service at this time. Please select a different time or pet.\"}");
                return;
            }

            Booking booking = new Booking();
            booking.setUserID(userId);
            booking.setDateBooked(LocalDateTime.now());
            booking.setState(Booking.BookingState.PENDINGPAYMENT.toString());
            booking.setStatus(true);
            booking.setTotalPrice(servicePrice);
            booking.setNote(note);

            boolean success = BookingDAO.create(booking);
            if (!success) {
                out.print("{\"success\": false, \"message\": \"Failed to create booking\"}");
                return;
            }

            int bookingId = booking.getBookingID();
            if (bookingId <= 0) {
                out.print("{\"success\": false, \"message\": \"Failed to retrieve booking ID\"}");
                return;
            }

            List<Room> availableRooms = RoomDAO.getByCategoryServiceId(service.getCategoryServiceID());
            List<BookingDetail> existingBookings = BookingDetailDAO.getByDateAndStates(
                    bookingDate,
                    new String[]{Booking.BookingState.BOOKED.toString(), Booking.BookingState.CART.toString(),
                        Booking.BookingState.NEXTBOOKING.toString(), Booking.BookingState.PENDINGPAYMENT.toString()}
            );

            int selectedRoomId = -1;
            for (Room room : availableRooms) {
                boolean isRoomAvailable = true;
                for (BookingDetail detail : existingBookings) {
                    if (detail.getRoomID() == room.getRoomID()
                            && detail.startTime != null && detail.endTime != null) {

                        boolean isOverlap = (bookingTime.isBefore(detail.endTime)
                                && endTime.isAfter(detail.startTime));

                        if (isOverlap) {
                            isRoomAvailable = false;
                            break;
                        }
                    }
                }

                if (isRoomAvailable) {
                    selectedRoomId = room.getRoomID();
                    break;
                }
            }

            if (selectedRoomId == -1) {
                out.print("{\"success\": false, \"message\": \"No room available for selected time slot\"}");
                return;
            }

            // Tạo booking detail
            BookingDetail bookingDetail = new BookingDetail();
            bookingDetail.setBookingID(booking.getBookingID());
            bookingDetail.setServiceID(serviceId);
            bookingDetail.setRoomID(selectedRoomId);
            bookingDetail.setStockBooking(1);

            LocalDateTime startDateTime = LocalDateTime.of(bookingDate, bookingTime);
            LocalDateTime endDateTime = LocalDateTime.of(bookingDate, endTime);

            bookingDetail.setDateStartService(startDateTime);
            bookingDetail.setDateEndService(endDateTime);
            bookingDetail.setStartTime(bookingTime);
            bookingDetail.setEndTime(endTime);
            bookingDetail.setPrice(servicePrice);
            bookingDetail.setUserPetID(userPetId);

            boolean detailSuccess = BookingDetailDAO.create(bookingDetail);

            if (detailSuccess) {
                out.print("{\"success\": true, \"message\": \"Regular booking created successfully\", \"bookingId\": " + booking.getBookingID() + "}");
            } else {
                out.print("{\"success\": false, \"message\": \"Failed to create booking detail\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"" + Common.escapeJsonString(e.getMessage()) + "\"}");
        } finally {
            out.flush();
            out.close();
        }
    }

    private void viewBookingAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            String[] excludeStates = {
                Booking.BookingState.CART.toString(),
                Booking.BookingState.FINISHED.toString()
            };

            int page = 1;
            int pageSize = 6;

            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int totalBookings = BookingDetailDAO.countByUserIdExcludeStates(userId, excludeStates);
            int totalPages = (int) Math.ceil((double) totalBookings / pageSize);

            int offset = (page - 1) * pageSize;

            List<BookingDetailDTO> bookingDTOs = new ArrayList<>();

            List<BookingDetail> details = BookingDetailDAO.getByUserIdWithPaginationExcludeStates(
                    userId, offset, pageSize, excludeStates);
            for (BookingDetail detail : details) {
                BookingDetailDTO dto = new BookingDetailDTO(detail);
                bookingDTOs.add(dto);
            }

            request.setAttribute("bookingDetails", bookingDTOs);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalBookings", totalBookings);
            request.setAttribute("pageSize", pageSize);

            // Calculate pagination info
            int startItem = offset + 1;
            int endItem = Math.min(offset + pageSize, totalBookings);
            request.setAttribute("startItem", startItem);
            request.setAttribute("endItem", endItem);
            request.getRequestDispatcher("/client/booking-list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Unable to load bookings: " + e.getMessage());
            request.getRequestDispatcher("/client/booking-list.jsp").forward(request, response);
        }
    }

    private void viewBookingDetailAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            Booking booking = BookingDAO.getById(bookingId);

            if (booking == null || booking.getUserID() != userId) {
                response.sendRedirect(request.getContextPath() + "/booking?action=viewBooking");
                return;
            }

            List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(bookingId);

            List<BookingDetailDTO> detailDTOs = new ArrayList<>();
            for (BookingDetail detail : bookingDetails) {
                BookingDetailDTO dto = new BookingDetailDTO(detail);
                detailDTOs.add(dto);
            }

            request.setAttribute("booking", booking);
            request.setAttribute("bookingDetails", detailDTOs);
            request.setAttribute("pageTitle", "Booking Details");
            request.getRequestDispatcher("/client/booking-detail.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/booking?action=viewBooking");
        }
    }

    private void cancelBookingAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            Booking booking = BookingDAO.getById(bookingId);

            if (booking == null || booking.getUserID() != userId) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Booking not found or access denied\"}");
                return;
            }

            if (!booking.getState().equals("PENDINGPAYMENT") && !booking.getState().equals("BOOKED")) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"This booking cannot be cancelled\"}");
                return;
            }

            booking.setState(Booking.BookingState.CANCEL.toString());
            boolean updated = BookingDAO.update(booking);

            if (updated) {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": true, \"message\": \"Booking cancelled successfully\"}");
            } else {
                response.setContentType("application/json");
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to cancel booking\"}");
            }

        } catch (NumberFormatException e) {
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid booking ID\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }

    private void payBookingAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            if (userDetailDTO == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"Please login first\"}");
                return;
            }

            int userId = userDetailDTO.getUser().getUserId();

            Booking booking = BookingDAO.getById(bookingId);

            if (booking == null || booking.getUserID() != userId) {
                response.getWriter().write("{\"success\": false, \"message\": \"Booking not found or access denied\"}");
                return;
            }

            if (!booking.getState().equals("PENDINGPAYMENT")) {
                response.getWriter().write("{\"success\": false, \"message\": \"This booking cannot be paid\"}");
                return;
            }

            Wallet userWallet = WalletDAO.getByUserId(userId);
            if (userWallet == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"Wallet not found\", \"action\": \"redirect_wallet\"}");
                return;
            }

            float totalAmount = booking.getTotalPrice();
            float paidAmount = booking.getPaid();
            float requiredPayment = totalAmount * 0.5f;

            if (userWallet.getAmount() < requiredPayment) {
                String message = String.format("Insufficient balance. Required: %.0f đ, Available: %.0f đ",
                        requiredPayment, userWallet.getAmount());
                response.getWriter().write("{\"success\": false, \"message\": \"" + message + "\", \"action\": \"redirect_wallet\"}");
                return;
            }

            Wallet adminWallet = WalletDAO.getAdminWallet();
            if (adminWallet == null) {
                System.out.println("Warning: Admin wallet not found. Payment will proceed but admin won't receive money.");
            }

            userWallet.setAmount(userWallet.getAmount() - requiredPayment);
            boolean walletUpdated = WalletDAO.update(userWallet);
            if (!walletUpdated) {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to update wallet\"}");
                return;
            }

            boolean adminWalletUpdated = true;
            if (adminWallet != null) {
                adminWallet.setAmount(adminWallet.getAmount() + requiredPayment);
                adminWalletUpdated = WalletDAO.update(adminWallet);

                if (!adminWalletUpdated) {
                    userWallet.setAmount(userWallet.getAmount() + requiredPayment);
                    WalletDAO.update(userWallet);
                    response.getWriter().write("{\"success\": false, \"message\": \"Failed to update admin wallet\"}");
                    return;
                }
            }

            booking.setPaid(paidAmount + requiredPayment);

            if (booking.getPaid() >= requiredPayment) {
                booking.setState(Booking.BookingState.BOOKED.toString());
            }

            boolean bookingUpdated = BookingDAO.update(booking);

            if (!bookingUpdated) {
                userWallet.setAmount(userWallet.getAmount() + requiredPayment);
                WalletDAO.update(userWallet);

                if (adminWallet != null) {
                    adminWallet.setAmount(adminWallet.getAmount() - requiredPayment);
                    WalletDAO.update(adminWallet);
                }

                response.getWriter().write("{\"success\": false, \"message\": \"Failed to update booking\"}");
                return;
            }

            request.getSession().setAttribute("wallet", userWallet);

            String responseJson = String.format(
                    "{\"success\": true, \"message\": \"Payment successful! Paid: %.0f đ\", "
                    + "\"paidAmount\": %.0f, \"totalAmount\": %.0f, \"remainingAmount\": %.0f, "
                    + "\"walletBalance\": %.0f, \"bookingState\": \"%s\"}",
                    requiredPayment, booking.getPaid(), totalAmount,
                    totalAmount - booking.getPaid(), userWallet.getAmount(), booking.getState()
            );

            response.getWriter().write(responseJson);

        } catch (NumberFormatException e) {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid booking ID\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"An error occurred while processing payment\"}");
        }
    }

    private void checkoutAction(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
        if (userDetailDTO == null) {
            response.sendRedirect("sign-in");
            return;
        }

        try {
            int userId = userDetailDTO.getUser().getUserId();
            List<Booking> userCarts = BookingDAO.getByUserIdAndState(userId, Booking.BookingState.CART.toString());

            if (userCarts.isEmpty()) {
                request.setAttribute("error", "No items in cart to checkout");
                response.sendRedirect(request.getContextPath() + "/booking?action=viewCart");
                return;
            }

            Booking cartBooking = userCarts.get(0);

            List<BookingDetail> cartItems = BookingDetailDAO.getByBookingId(cartBooking.getBookingID());

            if (cartItems.isEmpty()) {
                request.setAttribute("error", "No items in cart to checkout");
                response.sendRedirect(request.getContextPath() + "/booking?action=viewCart");
                return;
            }

            for (BookingDetail item : cartItems) {
                if (item.getUserPetID() == 0) {
                    request.setAttribute("error", "Please select a pet for all services before checkout");
                    response.sendRedirect(request.getContextPath() + "/booking?action=viewCart");
                    return;
                }

                Service service = ServiceDAO.getById(item.getServiceID());
                if (service == null || !service.isStatus()) {
                    request.setAttribute("error", "Some services in your cart are no longer available");
                    response.sendRedirect(request.getContextPath() + "/booking?action=viewCart");
                    return;
                }

                if (item.getRoomID() > 0) {
                    Room room = RoomDAO.getById(item.getRoomID());
                    if (room == null || !room.isStatus()) {
                        request.setAttribute("error", "Some rooms in your cart are no longer available");
                        response.sendRedirect(request.getContextPath() + "/booking?action=viewCart");
                        return;
                    }
                }
            }

            boolean updated = BookingDAO.updateState(cartBooking.getBookingID(), Booking.BookingState.PENDINGPAYMENT.toString());

            if (updated) {
                BookingDAO.updateBookingDate(cartBooking.getBookingID());

                response.sendRedirect(request.getContextPath() + "/booking?action=viewBookingDetail&bookingId=" + cartBooking.getBookingID());
            } else {
                request.setAttribute("error", "Failed to process checkout. Please try again.");
                response.sendRedirect(request.getContextPath() + "/booking?action=viewCart");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred during checkout: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/booking?action=viewCart");
        }
    }

    private void viewBookingDetailActionHTML(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String bookingIdParam = request.getParameter("bookingID");

            int bookingId = Integer.parseInt(bookingIdParam);

            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            int userId = userDetailDTO.getUser().getUserId();

            Booking booking = BookingDAO.getById(bookingId);

            if (booking == null || booking.getUserID() != userId) {
                response.setContentType("text/html;charset=UTF-8");
                response.getWriter().write("<div class='alert alert-danger'>Booking not found or access denied</div>");
                return;
            }

            List<BookingDetail> bookingDetails = BookingDetailDAO.getByBookingId(bookingId);

            List<BookingDetailDTO> detailDTOs = new ArrayList<>();
            for (BookingDetail detail : bookingDetails) {
                BookingDetailDTO dto = new BookingDetailDTO(detail);
                detailDTOs.add(dto);
            }

            request.setAttribute("booking", booking);
            request.setAttribute("bookingDetails", detailDTOs);

            request.getRequestDispatcher("/client/booking-detail-modal.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<div class='alert alert-danger'>Invalid booking ID</div>");
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().write("<div class='alert alert-danger'>Unable to load booking details</div>");
        }
    }
}
