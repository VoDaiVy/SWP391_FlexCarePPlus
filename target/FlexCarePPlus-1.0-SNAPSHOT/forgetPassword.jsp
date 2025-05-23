<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/client/assets/layout/header.jsp"/>
<div class="login-container">
    <div class="container" id="container">
        <div class="form-container sign-in-container">
            <form action="sign-in" method="post">
                <h1>Forget Password</h1>
                <input id="email" type="email" name="email" placeholder="Email" required/>
                <div id="email-error" style="color: red; font-size: 14px; display: none; margin-bottom: 10px"></div>
                <button id="forgetBtn" type="submit" value="forgetPassword" name="action" class="login-btn">Reset Password</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-right">
                    <h1>Welcome Back!</h1>
                    <p>To keep connected with us please login with your personal info</p>
                    <a class="ghost aonly" href="sign-in">Sign In</a>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    .aonly{
        border-radius: 20px;
        border: 1px solid #81c408;
        background-color: #81c408;
        color: #FFFFFF;
        font-size: 12px;
        font-weight: bold;
        padding: 12px 45px;
        letter-spacing: 1px;
        text-transform: uppercase;
        transition: transform 80ms ease-in;
    }

    a.ghost{
        background-color: transparent;
        border-color: #FFFFFF;
    }
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

<script>
    var checkWrongFormatEmail = true;
    const emailInput = document.getElementById("email");
    const errorDiv = document.getElementById("email-error");
    function isValidEmail(email) {
        // Regex kiểm tra định dạng email
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    emailInput.addEventListener("input", function () {
        var forgetButton = document.getElementById("forgetBtn");
        const email = emailInput.value.trim();
        checkWrongFormatEmail = email !== "" && !isValidEmail(email);
        if (checkWrongFormatEmail) {
            errorDiv.textContent = "Email không đúng định dạng.";
            errorDiv.style.display = "block";
        } else {
            errorDiv.textContent = "";
            errorDiv.style.display = "none";
            document.getElementById("email").addEventListener("blur", function () {
                const email = this.value;
                const errorDiv = document.getElementById("email-error");

                // Gửi request đến servlet
                fetch("sign-in", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/x-www-form-urlencoded"
                    },
                    body: `email=` + email + `+&action=checkEmail`
                })
                        .then(response => response.text())
                        .then(data => {
                            var forgetButton = document.getElementById("forgetBtn");
                            const isExisted = (data.trim() === "true"); // nhận kết quả boolean từ server

                            if (isExisted) {

                                forgetButton.disabled = false;
                            } else {
                                errorDiv.textContent = "Email does not register!";
                                errorDiv.style.display = "block";
                                forgetButton.disabled = true;
                            }
                        })
                        .catch(error => {
                            errorDiv.textContent = "Có lỗi xảy ra khi kiểm tra email.";
                            console.error("Lỗi:", error);
                        });
            });
        }
    });
</script>