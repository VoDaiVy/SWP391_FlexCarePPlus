<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    .booking-detail-card {
        box-shadow: 0 0 20px rgba(0,0,0,0.1);
        border: none;
        border-radius: 15px;
    }
    .status-badge {
        font-size: 1rem;
        padding: 8px 16px;
    }
    .detail-row {
        border-bottom: 1px solid #eee;
        padding: 1rem 0;
    }
    .detail-row:last-child {
        border-bottom: none;
    }
    .service-image {
        width: 80px;
        height: 80px;
        object-fit: cover;
        border-radius: 10px;
    }
    .spinner-border-sm {
        width: 0.875rem;
        height: 0.875rem;
    }
    .booking-cancelled {
        opacity: 0.7;
    }
    .booking-cancelled .service-image {
        filter: grayscale(50%);
    }
    .alert {
        animation: slideDown 0.3s ease-out;
    }
    @keyframes slideDown {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    .alert-insufficient {
        background-color: #f8d7da !important;
        border-color: #dc3545 !important;
        color: #721c24 !important;
        font-weight: bold;
        box-shadow: 0 4px 12px rgba(220, 53, 69, 0.3);
        animation: shake 0.5s ease-in-out, slideDown 0.3s ease-out;
    }
    .alert-insufficient .bi {
        color: #dc3545;
        font-size: 1.2rem;
    }
    @keyframes shake {
        0%, 100% { transform: translateX(0); }
        25% { transform: translateX(-5px); }
        75% { transform: translateX(5px); }
    }
    .btn-wallet-redirect {
        background: linear-gradient(135deg, #dc3545, #c82333);
        border: none;
        color: white;
        font-weight: bold;
        box-shadow: 0 3px 8px rgba(220, 53, 69, 0.4);
        transition: all 0.3s ease;
    }
    .btn-wallet-redirect:hover {
        background: linear-gradient(135deg, #c82333, #bd2130);
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 5px 12px rgba(220, 53, 69, 0.5);
    }
</style>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">Booking Details</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0">
                        <a class="text-white" href="home">Home</a> / 
                        <a class="text-white" href="booking?action=viewBooking">My Bookings</a> / 
                        <span class="text-white">Booking</span>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Payment Warning Alert for PENDINGPAYMENT bookings -->
<c:if test="${booking.state == 'PENDINGPAYMENT'}">
    <div class="container-fluid py-3">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="alert alert-warning border-warning mb-0" role="alert">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-exclamation-triangle-fill me-3" style="font-size: 1.8rem; color: #ff9800;"></i>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">
                                    <strong>Payment Required Within 5 Minutes</strong>
                                </h6>
                                <p class="mb-2 small">
                                    You must pay at least 50% of the total amount within 5 minutes, 
                                    otherwise this booking will be automatically cancelled.
                                </p>
                                <div class="small text-muted">
                                    Minimum payment: <strong class="text-dark">
                                        <fmt:formatNumber value="${booking.totalPrice * 0.5}" type="number" maxFractionDigits="0"/> đ
                                    </strong>
                                </div>
                            </div>
                            <div>
                                <button class="btn btn-warning btn-sm fw-bold" onclick="payNow(${booking.bookingID})">
                                    <i class="bi bi-credit-card me-1"></i>Pay Now
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- Booking Detail Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card booking-detail-card">
                    <div class="card-header bg-white border-0 pt-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">Booking</h4>
                            <c:choose>
                                <c:when test="${booking.state == 'PENDINGPAYMENT'}">
                                    <span class="badge bg-warning status-badge">Pending Payment</span>
                                </c:when>
                                <c:when test="${booking.state == 'BOOKED'}">
                                    <span class="badge bg-success status-badge">Confirmed</span>
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
                    </div>

                    <div class="card-body">
                        <!-- Booking Information -->
                        <div class="detail-row">
                            <div class="row">
                                <div class="col-sm-4">
                                    <strong>Booking Date:</strong>
                                </div>
                                <div class="col-sm-8">
                                    <!-- Thử pattern khác hoặc hiển thị trực tiếp string -->
                                    <c:choose>
                                        <c:when test="${fn:contains(booking.dateBooked, 'T')}">
                                            <!-- Nếu có 'T' thì parse với pattern ISO -->
                                            <c:catch var="parseError">
                                                <fmt:parseDate value="${booking.dateBooked}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="bookingDate" />
                                                <fmt:formatDate value="${bookingDate}" pattern="MMM dd, yyyy 'at' HH:mm"/>
                                            </c:catch>
                                            <c:if test="${not empty parseError}">
                                                ${booking.dateBooked}
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Hiển thị trực tiếp nếu không có 'T' -->
                                            ${booking.dateBooked}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>

                        <c:if test="${not empty booking.note}">
                            <div class="detail-row">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <strong>Special Notes:</strong>
                                    </div>
                                    <div class="col-sm-8">
                                        ${booking.note}
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Services -->
                        <div class="detail-row">
                            <h5 class="mb-3">Services</h5>
                            <c:forEach var="detail" items="${bookingDetails}">
                                <div class="d-flex align-items-center mb-3 p-3 bg-light rounded">
                                    <img src="${detail.service.imgURL}" alt="${detail.service.name}" class="service-image me-3">
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">${detail.service.name}</h6>
                                        <div class="row text-muted small">
                                            <div class="col-md-12">
                                                <c:choose>
                                                    <c:when test="${detail.service.categoryServiceID == 3}">
                                                        <c:catch var="dateError">
                                                            <fmt:parseDate value="${detail.dateStartService}" pattern="yyyy-MM-dd" var="checkInDate" />
                                                            <fmt:parseDate value="${detail.dateEndService}" pattern="yyyy-MM-dd" var="checkOutDate" />
                                                            <fmt:formatDate value="${checkInDate}" pattern="MMM dd, yyyy" var="formattedCheckInDate" />
                                                            <fmt:formatDate value="${checkOutDate}" pattern="MMM dd, yyyy" var="formattedCheckOutDate" />
                                                        </c:catch>

                                                        <p class="mb-1">
                                                            <i class="bi bi-calendar-check me-1"></i>
                                                            <strong>Check-in:</strong> 
                                                            <c:choose>
                                                                <c:when test="${empty dateError}">
                                                                    ${formattedCheckInDate} at 
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${detail.dateStartService} at 
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:choose>
                                                                <c:when test="${fn:length(detail.startTime) >= 5}">
                                                                    ${fn:substring(detail.startTime, 0, 5)}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${detail.startTime}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p class="mb-1">
                                                            <i class="bi bi-calendar-x me-1"></i>
                                                            <strong>Check-out:</strong> 
                                                            <c:choose>
                                                                <c:when test="${empty dateError}">
                                                                    ${formattedCheckOutDate} at 
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${detail.dateEndService} at 
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <c:choose>
                                                                <c:when test="${fn:length(detail.endTime) >= 5}">
                                                                    ${fn:substring(detail.endTime, 0, 5)}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    ${detail.endTime}
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                        <p class="mb-1">
                                                            <i class="bi bi-clock me-1"></i>
                                                            <strong>Duration:</strong> ${detail.stockBooking} ${detail.stockBooking > 1 ? 'days' : 'day'}
                                                        </p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:catch var="serviceDataError">
                                                            <fmt:parseDate value="${detail.dateStartService}" pattern="yyyy-MM-dd" var="serviceDate" />
                                                            <fmt:formatDate value="${serviceDate}" pattern="MMM dd, yyyy" var="formattedServiceDate" />
                                                        </c:catch>

                                                        <p class="mb-1">
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
                                                        </p>
                                                        <p class="mb-1">
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
                                                        </p>
                                                    </c:otherwise>
                                                </c:choose>

                                                <p class="mb-1">
                                                    <i class="bi bi-house me-1"></i>
                                                    <strong>Room:</strong>
                                                    <c:choose>
                                                        <c:when test="${detail.room != null}">
                                                            ${detail.room.name}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </p>
                                                <p class="mb-1">
                                                    <i class="bi bi-heart me-1"></i>
                                                    <strong>Pet:</strong>
                                                    <c:choose>
                                                        <c:when test="${detail.userPet != null}">
                                                            ${detail.userPet.petName}
                                                        </c:when>
                                                        <c:otherwise>N/A</c:otherwise>
                                                    </c:choose>
                                                </p>
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
                                <div class="col-sm-8">
                                    <h5>Total Amount:</h5>
                                </div>
                                <div class="col-sm-4 text-end">
                                    <h4 class="text-primary">
                                        <fmt:formatNumber value="${booking.totalPrice}" type="number" maxFractionDigits="0"/> đ
                                    </h4>
                                </div>
                            </div>
                            <c:if test="${booking.paid > 0}">
                                <div class="row mt-2">
                                    <div class="col-sm-8">
                                        <span>Paid Amount:</span>
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <span class="text-success">
                                            <fmt:formatNumber value="${booking.paid}" type="number" maxFractionDigits="0"/> đ
                                        </span>
                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <div class="col-sm-8">
                                        <span>Remaining:</span>
                                    </div>
                                    <div class="col-sm-4 text-end">
                                        <span class="text-warning">
                                            <fmt:formatNumber value="${booking.totalPrice - booking.paid}" type="number" maxFractionDigits="0"/> đ
                                        </span>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <!-- Action Buttons -->
                        <div class="text-center mt-4">
                            <a href="booking?action=viewBooking" class="btn btn-outline-secondary me-2">
                                <i class="bi bi-arrow-left me-2"></i>Back to Bookings
                            </a>

                            <c:if test="${booking.state == 'PENDINGPAYMENT'}">
                                <button class="btn btn-success me-2" onclick="payNow(${booking.bookingID})">
                                    <i class="bi bi-credit-card me-2"></i>Pay Now
                                </button>
                                <button class="btn btn-outline-danger" onclick="cancelBooking(${booking.bookingID})">
                                    <i class="bi bi-x-circle me-2"></i>Cancel Booking
                                </button>
                            </c:if>

                            <c:if test="${booking.state == 'BOOKED'}">
                                <button class="btn btn-outline-danger" onclick="cancelBooking(${booking.bookingID})">
                                    <i class="bi bi-x-circle me-2"></i>Cancel Booking
                                </button>
                            </c:if>

                            <c:if test="${booking.state == 'CANCEL'}">
                                <div class="alert alert-light border-danger mt-3">
                                    <i class="bi bi-x-circle text-danger me-2"></i>
                                    <strong>This booking has been cancelled</strong>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Booking Detail End -->

<script>
    function payNow(bookingId) {
        const confirmMessage = 'Proceed with payment for this booking?\n\n' +
                'You will pay the minimum required amount (50% of total).';

        if (confirm(confirmMessage)) {
            const payButton = document.querySelector('button[onclick*="payNow"]');
            if (payButton) {
                payButton.disabled = true;
                payButton.innerHTML = '<i class="bi bi-spinner-border spinner-border-sm me-2"></i>Processing...';
            }

            fetch('booking', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'action=payBooking&bookingId=' + bookingId
            })
                    .then(response => {
                        console.log('Payment response status:', response.status);

                        const contentType = response.headers.get('content-type');
                        if (!contentType || !contentType.includes('application/json')) {
                            throw new Error('Server returned non-JSON response');
                        }

                        return response.json();
                    })
                    .then(data => {
                        console.log('Payment response data:', data);

                        if (data.success) {
                            showAlert('success', data.message);
                            updateUIAfterPayment(data);

                            setTimeout(() => {
                                window.location.reload();
                            }, 3000);

                        } else {
                            showAlert('danger', data.message);

                            if (data.action === 'redirect_wallet') {
                                setTimeout(() => {
                                    if (confirm('Would you like to add money to your wallet now?')) {
                                        window.location.href = 'wallet?action=getWallet';
                                    }
                                }, 2000);
                            }

                            enablePayButton();
                        }
                    })
                    .catch(error => {
                        console.error('Payment error:', error);
                        showAlert('danger', 'An error occurred while processing payment. Please try again.');
                        enablePayButton();
                    });
        }
    }

    function cancelBooking(bookingId) {
        const confirmMessage = 'Are you sure you want to cancel this booking?\n\n' +
                'This action cannot be undone. The booking will be permanently cancelled.';

        if (confirm(confirmMessage)) {
            const cancelButtons = document.querySelectorAll('button[onclick*="cancelBooking"]');
            cancelButtons.forEach(btn => {
                btn.disabled = true;
                btn.innerHTML = '<i class="bi bi-spinner-border spinner-border-sm me-2"></i>Cancelling...';
            });

            fetch('booking', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: 'action=cancelBooking&bookingId=' + bookingId
            })
                    .then(response => {
                        console.log('Cancel response status:', response.status);

                        const contentType = response.headers.get('content-type');
                        if (!contentType || !contentType.includes('application/json')) {
                            throw new Error('Server returned non-JSON response');
                        }

                        return response.json();
                    })
                    .then(data => {
                        if (data.success) {
                            showAlert('success', 'Booking cancelled successfully!');
                            updateUIAfterCancel();

                            setTimeout(() => {
                                window.location.href = 'booking?action=viewBooking';
                            }, 2000);

                        } else {
                            showAlert('danger', data.message || 'Failed to cancel booking');
                            enableCancelButtons();
                        }
                    })
                    .catch(error => {
                        console.error('Cancel error:', error);
                        showAlert('danger', 'An error occurred while cancelling the booking');
                        enableCancelButtons();
                    });
        }
    }

    function showAlert(type, message) {
        const existingAlerts = document.querySelectorAll('.alert:not(.alert-warning)');
        existingAlerts.forEach(alert => alert.remove());

        const alertType = type === 'success' ? 'check-circle' : 'exclamation-triangle';
        const alertHtml = `
        <div class="alert alert-` + type+ ` alert-dismissible fade show" role="alert">
            <i class="bi bi-` + alertType + ` me-2"></i>` +
                message
                + `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    `;

        const cardBody = document.querySelector('.card-body');
        if (cardBody) {
            cardBody.insertAdjacentHTML('afterbegin', alertHtml);

            setTimeout(() => {
                const newAlert = cardBody.querySelector('.alert-' + type);
                if (newAlert) {
                    newAlert.remove();
                }
            }, 8000);
        }
    }

    function enablePayButton() {
        const payButton = document.querySelector('button[onclick*="payNow"]');
        if (payButton) {
            payButton.disabled = false;
            payButton.innerHTML = '<i class="bi bi-credit-card me-2"></i>Pay Now';
        }
    }

    function enableCancelButtons() {
        const cancelButtons = document.querySelectorAll('button[onclick*="cancelBooking"]');
        cancelButtons.forEach(btn => {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-x-circle me-2"></i>Cancel Booking';
        });
    }

    function updateUIAfterPayment(data) {
        const statusBadge = document.querySelector('.status-badge');
        if (statusBadge && data.bookingState === 'BOOKED') {
            statusBadge.className = 'badge bg-success status-badge';
            statusBadge.textContent = 'Confirmed';
        }

        if (data.bookingState === 'BOOKED') {
            const paymentWarning = document.querySelector('.alert-warning');
            if (paymentWarning && paymentWarning.closest('.container-fluid')) {
                paymentWarning.closest('.container-fluid').style.display = 'none';
            }
        }

        updatePaymentSummary(data);

        if (data.bookingState === 'BOOKED') {
            const actionButtons = document.querySelector('.text-center.mt-4');
            if (actionButtons) {
                const backButton = actionButtons.querySelector('a[href*="viewBooking"]');
                const cancelButton = actionButtons.querySelector('button[onclick*="cancelBooking"]');

                actionButtons.innerHTML = '';
                if (backButton) {
                    actionButtons.appendChild(backButton);
                }
                if (cancelButton) {
                    actionButtons.appendChild(cancelButton);
                }

                const successNote = document.createElement('div');
                successNote.className = 'alert alert-light border-success mt-3';
                successNote.innerHTML = '<i class="bi bi-check-circle text-success me-2"></i><strong>Payment completed successfully!</strong>';
                actionButtons.appendChild(successNote);
            }
        }
    }

    function updatePaymentSummary(data) {
        try
        {
            const paymentSectionHeading = Array.from(document.querySelectorAll('h5')).find(h5 => 
                h5.textContent.includes('Total Amount')
            );

            if (!paymentSectionHeading) {
                console.log('Payment section heading not found');
                return;
            }

            const paymentContainer = paymentSectionHeading.closest('.detail-row');
            if (!paymentContainer) {
                console.log('Payment container not found');
                return;
            }

            let paidRow = null;
            let remainingRow = null;  

            const allRows = paymentContainer.querySelectorAll('.row');
            for (let i = 0; i < allRows.length; i++) {
                const rowText = allRows[i].textContent || allRows[i].innerText || '';
                if (rowText.toLowerCase().includes('paid amount')) {
                    paidRow = allRows[i];
                }
                if (rowText.toLowerCase().includes('remaining')) {
                    remainingRow = allRows[i];
                }
            }

            if (data.paidAmount > 0) {
                if (!paidRow) {
                    const totalRow = paymentContainer.querySelector('.row');
                    if (totalRow) {
                        const paidAmount = new Intl.NumberFormat().format(data.paidAmount);
                        const newPaidRow = document.createElement('div');
                        newPaidRow.className = 'row mt-2';
                        newPaidRow.innerHTML = `
                        <div class="col-sm-8"><span>Paid Amount:</span></div>
                        <div class="col-sm-4 text-end">
                            <span class="text-success">` + 
                        paidAmount + `đ
                            </span>
                        </div>`;
                        if (totalRow.nextElementSibling) {
                            paymentContainer.insertBefore(newPaidRow, totalRow.nextElementSibling);
                        } else {
                            paymentContainer.appendChild(newPaidRow);
                        }
                        paidRow = newPaidRow;
                    }

                } else {
                    const paidAmountSpan = paidRow.querySelector('.text-success');
                    if (paidAmountSpan) {
                        paidAmountSpan.textContent = new Intl.NumberFormat().format(data.paidAmount) + ' đ';
                    }
                }

                if (data.remainingAmount > 0) {
                    if (!remainingRow) {
                        const newRemainingRow = document.createElement('div');
                        const remainingAmount = new Intl.NumberFormat().format(data.remainingAmount);
                        newRemainingRow.className = 'row mt-1';
                        newRemainingRow.innerHTML = `
                        <div class="col-sm-8"><span>Remaining:</span></div>
                        <div class="col-sm-4 text-end">
                            <span class="text-warning">` +
                        remainingAmount + `đ
                            </span>
                        </div>
                    `;
                        if (paidRow.nextElementSibling) {
                            paymentContainer.insertBefore(newRemainingRow, paidRow.nextElementSibling);
                        } else {
                            paymentContainer.appendChild(newRemainingRow);
                        }
                        remainingRow = newRemainingRow;
                    } else {
                        const remainingAmountSpan = remainingRow.querySelector('.text-warning');
                        if (remainingAmountSpan) {
                            remainingAmountSpan.textContent = new Intl.NumberFormat().format(data.remainingAmount) + ' đ';
                        }
                    }
                } else if (remainingRow && remainingRow.parentNode) {
                    remainingRow.parentNode.removeChild(remainingRow);
                }
            }
        } catch (error) {
            console.error('Error updating payment summary:', error);
        }
        
    }

    function updateUIAfterCancel() {
        const statusBadge = document.querySelector('.status-badge');
        if (statusBadge) {
            statusBadge.className = 'badge bg-danger status-badge';
            statusBadge.textContent = 'Cancelled';
        }

        const paymentWarning = document.querySelector('.alert-warning');
        if (paymentWarning && paymentWarning.closest('.container-fluid')) {
            paymentWarning.closest('.container-fluid').style.display = 'none';
        }

        const actionButtons = document.querySelector('.text-center.mt-4');
        if (actionButtons) {
            const backButton = actionButtons.querySelector('a[href*="viewBooking"]');
            const cancelledNote = document.createElement('div');
            cancelledNote.className = 'alert alert-light border-danger mt-3';
            cancelledNote.innerHTML = '<i class="bi bi-x-circle text-danger me-2"></i><strong>This booking has been cancelled</strong>';

            actionButtons.innerHTML = '';
            if (backButton) {
                actionButtons.appendChild(backButton);
            }
            actionButtons.appendChild(cancelledNote);
        }
    }


    document.addEventListener('DOMContentLoaded', function () {
        const statusBadge = document.querySelector('.status-badge');
        if (statusBadge && statusBadge.textContent.trim() === 'Cancelled') {
            const paymentWarning = document.querySelector('.alert-warning');
            if (paymentWarning && paymentWarning.closest('.container-fluid')) {
                paymentWarning.closest('.container-fluid').style.display = 'none';
            }

            const actionButtons = document.querySelector('.text-center.mt-4');
            if (actionButtons) {
                const payButtons = actionButtons.querySelectorAll('button[onclick*="payNow"]');
                const cancelButtons = actionButtons.querySelectorAll('button[onclick*="cancelBooking"]');
                payButtons.forEach(btn => btn.style.display = 'none');
                cancelButtons.forEach(btn => btn.style.display = 'none');
            }
        }
    });
</script>

<jsp:include page="/client/assets/layout/footer.jsp"/>