<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    .booking-card {
        transition: transform 0.2s;
        border-left: 4px solid #007bff;
    }
    .booking-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    .status-badge {
        font-size: 0.75rem;
        padding: 4px 8px;
    }
    .booking-meta {
        font-size: 0.9rem;
        color: #6c757d;
    }
    .pagination-info {
        font-size: 0.9rem;
        color: #6c757d;
    }
</style>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">My Bookings</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="home">Home</a> / <span class="text-white">My Bookings</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Booking List Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <c:choose>
                    <c:when test="${not empty bookingDetails}">
                        <!-- Pagination Info -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="pagination-info">
                                Showing ${startItem} to ${endItem} of ${totalBookings} bookings
                            </div>
                            <div class="pagination-info">
                                Page ${currentPage} of ${totalPages}
                            </div>
                        </div>

                        <div class="row">
                            <c:forEach var="detail" items="${bookingDetails}">
                                <div class="col-md-6 col-lg-4 mb-4">
                                    <div class="card booking-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-start mb-3">
                                                <h5 class="card-title mb-0">${detail.service.name}</h5>
                                                <c:choose>
                                                    <c:when test="${detail.booking.state == 'PENDINGPAYMENT'}">
                                                        <span class="badge bg-warning status-badge">Pending Payment</span>
                                                    </c:when>
                                                    <c:when test="${detail.booking.state == 'BOOKED'}">
                                                        <span class="badge bg-success status-badge">Confirmed</span>
                                                    </c:when>
                                                    <c:when test="${detail.booking.state == 'CANCEL'}">
                                                        <span class="badge bg-danger status-badge">Cancelled</span>
                                                    </c:when>
                                                    <c:when test="${detail.booking.state == 'NEXTBOOKING'}">
                                                        <span class="badge bg-info status-badge">Upcoming</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary status-badge">${detail.booking.state}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>

                                            <div class="booking-meta mb-3">
                                                <c:choose>
                                                    <c:when test="${detail.service.categoryServiceID == 3}">
                                                        <fmt:parseDate value="${detail.dateStartService}" pattern="yyyy-MM-dd" var="checkInDate" />
                                                        <fmt:parseDate value="${detail.dateEndService}" pattern="yyyy-MM-dd" var="checkOutDate" />
                                                        <fmt:formatDate value="${checkInDate}" pattern="dd/MM/yyyy" var="formattedCheckInDate" />
                                                        <fmt:formatDate value="${checkOutDate}" pattern="dd/MM/yyyy" var="formattedCheckOutDate" />

                                                        <div class="mb-2">
                                                            <i class="bi bi-calendar-check me-2"></i>
                                                            <strong>Check-in:</strong> ${formattedCheckInDate} at ${fn:substring(detail.startTime, 0, 5)}
                                                        </div>
                                                        <div class="mb-2">
                                                            <i class="bi bi-calendar-x me-2"></i>
                                                            <strong>Check-out:</strong> ${formattedCheckOutDate} at ${fn:substring(detail.endTime, 0, 5)}
                                                        </div>
                                                        <div class="mb-2">
                                                            <i class="bi bi-clock me-2"></i>
                                                            <strong>Duration:</strong> ${detail.stockBooking} ${detail.stockBooking > 1 ? 'days' : 'day'}
                                                        </div>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:parseDate value="${detail.dateStartService}" pattern="yyyy-MM-dd" var="serviceDate" />
                                                        <fmt:formatDate value="${serviceDate}" pattern="dd/MM/yyyy" var="formattedServiceDate" />
                                                        
                                                        <div class="mb-2">
                                                            <i class="bi bi-calendar3 me-2"></i>
                                                            <strong>Date:</strong> ${formattedServiceDate}
                                                        </div>
                                                        <div class="mb-2">
                                                            <i class="bi bi-clock me-2"></i>
                                                            <strong>Time:</strong> ${fn:substring(detail.startTime, 0, 5)} - ${fn:substring(detail.endTime, 0, 5)}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <div class="mb-2">
                                                    <i class="bi bi-house me-2"></i>
                                                    <strong>Room:</strong> 
                                                    <c:choose>
                                                        <c:when test="${detail.room != null}">
                                                            ${detail.room.name}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="mb-2">
                                                    <i class="bi bi-heart me-2"></i>
                                                    <strong>Pet:</strong>
                                                    <c:choose>
                                                        <c:when test="${detail.userPet != null}">
                                                            ${detail.userPet.petName}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <span class="h6 text-primary mb-0">
                                                        <fmt:formatNumber value="${detail.price}" type="number" maxFractionDigits="0"/> đ
                                                    </span>
                                                </div>
                                                <a href="booking?action=viewBookingDetail&bookingId=${detail.booking.bookingID}" 
                                                   class="btn btn-outline-primary btn-sm">View Details</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <div class="row mt-5">
                                <div class="col-12">
                                    <nav aria-label="Booking pagination">
                                        <ul class="pagination justify-content-center">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="booking?action=viewBooking&page=1">
                                                    <i class="bi bi-chevron-double-left"></i> First
                                                </a>
                                            </li>
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="booking?action=viewBooking&page=${currentPage - 1}">
                                                    <i class="bi bi-chevron-left"></i> Previous
                                                </a>
                                            </li>

                                            <c:choose>
                                                <c:when test="${totalPages <= 10}">
                                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                            <a class="page-link" href="booking?action=viewBooking&page=${i}">${i}</a>
                                                        </li>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${currentPage <= 5}">
                                                            <c:forEach begin="1" end="7" var="i">
                                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                                    <a class="page-link" href="booking?action=viewBooking&page=${i}">${i}</a>
                                                                </li>
                                                            </c:forEach>
                                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                                            <li class="page-item">
                                                                <a class="page-link" href="booking?action=viewBooking&page=${totalPages}">${totalPages}</a>
                                                            </li>
                                                        </c:when>
                                                        <c:when test="${currentPage >= totalPages - 4}">
                                                            <li class="page-item">
                                                                <a class="page-link" href="booking?action=viewBooking&page=1">1</a>
                                                            </li>
                                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                                            <c:forEach begin="${totalPages - 6}" end="${totalPages}" var="i">
                                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                                    <a class="page-link" href="booking?action=viewBooking&page=${i}">${i}</a>
                                                                </li>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <li class="page-item">
                                                                <a class="page-link" href="booking?action=viewBooking&page=1">1</a>
                                                            </li>
                                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                                            <c:forEach begin="${currentPage - 2}" end="${currentPage + 2}" var="i">
                                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                                    <a class="page-link" href="booking?action=viewBooking&page=${i}">${i}</a>
                                                                </li>
                                                            </c:forEach>
                                                            <li class="page-item disabled"><span class="page-link">...</span></li>
                                                            <li class="page-item">
                                                                <a class="page-link" href="booking?action=viewBooking&page=${totalPages}">${totalPages}</a>
                                                            </li>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:otherwise>
                                            </c:choose>

                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="booking?action=viewBooking&page=${currentPage + 1}">
                                                    Next <i class="bi bi-chevron-right"></i>
                                                </a>
                                            </li>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="booking?action=viewBooking&page=${totalPages}">
                                                    Last <i class="bi bi-chevron-double-right"></i>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </c:if>
                        
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-5">
                            <i class="bi bi-calendar-x text-muted" style="font-size: 4rem;"></i>
                            <h3 class="mt-3 text-muted">No bookings found</h3>
                            <p class="text-muted mb-4">You haven't made any bookings yet.</p>
                            <a href="service?action=viewListService" class="btn btn-primary">
                                <i class="bi bi-plus-circle me-2"></i>Book a Service
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<!-- Booking List End -->

<jsp:include page="/client/assets/layout/footer.jsp"/>