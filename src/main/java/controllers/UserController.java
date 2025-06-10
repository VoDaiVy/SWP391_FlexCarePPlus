package controllers;

import daos.UserDAO;
import daos.UserDetailDAO;
import daos.WalletDAO;
import dtos.UserDetailDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import models.User;
import models.UserDetail;
import models.Wallet;

public class UserController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin" ->
                admin(request, response);
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
                admin(request, response);
            case "customer" ->
                customerPost(request, response);
            case "staff" ->
                staffPost(request, response);
            default ->
                response.sendRedirect("./");
        }
    }
   
    private void admin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getUsers" -> {
                adminGetUsers(request, response);
            }
            case "getUserDetail" -> {
                adminGetUserDetail(request, response);
            }
            case "banUser" -> {
                adminBanUser(request, response);
            }
            case "allowUser" -> {
                adminAllowUser(request, response);
            }
        }
    }

    private void adminGetUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> users = UserDAO.adminGetAll();
        List<UserDetailDTO> userDTOs = new ArrayList<>();
        for (User user : users) {
            userDTOs.add(new UserDetailDTO(UserDetailDAO.getByUserId(user.getUserId()), user));
        }
        request.setAttribute("userDTOs", userDTOs);
        request.getRequestDispatcher("/adminPages/users.jsp").forward(request, response);
    }


    private void adminGetUserDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = UserDAO.getById(userId);
        UserDetail userDetail = UserDetailDAO.getByUserId(userId);
        Wallet wallet = WalletDAO.getByUserId(userId);
        request.setAttribute("user", user);
        request.setAttribute("userDetail", userDetail);
        request.setAttribute("wallet", wallet);
        request.getRequestDispatcher("adminPages/userdetail.jsp").forward(request, response);
    }
    
    private void adminBanUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = UserDAO.getById(userId);
        user.setStatus(false);
        UserDAO.update(user);
        response.sendRedirect("admin?action=getUsers");
    }
    
    private void adminAllowUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("id"));
        User user = UserDAO.getById(userId);
        user.setStatus(true);
        UserDAO.update(user);
        response.sendRedirect("admin?action=getUsers");
    }

    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
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

  
}
