<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-white animated slideInDown">Shopping Cart</h1>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-center">
                        <li class="breadcrumb-item"><a class="text-white" href="${pageContext.request.contextPath}/">Home</a></li>
                        <li class="breadcrumb-item text-white active" aria-current="page">Shopping Cart</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Cart Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${empty cartItems}">
                        <div class="text-center py-5">
                            <i class="bi bi-cart-x fs-1 text-primary mb-3"></i>
                            <h4 class="text-dark mb-3">Your cart is empty</h4>
                            <p class="text-muted mb-4">Add services to your cart to continue.</p>
                            <a href="${pageContext.request.contextPath}/service?action=viewListService" class="btn btn-primary py-2 px-4">
                                Browse Services
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover">
                                <thead class="bg-light">
                                    <tr>
                                        <th scope="col" class="text-center">Service</th>
                                        <th scope="col" class="text-center">Date & Time</th>
                                        <th scope="col" class="text-center">Room</th>
                                        <th scope="col" class="text-center">Pet</th>
                                        <th scope="col" class="text-center">Price</th>
                                        <th scope="col" class="text-center">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${cartItems}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <c:if test="${not empty item.service.imgURL}">
                                                        <img src="${item.service.imgURL}" 
                                                             alt="${item.service.name}" class="img-fluid rounded me-3" style="width: 60px; height: 60px; object-fit: cover;">
                                                    </c:if>
                                                    <div>
                                                        <h6 class="fw-bold mb-0">${item.service.name}</h6>
                                                        <small class="text-muted">${item.service.time} minutes</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-center align-middle">
                                                <c:choose>
                                                    <c:when test="${item.service.categoryServiceID == 3}">
                                                        <!-- Hiển thị cho dịch vụ lưu trú -->
                                                        <fmt:parseDate value="${item.dateStartService}" pattern="yyyy-MM-dd" var="checkInDate" />
                                                        <fmt:parseDate value="${item.dateEndService}" pattern="yyyy-MM-dd" var="checkOutDate" />
                                                        <fmt:formatDate value="${checkInDate}" pattern="dd/MM/yyyy" var="formattedCheckInDate" />
                                                        <fmt:formatDate value="${checkOutDate}" pattern="dd/MM/yyyy" var="formattedCheckOutDate" />

                                                        <table class="w-100 text-center align-middle">
                                                            <tr>
                                                                <td style="width: 85px; min-width: 85px; vertical-align: middle; padding-bottom: 8px;">
                                                                    <div style="text-align: center;">
                                                                        <span class="badge bg-primary p-2">Check in</span>
                                                                    </div>
                                                                </td>
                                                                <td style="width: 110px; min-width: 110px; vertical-align: middle; padding-bottom: 8px; text-align: left;">
                                                                    <span class="fw-bold">${formattedCheckInDate}</span>
                                                                </td>
                                                                <td style="vertical-align: middle; padding-bottom: 8px; text-align: left;">
                                                                    <span class="text-muted">${fn:substring(item.startTime, 0, 5)}</span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 85px; min-width: 85px; vertical-align: middle;">
                                                                    <div style="text-align: center;">
                                                                        <span class="badge bg-success p-2">Check out</span>
                                                                    </div>
                                                                </td>
                                                                <td style="width: 110px; min-width: 110px; vertical-align: middle; text-align: left;">
                                                                    <span class="fw-bold">${formattedCheckOutDate}</span>
                                                                </td>
                                                                <td style="vertical-align: middle; text-align: left;">
                                                                    <span class="text-muted">${fn:substring(item.endTime, 0, 5)}</span>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Hiển thị cho dịch vụ thông thường -->
                                                        <div>
                                                            <fmt:parseDate value="${item.dateStartService}" pattern="yyyy-MM-dd" var="parsedDate" />
                                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" var="formattedDate" />
                                                            <strong>${formattedDate}</strong>
                                                        </div>
                                                        <div class="text-muted">
                                                            ${fn:substring(item.startTime, 0, 5)} - ${fn:substring(item.endTime, 0, 5)}
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center align-middle">
                                                ${item.room.roomNumber}
                                            </td>
                                            <td class="text-center align-middle">
                                                ${item.userPet.petName}
                                            </td>
                                            <td class="text-center align-middle">
                                                <strong class="text-primary">
                                                    <fmt:formatNumber value="${item.price}" pattern="#,##0₫" />
                                                </strong>
                                            </td>
                                            <td class="text-center align-middle">
                                                <c:choose>
                                                    <c:when test="${item.service.categoryServiceID == 3}">
                                                        <!-- Nút Edit cho dịch vụ lưu trú -->
                                                        <button class="btn btn-sm btn-outline-primary me-1" 
                                                                onclick="openEditLodgingPetModal(
                                                                ${item.bookingDetailID},
                                                                                '${item.service.name}',
                                                                                '${formattedCheckInDate}',
                                                                                '${formattedCheckOutDate}',
                                                                                '${fn:substring(item.startTime, 0, 5)}',
                                                                ${item.userPet.userPetID})">
                                                            <i class="bi bi-pencil me-1"></i>Edit
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Nút Edit cho dịch vụ thông thường -->
                                                        <button class="btn btn-sm btn-outline-primary me-1" 
                                                                onclick="openEditPetModal(
                                                                ${item.bookingDetailID},
                                                                                '${item.service.name}',
                                                                                '${formattedDate}',
                                                                                '${fn:substring(item.startTime, 0, 5)} - ${fn:substring(item.endTime, 0, 5)}',
                                                                ${item.userPet.userPetID})">
                                                            <i class="bi bi-pencil me-1"></i>Edit
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                                <button class="btn btn-sm btn-danger" onclick="removeFromCart(${item.bookingDetailID})">
                                                    <i class="bi bi-trash me-1"></i>Remove
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="row mt-5">
                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath}/service?action=viewListService" class="btn btn-outline-primary">
                                    <i class="bi bi-arrow-left me-2"></i>Continue Shopping
                                </a>
                            </div>
                            <div class="col-md-6">
                                <div class="bg-light p-4 rounded">
                                    <h5 class="mb-3">Order Summary</h5>
                                    <div class="d-flex justify-content-between mb-2">
                                        <span>Subtotal:</span>
                                        <strong><fmt:formatNumber value="${cartBooking.totalPrice}" pattern="#,##0₫" /></strong>
                                    </div>
                                    <hr>
                                    <div class="d-flex justify-content-between mb-4">
                                        <span class="h5 mb-0">Total:</span>
                                        <span class="h5 mb-0 text-primary"><fmt:formatNumber value="${cartBooking.totalPrice}" pattern="#,##0₫" /></span>
                                    </div>
                                    <form action="booking" method="post" onsubmit="return confirmCheckout()">
                                        <input type="hidden" name="action" value="checkout">
                                        <button type="submit" class="btn btn-primary w-100 py-3">
                                            <i class="bi bi-credit-card me-2"></i>Proceed to Checkout
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>
<!-- Cart End -->

<!-- Edit Pet Modal -->
<div class="modal fade" id="editPetModal" tabindex="-1" aria-labelledby="editPetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editPetModalLabel">Change Pet</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editPetForm">
                    <input type="hidden" id="editBookingDetailId" name="bookingDetailId">
                    <input type="hidden" name="action" value="updateCartPet">

                    <div class="mb-3">
                        <h6 class="text-dark">Service: <span id="editServiceName" class="fw-bold"></span></h6>
                    </div>

                    <div class="mb-3">
                        <h6 class="text-dark">Date & Time: <span id="editDateTime" class="fw-bold"></span></h6>
                    </div>

                    <div class="mb-3">
                        <label for="editPet" class="form-label">Select Pet</label>
                        <select class="form-select" id="editPet" name="userPetId" required>
                            <option value="" selected disabled>Loading pet list...</option>
                        </select>
                    </div>

                    <div class="alert alert-danger" id="editPetError" style="display:none;"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveEditPetBtn">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Pet Modal For Lodging Services -->
<div class="modal fade" id="editLodgingPetModal" tabindex="-1" aria-labelledby="editLodgingPetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editLodgingPetModalLabel">Change Pet for Lodging Service</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editLodgingPetForm">
                    <input type="hidden" id="editLodgingBookingDetailId" name="bookingDetailId">
                    <input type="hidden" name="action" value="updateLodgingCartPet">

                    <div class="mb-3">
                        <h6 class="text-dark">Service: <span id="editLodgingServiceName" class="fw-bold"></span></h6>
                    </div>

                    <div class="mb-3">
                        <h6 class="text-dark">Lodging Period:</h6>
                        <div id="editLodgingDateTime" class="bg-light p-2 rounded mb-2"></div>
                    </div>

                    <div class="mb-3">
                        <label for="editLodgingPet" class="form-label">Select Pet</label>
                        <select class="form-select" id="editLodgingPet" name="userPetId" required>
                            <option value="" selected disabled>Loading pet list...</option>
                        </select>
                    </div>

                    <div class="alert alert-info mt-3">
                        <small><i class="bi bi-info-circle me-2"></i>Changing the pet for a lodging service will update it for the entire lodging period.</small>
                    </div>

                    <div class="alert alert-danger" id="editLodgingPetError" style="display:none;"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveLodgingEditPetBtn">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/client/assets/layout/footer.jsp"/>

<!-- JavaScript Libraries -->
<script>
    function removeFromCart(bookingDetailId) {
        if (confirm("Are you sure you want to remove this service from your cart?")) {
            fetch('${pageContext.request.contextPath}/booking?action=removeFromCart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'bookingDetailId=' + bookingDetailId
            })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            window.location.reload();
                        } else {
                            alert('Error: ' + (data.message || 'Failed to remove item from cart'));
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('An error occurred while removing the item from cart');
                    });
        }
    }

    function openEditPetModal(bookingDetailId, serviceName, date, time, currentPetId) {
        document.getElementById('editBookingDetailId').value = bookingDetailId;
        document.getElementById('editServiceName').textContent = serviceName;
        document.getElementById('editDateTime').textContent = date + ' ' + time;
        document.getElementById('editPetError').style.display = 'none';

        loadUserPets(currentPetId);

        // Mở modal
        const editPetModal = new bootstrap.Modal(document.getElementById('editPetModal'));
        editPetModal.show();
    }

    function loadUserPets(currentPetId) {
        const editPetSelect = document.getElementById('editPet');
        editPetSelect.innerHTML = '<option value="" disabled>Loading pets...</option>';

        fetch('userpet?action=getUserPet', {
            method: 'GET'
        })
                .then(response => response.json())
                .then(data => {
                    editPetSelect.innerHTML = '<option value="" disabled>Select a pet</option>';

                    if (data.length > 0) {
                        data.forEach(pet => {
                            const option = document.createElement('option');
                            option.value = pet.userPetID;
                            option.text = `` + pet.petName + `(` + pet.pet.name + `)`;

                            // Chọn pet hiện tại của booking
                            if (pet.userPetID == currentPetId) {
                                option.selected = true;
                            }

                            editPetSelect.appendChild(option);
                        });

                        document.getElementById('saveEditPetBtn').disabled = false;
                    } else {
                        editPetSelect.innerHTML = '<option value="" disabled>You don\'t have any pets</option>';
                        document.getElementById('saveEditPetBtn').disabled = true;
                    }
                })
                .catch(error => {
                    console.error('Error fetching user pets:', error);
                    editPetSelect.innerHTML = '<option value="" disabled>Error loading pets</option>';
                    document.getElementById('saveEditPetBtn').disabled = true;
                });
    }

    document.getElementById('saveEditPetBtn').addEventListener('click', function () {
        const bookingDetailId = document.getElementById('editBookingDetailId').value;
        const newPetId = document.getElementById('editPet').value;

        if (!newPetId) {
            document.getElementById('editPetError').textContent = 'Please select a pet';
            document.getElementById('editPetError').style.display = 'block';
            return;
        }

        // Hiển thị loading
        const saveBtn = this;
        saveBtn.disabled = true;
        saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...';

        const formData = new URLSearchParams();
        formData.append('action', 'updateCartPet');
        formData.append('bookingDetailId', bookingDetailId);
        formData.append('userPetId', newPetId);

        fetch('booking', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData
        })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Đóng modal và reload trang
                        bootstrap.Modal.getInstance(document.getElementById('editPetModal')).hide();
                        window.location.reload();
                    } else {
                        // Hiển thị lỗi
                        document.getElementById('editPetError').textContent = data.message || 'Failed to update pet';
                        document.getElementById('editPetError').style.display = 'block';

                        // Reset nút save
                        saveBtn.disabled = false;
                        saveBtn.innerHTML = 'Save Changes';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    document.getElementById('editPetError').textContent = 'An error occurred while updating the pet';
                    document.getElementById('editPetError').style.display = 'block';

                    saveBtn.disabled = false;
                    saveBtn.innerHTML = 'Save Changes';
                });
    });

    function openEditLodgingPetModal(bookingDetailId, serviceName, checkInDate, checkOutDate, checkInTime, currentPetId) {
        document.getElementById('editLodgingBookingDetailId').value = bookingDetailId;
        document.getElementById('editLodgingServiceName').textContent = serviceName;

        const lodgingDateTimeHtml = `
        <table class="w-100" style="table-layout: fixed;">
            <tr>
                <td style="width: 85px; min-width: 85px; vertical-align: middle; padding-bottom: 12px;">
                    <div style="text-align: center;">
                        <span class="badge bg-primary p-2">Check in</span>
                    </div>
                </td>
                <td style="width: 110px; min-width: 110px; vertical-align: middle; padding-bottom: 12px; text-align: left;">
                    <span class="fw-bold">` + checkInDate +`</span>
                </td>
                <td style="vertical-align: middle; padding-bottom: 12px; text-align: left;">
                    <span class="text-muted">` + checkInTime + `</span>
                </td>
            </tr>
            <tr>
                <td style="width: 85px; min-width: 85px; vertical-align: middle;">
                    <div style="text-align: center;">
                        <span class="badge bg-success p-2">Check out</span>
                    </div>
                </td>
                <td style="width: 110px; min-width: 110px; vertical-align: middle; text-align: left;">
                    <span class="fw-bold">` + checkOutDate +`</span>
                </td>
                <td style="vertical-align: middle; text-align: left;">
                    <span class="text-muted">` + checkInTime +`</span>
                </td>
            </tr>
        </table>
    `;

        document.getElementById('editLodgingDateTime').innerHTML = lodgingDateTimeHtml;
        document.getElementById('editLodgingPetError').style.display = 'none';

        // Load danh sách thú cưng
        loadLodgingUserPets(currentPetId);

        // Mở modal
        const editLodgingPetModal = new bootstrap.Modal(document.getElementById('editLodgingPetModal'));
        editLodgingPetModal.show();
    }

    // Hàm tải danh sách thú cưng cho modal lưu trú
    function loadLodgingUserPets(currentPetId) {
        const editLodgingPetSelect = document.getElementById('editLodgingPet');
        editLodgingPetSelect.innerHTML = '<option value="" disabled>Loading pets...</option>';

        fetch('userpet?action=getUserPet', {
            method: 'GET'
        })
                .then(response => response.json())
                .then(data => {
                    editLodgingPetSelect.innerHTML = '<option value="" disabled>Select a pet</option>';

                    if (data.length > 0) {
                        data.forEach(pet => {
                            const option = document.createElement('option');
                            option.value = pet.userPetID;
                            option.text = `` + pet.petName + `(` + pet.pet.name + `)`;

                            // Chọn pet hiện tại của booking
                            if (pet.userPetID == currentPetId) {
                                option.selected = true;
                            }

                            editLodgingPetSelect.appendChild(option);
                        });

                        document.getElementById('saveLodgingEditPetBtn').disabled = false;
                    } else {
                        editLodgingPetSelect.innerHTML = '<option value="" disabled>You don\'t have any pets</option>';
                        document.getElementById('saveLodgingEditPetBtn').disabled = true;
                    }
                })
                .catch(error => {
                    console.error('Error fetching user pets for lodging:', error);
                    editLodgingPetSelect.innerHTML = '<option value="" disabled>Error loading pets</option>';
                    document.getElementById('saveLodgingEditPetBtn').disabled = true;
                });
    }

    // Xử lý sự kiện khi nhấn nút Save Changes cho dịch vụ lưu trú
    document.getElementById('saveLodgingEditPetBtn').addEventListener('click', function () {
        const bookingDetailId = document.getElementById('editLodgingBookingDetailId').value;
        const newPetId = document.getElementById('editLodgingPet').value;

        if (!newPetId) {
            document.getElementById('editLodgingPetError').textContent = 'Please select a pet';
            document.getElementById('editLodgingPetError').style.display = 'block';
            return;
        }

        // Hiển thị trạng thái loading
        const saveBtn = this;
        saveBtn.disabled = true;
        saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Saving...';

        const formData = new URLSearchParams();
        formData.append('action', 'updateLodgingCartPet');
        formData.append('bookingDetailId', bookingDetailId);
        formData.append('userPetId', newPetId);

        fetch('booking', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: formData
        })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        // Đóng modal và reload trang
                        bootstrap.Modal.getInstance(document.getElementById('editLodgingPetModal')).hide();
                        window.location.reload();
                    } else {
                        // Hiển thị lỗi
                        document.getElementById('editLodgingPetError').textContent = data.message || 'Failed to update pet for lodging service';
                        document.getElementById('editLodgingPetError').style.display = 'block';

                        // Reset nút save
                        saveBtn.disabled = false;
                        saveBtn.innerHTML = 'Save Changes';
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    document.getElementById('editLodgingPetError').textContent = 'An error occurred while updating the pet';
                    document.getElementById('editLodgingPetError').style.display = 'block';

                    saveBtn.disabled = false;
                    saveBtn.innerHTML = 'Save Changes';
                });
    });
    
    function confirmCheckout() {
        return confirm("Are you ready to proceed with this booking? You will be redirected to the booking details page.");
    }
</script>