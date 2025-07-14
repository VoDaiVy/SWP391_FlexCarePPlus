package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RoomController extends HttpServlet {

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
        // Lấy danh sách phòng và danh mục dịch vụ
        java.util.List<models.Room> rooms = daos.RoomDAO.getAll();
        java.util.Map<Integer, models.CategoryService> categories = daos.CategoryServiceDAO.getMap();
        request.setAttribute("rooms", rooms);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("adminPages/rooms.jsp").forward(request, response);
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "createRoom" -> {
                String name = request.getParameter("name");
                int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
                int categoryServiceID = Integer.parseInt(request.getParameter("categoryServiceID"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                models.Room room = new models.Room();
                room.setName(name);
                room.setRoomNumber(roomNumber);
                room.setCategoryServiceID(categoryServiceID);
                room.setStatus(status);
                daos.RoomDAO.create(room);
                response.sendRedirect("admin?action=getRooms");
            }
            case "updateRoom" -> {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                String name = request.getParameter("name");
                int roomNumber = Integer.parseInt(request.getParameter("roomNumber"));
                int categoryServiceID = Integer.parseInt(request.getParameter("categoryServiceID"));
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                models.Room room = daos.RoomDAO.getById(roomID);
                if (room != null) {
                    room.setName(name);
                    room.setRoomNumber(roomNumber);
                    room.setCategoryServiceID(categoryServiceID);
                    room.setStatus(status);
                    daos.RoomDAO.update(room);
                }
                response.sendRedirect("admin?action=getRooms");
            }
            case "deleteRoom" -> {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                daos.RoomDAO.hardDelete(roomID);
                response.sendRedirect("admin?action=getRooms");
            }
        }
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không dùng PUT cho CRUD room ở UI này
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Không dùng DELETE cho CRUD room ở UI này
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
