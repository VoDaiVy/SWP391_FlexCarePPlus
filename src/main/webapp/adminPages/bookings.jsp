<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Booking Management - FlexCareP+</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .avatar-md { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; }
        .table th, .table td { vertical-align: middle; }
        .datepicker { max-width: 200px; }
    </style>
</head>
<body data-topbar="dark">
    <div id="layout-wrapper">
        <jsp:include page="/adminPages/assets/includes/header.jsp" />
        <jsp:include page="/adminPages/assets/includes/navbar.jsp" />
        <div class="main-content">
            <div class="page-content">
                <div class="container-fluid">
                    <div class="page-title-box d-flex align-items-center justify-content-between">
                        <h4 class="mb-0">Booking Management</h4>
                    </div>
                    <div class="mb-4 row g-3 align-items-end">
                        <div class="col-auto">
                            <form class="d-flex" action="admin" method="get" id="dateFilterForm">
                                <input type="hidden" name="action" value="getBookings" />
                                <div>
                                    <label for="selectedDate" class="form-label mb-0">Chọn ngày</label>
                                    <input type="date" class="form-control" id="selectedDate" name="selectedDate" value="${selectedDate}" />
                                </div>
                                <div class="ms-2">
                                    <button type="submit" class="btn btn-primary mt-4"><i class="fas fa-filter me-1"></i>Lọc</button>
                                </div>
                            </form>
                        </div>
                        <div class="col-auto ms-4">
                            <select class="form-select" id="status" autocomplete="off" style="min-width: 160px;">
                                <option value="">ALL</option>
                                <option value="CANCEL">CANCEL</option>
                                <option value="CART">CART</option>
                                <option value="PENDINGPAYMENT">PENDINGPAYMENT</option>
                                <option value="BOOKED">BOOKED</option>
                                <option value="FINISHED">FINISHED</option>
                                <option value="NEXTBOOKING">NEXTBOOKING</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <c:choose>
                            <c:when test="${not empty bookings}">
                                <div class="row g-4" id="bookingCards">
                                    <c:forEach var="booking" items="${bookings}">
                                        <div class="col-12 col-md-6 col-lg-4 booking-card" data-status="${booking.state}">
                                            <div class="card h-100 shadow-sm">
                                                <div class="card-body d-flex flex-column">
                                                    <div class="d-flex align-items-center mb-3 justify-content-between">
                                                        <div class="d-flex align-items-center">
                                                            <img class="avatar-md me-3" src="${userDetails[booking.userID].avatar}" alt="avatar" onerror="this.src='${pageContext.request.contextPath}/adminPages/assets/images/users/avatar-1.jpg'" />
                                                            <div>
                                                                <div class="fw-bold">${userDetails[booking.userID].firstName} ${userDetails[booking.userID].lastName}</div>
                                                                <div class="text-muted small">${users[booking.userID].email}</div>
                                                            </div>
                                                        </div>
                                                        <a href="admin?action=getBookingDetails&bookingID=${booking.bookingID}" class="btn btn-outline-secondary btn-sm" title="Xem chi tiết">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                    </div>
                                                    <div class="mb-2"><i class="fa fa-calendar-alt me-1"></i> <span class="fw-semibold">${booking.dateBooked}</span></div>
                                                    <div class="mb-2">
                                                        <span class="badge 
                                                            <c:choose>
                                                                <c:when test="${booking.state == 'FINISHED'}">bg-success</c:when>
                                                                <c:when test="${booking.state == 'BOOKED'}">bg-primary</c:when>
                                                                <c:when test="${booking.state == 'CANCEL'}">bg-danger</c:when>
                                                                <c:when test="${booking.state == 'PENDINGPAYMENT'}">bg-warning text-dark</c:when>
                                                                <c:when test="${booking.state == 'CART'}">bg-secondary</c:when>
                                                                <c:when test="${booking.state == 'NEXTBOOKING'}">bg-info text-dark</c:when>
                                                                <c:otherwise>bg-light text-dark</c:otherwise>
                                                            </c:choose>">
                                                            ${booking.state}
                                                        </span>
                                                    </div>
                                                    <div class="mb-2"><strong>Ghi chú:</strong> ${booking.note}</div>
                                                    <div class="mb-2"><strong>Tổng tiền:</strong> <fmt:formatNumber value="${booking.totalPrice}" type="number" maxFractionDigits="0" groupingUsed="true" /> VND</div>
                                                    <div class="mb-2"><strong>Đã thanh toán:</strong> <fmt:formatNumber value="${booking.paid}" type="number" maxFractionDigits="0" groupingUsed="true" /> VND</div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-muted py-5">Không có booking nào cho ngày này.</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
            <jsp:include page="/adminPages/assets/includes/footer.jsp" />
        </div>
    </div>
    <jsp:include page="/adminPages/assets/includes/rightbar.jsp" />
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>
    <script>
        // Lọc booking theo trạng thái bằng JS, realtime
        document.addEventListener('DOMContentLoaded', function () {
            var statusSelect = document.getElementById('status');
            var container = document.getElementById('bookingCards');
            function filterCards() {
                var value = statusSelect.value;
                var cards = container.querySelectorAll('.booking-card');
                var anyVisible = false;
                cards.forEach(function(card) {
                    if (!value || card.getAttribute('data-status') === value) {
                        card.style.display = '';
                        anyVisible = true;
                    } else {
                        card.style.display = 'none';
                    }
                });
                var emptyMsg = document.getElementById('noBookingMsg');
                if (!anyVisible && container) {
                    if (!emptyMsg) {
                        emptyMsg = document.createElement('div');
                        emptyMsg.id = 'noBookingMsg';
                        emptyMsg.className = 'text-center text-muted py-5';
                        emptyMsg.innerText = 'Không có booking nào cho trạng thái này.';
                        container.parentNode.appendChild(emptyMsg);
                    }
                } else if (emptyMsg) {
                    emptyMsg.remove();
                }
            }
            statusSelect.addEventListener('change', filterCards);
            // Lọc realtime khi trang vừa load (nếu có giá trị mặc định)
            filterCards();
        });
    </script>
</body>
</html>

