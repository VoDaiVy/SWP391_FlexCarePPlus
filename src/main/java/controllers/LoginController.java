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
import jakarta.servlet.http.HttpSession;
import models.GoogleAccount;
import models.User;
import models.UserDetail;
import models.Wallet;
import utils.Common;
import utils.GoogleLogin;

public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String)request.getSession().getAttribute("actor");
        if (actor == null) {
            showLoginPage(request, response);
        } else {
            switch (actor) {
                case "google-login" ->
                    loginWithGoogle(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "sign-in" ->
                login(request, response);
            case "sign-up" ->
                sign_up(request, response);
        }
    }

    private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("google_redirect_uri", GoogleLogin.GOOGLE_REDIRECT_URI);
        request.setAttribute("google_client_id", GoogleLogin.GOOGLE_CLIENT_ID);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    private void loginWithGoogle(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String code = request.getParameter("code");
        String token = GoogleLogin.getToken(code);
        GoogleAccount acc = GoogleLogin.getUserInfo(token);
        System.out.println(acc);
        User user = UserDAO.getByEmail(acc.getEmail());
        UserDetail userDetail;
        if (user == null) {
            user = new User();
            user.setEmail(acc.getEmail());
            user.setUserName(acc.getEmail());
            user.setPassword(Common.encryptMD5("123"));
            user.setRole("customer");
            user.setStatus(true);
            UserDAO.create(user);
            user = UserDAO.getByEmail(acc.getEmail());
            userDetail = new UserDetail();
            userDetail.setUserID(user.getUserId());
            userDetail.setAvatar(acc.getPicture());
            userDetail.setFirstName(acc.getFamily_name());
            userDetail.setLastName(acc.getGiven_name());
            System.out.println(user);
            System.out.println(userDetail);
            UserDetailDAO.create(userDetail);
            Wallet wallet = new Wallet(user.getUserId(), 0, true);
            WalletDAO.create(wallet);
        } else {
            userDetail = UserDetailDAO.getByUserId(user.getUserId());
            System.out.println(user);
            System.out.println(userDetail);
        }
        UserDetailDTO userDetailDTO = new UserDetailDTO(userDetail, user);
        navigateByRole(request, response, userDetailDTO);
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = Common.encryptMD5(request.getParameter("password"));
        User user = UserDAO.getByUsernameAndPassword(username, password);
        if (user == null) {
            request.setAttribute("msg", "Email or Password is wrong!");
            showLoginPage(request, response);
        } else {
            UserDetail userDetail = UserDetailDAO.getByUserId(user.getUserId());
            UserDetailDTO userDetailDTO = new UserDetailDTO(userDetail, user);
            navigateByRole(request, response, userDetailDTO);
        }
    }

    private void navigateByRole(HttpServletRequest request, HttpServletResponse response, UserDetailDTO userDetailDTO)
            throws ServletException, IOException {
        if (userDetailDTO.getUser().isStatus()) {
            HttpSession session = request.getSession();
            session.setAttribute("userDetailDTO", userDetailDTO);
            session.setAttribute("actor", User.RoleName.CUSTOMER.name());
            switch (userDetailDTO.getUser().getRole()) {
                case "customer" -> {
                    response.sendRedirect("home");
                }
                case "admin" -> {
                    response.sendRedirect("admin/homepage.jsp");
                }
                case "staff" -> {
                    response.sendRedirect("staff/homepage.jsp");
                }
            }
        } else {
            request.setAttribute("msg", "Account can not sign in!");
            showLoginPage(request, response);
        }
    }

    private void sign_up(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        String firstName = request.getParameter("firstName");
//        String lastName = request.getParameter("lastName");
//        String email = request.getParameter("email");
//        String password = Security.encryptMD5(request.getParameter("password"));
//        User user = new User();
//        user.setFirstName(firstName);
//        user.setLastName(lastName);
//        user.setEmail(email);
//        user.setRoleId(2);
//        user.setPassword(password);
//        user.setStatus(true);
//        boolean isSuccess = UserDAO.createUser(user);
//        response.setContentType("text/plain");
//        response.getWriter().write(Boolean.toString(isSuccess));
    }
}
