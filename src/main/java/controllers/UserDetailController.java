package controllers;

import daos.UserDAO;
import dtos.UserDetailDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.User;
import utils.Common;

public class UserDetailController extends HttpServlet {

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

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "changeInfo" ->
                customerChangeInfo(request, response);
            case "changePassword" ->
                customerChangePassword(request, response);
        }
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "changeInfo" ->
                customerChangeInfo(request, response);
            case "changePassword" ->
                customerChangePassword(request, response);
        }
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

    private void customerChangeInfo(HttpServletRequest request, HttpServletResponse response) {

    }

    private void customerChangePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get the current user from session
            UserDetailDTO currentUserDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            User currentUser = currentUserDetailDTO.getUser();

            if (currentUser == null) {
                // User not logged in, redirect to login page
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Get password parameters from the form
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Validate passwords
            if (newPassword == null || newPassword.isEmpty()
                    || currentPassword == null || currentPassword.isEmpty()
                    || confirmPassword == null || confirmPassword.isEmpty()) {

                request.setAttribute("passwordChangeError", "All password fields are required");
                request.getRequestDispatcher("/client/profile.jsp").forward(request, response);
                return;
            }

            // Check if new password and confirm password match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("passwordChangeError", "New password and confirmation do not match");
                request.getRequestDispatcher("/client/profile.jsp").forward(request, response);
                return;
            }

            // Verify current password
            // Note: In a real application, passwords should be hashed and not stored in plain text
            if (!currentUser.getPassword().equals(Common.encryptMD5(currentPassword))) {
                request.setAttribute("passwordChangeError", "Current password is incorrect");
                request.getRequestDispatcher("/client/profile.jsp").forward(request, response);
                return;
            }

            // Update password in database
            currentUser.setPassword(Common.encryptMD5(newPassword));
            boolean updated = UserDAO.update(currentUser);

            if (updated) {
                // Update successful
                request.setAttribute("passwordChangeSuccess", "Password updated successfully");

                // Update the session user object with new password
                currentUser.setPassword(newPassword);
                currentUserDetailDTO.setUser(currentUser);
                request.getSession().setAttribute("userDetailDTO", currentUserDetailDTO);
            } else {
                // Update failed
                request.setAttribute("passwordChangeError", "Failed to update password. Please try again.");
            }

            // Redirect back to profile page
            request.getRequestDispatcher("/client/profile.jsp").forward(request, response);

        } catch (Exception e) {
            // Log the error
            System.out.println("Error in customerChangePassword: " + e.getMessage());
            e.printStackTrace();

            // Set error message and forward back to profile page
            request.setAttribute("passwordChangeError", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/client/profile.jsp").forward(request, response);
        }
    }

    private void customerChangeAvatar(HttpServletRequest request, HttpServletResponse response) {

    }
}
