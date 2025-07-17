<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">Our Services</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="${pageContext.request.contextPath}">Home</a> / <span class="text-white">Services</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Service Listing Start -->
<div class="container-fluid py-5">
    <div class="container">
        <!-- Search & Filter Bar -->
        <div class="mb-5">
            <div class="bg-light p-4 rounded">
                <form action="service" method="get" class="row g-3">
                    <input type="hidden" name="action" value="viewListService">

                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search services..." name="keyword" value="${param.keyword}">
                            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <select class="form-select" name="sortBy" onchange="this.form.submit()">
                            <option value="name_asc" ${param.sortBy == 'name_asc' ? 'selected' : ''}>Name (A-Z)</option>
                            <option value="name_desc" ${param.sortBy == 'name_desc' ? 'selected' : ''}>Name (Z-A)</option>
                            <option value="price_asc" ${param.sortBy == 'price_asc' ? 'selected' : ''}>Price (Low to High)</option>
                            <option value="price_desc" ${param.sortBy == 'price_desc' ? 'selected' : ''}>Price (High to Low)</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <div class="d-grid">
                            <a href="service?action=viewListService" class="btn btn-outline-primary">Clear Filters</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Category Tabs -->
        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link ${empty param.categoryId ? 'active' : ''}" 
                   href="service?action=viewListService${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                    All Services
                </a>
            </li>
            <c:forEach var="category" items="${categories}">
                <li class="nav-item">
                    <c:set var="url" value="service?action=viewListService&categoryId=${category.categoryServiceID}"/>
                    <c:if test="${not empty param.keyword}">
                        <c:set var="url" value="${url}&keyword=${fn:escapeXml(param.keyword)}"/>
                    </c:if>
                    <a class="nav-link ${not empty param.categoryId and param.categoryId + 0 eq category.categoryServiceID ? 'active' : ''}" 
                       href="${url}">
                        ${category.name}
                    </a>
                </li>
            </c:forEach>
        </ul>

        <!-- Services Grid -->
        <div class="row g-4">
            <c:forEach var="service" items="${services}">
                <div class="col-lg-4 col-md-6">
                    <div class="service-item bg-light rounded d-flex flex-column h-100">
                        <div class="position-relative" style="height: 200px;">
                            <img class="img-fluid rounded-top w-100" src="${service.imgURL}" alt="${service.name}" style="height: 100%; object-fit: contain; background-color: #f8f9fa;">
                        </div>
                        <div class="p-4 flex-grow-1 d-flex flex-column">
                            <div class="d-flex justify-content-between mb-3 align-items-center">
                                <h5 class="text-uppercase mb-0" style="max-width: 60%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${service.name}</h5>
                                <span class="bg-primary text-white rounded-pill py-1 px-3">
                                    <fmt:formatNumber value="${service.price}" type="number" maxFractionDigits="0"/> đ
                                </span>
                            </div>
                            <p class="mb-3">${fn:substring(service.description, 0, 150)}${fn:length(service.description) > 150 ? '...' : ''}</p>
                            <div class="mt-auto">
                                <a href="service?action=viewDetail&id=${service.serviceID}" class="btn btn-primary">Learn More</a>
                                <c:if test="${not empty sessionScope.userDetailDTO}">
                                    <c:choose>
                                        <c:when test="${service.serviceID == 5}">
                                            <a href="#" class="btn btn-outline-primary ms-2"
                                               data-bs-toggle="modal" data-bs-target="#lodgingServiceModal"
                                               data-service-id="${service.serviceID}"
                                               data-category-id="${service.categoryServiceID}"
                                               data-service-name="${service.name}"
                                               data-service-price="${service.price}">
                                                <i class="bi bi-cart-plus"></i> Add to cart
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="#" class="btn btn-outline-primary ms-2"
                                               data-bs-toggle="modal" data-bs-target="#addToCartModal"
                                               data-service-id="${service.serviceID}"
                                               data-category-id="${service.categoryServiceID}"
                                               data-service-name="${service.name}"
                                               data-service-price="${service.price}">
                                                <i class="bi bi-cart-plus"></i> Add to cart
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty services && totalPages > 1}">
            <div class="row mt-5">
                <div class="col-12">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="service?action=viewListService&page=${currentPage - 1}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">Previous</a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage == i}">
                                        <li class="page-item active"><a class="page-link">${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="service?action=viewListService&page=${i}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="service?action=viewListService&page=${currentPage + 1}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>

        <!-- No Services Found -->
        <c:if test="${empty services}">
            <div class="alert alert-info text-center p-5">
                <i class="bi bi-info-circle fs-1 mb-3"></i>
                <h4>No Services Found</h4>
                <p>We couldn't find any services matching your criteria. Please try a different search or category.</p>
                <a href="service?action=viewListService" class="btn btn-primary mt-3">View All Services</a>
            </div>
        </c:if>
    </div>
</div>
<!-- Service Listing End -->

<!-- Call to Action Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-md-6 text-white">
                <h1 class="display-5 text-uppercase mb-4">Book Services For Your Pets Today!</h1>
                <p class="fs-5 mb-4">Treat your pet to the best care with our professional services</p>
                <c:if test="${not empty sessionScope.userDetailDTO}">
                    <a href="booking?action=viewCart" class="btn btn-light py-md-3 px-md-5 text-uppercase">View Cart</a>
                </c:if>
                <c:if test="${empty sessionScope.userDetailDTO}">
                    <a href="${pageContext.request.contextPath}/sign-in" class="btn btn-light py-md-3 px-md-5 text-uppercase">Sign In to Book</a>
                </c:if>
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
                    <input type="hidden" name="serviceId" value="" />
                    <input type="hidden" name="categoryServiceId" value="" />
                    <div class="mb-3">
                        <label for="cartDate" class="form-label">Select date</label>
                        <input type="date" class="form-control" id="cartDate" name="bookingDate" min="${java.time.LocalDate.now()}" required />
                    </div>

                    <div class="mb-3" id="timeSelectionContainer">
                        <label class="form-label" id="timeSelectionLabel">Select time</label>
                        <select class="form-select" id="cartTime" name="bookingTime" required>
                            <option value="" selected disabled>Select time</option>
                            <option value="08:00:00">8:00 AM</option>
                            <option value="08:30:00">8:30 AM</option>
                            <option value="09:00:00">9:00 AM</option>
                            <option value="09:30:00">9:30 AM</option>
                            <option value="10:00:00">10:00 AM</option>
                            <option value="10:30:00">10:30 AM</option>
                            <option value="11:00:00">11:00 AM</option>
                            <option value="11:30:00">11:30 AM</option>
                            <option value="13:00:00">1:00 PM</option>
                            <option value="13:30:00">1:30 PM</option>
                            <option value="14:00:00">2:00 PM</option>
                            <option value="14:30:00">2:30 PM</option>
                            <option value="15:00:00">3:00 PM</option>
                            <option value="15:30:00">3:30 PM</option>
                            <option value="16:00:00">4:00 PM</option>
                            <option value="16:30:00">4:30 PM</option>
                            <option value="17:00:00">5:00 PM</option>
                        </select>
                        <small class="form-text text-muted">Choose a time slot (8:00 - 17:30, every 30 minutes)</small>
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
                    <input type="hidden" name="serviceId" value="" />
                    <input type="hidden" name="serviceType" value="lodging" />
                    <input type="hidden" name="categoryServiceId" value="" />

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
                                    <span class="text-primary fw-bold service-price-display"></span>
                                </span>
                                <span class="d-flex justify-content-between">
                                    <span>Length of stay:</span>
                                    <span id="stayLengthDisplay">1 day</span>
                                </span>
                                <hr>
                                <span class="d-flex justify-content-between">
                                    <span>Total:</span>
                                    <span class="text-primary fw-bold" id="totalPriceDisplay"></span>
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

<script>
// ======= JS CHO MODAL BOOKING THƯỜNG (addToCartModal) =======

    document.addEventListener('show.bs.modal', function (event) {
        var modal = document.getElementById('addToCartModal');
        if (!modal)
            return;
        var button = event.relatedTarget;
        if (!button || button.getAttribute('data-bs-target') !== '#addToCartModal')
            return;

        var serviceId = button.getAttribute('data-service-id');
        var categoryId = button.getAttribute('data-category-id');
        var serviceName = button.getAttribute('data-service-name');
        var servicePrice = button.getAttribute('data-service-price');

        modal.querySelector('input[name="serviceId"]').value = serviceId;
        modal.querySelector('input[name="categoryServiceId"]').value = categoryId;

        var modalLabel = modal.querySelector('#addToCartModalLabel');
        if (modalLabel)
            modalLabel.textContent = 'Book: ' + serviceName;
    });

    // Load pet cho modal thường
    function loadUserPets() {
        fetch('userpet?action=getUserPet', {method: 'GET'})
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
                    const cartPetSelect = document.getElementById('cartPet');
                    if (cartPetSelect) {
                        cartPetSelect.innerHTML = '<option value="" disabled>Error loading pet</option>';
                    }
                });
    }
    
    document.getElementById('addToCartModal')?.addEventListener('hidden.bs.modal', function () {
        const form = document.getElementById('addToCartForm');
        if (form) form.reset();
        document.getElementById('addToCartError').style.display = 'none';
        document.getElementById('addToCartError').textContent = '';
        document.getElementById('addToCartBtn').disabled = true;
        document.getElementById('addToCartBtn').innerHTML = 'Add to cart';
    });


    // Validate form booking thường
    function validateForm() {
        const date = document.getElementById('cartDate')?.value || '';
        const time = document.getElementById('cartTime')?.value || '';
        const pet = document.getElementById('cartPet')?.value || '';
        const addButton = document.getElementById('addToCartBtn');
        if (addButton) {
            addButton.disabled = !(date && time && pet);
        }
    }

    // Validate thời gian đặt phải cách hiện tại ít nhất 30 phút
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

    // Sự kiện cho các trường trong modal booking thường
    document.addEventListener('DOMContentLoaded', function () {
        loadUserPets();
        if (document.getElementById('cartDate')) {
            document.getElementById('cartDate').min = new Date().toISOString().split('T')[0];
            document.getElementById('cartDate').addEventListener('change', validateForm);
        }
        if (document.getElementById('cartTime')) {
            document.getElementById('cartTime').addEventListener('change', validateForm);
        }
        if (document.getElementById('cartPet')) {
            document.getElementById('cartPet').addEventListener('change', validateForm);
        }
        validateForm();
    });

    // Xử lý submit modal booking thường
    document.getElementById('addToCartForm')?.addEventListener('submit', function (e) {
        e.preventDefault();
        const date = document.getElementById('cartDate').value;
        const time = document.getElementById('cartTime').value;
        const pet = document.getElementById('cartPet').value;
        if (!date || !time || !pet) {
            document.getElementById('addToCartError').style.display = 'block';
            document.getElementById('addToCartError').textContent = 'Please fill in all required fields.';
            return false;
        }

        // Kiểm tra thời gian đặt phải cách hiện tại ít nhất 30 phút
        const validationResult = validateBookingTime(time, date);
        if (!validationResult.valid) {
            document.getElementById('addToCartError').style.display = 'block';
            document.getElementById('addToCartError').textContent = validationResult.message;
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
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
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

// ======= JS CHO MODAL LODGING (lodgingServiceModal) =======
    document.addEventListener('show.bs.modal', function (event) {
        var modal = document.getElementById('lodgingServiceModal');
        if (!modal)
            return;
        var button = event.relatedTarget;
        if (!button || button.getAttribute('data-bs-target') !== '#lodgingServiceModal')
            return;

        var serviceId = button.getAttribute('data-service-id');
        var categoryId = button.getAttribute('data-category-id');
        var serviceName = button.getAttribute('data-service-name');
        var servicePrice = button.getAttribute('data-service-price');

        modal.querySelector('input[name="serviceId"]').value = serviceId;
        modal.querySelector('input[name="categoryServiceId"]').value = categoryId;

        var modalLabel = modal.querySelector('#lodgingServiceModalLabel');
        if (modalLabel)
            modalLabel.textContent = 'Book Lodging: ' + serviceName;

        var priceDisplay = modal.querySelector('.service-price-display');
        if (priceDisplay)
            priceDisplay.textContent = new Intl.NumberFormat('vi-VN').format(servicePrice) + ' đ';

        var daysInput = modal.querySelector('#lodgingDays');
        if (daysInput)
            daysInput.value = 1;
        var stayLengthDisplay = modal.querySelector('#stayLengthDisplay');
        if (stayLengthDisplay)
            stayLengthDisplay.textContent = '1 day';
        var totalPriceDisplay = modal.querySelector('#totalPriceDisplay');
        if (totalPriceDisplay)
            totalPriceDisplay.textContent = new Intl.NumberFormat('vi-VN').format(servicePrice) + ' đ';

        if (daysInput)
            daysInput.setAttribute('data-base-price', servicePrice);
    });
    
    document.getElementById('lodgingServiceModal')?.addEventListener('hidden.bs.modal', function () {
        const form = document.getElementById('lodgingServiceForm');
        if (form) form.reset();
        document.getElementById('lodgingServiceError').style.display = 'none';
        document.getElementById('lodgingServiceError').textContent = '';
        document.getElementById('lodgingAddToCartBtn').disabled = true;
        document.getElementById('lodgingAddToCartBtn').innerHTML = 'Add to cart';

        if (typeof updateLodgingSummary === 'function') updateLodgingSummary();
    });

    // Load pet cho modal lodging
    function loadLodgingPets() {
        fetch('userpet?action=getUserPet', {method: 'GET'})
                .then(response => response.json())
                .then(data => {
                    const lodgingPetSelect = document.getElementById('lodgingPet');
                    if (lodgingPetSelect) {
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
                    }
                })
                .catch(error => {
                    const lodgingPetSelect = document.getElementById('lodgingPet');
                    if (lodgingPetSelect) {
                        lodgingPetSelect.innerHTML = '<option value="" disabled>Error loading pet</option>';
                    }
                });
    }

    // Validate form lodging
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

    // Cập nhật tổng tiền lodging
    function updateLodgingSummary() {
        const days = parseInt(document.getElementById('lodgingDays').value) || 1;
        if (days < 1) {
            document.getElementById('lodgingDays').value = 1;
            return updateLodgingSummary();
        }
        document.getElementById('stayLengthDisplay').textContent = days + (days > 1 ? ' days' : ' day');
        const basePrice = parseInt(document.getElementById('lodgingPriceDisplay').querySelector('.fw-bold').textContent.replace(/\D/g, '')) || 0;
        const totalPrice = basePrice * days;
        document.getElementById('totalPriceDisplay').textContent = new Intl.NumberFormat('vi-VN').format(totalPrice) + ' đ';
    }

    // Sự kiện cho các trường trong modal lodging
    document.addEventListener('DOMContentLoaded', function () {
        loadLodgingPets();
        if (document.getElementById('checkInDate')) {
            document.getElementById('checkInDate').min = new Date().toISOString().split('T')[0];
            document.getElementById('checkInDate').addEventListener('change', validateLodgingForm);
        }
        if (document.getElementById('checkInTime')) {
            document.getElementById('checkInTime').addEventListener('change', validateLodgingForm);
        }
        if (document.getElementById('lodgingPet')) {
            document.getElementById('lodgingPet').addEventListener('change', validateLodgingForm);
        }
        if (document.getElementById('lodgingDays')) {
            document.getElementById('lodgingDays').addEventListener('change', function () {
                updateLodgingSummary();
                validateLodgingForm();
            });
        }
        updateLodgingSummary();
        validateLodgingForm();
    });

    // Xử lý submit modal lodging
    document.getElementById('lodgingServiceForm')?.addEventListener('submit', function (e) {
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
        document.getElementById('lodgingAddToCartBtn').disabled = true;
        document.getElementById('lodgingAddToCartBtn').innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Adding...';
        const form = e.target;
        const formData = new FormData(form);
        const params = new URLSearchParams();
        for (const [key, value] of formData.entries()) {
            params.append(key, value);
        }
        fetch('booking', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
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
                        document.getElementById('lodgingServiceError').style.display = 'block';
                        document.getElementById('lodgingServiceError').textContent = data.message || 'Failed to add to cart. Please try again.';
                        document.getElementById('lodgingAddToCartBtn').disabled = false;
                        document.getElementById('lodgingAddToCartBtn').innerHTML = 'Add to cart';
                    }
                });
    });
</script>

<jsp:include page="/client/assets/layout/footer.jsp"/>
