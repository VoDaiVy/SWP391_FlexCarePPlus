<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    .img-preview {
        object-fit: contain;
        cursor: pointer;
    }

    .image-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        z-index: 10000;
        justify-content: center;
        align-items: center;
    }

    .image-overlay img {
        max-width: 80%;
        max-height: 80vh;
        object-fit: contain;
        border-radius: 8px;
    }

    .image-overlay.active {
        display: flex;
    }

    .gallery-container {
        position: relative;
        overflow-x: auto;
        white-space: nowrap;
        padding: 10px 0;
    }

    .gallery-container::-webkit-scrollbar {
        display: none;
    }

    .gallery-item {
        display: inline-block;
        width: 25%;
        padding: 0 5px;
    }

    .gallery-item img {
        width: 100%;
        height: 100px;
        object-fit: cover;
        border-radius: 8px;
        cursor: pointer;
    }

    .scroll-btn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        padding: 10px;
        cursor: pointer;
        z-index: 10;
        border-radius: 50%;
        font-size: 1.2rem;
    }

    .scroll-btn.left {
        left: 0;
    }

    .scroll-btn.right {
        right: 0;
    }

    .scroll-btn:hover {
        background: rgba(0, 0, 0, 0.8);
    }    /* Timeline Styles */
    .timeline-wrapper {
        margin: 15px 0;
    }

    .timeline-hours {
        position: relative;
        height: 40px;
        background: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 6px;
        overflow: hidden;
        cursor: pointer;
    }

    .timeline-scale {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, #28a745 0%, #28a745 100%);
    }
    .timeline-tick {
        position: absolute;
        top: 0;
        width: 1px;
        height: 100%;
        background: rgba(255, 255, 255, 0.3);
    }

    .timeline-tick:nth-child(2n) {
        background: rgba(255, 255, 255, 0.5);
        height: 60%;
        top: 20%;
    }

    .timeline-busy {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 2;
    }

    .timeline-busy .busy-slot {
        position: absolute;
        height: 100%;
        background: #dc3545;
        border-left: 1px solid rgba(255, 255, 255, 0.3);
        border-right: 1px solid rgba(255, 255, 255, 0.3);
    }

    .timeline-selector {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 3;
        cursor: pointer;
    }

    .timeline-selector::after {
        content: '';
        position: absolute;
        top: 50%;
        left: var(--selector-position, -10px);
        transform: translate(-50%, -50%);
        width: 3px;
        height: 80%;
        background: #007bff;
        border-radius: 2px;
        opacity: 0;
        transition: opacity 0.2s;
    }

    .timeline-selector.active::after {
        opacity: 1;
    }

    .timeline-selector:hover {
        background: rgba(0, 123, 255, 0.1);
    }

    .timeline-labels {
        display: flex;
        position: relative;
        margin-top: 5px;
        height: 20px;
    }

    .timeline-label {
        position: absolute;
        font-size: 11px;
        color: #6c757d;
        transform: translateX(-50%);
        white-space: nowrap;
    }

    #addToCartError {
        border-left: 4px solid #dc3545;
        padding-left: 12px;
        animation: fadeIn 0.3s;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(-10px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">${service.name}</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="home">Home</a> / <a class="text-white" href="service?action=viewListService">Services</a> / <span class="text-white">${service.name}</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Service Detail Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-8">
                <!-- Main Service Content -->
                <div class="mb-5">
                    <div class="position-relative mb-4">
                        <img class="img-fluid rounded w-100 img-preview" src="${service.imgURL}" alt="${service.name}" 
                             style="max-height: 400px;" onclick="showImage(this.src, this.alt)">
                    </div>

                    <!-- Image Gallery -->
                    <c:if test="${not empty serviceImages && serviceImages.size() > 0}">
                        <div class="mb-4 position-relative">
                            <div class="gallery-container" id="galleryContainer">
                                <c:forEach var="img" items="${serviceImages}">
                                    <div class="gallery-item">
                                        <img class="img-preview" src="${img.imgURL}" alt="Service Image" 
                                             onclick="showImage(this.src, this.alt)">
                                    </div>
                                </c:forEach>
                            </div>
                            <c:if test="${serviceImages.size() > 4}">
                                <button class="scroll-btn left" onclick="scrollGallery(-200)">◀</button>
                                <button class="scroll-btn right" onclick="scrollGallery(200)">▶</button>
                            </c:if>
                        </div>
                    </c:if>

                    <div class="image-overlay" id="imageOverlay">
                        <img id="largeImage" src="" alt="">
                    </div>

                    <!-- Main Content -->
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h2 class="text-uppercase mb-0">${service.name}</h2>
                        <div class="d-flex align-items-center">
                            <h3 class="mb-0 me-2">
                                <span class="text-primary"><fmt:formatNumber value="${service.price}" type="number" maxFractionDigits="0"/> đ</span>
                            </h3>
                            <span class="bg-light text-dark rounded-pill py-1 px-3 ms-2">
                                <i class="bi bi-clock"></i> ${service.time} mins
                            </span>
                        </div>
                    </div>

                    <div class="mb-5">
                        <p>${service.description}</p>
                    </div>

                    <!-- Booking Section -->
                    <div class="bg-light p-4 rounded mb-5">
                        <h3 class="text-uppercase mb-3">Book This Service</h3>
                        <c:choose>
                            <c:when test="${not empty sessionScope.userDetailDTO}">
                                <form action="booking" method="get">
                                    <input type="hidden" name="action" value="addToCart">
                                    <input type="hidden" name="serviceId" value="${service.serviceID}">

                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label for="bookingDate" class="form-label">Preferred Date</label>
                                            <input type="date" class="form-control" id="bookingDate" name="bookingDate" min="${java.time.LocalDate.now()}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="bookingTime" class="form-label">Preferred Time</label>
                                            <select class="form-select" id="bookingTime" name="bookingTime" required>
                                                <option value="" selected disabled>Select a time</option>
                                                <option value="08:00:00">8:00 AM</option>
                                                <option value="09:00:00">9:00 AM</option>
                                                <option value="10:00:00">10:00 AM</option>
                                                <option value="11:00:00">11:00 AM</option>
                                                <option value="13:00:00">1:00 PM</option>
                                                <option value="14:00:00">2:00 PM</option>
                                                <option value="15:00:00">3:00 PM</option>
                                                <option value="16:00:00">4:00 PM</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="petSelect" class="form-label">Select Your Pet</label>
                                            <select class="form-select" id="petSelect" name="userPetId" required>
                                                <option value="" selected disabled>Select a pet</option>
                                            </select>
                                            <small class="text-danger" style="display: none;">You don't have any pets. <a href="userdetail?action=getUserDetail">Add a pet first</a>.</small>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="note" class="form-label">Special Instructions (Optional)</label>
                                            <input type="text" class="form-control" id="note" name="note">
                                        </div>
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary w-100 py-3" disabled>
                                                <i class="bi bi-cart-plus me-2"></i> Book Now
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center">
                                    <p class="mb-3">You need to sign in to book this service</p>
                                    <a href="${pageContext.request.contextPath}/sign-in" class="btn btn-primary py-2 px-4">
                                        <i class="bi bi-box-arrow-in-right me-2"></i> Sign In
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Reviews Section -->
                    <div class="mb-5">
                        <h3 class="text-uppercase mb-4">Customer Reviews</h3>

                        <!-- Review Stats -->
                        <div class="bg-light p-4 rounded mb-4">
                            <div class="row align-items-center">
                                <div class="col-md-3 text-center border-end">
                                    <h1 class="display-4 text-primary mb-0">
                                        <c:choose>
                                            <c:when test="${not empty feedbacks && feedbacks.size() > 0}">
                                                <fmt:formatNumber value="${averageRating}" pattern="#0.0"/>
                                            </c:when>
                                            <c:otherwise>0.0</c:otherwise>
                                        </c:choose>
                                    </h1>
                                    <p class="mb-0">Average Rating</p>
                                    <div class="mt-1">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${i <= averageRating}">
                                                    <i class="bi bi-star-fill text-warning"></i>
                                                </c:when>
                                                <c:when test="${i <= averageRating + 0.5}">
                                                    <i class="bi bi-star-half text-warning"></i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="bi bi-star text-warning"></i>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                    <small class="text-muted">${feedbacks.size()} ${feedbacks.size() == 1 ? 'review' : 'reviews'}</small>
                                </div>
                                <div class="col-md-9">
                                    <!-- Rating Bars -->
                                    <c:forEach begin="1" end="5" var="i">
                                        <div class="d-flex align-items-center mb-1">
                                            <small class="text-muted me-2">${i} <i class="bi bi-star-fill text-warning"></i></small>
                                            <div class="progress flex-grow-1" style="height: 8px;">
                                                <c:set var="progressWidth">
                                                    <c:choose>
                                                        <c:when test="${not empty feedbacks && feedbacks.size() > 0}">
                                                            <fmt:formatNumber value="${starCounts[i] * 100 / feedbacks.size()}" pattern="#0" type="number"/>
                                                        </c:when>
                                                        <c:otherwise>0</c:otherwise>
                                                    </c:choose>
                                                </c:set>
                                                <div class="progress-bar bg-warning" style="width:${progressWidth}%"></div>
                                            </div>
                                            <small class="text-muted ms-2">
                                                <c:out value="${starCounts[i] != null ? starCounts[i] : 0}"/>
                                            </small>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>

                        <!-- Review List -->
                        <c:choose>
                            <c:when test="${not empty feedbacks && feedbacks.size() > 0}">
                                <div class="review-list">
                                    <c:forEach var="feedback" items="${feedbacks}">
                                        <div class="review-item bg-light p-4 rounded mb-3 shadow-sm">
                                            <div class="d-flex align-items-start mb-2">
                                                <c:if test="${not empty feedback.userDetail.avatar}">
                                                    <img src="${feedback.userDetail.avatar}" alt="${feedback.userDetail.firstName} ${feedback.userDetail.lastName}'s avatar" 
                                                         class="rounded-circle me-3" style="width: 50px; height: 50px; object-fit: cover;">
                                                </c:if>
                                                <c:if test="${empty feedback.userDetail.avatar}">
                                                    <div class="rounded-circle me-3 bg-secondary" style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; color: white;">
                                                        <i class="bi bi-person-fill"></i>
                                                    </div>
                                                </c:if>

                                                <div class="flex-grow-1">
                                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                                        <h5 class="mb-0">${feedback.userDetail.firstName} ${feedback.userDetail.lastName}</h5>
                                                        <div>
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <i class="bi bi-star${i <= feedback.rating ? '-fill' : ''} text-warning"></i>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">
                                                        <fmt:parseDate value="${feedback.dateCreatedString}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedDate" />
                                                        <fmt:formatDate value="${parsedDate}" pattern="MM dd, yyyy" />
                                                    </small>
                                                </div>
                                            </div>
                                            <p class="mt-2 mb-0">${feedback.comment}</p>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info text-center">
                                    No reviews yet. Be the first to review this service!
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <div class="col-lg-4">
                <!-- Sidebar -->
                <div class="mb-5">
                    <!-- Contact Information -->
                    <div class="bg-light p-4 rounded mb-4">
                        <h3 class="text-uppercase mb-4">Need Help?</h3>
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-telephone-fill text-primary me-3 fs-5"></i>
                            <div>
                                <h5 class="mb-1">Call Us</h5>
                                <p class="mb-0">0767658269</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-envelope-fill text-primary me-3 fs-5"></i>
                            <div>
                                <h5 class="mb-1">Email Us</h5>
                                <p class="mb-0">flexcarepplus@gmail.com</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-geo-alt-fill text-primary me-3 fs-5"></i>
                            <div>
                                <h5 class="mb-1">Visit Us</h5>
                                <p class="mb-0">FPT City, Ngu Hanh Son, Da Nang</p>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="bg-light p-4 rounded mb-4">
                        <h3 class="text-uppercase mb-3">Quick Actions</h3>
                        <a href="service?action=viewListService" class="btn btn-outline-primary w-100 mb-2">
                            <i class="bi bi-grid me-2"></i> View All Services
                        </a>
                        <a href="contact.jsp" class="btn btn-outline-primary w-100 mb-2">
                            <i class="bi bi-chat-dots me-2"></i> Contact Us
                        </a>
                        <c:if test="${not empty sessionScope.userDetailDTO}">
                            <a href="booking?action=viewCart" class="btn btn-outline-primary w-100 mb-2">
                                <i class="bi bi-cart me-2"></i> View Cart
                            </a>
                            <c:choose>
                                <c:when test="${service.categoryServiceID == 3}">
                                    <button type="button" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#lodgingServiceModal">
                                        <i class="bi bi-cart-plus me-2"></i> ADD TO CART
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#addToCartModal">
                                        <i class="bi bi-cart-plus me-2"></i> ADD TO CART
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                    </div>

                    <!-- Modal for Add To Cart -->
                    <div class="modal fade" id="addToCartModal" tabindex="-1" aria-labelledby="addToCartModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addToCartModalLabel">Select date and time of service</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div id="addToCartError" class="alert alert-danger mb-3" style="display:none;"></div>
                                <div class="modal-body">
                                    <form id="addToCartForm" action="booking" method="post">
                                        <input type="hidden" name="action" value="addToCart">
                                        <input type="hidden" name="serviceId" value="${service.serviceID}" />
                                        <input type="hidden" name="categoryServiceId" value="${service.categoryServiceID}" />
                                        <div class="mb-3">
                                            <label for="cartDate" class="form-label">Select date</label>
                                            <input type="date" class="form-control" id="cartDate" name="bookingDate" min="${java.time.LocalDate.now()}" required />
                                        </div>

                                        <div class="mb-3" id="timeSelectionContainer">
                                            <label class="form-label" id="timeSelectionLabel">Select time</label>

                                            <!-- Time Input Row -->
                                            <div class="row mb-3">                                  
                                                <div class="col-md-8">
                                                    <input type="time" class="form-control" id="cartTimeInput" 
                                                           min="08:00" max="17:30" step="60" placeholder="HH:MM" disabled>
                                                    <small class="form-text text-muted">Enter any time directly (8:00-17:30) or use timeline below</small>
                                                </div>
                                                <div class="col-md-4">
                                                    <button type="button" class="btn btn-outline-secondary btn-sm w-100" id="setTimeFromInput" disabled>
                                                        Set Time
                                                    </button>
                                                </div>
                                            </div>

                                            <div id="timelineContainer" style="display: none;">
                                                <div class="timeline-wrapper">
                                                    <div class="timeline-hours">
                                                        <div class="timeline-scale" id="timelineScale"></div>
                                                        <div class="timeline-busy" id="timelineBusy"></div>
                                                        <div class="timeline-selector" id="timelineSelector"></div>
                                                    </div>
                                                    <div class="timeline-labels" id="timelineLabels"></div>
                                                </div>
                                                <div class="mt-2">
                                                    <small class="text-muted">
                                                        <span class="badge bg-success me-2">Available</span>
                                                        <span class="badge bg-danger">Busy</span>
                                                    </small>
                                                </div>
                                                <input type="hidden" id="cartTime" name="bookingTime" required>
                                                <div class="mt-2">
                                                    <small id="selectedTimeDisplay" class="text-primary fw-bold"></small>
                                                </div>
                                            </div>
                                            <div id="selectDateFirst" class="text-muted">
                                                Please select a date first to see available time slots
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="cartPet" class="form-label">Choose a pet</label>
                                            <select class="form-select" id="cartPet" name="userPetId" required>
                                                <option value="" selected disabled>Loading pet list...</option>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label for="cartNote" class="form-label">Notes (optional)</label>
                                            <textarea class="form-control" id="cartNote" name="note" rows="2"></textarea>
                                        </div>
                                        <div id="cartTimeLoading" style="display:none;" class="mb-2 text-primary">Loading free time...</div>
                                        <div id="cartTimeError" style="display:none;" class="mb-2 text-danger"></div>
                                        <button type="submit" class="btn btn-success w-100" id="addToCartBtn" disabled>Add to cart</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Separate Modal for Lodging Services -->
                    <div class="modal fade" id="lodgingServiceModal" tabindex="-1" aria-labelledby="lodgingServiceModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="lodgingServiceModalLabel">Book Lodging Service</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div id="lodgingServiceError" class="alert alert-danger mb-3" style="display:none;"></div>
                                    <form id="lodgingServiceForm" action="booking" method="post">
                                        <input type="hidden" name="action" value="addToCart">
                                        <input type="hidden" name="serviceId" value="${service.serviceID}" />
                                        <input type="hidden" name="serviceType" value="lodging" />
                                        <input type="hidden" name="categoryServiceId" value="${service.categoryServiceID}" />

                                        <div class="mb-3">
                                            <label for="checkInDate" class="form-label">Check-in date</label>
                                            <input type="date" class="form-control" id="checkInDate" name="bookingDate" min="${java.time.LocalDate.now()}" required />
                                        </div>

                                        <div class="mb-3">
                                            <label for="lodgingDays" class="form-label">Length of stay</label>
                                            <div class="input-group">
                                                <input type="number" class="form-control" id="lodgingDays" name="lodgingDays" min="1" value="1">
                                                <span class="input-group-text">days</span>
                                            </div>
                                            <small class="form-text text-muted">Minimum stay is 1 day</small>
                                        </div>

                                        <div class="mb-3">
                                            <label for="checkInTime" class="form-label">Check-in time</label>
                                            <select class="form-select" id="checkInTime" name="bookingTime" required>
                                                <option value="" selected disabled>Select check-in time</option>
                                                <option value="08:00:00">8:00 AM</option>
                                                <option value="09:00:00">9:00 AM</option>
                                                <option value="10:00:00">10:00 AM</option>
                                                <option value="11:00:00">11:00 AM</option>
                                                <option value="13:00:00">1:00 PM</option>
                                                <option value="14:00:00">2:00 PM</option>
                                                <option value="15:00:00">3:00 PM</option>
                                                <option value="16:00:00">4:00 PM</option>
                                                <option value="17:00:00">5:00 PM</option>
                                            </select>
                                            <small class="form-text text-muted">Check-out will be at the same time on your departure day</small>
                                        </div>

                                        <div class="mb-3">
                                            <label for="lodgingPet" class="form-label">Choose a pet</label>
                                            <select class="form-select" id="lodgingPet" name="userPetId" required>
                                                <option value="" selected disabled>Loading pet list...</option>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label for="lodgingNote" class="form-label">Special instructions (optional)</label>
                                            <textarea class="form-control" id="lodgingNote" name="note" rows="2"></textarea>
                                        </div>

                                        <div class="card mb-3 bg-light">
                                            <div class="card-body">
                                                <h6 class="card-title">Summary</h6>
                                                <div id="lodgingPriceDisplay" class="mt-2">
                                                    <span class="d-flex justify-content-between">
                                                        <span>Daily rate:</span>
                                                        <span class="text-primary fw-bold">${service.price} đ</span>
                                                    </span>
                                                    <span class="d-flex justify-content-between">
                                                        <span>Length of stay:</span>
                                                        <span id="stayLengthDisplay">1 day</span>
                                                    </span>
                                                    <hr>
                                                    <span class="d-flex justify-content-between">
                                                        <span>Total:</span>
                                                        <span class="text-primary fw-bold" id="totalPriceDisplay">${service.price} đ</span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <button type="submit" class="btn btn-success w-100" id="lodgingAddToCartBtn" disabled>Add to cart</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>                   

                    <!-- Related Services -->
                    <div class="bg-light p-4 rounded">
                        <h3 class="text-uppercase mb-4">Related Services</h3>
                        <c:choose>
                            <c:when test="${not empty relatedServices && relatedServices.size() > 0}">
                                <c:forEach var="relatedService" items="${relatedServices}">
                                    <div class="d-flex mb-3">
                                        <img src="${relatedService.imgURL}" class="img-fluid rounded" alt="${relatedService.name}" 
                                             style="width: 80px; height: 60px; object-fit: cover;">
                                        <div class="ms-3">
                                            <h6 class="text-uppercase mb-1">
                                                <a href="service?action=viewDetail&id=${relatedService.serviceID}" class="text-body">${relatedService.name}</a>
                                            </h6>
                                            <span class="text-primary">
                                                <fmt:formatNumber value="${relatedService.price}" type="number" maxFractionDigits="0"/> đ
                                            </span>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p class="mb-0">No related services available</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Service Detail End -->

<!-- Call to Action Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-md-6 text-white">
                <h1 class="display-5 text-uppercase mb-4">Book Services For Your Pets Today!</h1>
                <p class="fs-5 mb-4">Treat your pet to the best care with our professional services</p>
                <a href="service?action=viewListService" class="btn btn-light py-md-3 px-md-5 text-uppercase">View All Services</a>
            </div>
            <div class="col-md-6">
                <div class="position-relative rounded overflow-hidden h-100" style="min-height: 300px">
                    <img src="${pageContext.request.contextPath}/client/assets/img/about.jpg" class="position-absolute w-100 h-100" style="object-fit: cover">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Call to Action End -->

<jsp:include page="/client/assets/layout/footer.jsp"/>

<!-- Add lightbox script for image gallery -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Set minimum date for booking to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('bookingDate').min = today;

        // Set minimum date for cart modal date picker
        if (document.getElementById('cartDate')) {
            document.getElementById('cartDate').min = today;
        }

        // Load pets for the modal
        loadUserPets();

        const timelineSelector = document.getElementById('timelineSelector');
        if (timelineSelector) {
            timelineSelector.style.pointerEvents = 'none';
        }

        validateForm();
    });

    function showImage(src, alt) {
        const overlay = document.getElementById('imageOverlay');
        const largeImage = document.getElementById('largeImage');

        largeImage.src = src;
        largeImage.alt = alt;

        overlay.classList.add('active');
    }

    document.getElementById('imageOverlay').addEventListener('click', function (e) {
        if (e.target === this) {
            this.classList.remove('active');
        }
    });

    function scrollGallery(amount) {
        const container = document.getElementById('galleryContainer');
        container.scrollLeft += amount;
    }

    function loadUserPets() {
        fetch('userpet?action=getUserPet', {
            method: 'GET'
        })
                .then(response => response.json())
                .then(data => {
                    const petSelect = document.getElementById('petSelect');
                    const noPetsMessage = document.querySelector('.text-danger');
                    const bookButton = document.querySelector('button[type="submit"]');

                    petSelect.innerHTML = '<option value="" selected disabled>Select a pet</option>';

                    if (data.length > 0) {
                        data.forEach(pet => {
                            const option = document.createElement('option');
                            option.value = pet.userPetID;
                            option.text = `` + pet.petName + `(` + pet.pet.name + `)`;
                            petSelect.appendChild(option);
                        });
                        bookButton.disabled = false;
                        if (noPetsMessage)
                            noPetsMessage.style.display = 'none';
                    } else {
                        if (noPetsMessage)
                            noPetsMessage.style.display = 'block';
                        bookButton.disabled = true;
                    }
                })
                .catch(error => {
                    console.error('Error fetching user pets:', error);
                    const petSelect = document.getElementById('petSelect');
                    petSelect.innerHTML = '<option value="" disabled>Error loading pets. Try again later.</option>';
                    document.querySelector('button[type="submit"]').disabled = true;
                });

        fetch('userpet?action=getUserPet', {
            method: 'GET'
        })
                .then(response => response.json())
                .then(data => {
                    const cartPetSelect = document.getElementById('cartPet');
                    if (cartPetSelect) {
                        cartPetSelect.innerHTML = '<option value="" selected disabled>Choose a pet</option>';

                        if (data.length > 0) {
                            data.forEach(pet => {
                                const option = document.createElement('option');
                                option.value = pet.userPetID;
                                option.text = `` + pet.petName + `(` + pet.pet.name + `)`;
                                cartPetSelect.appendChild(option);
                            });
                        } else {
                            cartPetSelect.innerHTML = '<option value="" disabled>You do not have any pets</option>';
                        }
                    }
                })
                .catch(error => {
                    console.error('Error fetching user pets for modal:', error);
                    const cartPetSelect = document.getElementById('cartPet');
                    if (cartPetSelect) {
                        cartPetSelect.innerHTML = '<option value="" disabled>Error loading pet</option>';
                    }
                });
    }

    function validateForm() {
        const date = document.getElementById('cartDate')?.value || '';
        const time = document.getElementById('cartTime')?.value || '';
        const pet = document.getElementById('cartPet')?.value || '';
        const addButton = document.getElementById('addToCartBtn');

        if (addButton) {
            if (date && time && pet) {
                addButton.disabled = false;
            } else {
                addButton.disabled = true;
            }
        }
    }

    function validateBookingTime(selectedTimeStr, selectedDate) {
        const now = new Date();
        const selectedDateTime = new Date(selectedDate + 'T' + selectedTimeStr);

        const minAllowedTime = new Date(now.getTime() + 30 * 60000);

        if (selectedDateTime < minAllowedTime) {
            return {
                valid: false,
                message: 'Booking time must be at least 30 minutes from now to allow preparation time.'
            };
        }

        return {valid: true};
    }

    document.getElementById('cartPet').addEventListener('change', validateForm);

    document.addEventListener('DOMContentLoaded', function () {
        const cartDate = document.getElementById('cartDate');
        const cartTime = document.getElementById('cartTime');
        const cartTimeLoading = document.getElementById('cartTimeLoading');
        const cartTimeError = document.getElementById('cartTimeError');
        const timelineContainer = document.getElementById('timelineContainer');
        const selectDateFirst = document.getElementById('selectDateFirst');
        const selectedTimeDisplay = document.getElementById('selectedTimeDisplay');
        const serviceId = '${service.serviceID}';
        const categoryServiceId = '${service.categoryServiceID}';

        if (cartDate) {
            cartDate.addEventListener('change', function () {
                const selectedDate = cartDate.value;
                if (!selectedDate) {
                    // Disable time input và button khi không có date
                    document.getElementById('cartTimeInput').disabled = true;
                    document.getElementById('setTimeFromInput').disabled = true;
                    document.getElementById('timelineSelector').style.pointerEvents = 'none';
                    return;
                }

                // Enable time input và button khi đã chọn date
                document.getElementById('cartTimeInput').disabled = false;
                document.getElementById('setTimeFromInput').disabled = false;
                document.getElementById('timelineSelector').style.pointerEvents = 'auto';

                // Hiển thị loading và ẩn timeline
                timelineContainer.style.display = 'none';
                selectDateFirst.style.display = 'none';
                cartTimeLoading.style.display = 'block';
                cartTimeError.style.display = 'none';
                selectedTimeDisplay.textContent = '';
                cartTime.value = '';

                validateForm();
                fetch('booking?action=getTimeAvaliable&date=' + encodeURIComponent(selectedDate) + '&categoryServiceId=' + categoryServiceId, {
                    method: 'GET'
                })
                        .then(response => response.json())
                        .then(data => {
                            cartTimeLoading.style.display = 'none';
                            if (data) {
                                window.currentBusyTimeRanges = data.busyTimeRanges || [];
                                // Hiển thị timeline
                                timelineContainer.style.display = 'block';
                                renderTimeline(data.busyTimeRanges || [], data.workingHours || '08:00-17:30');
                            } else {
                                cartTimeError.style.display = 'block';
                                cartTimeError.textContent = 'No time data available for this date.';
                            }
                        })
                        .catch(error => {
                            cartTimeLoading.style.display = 'none';
                            cartTimeError.style.display = 'block';
                            cartTimeError.textContent = 'Error loading available times. Please try again.';
                            console.error('Error fetching time data:', error);
                        });
            });
        }

        function renderTimeline(busyTimeRanges, workingHours) {
            const timelineScale = document.getElementById('timelineScale');
            const timelineBusy = document.getElementById('timelineBusy');
            const timelineSelector = document.getElementById('timelineSelector');
            const timelineLabels = document.getElementById('timelineLabels');

            // Parse working hours
            const [startTime, endTime] = workingHours.split('-');
            const startHour = parseInt(startTime.split(':')[0]);
            const startMinute = parseInt(startTime.split(':')[1]);
            const endHour = parseInt(endTime.split(':')[0]);
            const endMinute = parseInt(endTime.split(':')[1]);

            // Tính tổng số phút làm việc
            const totalMinutes = (endHour * 60 + endMinute) - (startHour * 60 + startMinute);
            const workingStartMinutes = startHour * 60 + startMinute;

            // Clear timeline
            timelineScale.innerHTML = '';
            timelineBusy.innerHTML = '';
            timelineLabels.innerHTML = '';
            // Tạo scale (các vạch chia 15 phút)
            for (let minutes = 0; minutes <= totalMinutes; minutes += 15) {
                const scale = document.createElement('div');
                scale.className = 'timeline-tick';
                scale.style.left = (minutes / totalMinutes * 100) + '%';
                timelineScale.appendChild(scale);
            }

            // Tạo labels (chỉ hiển thị thời gian đầu, cuối và busy times)
            const labelsToShow = new Set();

            // Thêm label đầu và cuối
            labelsToShow.add(0); // Thời gian bắt đầu
            labelsToShow.add(totalMinutes); // Thời gian kết thúc

            // Thêm labels cho busy time ranges
            busyTimeRanges.forEach(busyRange => {
                const busyStartParts = busyRange.start.split(':');
                const busyEndParts = busyRange.end.split(':');
                const busyStartMinutes = parseInt(busyStartParts[0]) * 60 + parseInt(busyStartParts[1]);
                const busyEndMinutes = parseInt(busyEndParts[0]) * 60 + parseInt(busyEndParts[1]);

                const relativeStart = busyStartMinutes - workingStartMinutes;
                const relativeEnd = busyEndMinutes - workingStartMinutes;

                if (relativeStart >= 0 && relativeStart <= totalMinutes) {
                    labelsToShow.add(relativeStart);
                }
                if (relativeEnd >= 0 && relativeEnd <= totalMinutes) {
                    labelsToShow.add(relativeEnd);
                }
            });

            // Render labels
            labelsToShow.forEach(minutes => {
                const currentMinutes = startHour * 60 + startMinute + minutes;
                const hour = Math.floor(currentMinutes / 60);
                const minute = currentMinutes % 60;

                const label = document.createElement('div');
                label.className = 'timeline-label';
                label.style.left = (minutes / totalMinutes * 100) + '%';
                label.textContent = hour.toString().padStart(2, '0') + ':' + minute.toString().padStart(2, '0');
                timelineLabels.appendChild(label);
            });

            // Tạo các khoảng bận dựa trên busyTimeRanges
            busyTimeRanges.forEach(busyRange => {
                const startParts = busyRange.start.split(':');
                const endParts = busyRange.end.split(':');

                const busyStartMinutes = parseInt(startParts[0]) * 60 + parseInt(startParts[1]);
                const busyEndMinutes = parseInt(endParts[0]) * 60 + parseInt(endParts[1]);

                // Tính toán vị trí tương đối trong timeline
                const relativeStart = busyStartMinutes - workingStartMinutes;
                const relativeEnd = busyEndMinutes - workingStartMinutes;

                if (relativeStart >= 0 && relativeStart < totalMinutes) {
                    const busySlot = document.createElement('div');
                    busySlot.className = 'busy-slot';
                    busySlot.style.left = (relativeStart / totalMinutes * 100) + '%';
                    busySlot.style.width = ((relativeEnd - relativeStart) / totalMinutes * 100) + '%';
                    busySlot.title = `Busy: ${busyRange.start} - ${busyRange.end}`;
                    timelineBusy.appendChild(busySlot);
                }
            });
            // Xử lý click trên timeline
            timelineSelector.onclick = function (e) {
                const rect = timelineSelector.getBoundingClientRect();
                const clickX = e.clientX - rect.left;
                const percentage = clickX / rect.width;
                // Cho phép chọn bất kỳ thời gian nào (làm tròn đến phút)
                const selectedMinutes = Math.round(percentage * totalMinutes);

                // Tính thời gian được chọn
                const actualMinutes = workingStartMinutes + selectedMinutes;
                const selectedHour = Math.floor(actualMinutes / 60);
                const selectedMin = actualMinutes % 60;
                const selectedTimeStr = selectedHour.toString().padStart(2, '0') + ':' + selectedMin.toString().padStart(2, '0');

                // Lấy thời gian dịch vụ hiện tại (từ JSP)
                const serviceTime = parseInt('${service.time}'); // Thời gian dịch vụ tính bằng phút
                const serviceEndMinutes = actualMinutes + serviceTime;
                const serviceEndHour = Math.floor(serviceEndMinutes / 60);
                const serviceEndMin = serviceEndMinutes % 60;

                // Kiểm tra nếu thời gian được chọn có bị conflict với các khoảng bận không
                let isConflict = false;
                busyTimeRanges.forEach(busyRange => {
                    const busyStartParts = busyRange.start.split(':');
                    const busyEndParts = busyRange.end.split(':');
                    const busyStartMinutes = parseInt(busyStartParts[0]) * 60 + parseInt(busyStartParts[1]);
                    const busyEndMinutes = parseInt(busyEndParts[0]) * 60 + parseInt(busyEndParts[1]);

                    // Kiểm tra overlap: dịch vụ bắt đầu trước khi busy kết thúc VÀ dịch vụ kết thúc sau khi busy bắt đầu
                    if (actualMinutes < busyEndMinutes && serviceEndMinutes > busyStartMinutes) {
                        isConflict = true;
                    }
                });

                // Kiểm tra nếu dịch vụ vượt quá giờ làm việc
                const workingEndMinutes = endHour * 60 + endMinute;
                if (serviceEndMinutes > workingEndMinutes) {
                    alert('Service time extends beyond working hours. Please choose an earlier time.');
                    return;
                }

                if (!isConflict && selectedMinutes >= 0 && selectedMinutes < totalMinutes) {
                    const selectedTimeStr = selectedHour.toString().padStart(2, '0') + ':' +
                            selectedMin.toString().padStart(2, '0') + ':00';

                    // Thêm kiểm tra thời gian đặt phải cách hiện tại ít nhất 30 phút
                    const validationResult = validateBookingTime(selectedTimeStr, cartDate.value);
                    if (!validationResult.valid) {
                        alert(validationResult.message);
                        return;
                    }
                    
                    document.getElementById('cartTimeInput').value = selectedHour.toString().padStart(2, '0') + ':' + selectedMin.toString().padStart(2, '0');
                    cartTime.value = selectedHour.toString().padStart(2, '0') + ':' + selectedMin.toString().padStart(2, '0') + ':00';
                    
                    const endTimeStr = serviceEndHour.toString().padStart(2, '0') + ':' + serviceEndMin.toString().padStart(2, '0');
                    selectedTimeDisplay.textContent = `Selected:` + selectedTimeStr + `-` + endTimeStr + `(${service.time} mins)`;
                    validateForm();
                } else {
                    cartTime.value = '';
                    selectedTimeDisplay.textContent = '';
                    validateForm();

                    if (isConflict) {
                        alert('This time slot conflicts with existing bookings. Please choose another time.');
                    } else {
                        alert('Please select a time within working hours.');
                    }
                }  
            };
        }

        // Xử lý nút "Set Time" từ input
        const setTimeFromInputBtn = document.getElementById('setTimeFromInput');
        const cartTimeInput = document.getElementById('cartTimeInput');

        if (setTimeFromInputBtn && cartTimeInput) {
            setTimeFromInputBtn.addEventListener('click', function () {
                const inputTime = cartTimeInput.value;
                if (!inputTime) {
                    alert('Please enter a time first.');
                    return;
                }
                // Validate time format và range
                const [inputHour, inputMinute] = inputTime.split(':').map(num => parseInt(num));
                if (inputHour < 8 || inputHour > 17 || (inputHour === 17 && inputMinute > 30)) {
                    alert('Please select a time between 8:00 and 17:30.');
                    cartTime.value = '';
                    selectedTimeDisplay.textContent = '';
                    validateForm();
                    return;
                }

                const success = validateAndSetTime(inputTime);
                if (!success) {
                    cartTime.value = '';
                    selectedTimeDisplay.textContent = '';
                    validateForm();
                }
            });

            // Cũng xử lý khi nhấn Enter trong input
            cartTimeInput.addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    setTimeFromInputBtn.click();
                }
            });
        }

        // Hàm chung để validate và set time
        function validateAndSetTime(timeStr) {
            if (!cartDate.value) {
                alert('Please select a date first.');
                return;
            }

            const [selectedHour, selectedMin] = timeStr.split(':').map(num => parseInt(num));
            const selectedMinutes = selectedHour * 60 + selectedMin;
            let serviceTime;
            let serviceEndMinutes;

            if (isLodgingService) {
                const days = parseInt(document.getElementById('lodgingDays').value) || 1;
                serviceTime = days * 24 * 60;
                serviceEndMinutes = selectedMinutes + serviceTime;
            } else {
                serviceTime = parseInt('${service.time}');
                serviceEndMinutes = selectedMinutes + serviceTime;
            }

            // Parse working hours
            const workingHours = '08:00-17:30'; // Default nếu chưa có data
            const [startTime, endTime] = workingHours.split('-');
            const [startHour, startMinute] = startTime.split(':').map(num => parseInt(num));
            const [endHour, endMinute] = endTime.split(':').map(num => parseInt(num));
            const workingEndMinutes = endHour * 60 + endMinute;
            const workingStartMinutes = startHour * 60 + startMinute;

            // Kiểm tra nếu thời gian nằm ngoài giờ làm việc
            if (selectedMinutes < workingStartMinutes || selectedMinutes >= workingEndMinutes) {
                alert('Please select a time between 8:00 and 17:30.');
                return false;
            }

            // Kiểm tra nếu dịch vụ vượt quá giờ làm việc
            if (serviceEndMinutes > workingEndMinutes) {
                alert('Service time extends beyond working hours. Please choose an earlier time.');
                return;
            }

            const selectedTimeFormatted = selectedHour.toString().padStart(2, '0') + ':' +
                    selectedMin.toString().padStart(2, '0') + ':00';
            const validationResult = validateBookingTime(selectedTimeFormatted, cartDate.value);
            if (!validationResult.valid) {
                alert(validationResult.message);
                return false;
            }

            // Kiểm tra conflict với busyTimeRanges (nếu đã load)
            const timelineContainer = document.getElementById('timelineContainer');
            if (timelineContainer && timelineContainer.style.display !== 'none') {
                // Timeline đã được render, có thể check conflict
                let isConflict = false;
                const busyTimeRanges = window.currentBusyTimeRanges || [];

                busyTimeRanges.forEach(busyRange => {
                    const busyStartParts = busyRange.start.split(':');
                    const busyEndParts = busyRange.end.split(':');
                    const busyStartMinutes = parseInt(busyStartParts[0]) * 60 + parseInt(busyStartParts[1]);
                    const busyEndMinutes = parseInt(busyEndParts[0]) * 60 + parseInt(busyEndParts[1]);

                    // Kiểm tra overlap: dịch vụ bắt đầu trước khi busy kết thúc VÀ dịch vụ kết thúc sau khi busy bắt đầu
                    if (selectedMinutes < busyEndMinutes && serviceEndMinutes > busyStartMinutes) {
                        isConflict = true;
                    }
                });

                if (isConflict) {
                    alert('This time slot conflicts with existing bookings. Please choose another time.');
                    return;
                }
            }

            // Set time
            cartTime.value = timeStr + ':00';
            const serviceEndHour = Math.floor(serviceEndMinutes / 60);
            const serviceEndMin = serviceEndMinutes % 60;
            const endTimeStr = serviceEndHour.toString().padStart(2, '0') + ':' + serviceEndMin.toString().padStart(2, '0');
            if (selectedTimeDisplay) {
                selectedTimeDisplay.textContent = `Selected:` + timeStr + `-` + endTimeStr + `(` + serviceTime + `mins)`;
            }

            validateForm();

            // Update timeline selector position nếu timeline đang hiển thị
            if (timelineContainer && timelineContainer.style.display !== 'none') {
                const workingStartMinutes = startHour * 60 + startMinute;
                const totalMinutes = workingEndMinutes - workingStartMinutes;
                const relativeMinutes = selectedMinutes - workingStartMinutes;
                const selectorPos = (relativeMinutes / totalMinutes * 100) + '%';

                const timelineSelector = document.getElementById('timelineSelector');
                if (timelineSelector) {
                    timelineSelector.style.setProperty('--selector-position', selectorPos);
                    timelineSelector.classList.add('active');
                }
            }

            return true;
        }
    });

    document.getElementById('addToCartForm').addEventListener('submit', function (e) {
        e.preventDefault();

        const date = document.getElementById('cartDate').value;
        const time = document.getElementById('cartTime').value;
        const pet = document.getElementById('cartPet').value;

        if (!date || !time || !pet) {
            document.getElementById('addToCartError').style.display = 'block';
            document.getElementById('addToCartError').textContent = 'Please fill in all required fields.';
            return false;
        }

        document.getElementById('addToCartBtn').disabled = true;
        document.getElementById('addToCartBtn').innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Adding...';

        const form = e.target;
        const formData = new FormData(form);

        const params = new URLSearchParams();
        for (const [key, value] of formData.entries()) {
            params.append(key, value);
        }

        fetch('booking', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: params
        })
                .then(response => response.json())
                .catch(error => {
                    return {success: false, message: 'Failed to add to cart. Please try again.'};
                })
                .then(data => {
                    if (data.success) {
                        window.location.href = 'booking?action=viewCart';
                    } else {
                        document.getElementById('addToCartError').style.display = 'block';
                        document.getElementById('addToCartError').textContent = data.message || 'Failed to add to cart. Please try again.';

                        document.getElementById('addToCartBtn').disabled = false;
                        document.getElementById('addToCartBtn').innerHTML = 'Add to cart';
                    }
                });
    });

    // Biến để kiểm tra loại dịch vụ
    const isLodgingService = ${service.categoryServiceID == 3};

    if (isLodgingService) {
        document.addEventListener('DOMContentLoaded', function () {
            loadLodgingPets();
            initLodgingEvents();
        });

        function loadLodgingPets() {
            fetch('userpet?action=getUserPet', {
                method: 'GET'
            })
                    .then(response => response.json())
                    .then(data => {
                        const lodgingPetSelect = document.getElementById('lodgingPet');
                        lodgingPetSelect.innerHTML = '<option value="" selected disabled>Choose a pet</option>';

                        if (data.length > 0) {
                            data.forEach(pet => {
                                const option = document.createElement('option');
                                option.value = pet.userPetID;
                                option.text = `` + pet.petName + `(` + pet.pet.name + `)`;
                                lodgingPetSelect.appendChild(option);
                            });
                        } else {
                            lodgingPetSelect.innerHTML = '<option value="" disabled>You do not have any pets</option>';
                        }
                        validateLodgingForm();
                    })
                    .catch(error => {
                        console.error('Error fetching pets for lodging:', error);
                        document.getElementById('lodgingPet').innerHTML = '<option value="" disabled>Error loading pets</option>';
                    });
        }

        function initLodgingEvents() {
            // Số ngày lưu trú thay đổi
            const lodgingDays = document.getElementById('lodgingDays');
            lodgingDays.addEventListener('change', function () {
                updateLodgingSummary();
                validateLodgingForm();
            });

            const today = new Date().toISOString().split('T')[0];
            document.getElementById('bookingDate').min = today;

            if (document.getElementById('checkInDate')) {
                document.getElementById('checkInDate').min = today;
            }

            document.getElementById('checkInDate').addEventListener('change', validateLodgingForm);

            document.getElementById('checkInTime').addEventListener('change', validateLodgingForm);

            document.getElementById('lodgingPet').addEventListener('change', validateLodgingForm);

            document.getElementById('lodgingServiceForm').addEventListener('submit', handleLodgingSubmit);

            updateLodgingSummary();
        }

        function updateLodgingSummary() {
            const days = parseInt(document.getElementById('lodgingDays').value) || 1;
            if (days < 1) {
                document.getElementById('lodgingDays').value = 1;
                return updateLodgingSummary();
            }

            document.getElementById('stayLengthDisplay').textContent = days + (days > 1 ? ' days' : ' day');

            const basePrice = ${service.price};
            const totalPrice = basePrice * days;

            document.getElementById('totalPriceDisplay').textContent = formatCurrency(totalPrice);
        }

        function formatCurrency(amount) {
            return new Intl.NumberFormat('vi-VN').format(amount) + ' đ';
        }

        function validateLodgingForm() {
            const date = document.getElementById('checkInDate')?.value || '';
            const time = document.getElementById('checkInTime')?.value || '';
            const pet = document.getElementById('lodgingPet')?.value || '';
            const days = parseInt(document.getElementById('lodgingDays')?.value) || 0;
            const addButton = document.getElementById('lodgingAddToCartBtn');

            if (addButton) {
                addButton.disabled = !(date && time && pet && days >= 1);
            }
        }

        function handleLodgingSubmit(e) {
            e.preventDefault();

            const date = document.getElementById('checkInDate').value;
            const time = document.getElementById('checkInTime').value;
            const pet = document.getElementById('lodgingPet').value;
            const days = parseInt(document.getElementById('lodgingDays').value) || 0;

            if (!date || !time || !pet || days < 1) {
                document.getElementById('lodgingServiceError').style.display = 'block';
                document.getElementById('lodgingServiceError').textContent = 'Please fill in all required fields and select at least 1 day for lodging.';
                return false;
            }

            // Kiểm tra thời gian đặt phải cách hiện tại ít nhất 30 phút
            const validationResult = validateBookingTime(time, date);
            if (!validationResult.valid) {
                document.getElementById('lodgingServiceError').style.display = 'block';
                document.getElementById('lodgingServiceError').textContent = validationResult.message;
                return false;
            }

            // Disable button và hiển thị trạng thái loading
            document.getElementById('lodgingAddToCartBtn').disabled = true;
            document.getElementById('lodgingAddToCartBtn').innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Adding...';

            // Gửi form bằng fetch
            const formData = new FormData(this);
            const params = new URLSearchParams();
            for (const [key, value] of formData.entries()) {
                params.append(key, value);
            }

            fetch('booking', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: params
            })
                    .then(response => response.json())
                    .catch(error => {
                        console.error("Error submitting lodging form:", error);
                        return {success: false, message: 'Failed to add to cart. Please try again.'};
                    })
                    .then(data => {
                        if (data.success) {
                            window.location.href = 'booking?action=viewCart';
                        } else {
                            document.getElementById('lodgingServiceError').style.display = 'block';
                            document.getElementById('lodgingServiceError').textContent = data.message || 'Failed to add to cart. Please try again.';

                            document.getElementById('lodgingAddToCartBtn').disabled = false;
                            document.getElementById('lodgingAddToCartBtn').innerHTML = 'Add to cart';
                        }
                    });
        }
    }
</script>
