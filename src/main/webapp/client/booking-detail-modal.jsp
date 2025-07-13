<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
    .service-image {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 8px;
    }
    .detail-row {
        border-bottom: 1px solid #eee;
        padding: 0.75rem 0;
    }
    .detail-row:last-child {
        border-bottom: none;
    }
    .status-badge {
        font-size: 0.875rem;
        padding: 6px 12px;
    }
    .star-rating {
        color: #ffc107;
        cursor: pointer;
    }
    .star-rating .star {
        font-size: 1.5rem;
        margin: 0 2px;
    }
    .star-rating .star.active {
        color: #ffc107;
    }
    .star-rating .star.inactive {
        color: #e9ecef;
    }
</style>

<div data-booking-id="${booking.bookingID}">

    <!-- Booking Header -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h5 class="mb-0 text-primary">Booking</h5>
        <c:choose>
            <c:when test="${booking.state == 'PENDINGPAYMENT'}">
                <span class="badge bg-warning status-badge">Pending Payment</span>
            </c:when>
            <c:when test="${booking.state == 'BOOKED'}">
                <span class="badge bg-success status-badge">Confirmed</span>
            </c:when>
            <c:when test="${booking.state == 'FINISHED'}">
                <span class="badge bg-primary status-badge">Finished</span>
            </c:when>
            <c:when test="${booking.state == 'CANCEL'}">
                <span class="badge bg-danger status-badge">Cancelled</span>
            </c:when>
            <c:when test="${booking.state == 'NEXTBOOKING'}">
                <span class="badge bg-info status-badge">Upcoming</span>
            </c:when>
            <c:otherwise>
                <span class="badge bg-secondary status-badge">${booking.state}</span>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Booking Information -->
    <div class="detail-row">
        <div class="row">
            <div class="col-5">
                <strong>Booking Date:</strong>
            </div>
            <div class="col-7">
                <c:choose>
                    <c:when test="${fn:contains(booking.dateBooked, 'T')}">
                        <c:catch var="parseError">
                            <fmt:parseDate value="${booking.dateBooked}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="bookingDate" />
                            <fmt:formatDate value="${bookingDate}" pattern="MMM dd, yyyy 'at' HH:mm"/>
                        </c:catch>
                        <c:if test="${not empty parseError}">
                            ${booking.dateBooked}
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        ${booking.dateBooked}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <c:if test="${not empty booking.note}">
        <div class="detail-row">
            <div class="row">
                <div class="col-5">
                    <strong>Special Notes:</strong>
                </div>
                <div class="col-7">
                    ${booking.note}
                </div>
            </div>
        </div>
    </c:if>

    <!-- Services Section -->
    <div class="detail-row">
        <h6 class="mb-3 text-primary">Services</h6>
        <c:forEach var="detail" items="${bookingDetails}">
            <div class="d-flex align-items-start mb-3 p-2 bg-light rounded">
                <img src="${detail.service.imgURL}" alt="${detail.service.name}" class="service-image me-3">
                <div class="flex-grow-1">
                    <h6 class="mb-1">${detail.service.name}</h6>
                    <div class="text-muted small">
                        <c:choose>
                            <c:when test="${detail.service.categoryServiceID == 3}">
                                <!-- Lodging Service -->
                                <c:catch var="dateError">
                                    <fmt:parseDate value="${detail.dateStartService}" pattern="yyyy-MM-dd" var="checkInDate" />
                                    <fmt:parseDate value="${detail.dateEndService}" pattern="yyyy-MM-dd" var="checkOutDate" />
                                    <fmt:formatDate value="${checkInDate}" pattern="MMM dd, yyyy" var="formattedCheckInDate" />
                                    <fmt:formatDate value="${checkOutDate}" pattern="MMM dd, yyyy" var="formattedCheckOutDate" />
                                </c:catch>

                                <div class="mb-1">
                                    <i class="bi bi-calendar-check me-1"></i>
                                    <strong>Check-in:</strong> 
                                    <c:choose>
                                        <c:when test="${empty dateError}">
                                            ${formattedCheckInDate}
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.dateStartService}
                                        </c:otherwise>
                                    </c:choose>
                                    at 
                                    <c:choose>
                                        <c:when test="${fn:length(detail.startTime) >= 5}">
                                            ${fn:substring(detail.startTime, 0, 5)}
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.startTime}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mb-1">
                                    <i class="bi bi-calendar-x me-1"></i>
                                    <strong>Check-out:</strong> 
                                    <c:choose>
                                        <c:when test="${empty dateError}">
                                            ${formattedCheckOutDate}
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.dateEndService}
                                        </c:otherwise>
                                    </c:choose>
                                    at 
                                    <c:choose>
                                        <c:when test="${fn:length(detail.endTime) >= 5}">
                                            ${fn:substring(detail.endTime, 0, 5)}
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.endTime}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mb-1">
                                    <i class="bi bi-clock me-1"></i>
                                    <strong>Duration:</strong> ${detail.stockBooking} ${detail.stockBooking > 1 ? 'days' : 'day'}
                                </div>
                            </c:when>
                            <c:otherwise>
                                <!-- Regular Service -->
                                <c:catch var="serviceDataError">
                                    <fmt:parseDate value="${detail.dateStartService}" pattern="yyyy-MM-dd" var="serviceDate" />
                                    <fmt:formatDate value="${serviceDate}" pattern="MMM dd, yyyy" var="formattedServiceDate" />
                                </c:catch>

                                <div class="mb-1">
                                    <i class="bi bi-calendar3 me-1"></i>
                                    <strong>Date:</strong> 
                                    <c:choose>
                                        <c:when test="${empty serviceDataError}">
                                            ${formattedServiceDate}
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.dateStartService}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mb-1">
                                    <i class="bi bi-clock me-1"></i>
                                    <strong>Time:</strong> 
                                    <c:choose>
                                        <c:when test="${fn:length(detail.startTime) >= 5}">
                                            ${fn:substring(detail.startTime, 0, 5)}
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.startTime}
                                        </c:otherwise>
                                    </c:choose>
                                    - 
                                    <c:choose>
                                        <c:when test="${fn:length(detail.endTime) >= 5}">
                                            ${fn:substring(detail.endTime, 0, 5)}
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.endTime}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="mb-1">
                            <i class="bi bi-house me-1"></i>
                            <strong>Room:</strong>
                            <c:choose>
                                <c:when test="${detail.room != null}">
                                    ${detail.room.name}
                                </c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="mb-1">
                            <i class="bi bi-heart me-1"></i>
                            <strong>Pet:</strong>
                            <c:choose>
                                <c:when test="${detail.userPet != null}">
                                    ${detail.userPet.petName}
                                </c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="text-end">
                    <h6 class="text-primary mb-0">
                        <fmt:formatNumber value="${detail.price}" type="number" maxFractionDigits="0"/> đ
                    </h6>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Payment Summary -->
    <div class="detail-row">
        <div class="row">
            <div class="col-7">
                <h6>Total Amount:</h6>
            </div>
            <div class="col-5 text-end">
                <h5 class="text-primary mb-0">
                    <fmt:formatNumber value="${booking.totalPrice}" type="number" maxFractionDigits="0"/> đ
                </h5>
            </div>
        </div>
        <c:if test="${booking.paid > 0}">
            <div class="row mt-2">
                <div class="col-7">
                    <span>Paid Amount:</span>
                </div>
                <div class="col-5 text-end">
                    <span class="text-success">
                        <fmt:formatNumber value="${booking.paid}" type="number" maxFractionDigits="0"/> đ
                    </span>
                </div>
            </div>
        </c:if>
    </div>

    <c:if test="${booking.state == 'FINISHED'}">
        <div class="text-center mt-3 pt-3 border-top">
            <button type="button" class="btn btn-outline-primary btn-sm" onclick="checkFeedbackAvailability(${booking.bookingID})">
                <i class="bi bi-star me-1"></i>Rate Services
            </button>
        </div>
    </c:if>
</div>
