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
import utils.Email;
import utils.GoogleLogin;

public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = request.getParameter("actor");
        if (actor == null) {
            showLoginPage(request, response);
        } else {
            switch (actor) {
                case "google-login" ->
                    loginWithGoogle(request, response);
                case "logout" ->
                    logout(request, response);
                case "forgetPassword" ->
                    showForgetPassword(request, response);
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
            case "checkEmail" ->
                checkEmailExist(request, response);
            case "verifyEmail" ->
                verifyEmail(request, response);
            case "forgetPassword" ->
                forgetPassword(request, response);
        }
    }
    
    //Show Login page
    private void showLoginPage(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("google_redirect_uri", GoogleLogin.GOOGLE_REDIRECT_URI);
        request.setAttribute("google_client_id", GoogleLogin.GOOGLE_CLIENT_ID);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
    
    //Show forget password
    private void showForgetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
    }
    
    //Login with gg
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
            session.setAttribute("actor", userDetailDTO.getUser().getRole());
            session.setAttribute("wallet", WalletDAO.getByUserId(userDetailDTO.getUser().getUserId()));
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
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = Common.encryptMD5(request.getParameter("password"));
        User user = new User();
        user.setRole("customer");
        user.setEmail(email);
        user.setUserName(email);
        user.setPassword(password);
        user.setStatus(true);

        UserDetail userDetail = new UserDetail();
        userDetail.setUserID(user.getUserId());
        userDetail.setFirstName(firstName);
        userDetail.setLastName(lastName);
        HttpSession session = request.getSession();
        String key = Email.generateRandomKey();
        session.setAttribute("key", key);
        session.setAttribute("user", user);
        session.setAttribute("userDetail", userDetail);
        session.setAttribute("action", "signUp");
        if (Email.sendEmail(user.getEmail(), "Welcome to FlexCareP+ - Dịch vụ thú cưng", Email.noiDungRegis(key))) {
            request.getRequestDispatcher("verifyEmail.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "Can not sign up!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }

        response.sendRedirect("home");
    }

    private void checkEmailExist(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        User user = UserDAO.getByEmail(email);
        response.setContentType("text/plain");
        response.getWriter().write(Boolean.toString(user != null));
    }

    private void verifyEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String status = request.getParameter("status");
        HttpSession session = request.getSession(false);
        if (status.equals("right")) {
            switch ((String) session.getAttribute("action")) {
                case "signUp" ->
                    createNewAccount(request);
                case "resetPassword" ->
                    resetPassword(request);
            }
        }
        session.invalidate();
        response.sendRedirect("sign-in");
    }

    private void createNewAccount(HttpServletRequest request)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        UserDetail userDetail = (UserDetail) session.getAttribute("userDetail");
        UserDAO.create(user);
        user = UserDAO.getByEmail(user.getEmail());
        userDetail.setUserID(user.getUserId());
        UserDetailDAO.create(userDetail);
        Wallet wallet = new Wallet(user.getUserId(), 0, true);
        WalletDAO.create(wallet);
    }

    private void resetPassword(HttpServletRequest request)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User user = UserDAO.getByEmail(email);
        user.setPassword(Common.encryptMD5("123"));
        UserDAO.update(user);
        Email.sendEmail(email, "FlexCareP+ - Dịch vụ chăm sóc thú cưng", Email.noiDungReset());
    }

    private void forgetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        User user = UserDAO.getByEmail(email);
        String key = Email.generateRandomKey();
        session.setAttribute("email", email);
        session.setAttribute("key", key);
        session.setAttribute("user", user);
        session.setAttribute("action", "resetPassword");
        if (Email.sendEmail(user.getEmail(), "Welcome to FlexCareP+ - Dịch vụ thú cưng", Email.noiDungRegis(key))) {
            request.getRequestDispatcher("verifyEmail.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "Can not reset pasword!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
