<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

<div class="container-fluid bg-light mt-5 py-5">
    <div class="container pt-5">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Get In Touch</h5>
                <p class="mb-4">At FlexCareP+, we offer personalized pet care, grooming, and health services to keep your furry friends happy and healthy every day.</p>
                <p class="mb-2"><i class="bi bi-geo-alt text-primary me-2"></i>FPT City, Ngu Hanh Son, Da Nang</p>
                <p class="mb-2"><i class="bi bi-envelope-open text-primary me-2"></i>flexcarepplus@gmail.com</p>
                <p class="mb-0"><i class="bi bi-telephone text-primary me-2"></i>0767658269</p>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Quick Links</h5>
                <div class="d-flex flex-column justify-content-start">
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Home</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>About Us</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Our Services</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Meet The Team</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Latest Blog</a>
                    <a class="text-body" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Contact Us</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Popular Links</h5>
                <div class="d-flex flex-column justify-content-start">
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Home</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>About Us</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Our Services</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Meet The Team</a>
                    <a class="text-body mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Latest Blog</a>
                    <a class="text-body" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Contact Us</a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Newsletter</h5>
                <form action="">
                    <div class="input-group">
                        <input type="text" class="form-control p-3" placeholder="Your Email">
                        <button class="btn btn-primary">Sign Up</button>
                    </div>
                </form>
                <h6 class="text-uppercase mt-4 mb-3">Follow Us</h6>
                <div class="d-flex">
                    <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-twitter"></i></a>
                    <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-facebook"></i></a>
                    <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-linkedin"></i></a>
                    <a class="btn btn-outline-primary btn-square" href="#"><i class="bi bi-instagram"></i></a>
                </div>
            </div>
            <div class="col-12 text-center text-body">
                <a class="text-body" href="">Terms & Conditions</a>
                <span class="mx-1">|</span>
                <a class="text-body" href="">Privacy Policy</a>
                <span class="mx-1">|</span>
                <a class="text-body" href="">Customer Support</a>
                <span class="mx-1">|</span>
                <a class="text-body" href="">Payments</a>
                <span class="mx-1">|</span>
                <a class="text-body" href="">Help</a>
                <span class="mx-1">|</span>
                <a class="text-body" href="">FAQs</a>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid bg-dark text-white-50 py-4">
    <div class="container">
        <div class="row g-5">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-md-0">&copy; <a class="text-white" href="#">FlexCareP+</a>. All Rights Reserved.</p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <p class="mb-0">Designed by <a class="text-white" href="https://htmlcodex.com">FlexCareP+</a></p>
            </div>
        </div>
    </div>
</div>


<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-primary py-3 fs-4 back-to-top"><i class="bi bi-arrow-up"></i></a>
<!-- Chat Button -->
<c:if test="${not empty sessionScope.userDetailDTO}">
    <!-- Chat Icon -->
    <div class="chat-icon" onclick="toggleChat()">
        <i class="fas fa-comments"></i>
    </div>

    <!-- Chat Box -->
    <div class="chat-box" id="chatBox">
        <div class="chat-header">
            Chat Support ${sessionScope.userDetailDTO.user.userId}
            <span class="close-btn" onclick="closeChat()">&times;</span>
        </div>
        <div class="chat-messages" id="chatMessages"></div>
        <div class="chat-input">
            <input type="text" id="chatInput" class="form-control" placeholder="Enter your message">
            <button class="btn btn-primary" onclick="sendMessage()">Send</button>
        </div>
    </div>

    <!-- STYLE -->
    <style>
        .chat-icon {
            position: fixed;
            bottom: 20px;
            left: 20px;
            background-color: #8ecc7d;
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 28px;
            cursor: pointer;
            z-index: 1000;
        }

        .chat-box {
            position: fixed;
            bottom: 90px;
            left: 50px;
            width: 320px;
            height: 400px;
            border: 1px solid #ccc;
            background-color: white;
            border-radius: 10px;
            display: none;
            flex-direction: column;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            z-index: 9999;
        }

        .chat-box.active {
            display: flex;
        }

        .chat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 15px;
            border-bottom: 1px solid #ccc;
            font-weight: bold;
            background-color: #f8f9fa;
        }

        .chat-messages {
            flex: 1;
            overflow-y: auto;
            padding: 10px;
            display: flex;
            flex-direction: column;
        }

        .message {
            padding: 8px 12px;
            border-radius: 18px;
            max-width: 75%;
            margin-bottom: 10px;
            word-wrap: break-word;
        }

        .user {
            align-self: flex-end;
            background-color: #dcf8c6;
        }

        .bot {
            align-self: flex-start;
            background-color: #f1f0f0;
        }

        .chat-input {
            display: flex;
            padding: 10px;
            border-top: 1px solid #ccc;
            background-color: white;
        }

        .chat-input input {
            flex: 1;
            margin-right: 5px;
        }

        .close-btn {
            cursor: pointer;
            color: #888;
            font-size: 20px;
        }

        .close-btn:hover {
            color: #333;
        }
    </style>

    <!-- SCRIPT -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const chatBox = document.getElementById('chatBox');
            const chatMessages = document.getElementById('chatMessages');
            const chatInput = document.getElementById('chatInput');
            const senderID = ${sessionScope.userDetailDTO.user.userId};

            function isNearBottom() {
                const threshold = 0; 
                return chatMessages.scrollHeight - chatMessages.scrollTop - chatMessages.clientHeight < threshold;
            }

            window.getMessages = function () {
                fetch('message?senderID=' + senderID + '&receiverID=8', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    }
                })
                        .then(response => response.json())  // Nhận kết quả dưới dạng JSON
                        .then(datas => {
                            chatMessages.innerHTML = '';
                            datas.forEach(data => {
                                const msgDiv = document.createElement('div');
                                msgDiv.className = 'message ' + (data.userID === senderID ? 'user' : 'bot');
                                msgDiv.innerHTML = data.content;
                                chatMessages.appendChild(msgDiv);
                            });
                            if (isNearBottom) {
                                scrollToBottom();
                            }
                        })
                        .catch(error => console.error('Error:', error));
            };

            setInterval(() => {
                getMessages();
            }, 500);

            window.toggleChat = function () {
                chatBox.classList.toggle('active');
                if (chatBox.classList.contains('active')) {
                    scrollToBottom();
                }
            };

            window.closeChat = function () {
                chatBox.classList.remove('active');
            };

            function scrollToBottom() {
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            window.sendMessage = function () {
                const text = chatInput.value.trim();
                if (!text)
                    return;
                chatInput.value = '';

                fetch('message', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        senderID: senderID,
                        receiverID: 8,
                        content: text
                    })
                })
                        .then(() => {
                            getMessages();
                            scrollToBottom();
                        })
                        .catch(error => console.error('Send error:', error));

            };

            chatInput.addEventListener('keydown', function (event) {
                if (event.key === 'Enter') {
                    event.preventDefault();
                    sendMessage();
                }
            });
        });
    </script>
</c:if>


<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/client/assets/lib/easing/easing.min.js"></script>
<script src="${pageContext.request.contextPath}/client/assets/lib/waypoints/waypoints.min.js"></script>
<script src="${pageContext.request.contextPath}/client/assets/lib/owlcarousel/owl.carousel.min.js"></script>

<!-- Template Javascript -->
<script src="${pageContext.request.contextPath}/client/assets/js/main.js"></script>