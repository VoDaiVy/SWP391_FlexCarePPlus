<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>
<div class="login-container">
    <div class="container" id="container">
        <div class="password-container">
            <form id="verifyForm" action="#" method="post">
                <h1>Verify Email</h1>
                <input type="text" name="key" id="keyInput" placeholder="Mã xác thực" required />
                <button class="login-btn">Verify Email</button>
            </form>
        </div>
    </div>
</div>

<!-- Popup thành công -->
<div id="successModal" class="modal">
    <div class="modal-content">
        <div class="modal-icon-text">
            <img src="https://cdn-icons-png.flaticon.com/512/190/190411.png" alt="Success" class="icon-tick" />
            <p>Xác minh thành công!</p>
        </div>
        <form action="sign-in" method="post">
            <input type="hidden" name="action" value="verifyEmail">
            <button name="status" value="right" type="submit" class="ok-button">OK</button>
        </form>
    </div>
</div>

<!-- Popup thất bại -->
<div id="failModal" class="modal">
    <div class="modal-content">
        <div class="modal-icon-text">
            <img src="https://cdn-icons-png.flaticon.com/512/1828/1828665.png" alt="Fail" class="icon-cross" />
            <p>Mã xác thực không đúng!</p>
        </div>
        <form action="sign-in" method="post">
            <input type="hidden" name="action" value="verifyEmail">
            <button name="status" value="wrong" type="submit" class="ok-button fail">OK</button>
        </form>
    </div>
</div>

<!-- CSS để điều chỉnh khoảng cách và làm đẹp Sign In with Google -->
<style>
    .ok-button {
        display: inline-block;
        margin-top: 10px;
        padding: 8px 20px;
        border: none;
        border-radius: 5px;
        font-weight: bold;
        font-size: 16px;
        cursor: pointer;
        background-color: #28a745;
        color: white;
        transition: background-color 0.3s ease;
    }
    .ok-button:hover {
        background-color: #218838;
    }
    .ok-button.fail {
        background-color: #dc3545;
    }
    .ok-button.fail:hover {
        background-color: #c82333;
    }


    .icon-tick {
        width: 32px;
        height: 32px;
    }

    .icon-cross {
        width: 32px;
        height: 32px;
    }
    .modal {
        display: none;
        position: fixed;
        z-index: 999;
        padding-top: 150px;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.4);
    }

    .password-container{
        padding: 100px;
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

    .modal-content {
        background-color: white;
        margin: auto;
        padding: 30px 40px;
        border: 1px solid #ddd;
        border-radius: 10px;
        width: 400px; /* tăng chiều rộng box */
        text-align: center;
        color: #555;
        font-size: 16px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        word-wrap: break-word; /* ngắt từ nếu cần */
    }

    .modal-icon-text {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 12px;
        margin-bottom: 20px;
        flex-wrap: wrap; /* Cho phép xuống dòng nếu icon + text dài */
    }

    .modal-icon-text p {
        margin: 0;
        font-size: 18px;
        line-height: 1.4;
        max-width: 300px;
        word-break: break-word;
    }

</style>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const form = document.getElementById("verifyForm");
        const keyInput = document.getElementById("keyInput");

        const successModal = document.getElementById("successModal");
        const failModal = document.getElementById("failModal");

        // Đọc session key từ JSP và ép về string
        const sessionKey = "${sessionScope.key}";

        form.addEventListener("submit", function (e) {
            e.preventDefault(); // Ngăn reload

            const userKey = keyInput.value.trim();

            if (userKey === sessionKey) {
                successModal.style.display = "block";
            } else {
                failModal.style.display = "block";
            }
        });
    });
</script>

