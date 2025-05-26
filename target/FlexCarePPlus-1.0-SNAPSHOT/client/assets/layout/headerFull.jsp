<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/client/assets/layout/header.jsp"/>

<nav class="navbar navbar-expand-lg bg-white navbar-light shadow-sm py-3 py-lg-0 px-3 px-lg-0">
    <a href="index.html" class="navbar-brand ms-lg-5">
        <h1 class="m-0 text-uppercase text-dark"><i class="bi bi-shop fs-1 text-primary me-3"></i>FlexCareP+</h1>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto py-0">
            <a href="${pageContext.request.contextPath}/client/index.html" class="nav-item nav-link active">Home</a>
            <a href="${pageContext.request.contextPath}/client/about.html" class="nav-item nav-link">About</a>
            <a href="${pageContext.request.contextPath}/client/service.html" class="nav-item nav-link">Service</a>
            <a href="${pageContext.request.contextPath}/client/product.html" class="nav-item nav-link">News</a>
            <a href="contact.html" class="nav-item nav-link nav-contact bg-primary text-white px-5 ms-lg-5">Contact <i class="bi bi-arrow-right"></i></a>
                <c:choose>
                    <c:when test="${not empty sessionScope.userDetailDTO}">
                    <!-- User Avatar with Dropdown -->
                    <div class="nav-item dropdown ms-lg-3 d-flex align-items-center me-4 me-lg-5">
                        <a href="#" class="nav-link dropdown-toggle p-0" data-bs-toggle="dropdown" id="userDropdown" style="display:flex; align-items:center;">
                            <img src="${not empty sessionScope.userDetailDTO.avatar ? sessionScope.userDetailDTO.avatar : pageContext.request.contextPath.concat('/client/assets/img/hero.jpg')}" alt="User Avatar" class="rounded-circle p-3" width="87" height="87" 
                                 style="object-fit: cover;">
                        </a>
                        <div class="dropdown-menu dropdown-menu-end m-0" aria-labelledby="userDropdown">
                            <a href="userdetail?action=getUserDetail" class="dropdown-item"><i class="bi bi-person me-2"></i>View Profile</a>
                            <a href="wallet.html" class="dropdown-item"><i class="bi bi-wallet2 me-2"></i>View Wallet</a>
                            <a href="wallet.html" class="dropdown-item"><i class="bi bi-wallet2 me-2"></i>View Booking</a>
                            <div class="dropdown-divider"></div>
                            <a href="sign-in?actor=logout" class="dropdown-item text-danger"><i class="bi bi-box-arrow-right me-2"></i>Logout</a>
                        </div>
                        <!-- Bell Notification Icon -->
                        <div class="dropdown ms-2 d-flex align-items-center" style="height: 56px;">
                            <a href="#" class="nav-link p-0 position-relative d-flex align-items-center justify-content-center"
                               id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false"
                               style="width: 56px; height: 87px;">
                                <i class="bi bi-bell" style="font-size: 2rem; color: #7ac143;"></i>
                                <span class="position-absolute translate-middle badge rounded-pill bg-danger"
                                      style="font-size:0.8rem; left: 75%; top: 32%;">
                                    3
                                    <span class="visually-hidden">unread messages</span>
                                </span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown" style="min-width: 300px;">
                                <li class="dropdown-header">Notifications</li>
                                <li><a class="dropdown-item" href="#">Bạn có lịch hẹn mới</a></li>
                                <li><a class="dropdown-item" href="#">Đơn đặt dịch vụ đã xác nhận</a></li>
                                <li><a class="dropdown-item" href="#">Tin nhắn mới từ admin</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-center" href="#">Xem tất cả</a></li>
                            </ul>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- User is not logged in - Show Sign In Button -->
                    <div class="nav-item ms-lg-3 d-flex align-items-center me-4 me-lg-5">
                        <a href="${pageContext.request.contextPath}/sign-in" class="nav-link d-flex align-items-center">
                            <i class="bi bi-person-circle fs-5 me-2"></i>
                            <span>Sign In</span>
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>         
        </div>
    </div>
</nav>
<!-- Navbar End -->
