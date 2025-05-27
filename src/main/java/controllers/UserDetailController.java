package controllers;

import daos.UserDAO;
import dtos.UserDetailDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import models.User;
import utils.Common;
import static utils.S3Uploader.deleteFromS3;
import static utils.S3Uploader.uploadToS3;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
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
        String action = request.getParameter("action");
        switch (action) {
            case "getUserDetail" ->
                request.getRequestDispatcher("/client/profile.jsp").forward(request, response);

        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "changeInfo" ->
                customerChangeInfo(request, response);
            case "changePassword" ->
                customerChangePassword(request, response);
            case "changeAvatar" ->
                customerChangeAvatar(request, response);
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
            case "changeAvatar" ->
                customerChangeAvatar(request, response);
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

    private void customerChangeInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            if (userDetailDTO == null) {
                response.getWriter().write("<div class='alert alert-danger'>You are not logged in!</div>");
                return;
            }

            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String tel = request.getParameter("tel");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");

            userDetailDTO.setFirstName(firstName);
            userDetailDTO.setLastName(lastName);
            userDetailDTO.setTel(tel);
            userDetailDTO.setDob(LocalDate.parse(dob, DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            userDetailDTO.setGender(gender);

            boolean updated = daos.UserDetailDAO.update(userDetailDTO.toUserDetail());

            if (updated) {
                request.getSession().setAttribute("userDetailDTO", userDetailDTO);
                response.getWriter().write("<div class='alert alert-success alert-dismissible fade show'>Update successful!</div>");
            } else {
                response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Update failed!</div>");
            }
        } catch (Exception e) {
            response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Error: " + e.getMessage() + "</div>");
        }
    }

    private void customerChangePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            UserDetailDTO currentUserDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            User currentUser = currentUserDetailDTO.getUser();

            if (currentUser == null) {
                response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>You are not logged in!</div>");
                return;
            }

            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            if (newPassword == null || newPassword.isEmpty()
                    || confirmPassword == null || confirmPassword.isEmpty()) {
                response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Please enter new password in full!</div>");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Confirmation password does not match!</div>");
                return;
            }

            // Nếu user chưa có mật khẩu (lần đầu setup)
            boolean isFirstSetup = currentUser.getPassword() == null || currentUser.getPassword().isEmpty();

            if (!isFirstSetup) {
                // Đã có mật khẩu, phải kiểm tra mật khẩu cũ
                if (currentPassword == null || currentPassword.isEmpty()) {
                    response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Please enter current password!</div>");
                    return;
                }
                if (!currentUser.getPassword().equals(Common.encryptMD5(currentPassword))) {
                    response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Current password is incorrect!</div>");
                    return;
                }
            }

            // Update password
            currentUser.setPassword(Common.encryptMD5(newPassword));
            boolean updated = UserDAO.update(currentUser);

            if (updated) {
                // Update session
                currentUserDetailDTO.setUser(currentUser);
                request.getSession().setAttribute("userDetailDTO", currentUserDetailDTO);
                response.getWriter().write("<div class='alert alert-success alert-dismissible fade show'>Password updated successfully!</div>");
            } else {
                response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Password update failed!</div>");
            }
        } catch (Exception e) {
            response.getWriter().write("<div class='alert alert-danger alert-dismissible fade show'>Error: " + e.getMessage() + "</div>");
        }
    }

    private void customerChangeAvatar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get the current user from session
            UserDetailDTO currentUserDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");

            if (currentUserDetailDTO == null) {
                // User not logged in, redirect to login page
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Process the file upload - need to use Parts for multipart/form-data
            Part filePart = request.getPart("avatar");

            // Check if file was actually uploaded
            if (filePart == null || filePart.getSize() <= 0) {
                request.setAttribute("avatarUploadError", "No file was uploaded");
                request.getRequestDispatcher("/client/profile.jsp").forward(request, response);
                return;
            }

            // Validate file type
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

            if (!fileExtension.equals("jpg") && !fileExtension.equals("jpeg")
                    && !fileExtension.equals("png") && !fileExtension.equals("gif")) {
                request.setAttribute("avatarUploadError", "Only image files (jpg, jpeg, png, gif) are allowed");
                request.getRequestDispatcher("/client/profile.jsp").forward(request, response);
                return;
            }

            InputStream inputStream = filePart.getInputStream();
            String avatarURL = uploadToS3(inputStream, fileName, filePart.getSize());

            deleteFromS3(currentUserDetailDTO.getAvatar());

            int userID = currentUserDetailDTO.getUser().getUserId();

            // Update in the database
            boolean updated = daos.UserDetailDAO.updateAvatar(userID, avatarURL);

            if (updated) {
                // Update successful - update the session object
                currentUserDetailDTO.setAvatar(avatarURL);
                request.getSession().setAttribute("userDetailDTO", currentUserDetailDTO);
                request.setAttribute("avatarUploadSuccess", "Avatar updated successfully");
            } else {
                request.setAttribute("avatarUploadError", "Failed to update avatar in database");
            }

            // Redirect back to profile page
            request.getRequestDispatcher("/client/profile.jsp").forward(request, response);

        } catch (Exception e) {
            // Log the error
            System.out.println("Error in customerChangeAvatar: " + e.getMessage());
            e.printStackTrace();

            // Set error message and forward back to profile page
            request.setAttribute("avatarUploadError", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("/client/profile.jsp").forward(request, response);
        }
    }
}
