<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Booking Details - FlexCareP+</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .avatar-md { width: 48px; height: 48px; border-radius: 50%; object-fit: cover; }
        .service-img { width: 64px; height: 64px; border-radius: 8px; object-fit: cover; }
        .card { box-shadow: 0 2px 8px rgba(0,0,0,0.1); border: none; border-radius: 8px; margin-bottom: 20px; }
        .filter-section { margin-bottom: 24px; }
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
                        <h4 class="mb-0">Booking Details</h4>
                        <a href="admin?action=getBookings" class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i>Back to Bookings</a>
                    </div>
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title mb-3">Booking Info</h5>
                            <div class="row g-3">
                                <div class="col-md-4"><strong>Booking ID:</strong> ${booking.bookingID}</div>
                                <div class="col-md-4"><strong>User ID:</strong> ${booking.userID}</div>
                                <div class="col-md-4"><strong>Date Booked:</strong> ${booking.dateBooked}</div>
                                <div class="col-md-4"><strong>Status:</strong> <span class="badge 
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
                                </span></div>
                                <div class="col-md-4"><strong>Total Price:</strong> <fmt:formatNumber value="${booking.totalPrice}" type="number" maxFractionDigits="0" groupingUsed="true" /> VND</div>
                                <div class="col-md-4"><strong>Paid:</strong> <fmt:formatNumber value="${booking.paid}" type="number" maxFractionDigits="0" groupingUsed="true" /> VND</div>
                                <div class="col-md-12"><strong>Note:</strong> ${booking.note}</div>
                            </div>
                        </div>
                    </div>
                    <div class="filter-section row align-items-end mb-3">
                        <div class="col-md-4">
                            <label for="serviceFilter" class="form-label">Filter by Service</label>
                            <select class="form-select" id="serviceFilter">
                                <option value="">All Services</option>
                                <c:forEach var="service" items="${services.values()}">
                                    <option value="${service.serviceID}">${service.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row g-4" id="bookingDetailCards">
                        <c:choose>
                            <c:when test="${not empty bookingDetails}">
                                <c:forEach var="detail" items="${bookingDetails}">
                                    <c:set var="service" value="${services[detail.serviceID]}" />
                                    <div class="col-12 col-md-6 col-lg-4 booking-detail-card" data-service="${service.serviceID}">
                                        <div class="card h-100">
                                            <div class="card-body d-flex flex-column">
                                                <div class="d-flex align-items-center mb-3">
                                                    <img class="service-img me-3" src="${service.imgURL}" alt="service image" onerror="this.src='${pageContext.request.contextPath}/adminPages/assets/images/no-image.png'" />
                                                    <div>
                                                        <div class="fw-bold">${service.name}</div>
                                                        <div class="text-muted small">Service ID: ${service.serviceID}</div>
                                                    </div>
                                                </div>
                                                <div class="mb-2"><strong>Time Slot:</strong> 
                                                    <c:out value="${detail.startTime}" /> - <c:out value="${detail.endTime}" />
                                                </div>
                                                <div class="mb-2"><strong>Date Start:</strong> <c:out value="${detail.dateStartService}" /></div>
                                                <div class="mb-2"><strong>Date End:</strong> <c:out value="${detail.dateEndService}" /></div>
                                                <div class="mb-2"><strong>Room ID:</strong> <c:out value="${detail.roomID}" /></div>
                                                <div class="mb-2"><strong>Pet ID:</strong> <c:out value="${detail.userPetID}" /></div>
                                                <div class="mb-2"><strong>Price:</strong> <fmt:formatNumber value="${detail.price}" type="number" maxFractionDigits="0" groupingUsed="true" /> VND</div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center text-muted py-5">No booking details found for this booking.</div>
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
    <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>
    <script>
        // Service filter JS
        document.addEventListener('DOMContentLoaded', function () {
            var serviceSelect = document.getElementById('serviceFilter');
            var cards = document.querySelectorAll('.booking-detail-card');
            serviceSelect.addEventListener('change', function () {
                var value = serviceSelect.value;
                var anyVisible = false;
                cards.forEach(function(card) {
                    if (!value || card.getAttribute('data-service') === value) {
                        card.style.display = '';
                        anyVisible = true;
                    } else {
                        card.style.display = 'none';
                    }
                });
                var emptyMsg = document.getElementById('noDetailMsg');
                if (!anyVisible) {
                    if (!emptyMsg) {
                        emptyMsg = document.createElement('div');
                        emptyMsg.id = 'noDetailMsg';
                        emptyMsg.className = 'text-center text-muted py-5';
                        emptyMsg.innerText = 'No booking details for this service.';
                        document.getElementById('bookingDetailCards').appendChild(emptyMsg);
                    }
                } else if (emptyMsg) {
                    emptyMsg.remove();
                }
            });
        });
    </script>
</body>
</html>
