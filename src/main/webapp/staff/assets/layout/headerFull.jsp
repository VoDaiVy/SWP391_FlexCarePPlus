<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/client/assets/layout/header.jsp" />

<nav class="navbar navbar-expand-lg bg-white navbar-light shadow-sm py-3 py-lg-0 px-3 px-lg-0">
    <div class="container-fluid">
        <!-- Logo sát trái -->
        <a href="index.html" class="navbar-brand ms-lg-0" style="padding-left:16px;">
            <h1 class="m-0 text-uppercase text-dark">
                <i class="bi bi-shop fs-1 text-primary me-3"></i>FlexCareP+
            </h1>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse">
            <!-- Menu giữa -->
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
            </ul>
            <!-- Avatar/Sign In sát phải -->
            <c:choose>
                <c:when test="${not empty sessionScope.userDetailDTO}">
                    <div class="nav-item dropdown ms-lg-3 d-flex align-items-center me-4 me-lg-5" style="margin-right:16px;">
                        <!-- Bell Notification Icon (đưa lên trước) -->
                        <div class="dropdown d-flex align-items-center" style="height: 56px; margin-right: 16px;">
                            <a href="#"
                               class="nav-link p-0 position-relative d-flex align-items-center justify-content-center"
                               id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false"
                               style="width: 56px; height: 87px;">
                                <i class="bi bi-bell" style="font-size: 2rem; color: #7ac143;"></i>
                                <span class="position-absolute translate-middle badge rounded-pill bg-danger"
                                      style="font-size:0.8rem; left: 75%; top: 32%;">
                                    3
                                    <span class="visually-hidden">unread messages</span>
                                </span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown"
                                style="min-width: 300px;">
                                <li class="dropdown-header">Notifications</li>
                                <li><a class="dropdown-item" href="#">Bạn có lịch hẹn mới</a></li>
                                <li><a class="dropdown-item" href="#">Đơn đặt dịch vụ đã xác nhận</a></li>
                                <li><a class="dropdown-item" href="#">Tin nhắn mới từ admin</a></li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item text-center" href="#">Xem tất cả</a></li>
                            </ul>
                        </div>
                        <!-- User Avatar with Dropdown -->
                        <a href="#" class="nav-link dropdown-toggle p-0" data-bs-toggle="dropdown"
                           id="userDropdown" style="display:flex; align-items:center;">
                            <img src="${not empty sessionScope.userDetailDTO.avatar ? sessionScope.userDetailDTO.avatar : pageContext.request.contextPath.concat('/client/assets/img/hero.jpg')}"
                                 alt="User Avatar" class="rounded-circle p-3" width="87" height="87"
                                 style="object-fit: cover;">
                        </a>
                        <div class="dropdown-menu dropdown-menu-end m-0" aria-labelledby="userDropdown">
                            <a href="userdetail?action=getUserDetail" class="dropdown-item"><i
                                    class="bi bi-person me-2"></i>View Profile</a>
                            <a href="wallet?action=getWallet" class="dropdown-item"><i class="bi bi-wallet2 me-2"></i>View
                                Wallet</a>
                            <a href="wallet.html" class="dropdown-item"><i class="bi bi-wallet2 me-2"></i>View
                                Booking</a>
                            <div class="dropdown-divider"></div>
                            <a href="sign-in?actor=logout" class="dropdown-item text-danger"><i
                                    class="bi bi-box-arrow-right me-2"></i>Logout</a>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="nav-item d-flex align-items-center" style="margin-right:16px;">
                        <a href="${pageContext.request.contextPath}/sign-in"
                           class="nav-link d-flex align-items-center">
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