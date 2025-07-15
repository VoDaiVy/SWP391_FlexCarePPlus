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
                <li class="nav-item">
                    <a href="home"
                       class="nav-link active">Home</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/client/about.jsp" class="nav-link">About</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/service?action=viewListService"
                       class="nav-link">Service</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/news?action=viewListNews" class="nav-link">News</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/policy?action=viewListPolicy" class="nav-link">Policy</a>
                </li>
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/client/contact.jsp"
                       class="nav-link">Contact</a>
                </li>
            </ul>
            <!-- Avatar/Sign In sát phải -->
            <c:choose>
                <c:when test="${not empty sessionScope.userDetailDTO}">
                    <div class="nav-item dropdown ms-lg-3 d-flex align-items-center me-4 me-lg-5" style="margin-right:16px;">
                        <!-- Bell Notification Icon -->
                        <div class="dropdown d-flex align-items-center" style="height: 56px; margin-right: 16px;">
                            <a href="#"
                               class="nav-link p-0 position-relative d-flex align-items-center justify-content-center"
                               id="notificationDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-bell" style="font-size: 2rem; color: #7ac143;"></i>
                                <span class="position-absolute translate-middle badge rounded-pill bg-danger"
                                      id="notificationBadge"
                                      style="font-size:0.8rem; left: 75%; top: 32%; display: none">
                                    
                                </span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="notificationDropdown"
                                style="min-width: 300px;" id="notificationDropdownMenu">
                                <li class="dropdown-header d-flex justify-content-between align-items-center">
                                    Notifications
                                    <button id="markAllReadBtn" class="btn btn-link btn-sm p-0" style="font-size:0.9rem;">Đánh dấu tất cả đã đọc</button>
                                </li>
                                <li id="notificationListEmpty"><span class="dropdown-item text-muted">Không có thông báo nào</span></li>
                                <li>
                                    <ul id="notificationListItems" style="padding-left:0; margin-bottom:0;"></ul>
                                </li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li><a class="dropdown-item text-center" id="viewAllNotificationsBtn" href="#">Xem tất cả</a></li>
                            </ul>
                        </div>
                        <!-- Cart Icon  -->
                        <div class="d-flex align-items-center" style="height: 56px; margin-right: 16px;">
                            <a href="${pageContext.request.contextPath}/booking?action=viewCart"
                               class="nav-link p-0 position-relative d-flex align-items-center justify-content-center"
                               style="width: 56px; height: 87px;">
                                <i class="bi bi-cart3" style="font-size: 2rem; color: #7ac143;"></i> 
                            </a>
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
                            <a href="booking?action=viewBooking" class="dropdown-item"><i class="bi bi-calendar-check me-2"></i>View
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

<script>
    // Chỉ thực hiện khi đã đăng nhập và có icon giỏ hàng
    document.addEventListener('DOMContentLoaded', function () {
        const cartIcon = document.querySelector('.bi-cart3');
        if (cartIcon) {
            const savedCartCount = localStorage.getItem('cartCount');
            if (savedCartCount && parseInt(savedCartCount) > 0) {
                updateCartBadge(parseInt(savedCartCount));
            }

            window.updateCartCount = function () {
                fetch('booking?action=getCartCount')
                        .then(response => response.json())
                        .then(data => {
                            localStorage.setItem('cartCount', data.count);
                            updateCartBadge(data.count);
                        })
                        .catch(error => console.error('Error updating cart count:', error));
            };
            window.updateCartBadge = function (count) {
                const badgeContainer = cartIcon.closest('a');
                let badgeElement = badgeContainer.querySelector('.badge');
                if (count > 0) {
                    if (badgeElement) {
                        badgeElement.textContent = count;
                    } else {
                        badgeElement = document.createElement('span');
                        badgeElement.className = 'position-absolute translate-middle badge rounded-pill bg-danger';
                        badgeElement.style.fontSize = '0.8rem';
                        badgeElement.style.left = '75%';
                        badgeElement.style.top = '32%';
                        badgeElement.textContent = count;
                        const visually = document.createElement('span');
                        visually.className = 'visually-hidden';
                        visually.textContent = 'items in cart';
                        badgeElement.appendChild(visually);
                        badgeContainer.appendChild(badgeElement);
                    }
                } else {
                    if (badgeElement) {
                        badgeElement.remove();
                    }
                }
            };
            updateCartCount();
            setInterval(updateCartCount, 15000);
        }
    }
    );
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        window.fetchNotifications = function () {
            fetch('notification?action=getNotificationForUser', {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                }
            })
                    .then(response => {
                        if (!response.ok)
                            throw new Error("Unauthorized or error");
                        return response.json();
                    })
                    .then(data => {
                        renderNotifications(data);
                    })
                    .catch(error => {
                        console.error('Error loading notifications:', error);
                    });
        };

        function renderNotifications(data) {
            var listEmpty = document.getElementById('notificationListEmpty');
            var listItems = document.getElementById('notificationListItems');

            // Xoá hết li cũ (trừ header)
            listItems.querySelectorAll('li').forEach(li => li.remove());
            // Xóa tất cả các li cũ trong listItems


            if (data.length === 0) {
                listEmpty.style.display = 'block';
                badge.style.display = 'none';
            } else {
                listEmpty.style.display = 'none';
                for (var i = 0; i < data.length; i++) {
                    var noti = data[i];
                    console.log(noti);
                    var li = document.createElement('li');
                    var a = document.createElement('a');
                    a.className = 'dropdown-item d-flex justify-content-between align-items-center';
                    a.href = '#';
                    a.textContent = noti.content;
                    if (!noti.hasRead) {
                        a.style.fontWeight = 'bold';
                        a.style.color = '';
                    } else {
                        a.style.fontWeight = 'normal';
                        a.style.color = '#888';
                    }
                    // Sử dụng let để đảm bảo mỗi onclick lấy đúng ID
                    let notificationID = noti.notificationID;
                    a.onclick = function(e) {
                        e.preventDefault();
                        console.log('action=readNotification&notificationID=' + encodeURIComponent(notificationID));
                        fetch('notification', {
                            method: 'POST',
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: 'action=readNotification&notificationID=' + encodeURIComponent(notificationID)
                        }).then(function() { 
                            fetchNotifications(); 
                            fetchUnreadCount();
                        });
                    };
                    li.appendChild(a);
                    listItems.appendChild(li);
                }
            }
        }

        // Gọi lần đầu + sau đó mỗi 2s
        fetchNotifications();
        setInterval(fetchNotifications, 2000);
    });
</script>
<!-- Thêm sau khi DOM đã load -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var viewAllBtn = document.getElementById('viewAllNotificationsBtn');
        if (viewAllBtn) {
            viewAllBtn.onclick = function (e) {
                e.preventDefault();
                fetch('notification', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: 'action=readAllMessage'
                }).then(function () {
                    if (typeof fetchNotifications === 'function') {
                        fetchNotifications();
                        fetchUnreadCount();
                    }

                });
            };
        }
    });
</script>
<script>
    window.fetchUnreadCount = function () {
        var badge = document.getElementById('notificationBadge');
        fetch('notification?action=countUnreadNotifications', {
            method: 'GET',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            }
        })
                .then(response => {
                    if (!response.ok)
                        throw new Error("Unauthorized or error");
                    return response.json();
                })
                .then(data => {
                    if (badge) {
                        if (data && data.count > 0) {
                            badge.style.display = '';
                            badge.textContent = data.count;
                        } else {
                            badge.style.display = 'none';
                        }
                    }
                })
                .catch(function () {
                    var badge = document.getElementById('notificationBadge');
                    if (badge)
                        badge.style.display = 'none';
                });
    };
    fetchUnreadCount();
    setInterval(fetchUnreadCount, 2000);
</script>
