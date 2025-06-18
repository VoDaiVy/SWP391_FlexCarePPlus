package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import daos.MessageDAO;
import daos.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.List;
import models.Message;
import models.User;
import utils.LocalDateTimeAdapter;

public class MessageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                adminGet(request, response);
            case "customer" ->
                customerGet(request, response);
            case "staff" ->
                staffGet(request, response);
            default ->
                response.sendRedirect("./");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                adminPost(request, response);
            case "customer" ->
                customerPost(request, response);
            case "staff" ->
                staffPost(request, response);
            default ->
                response.sendRedirect("./");
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                adminPut(request, response);
            case "customer" ->
                customerPut(request, response);
            case "staff" ->
                staffPut(request, response);
            default ->
                response.sendRedirect("./");
        }
    }

    // Admin role methods
    private void adminGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        int senderID = Integer.parseInt(request.getParameter("senderID"));
        int receiverID = Integer.parseInt(request.getParameter("receiverID"));

        List<Message> messages = MessageDAO.getMessagesBetweenUsers(senderID, receiverID);

        Gson gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                .create();
        String data = gson.toJson(messages);

        try (PrintWriter out = response.getWriter()) {
            out.write(data);
            out.flush(); // ✅ đảm bảo tất cả dữ liệu được đẩy ra
            // ✅ kết thúc stream chính xác
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String content = request.getParameter("content");
        int senderID = Integer.parseInt(request.getParameter("senderID"));
        int receiverID = Integer.parseInt(request.getParameter("receiverID"));

        if (content != null && !content.isEmpty()) {
            Message message = new Message();
            message.setContent(content);
            message.setUserID(senderID);
            message.setUserReceiveID(receiverID);
            message.setStatus(true);
            MessageDAO.create(message);
        }
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getMessages" -> {
                List<User> users = UserDAO.getCustomerHasMessages();
                List<Message> messages = MessageDAO.getMessagesBetweenUsers(8, users.getFirst().getUserId());
                request.setAttribute("users", users);
                request.setAttribute("messages", messages);
                request.getRequestDispatcher("staff/managePage.jsp").forward(request, response);
            }

            case "getUsers" -> {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                List<User> users = UserDAO.getCustomerHasMessages();

                Gson gson = new GsonBuilder()
                        .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                        .create();
                String data = gson.toJson(users);

                try (PrintWriter out = response.getWriter()) {
                    out.write(data);
                    out.flush(); // ✅ đảm bảo tất cả dữ liệu được đẩy ra
                    // ✅ kết thúc stream chính xác
                }
            }
            case "getUserMessages" -> {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                int senderID = Integer.parseInt(request.getParameter("senderID"));
                int receiverID = Integer.parseInt(request.getParameter("receiverID"));

                List<Message> messages = MessageDAO.getMessagesBetweenUsers(senderID, receiverID);

                Gson gson = new GsonBuilder()
                        .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
                        .create();
                String data = gson.toJson(messages);

                try (PrintWriter out = response.getWriter()) {
                    out.write(data);
                    out.flush(); // ✅ đảm bảo tất cả dữ liệu được đẩy ra
                    // ✅ kết thúc stream chính xác
                }
            }
        }
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String content = request.getParameter("content");
        int receiverID = Integer.parseInt(request.getParameter("receiverID"));

        if (content != null && !content.isEmpty()) {
            Message message = new Message();
            message.setContent(content);
            message.setUserID(8);
            message.setUserReceiveID(receiverID);
            message.setStatus(true);
            MessageDAO.create(message);
        }
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }
}
