
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/client/assets/layout/header.jsp"/>
<!DOCTYPE html>
<style>
    .login-mess-policy {
        font-size: 14px;
        text-align: center;
        color: #707070;
        padding-top: 20px;
        padding-bottom: 20px;
    }
</style>
<div class="login-container">
    <div class="container" id="container">
        <div class="form-container sign-in-container">
            <form action="${pageContext.request.contextPath}/UsersServlet" method="post">
                <h1>Sign in</h1>
                <input type="text" name="username" placeholder="Email Or Username" required />
                <input type="hidden" name="actor" value="guest">
                <input type="password" name="password" placeholder="Password" required />
                <button type="submit" class="login-btn" name="action" value="Login">Sign In</button>
                <%
                    if (session != null && session.getAttribute("msg") != null) {
                        String msg = (String) session.getAttribute("msg");
                %>
                <div id="loginMessage" class="alert alert-danger">
                    <%= msg%>
                </div>
                <%
                        session.removeAttribute("msg");
                    }
                %>
                <a href="${pageContext.request.contextPath}/views/client/pages/forgetpassword.jsp" id="forgot">Forgot Password?</a>
                <p class="or-text">Or sign in with</p>
                <a href="https://accounts.google.com/o/oauth2/auth?scope=email profile openid&redirect_uri=http://localhost:8080/FlexFood/UsersServlet?actor=google-login&response_type=code&client_id=409816900443-kfrs4qib3553p053mv9p6s1ams0hs25s.apps.googleusercontent.com&approval_prompt=force" 
                   class="google-btn">
                    <img src="https://developers.google.com/identity/images/g-logo.png" alt="Google logo" width="20px"/>
                    Sign In with Google
                </a>
                <div class="login-mess-policy">Bằng cách đăng nhập hoặc đăng ký, bạn đồng ý với <a
                        style="color: #0495ba; border-bottom: 2px solid; text-decoration: none !important; font-size: 14px;" target="_blank"
                        href="${pageContext.request.contextPath}/views/client/pages/policy.jsp">Chính sách quy định của FlexCareP+</a></div>
            </form>
        </div>

        <div class="form-container sign-up-container">
            <form action="${pageContext.request.contextPath}/UsersServlet" method="post">
                <h1>Create Account</h1>
                <input type="hidden" name="actor" value="guest">
                <input type="text" name="username" placeholder="Name" required/>
                <input type="email" name="email" placeholder="Email" required/>
                <input type="password" name="password" placeholder="Password" required/>
                <input type="password" name="re-password" placeholder="Re-enter Password" required />
                <button type="submit" value="Register" name="action" class="login-btn">Sign Up</button>
                <%
                    if (session != null && session.getAttribute("msg") != null) {
                        String msg = (String) session.getAttribute("msg");
                %>
                <div id="loginMessage" class="alert alert-danger">
                    <%= msg%>
                </div>
                <%
                        session.removeAttribute("msg");
                    }
                %>
            </form>
        </div>

        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1>Welcome Back!</h1>
                    <p>To keep connected with us please login with your personal info</p>
                    <button class="ghost" id="signIn" autofocus>Sign In</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1>Hello, Friend!</h1>
                    <p>Enter your personal details and start journey with us</p>
                    <button class="ghost" id="signUp">Sign Up</button>
                </div>
            </div>
        </div>


    </div>
</div>

<script>
    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const forgotButton = document.getElementById('forgot');
    const container = document.getElementById('container');

    signUpButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
        history.pushState({}, "", "/FlexCarePPlus/sign-up");
    });

    signInButton.addEventListener('click', () => {
        container.classList.remove("right-panel-active");
        history.pushState({}, "", "/FlexCarePPlus/sign-in");
    });
    forgotButton.addEventListener('click', () => {
        container.classList.add("right-panel-active");
    });
</script>
<script>
    // Kiểm tra xem phần tử thông báo có tồn tại không
    window.onload = function () {
        var loginMessage = document.getElementById("loginMessage");
        if (loginMessage) {
            // Ẩn phần tử sau 5 giây (5000 milliseconds)
            setTimeout(function () {
                loginMessage.style.display = "none";
            }, 5000);
        }
    };
</script>

<%--<jsp:include page="/views/client/includes/footer.jsp" />--%>

<!-- CSS để điều chỉnh khoảng cách và làm đẹp Sign In with Google -->
<style>
    .google-btn {
        display: inline-flex;
        align-items: center;
        background-color: white;
        border: 1px solid #ddd;
        padding: 10px 20px;
        border-radius: 5px;
        color: #555;
        font-size: 16px;
        text-decoration: none;
        transition: background-color 0.3s ease;
        margin-top: 0px; /* Điều chỉnh khoảng cách phía trên của nút */
    }

    .google-btn img {
        margin-right: 10px;
    }

    .google-btn:hover {
        background-color: #f5f5f5;
        border-color: #ccc;
    }

    .or-text {
        margin: 10px 0 5px 0; /* Điều chỉnh khoảng cách trên và dưới của đoạn văn "Or sign in with" */
        font-size: 14px;
        color: #555;
    }
</style>