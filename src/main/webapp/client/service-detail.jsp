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
                            <a href="booking?action=viewCart" class="btn btn-outline-primary w-100">
                                <i class="bi bi-cart me-2"></i> View Cart
                            </a>
                        </c:if>
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

    document.addEventListener('DOMContentLoaded', function () {
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
                            option.text = `` + pet.petName + `(` + pet.pet.name +`)`;
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
    });
</script>
