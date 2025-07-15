<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    /* Animation for new row */
    @keyframes highlightNew {
        0% {
            background-color: rgba(52, 173, 84, 0.2);
        }
        70% {
            background-color: rgba(52, 173, 84, 0.2);
        }
        100% {
            background-color: transparent;
        }
    }

    .highlight-new {
        animation: highlightNew 3s ease;
    }

    /* Animation for row deletion */
    @keyframes fadeOut {
        from {
            opacity: 1;
        }
        to {
            opacity: 0;
            transform: translateX(30px);
        }
    }

    .fade-out {
        animation: fadeOut 0.5s ease forwards;
    }
</style>

<!-- Profile Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">My Profile</h1>
                <div class="d-inline-block position-relative">
                    <img src="${not empty sessionScope.userDetailDTO.avatar ? sessionScope.userDetailDTO.avatar : pageContext.request.contextPath.concat('/client/assets/img/hero.jpg')}" 
                         alt="Profile Image" class="img-fluid rounded-circle border border-5 border-white" 
                         style="width: 150px; height: 150px; object-fit: cover;">
                    <div class="position-absolute bottom-0 end-0 me-2">
                        <form id="avatarForm" action="userdetail" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="changeAvatar">
                            <label for="profileImageUpload" class="btn btn-sm btn-light rounded-circle" 
                                   style="width: 40px; height: 40px; cursor: pointer;">
                                <i class="bi bi-camera text-primary fs-5 d-flex align-items-center justify-content-center h-100"></i>
                            </label>
                            <input type="file" id="profileImageUpload" name="avatar" style="display: none;" accept="image/*" onchange="submitAvatarForm()">
                        </form>
                    </div>
                </div>
                <div class="mt-3">
                    <c:if test="${not empty avatarUploadError}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            ${avatarUploadError}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty avatarUploadSuccess}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            ${avatarUploadSuccess}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                    </c:if>
                </div>         
                <h4 class="text-white mt-3">${sessionScope.userDetailDTO.firstName} ${sessionScope.userDetailDTO.lastName}</h4>
                <p class="text-white">${sessionScope.userDetailDTO.user.email}</p>
            </div>
        </div>
    </div>
</div>
<!-- Profile Header End -->

<!-- Profile Content Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 mb-5">
                <div class="bg-light p-4 rounded">
                    <div class="d-flex flex-column">
                        <a href="#personalInfo" class="d-flex align-items-center mb-3 pb-3 border-bottom active" data-bs-toggle="tab" role="tab" id="personal-info-tab">
                            <i class="bi bi-person-fill me-2 text-primary"></i>
                            <span>Personal Information</span>
                        </a>
                        <a href="#securitySettings" class="d-flex align-items-center mb-3 pb-3 border-bottom" data-bs-toggle="tab" role="tab" id="security-settings-tab">
                            <i class="bi bi-shield-lock me-2 text-primary"></i>
                            <span>Security Settings</span>
                        </a>
                        <a href="#userPets" class="d-flex align-items-center mb-3 pb-3 border-bottom" data-bs-toggle="tab" role="tab" id="user-pets-tab">
                            <i class="bi bi-heart-fill me-2 text-primary"></i>
                            <span>My Pets</span>
                        </a>
                        <a href="#bookingHistory" class="d-flex align-items-center" data-bs-toggle="tab" role="tab" id="booking-history-tab">
                            <i class="bi bi-calendar-check me-2 text-primary"></i>
                            <span>Booking History</span>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="tab-content">
                    <!-- Personal Information Tab -->
                    <div class="tab-pane fade show active" id="personalInfo" role="tabpanel" aria-labelledby="personal-info-tab">
                        <div class="bg-light p-4 rounded">
                            <div class="border-bottom pb-3 mb-4 d-flex justify-content-between align-items-center">
                                <h4 class="text-uppercase">Personal Information</h4>
                                <button class="btn btn-sm btn-primary" id="editPersonalInfoBtn">Edit</button>
                            </div>

                            <form id="personalInfoForm">
                                <input type="hidden" name="action" value="changeInfo">
                                <div class="row mb-3">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <label for="firstName" class="form-label">First Name</label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" 
                                               value="${sessionScope.userDetailDTO.firstName}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label">Last Name</label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" 
                                               value="${sessionScope.userDetailDTO.lastName}" disabled>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${sessionScope.userDetailDTO.user.email}" readonly>
                                </div>

                                <div class="mb-3">
                                    <label for="tel" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="tel" name="tel" 
                                           value="${sessionScope.userDetailDTO.tel}" disabled>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <label for="dob" class="form-label">Date of Birth</label>
                                        <input type="date" class="form-control" id="dob" name="dob" 
                                               value="${sessionScope.userDetailDTO.dob}" disabled>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Gender</label>
                                        <div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="genderMale" 
                                                       value="male" disabled ${sessionScope.userDetailDTO.gender == 'male' ? 'checked' : ''}>
                                                <label class="form-check-label" for="genderMale">Male</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="genderFemale" 
                                                       value="female" disabled ${sessionScope.userDetailDTO.gender == 'female' ? 'checked' : ''}>
                                                <label class="form-check-label" for="genderFemale">Female</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gender" id="genderOther" 
                                                       value="other" disabled ${sessionScope.userDetailDTO.gender == 'other' ? 'checked' : ''}>
                                                <label class="form-check-label" for="genderOther">Other</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3" id="saveButtonGroup" style="display: none;">
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                    <button type="button" class="btn btn-outline-secondary ms-2" id="cancelEditBtn">Cancel</button>
                                </div>
                            </form>

                            <div id="infoUpdateMsg"></div>
                        </div>
                    </div>

                    <!-- Security Settings Tab -->
                    <div class="tab-pane fade" id="securitySettings" role="tabpanel" aria-labelledby="security-settings-tab">
                        <div class="bg-light p-4 rounded">
                            <div class="border-bottom pb-3 mb-4">
                                <h4 class="text-uppercase">Security Settings</h4>
                            </div>

                            <form id="passwordChangeForm">
                                <input type="hidden" name="action" value="changePassword">

                                <!-- Add error/success message display -->
                                <c:if test="${not empty passwordChangeError}">
                                    <div class="alert alert-danger mb-3" role="alert">
                                        ${passwordChangeError}
                                    </div>
                                </c:if>
                                <c:if test="${not empty passwordChangeSuccess}">
                                    <div class="alert alert-success mb-3" role="alert">
                                        ${passwordChangeSuccess}
                                    </div>
                                </c:if>
                                <div id="passwordChangeMsg"></div>
                                <div class="mb-3">
                                    <label for="currentPassword" class="form-label">Current Password</label>
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                </div>

                                <div class="mb-3">
                                    <label for="newPassword" class="form-label">New Password</label>
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                </div>

                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm New Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <div id="passwordMismatch" class="text-danger" style="display: none;">
                                        Passwords do not match
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <button type="submit" class="btn btn-primary">Update Password</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Booking History Tab -->
                    <div class="tab-pane fade" id="bookingHistory" role="tabpanel" aria-labelledby="booking-history-tab">
                        <div class="bg-light p-4 rounded">
                            <div class="border-bottom pb-3 mb-4">
                                <h4 class="text-uppercase">Booking History</h4>
                            </div>
                            <div id="bookingHistoryTableContainer">
                                <div class="text-center py-4">
                                    <div class="spinner-border text-primary" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- My Pets Tab -->
                    <div class="tab-pane fade" id="userPets" role="tabpanel" aria-labelledby="user-pets-tab">
                        <div class="bg-light p-4 rounded">
                            <div id="petAddMsg" class="mb-3"></div>
                            <div class="border-bottom pb-3 mb-4 d-flex justify-content-between align-items-center">
                                <h4 class="text-uppercase">My Pets</h4>
                                <button type="button" class="btn btn-success" id="addPetBtn" data-bs-toggle="modal" data-bs-target="#addPetModal">
                                    <i class="bi bi-plus-circle me-1"></i> Add Pet
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Type</th>
                                            <th>Name</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="petsTableBody">
                                        <c:forEach var="pet" items="${sessionScope.userPets}" varStatus="status">
                                            <tr>
                                                <td>${status.index + 1}</td>
                                                <td>${pet.pet.name}</td>
                                                <td>${pet.petName}</td>                                                
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <a href="medicalrecords?action=getMedicalRecords&userPetID=${pet.userPetID}" class="btn btn-sm btn-outline-primary me-4">View Medical Records</a>
                                                        <button type="button" class="btn btn-sm btn-outline-secondary edit-pet-btn me-4" data-id="${pet.userPetID}" data-name="${pet.petName}" data-type="${pet.pet.name}">Edit</button>
                                                        <button type="button" class="btn btn-sm btn-outline-danger delete-pet-btn" data-id="${pet.userPetID}">Delete</button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty sessionScope.userPets}">
                                            <tr><td colspan="4" class="text-center">No pets found.</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Profile Content End -->

<!-- Add Pet Modal -->
<div class="modal fade" id="addPetModal" tabindex="-1" aria-labelledby="addPetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="addPetModalLabel">Add New Pet</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>            <div class="modal-body">
                <form id="addPetForm">
                    <div class="mb-3">
                        <label for="petType" class="form-label">Pet Type</label>
                        <select class="form-select" id="petType" name="petID" required>
                            <option value="" selected disabled>Select a pet type...</option>
                            <!-- Options will be loaded dynamically -->
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="petName" class="form-label">Pet Name</label>
                        <input type="text" class="form-control" id="petName" name="petName" required>
                        <small class="form-text text-muted">Enter a name for your pet</small>
                    </div>
                    <div id="modalPetAddMsg"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="saveNewPetBtn">Add Pet</button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Pet Modal -->
<div class="modal fade" id="editPetModal" tabindex="-1" aria-labelledby="editPetModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="editPetModalLabel">Edit Pet Name</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editPetForm">
                    <input type="hidden" id="editPetId" name="userPetID">
                    <div class="mb-3">
                        <label class="form-label">Pet Type</label>
                        <input type="text" class="form-control" id="editPetType" readonly>
                    </div>
                    <div class="mb-3">
                        <label for="editPetName" class="form-label">Pet Name</label>
                        <input type="text" class="form-control" id="editPetName" name="petName" required>
                        <small class="form-text text-muted">Enter a new name for your pet</small>
                    </div>
                    <div id="modalPetEditMsg"></div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" id="saveEditPetBtn">Save Changes</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/client/assets/layout/footer.jsp"/>

<!-- Feedback Modal -->
<div class="modal fade" id="feedbackModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Rate Service</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="feedbackServiceList">
                    <!-- Services without feedback will be loaded here -->
                </div>
                <form id="feedbackForm" style="display: none;">
                    <div class="text-center mb-3">
                        <img id="feedbackServiceImage" src="" alt="" class="service-image">
                        <h6 id="feedbackServiceName" class="mt-2"></h6>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Rating *</label>
                        <div class="star-rating text-center" id="starRating">
                            <span class="star" data-rating="1">★</span>
                            <span class="star" data-rating="2">★</span>
                            <span class="star" data-rating="3">★</span>
                            <span class="star" data-rating="4">★</span>
                            <span class="star" data-rating="5">★</span>
                        </div>
                        <input type="hidden" id="ratingValue" name="rating" value="0">
                    </div>

                    <div class="mb-3">
                        <label for="feedbackComment" class="form-label">Comment (Optional)</label>
                        <textarea class="form-control" id="feedbackComment" name="comment" rows="3" 
                                  placeholder="Share your experience with this service..."></textarea>
                    </div>

                    <input type="hidden" id="feedbackBookingId" name="bookingId">
                    <input type="hidden" id="feedbackServiceId" name="serviceId">
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" id="submitFeedbackBtn" class="btn btn-primary" style="display: none;" onclick="submitFeedback()">
                    Submit Feedback
                </button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript for Profile Page -->
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Edit Personal Info Button
        document.getElementById('editPersonalInfoBtn').addEventListener('click', function () {
            const inputs = document.querySelectorAll('#personalInfoForm input:not([readonly])');
            inputs.forEach(input => input.disabled = false);
            document.getElementById('saveButtonGroup').style.display = 'block';
            this.style.display = 'none';
        });

        // Cancel Edit Button
        document.getElementById('cancelEditBtn').addEventListener('click', function () {
            const inputs = document.querySelectorAll('#personalInfoForm input');
            inputs.forEach(input => input.disabled = true);
            document.getElementById('saveButtonGroup').style.display = 'none';
            document.getElementById('editPersonalInfoBtn').style.display = 'block';
        });

        // Password confirmation validation
        document.getElementById('confirmPassword').addEventListener('input', function () {
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = this.value;
            if (newPassword !== confirmPassword) {
                document.getElementById('passwordMismatch').style.display = 'block';
            } else {
                document.getElementById('passwordMismatch').style.display = 'none';
            }
        });

        // Profile Image Upload Preview
        document.getElementById('profileImageUpload').addEventListener('change', function () {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    const profileImage = document.querySelector('.rounded-circle');
                    profileImage.src = e.target.result;
                };
                reader.readAsDataURL(file);
            }
        });

        function autoHideAlerts() {
            setTimeout(function () {
                document.querySelectorAll('.alert-dismissible').forEach(function (alert) {

                    alert.classList.remove('show');
                    alert.classList.add('hide');

                    setTimeout(function () {
                        if (alert.parentNode)
                            alert.parentNode.removeChild(alert);
                    }, 500);
                });
            }, 5000);
        }

        document.addEventListener('DOMContentLoaded', function () {
            autoHideAlerts();
        });
        // Form submissions
        document.getElementById('personalInfoForm').addEventListener('submit', function (e) {
            e.preventDefault();

            const form = e.target;
            const formData = new FormData(form);

            fetch('userdetail', {
                method: 'POST',
                body: formData
            })
                    .then(response => response.text())
                    .then(html => {
                        document.getElementById('infoUpdateMsg').innerHTML = html;
                        // Disable inputs and hide save button after successful update
                        const inputs = document.querySelectorAll('#personalInfoForm input');
                        inputs.forEach(input => input.disabled = true);
                        document.getElementById('saveButtonGroup').style.display = 'none';
                        document.getElementById('editPersonalInfoBtn').style.display = 'block';
                        autoHideAlerts();
                    })
                    .catch(error => {
                        document.getElementById('infoUpdateMsg').innerHTML = '<div class="alert alert-danger alert-dismissible fade show">An error occurred!</div>';
                    });
        });

        document.getElementById('passwordChangeForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const form = e.target;
            const formData = new FormData(form);

            fetch('userdetail', {
                method: 'POST',
                body: formData
            })
                    .then(response => response.text())
                    .then(html => {
                        document.getElementById('passwordChangeMsg').innerHTML = html;
                        autoHideAlerts();
                        form.reset();
                    })
                    .catch(error => {
                        document.getElementById('passwordChangeMsg').innerHTML =
                                '<div class="alert alert-danger alert-dismissible fade show">An error occurred!</div>';
                        autoHideAlerts();
                    });
        });

        document.addEventListener('DOMContentLoaded', function () {
            const hasPassword = '${sessionScope.userDetailDTO.user.password}' !== '';
            if (!hasPassword) {
                document.getElementById('currentPassword').closest('.mb-3').style.display = 'none';
            }
        });

        // Tab navigation - ensure proper activation of tabs
        document.querySelectorAll('[data-bs-toggle="tab"]').forEach(function (element) {
            element.addEventListener('click', function (e) {
                e.preventDefault();

                const target = this.getAttribute('href');
                if (!target)
                    return;
                const targetId = target.substring(1);
                const targetPane = document.getElementById(targetId);

                if (!targetPane) {
                    console.error('Tab pane not found:', targetId);
                    return;
                }

                // Remove active class from all tabs
                document.querySelectorAll('[data-bs-toggle="tab"]').forEach(el => {
                    el.classList.remove('active');
                    el.setAttribute('aria-selected', 'false');
                });

                // Add active class to clicked tab
                this.classList.add('active');
                this.setAttribute('aria-selected', 'true');

                document.querySelectorAll('.tab-pane').forEach(pane => {
                    pane.classList.remove('show', 'active');
                });

                // Show target pane
                targetPane.classList.add('show', 'active');

                // Special handling for booking history
                if (targetId === 'bookingHistory') {
                    loadBookingHistory();
                }
            });
        });

        // Pet type select dropdown - load options on modal open
        document.getElementById('addPetBtn').addEventListener('click', function () {
            // Clear previous messages and form values
            document.getElementById('modalPetAddMsg').innerHTML = '';
            document.getElementById('addPetForm').reset();

            // Fetch pet types from server
            fetch('userdetail?action=getAvailablePets')
                    .then(response => response.json())
                    .then(pets => {
                        const petSelect = document.getElementById('petType');
                        // Clear existing options
                        while (petSelect.options.length > 1) {
                            petSelect.remove(1);
                        }

                        // Add new options
                        pets.forEach(pet => {
                            const option = document.createElement('option');
                            option.value = pet.petID;
                            option.textContent = pet.name;
                            petSelect.appendChild(option);
                        });
                    })
                    .catch(error => {
                        document.getElementById('modalPetAddMsg').innerHTML =
                                '<div class="alert alert-danger">Error loading pet types. Please try again.</div>';
                    });
        });
        // Initialize modal object
        const petModal = new bootstrap.Modal(document.getElementById('addPetModal'), {
            backdrop: 'static', // Prevent closing when clicking outside
            keyboard: false       // Prevent closing with keyboard
        });

        // Save new pet button
        document.getElementById('saveNewPetBtn').addEventListener('click', function () {
            const form = document.getElementById('addPetForm');
            const petTypeSelect = document.getElementById('petType');
            const petNameInput = document.getElementById('petName');
            const modalMsgDiv = document.getElementById('modalPetAddMsg');

            // Clear previous error messages
            modalMsgDiv.innerHTML = '';

            // Custom validation
            let isValid = true;

            if (petTypeSelect.value === "") {
                modalMsgDiv.innerHTML += '<div class="alert alert-danger">Please select a pet type</div>';
                isValid = false;
            }

            if (petNameInput.value.trim() === "") {
                modalMsgDiv.innerHTML += '<div class="alert alert-danger">Please enter a name for your pet</div>';
                isValid = false;
            } else if (petNameInput.value.length > 50) {
                modalMsgDiv.innerHTML += '<div class="alert alert-danger">Pet name cannot be more than 50 characters</div>';
                isValid = false;
            }

            // Stop if validation fails
            if (!isValid) {
                return;
            }

            const petID = petTypeSelect.value;
            const petName = petNameInput.value.trim();

            // Create form data
            const formData = new FormData();
            formData.append('action', 'addUserPet');
            formData.append('petID', petID);
            formData.append('petName', petName);

            // Send AJAX request
            fetch('userdetail', {
                method: 'POST',
                body: formData
            })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Close modal
                            petModal.hide();

                            // Update pets table
                            updatePetsTable(data.pet);
                            // Show success message
                            document.getElementById('petAddMsg').innerHTML =
                                    '<div class="alert alert-success alert-dismissible fade show">Pet added successfully! <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';

                            // Hide message after 5 seconds
                            setTimeout(() => {
                                const alert = document.querySelector('#petAddMsg .alert');
                                if (alert) {
                                    alert.classList.remove('show');
                                    alert.classList.add('hide');
                                    setTimeout(() => {
                                        if (alert.parentNode) {
                                            alert.parentNode.removeChild(alert);
                                        }
                                    }, 500);
                                }
                            }, 5000);
                        } else {
                            document.getElementById('modalPetAddMsg').innerHTML =
                                    `<div class="alert alert-danger">${data.error || 'Failed to add pet. Please try again.'}</div>`;
                        }
                    })
                    .catch(error => {
                        document.getElementById('modalPetAddMsg').innerHTML =
                                '<div class="alert alert-danger">An error occurred. Please try again.</div>';
                    });
        });
        // Function to update the pets table
        function updatePetsTable(newPet) {
            const tableBody = document.getElementById('petsTableBody');

            // Remove "No pets found" row if it exists
            const noPetsRow = tableBody.querySelector('tr td[colspan="4"]');
            if (noPetsRow) {
                tableBody.innerHTML = '';
            }

            // Count existing rows to determine new ID
            const rowCount = tableBody.querySelectorAll('tr').length + 1;

            // Create new row
            const newRow = document.createElement('tr');
            newRow.innerHTML = `
                <td>` + rowCount + `</td>
                <td>` + newPet.petType + `</td>
                <td>` + newPet.petName + `</td>
                <td>
                    <div class="btn-group" role="group">
                        <a href="petDetail?userPetID=` + newPet.userPetID + `" class="btn btn-sm btn-outline-primary me-4">View Details</a>
                        <button type="button" class="btn btn-sm btn-outline-secondary edit-pet-btn me-4" data-id="` + newPet.userPetID + `" data-name="` + newPet.petName + `" data-type="` + newPet.petType + `">Edit</button>
                        <button type="button" class="btn btn-sm btn-outline-danger delete-pet-btn" data-id="` + newPet.userPetID + `">Delete</button>
                    </div>
                </td>
            `;

            // Add row to table with animation
            newRow.classList.add('highlight-new');
            tableBody.appendChild(newRow);

            // Add event listeners for the buttons
            const deleteButton = newRow.querySelector('.delete-pet-btn');
            if (deleteButton) {
                deleteButton.addEventListener('click', handleDeletePet);
            }

            const editButton = newRow.querySelector('.edit-pet-btn');
            if (editButton) {
                editButton.addEventListener('click', handleEditPet);
            }

            // Remove highlight after animation
            setTimeout(() => {
                newRow.classList.remove('highlight-new');
            }, 3000);
        }

        // Function to handle delete pet button clicks
        function handleDeletePet(event) {
            if (confirm('Are you sure you want to delete this pet?')) {
                const petId = event.target.getAttribute('data-id');

                // Create form data
                const formData = new FormData();
                formData.append('action', 'deleteUserPet');
                formData.append('userPetID', petId);

                // Send AJAX request
                fetch('userdetail', {
                    method: 'POST',
                    body: formData
                })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Server responded with an error');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                // Find and remove the row
                                const row = event.target.closest('tr');
                                row.classList.add('fade-out');

                                // Wait for animation to finish then remove
                                setTimeout(() => {
                                    row.remove();

                                    // Show success message
                                    document.getElementById('petAddMsg').innerHTML =
                                            '<div class="alert alert-success alert-dismissible fade show">Pet deleted successfully! <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';

                                    // Renumber remaining rows
                                    const rows = document.querySelectorAll('#petsTableBody tr');
                                    if (rows.length === 0) {
                                        // Add "No pets found" message if all pets are deleted
                                        document.getElementById('petsTableBody').innerHTML = '<tr><td colspan="4" class="text-center">No pets found.</td></tr>';
                                    } else {
                                        rows.forEach((row, index) => {
                                            row.cells[0].textContent = index + 1;
                                        });
                                    }

                                    // Hide message after 5 seconds
                                    setTimeout(() => {
                                        const alert = document.querySelector('#petAddMsg .alert');
                                        if (alert) {
                                            alert.classList.remove('show');
                                            alert.classList.add('hide');
                                            setTimeout(() => {
                                                if (alert.parentNode) {
                                                    alert.parentNode.removeChild(alert);
                                                }
                                            }, 500);
                                        }
                                    }, 5000);
                                }, 500);
                            } else {
                                document.getElementById('petAddMsg').innerHTML =
                                        `<div class="alert alert-danger">${data.error || 'Failed to delete pet. Please try again.'}</div>`;
                            }
                        })
                        .catch(error => {
                            document.getElementById('petAddMsg').innerHTML =
                                    '<div class="alert alert-danger">An error occurred ' + error + '. Please try again.</div>';
                        });
            }
        }

        // Add event listeners to existing delete buttons
        document.querySelectorAll('.delete-pet-btn').forEach(button => {
            button.addEventListener('click', handleDeletePet);
        });

        // Add event listeners to existing edit buttons
        document.querySelectorAll('.edit-pet-btn').forEach(button => {
            button.addEventListener('click', handleEditPet);
        });

        // Initialize edit pet modal
        const editPetModal = new bootstrap.Modal(document.getElementById('editPetModal'), {
            backdrop: 'static',
            keyboard: false
        });

        // Function to handle edit pet button clicks
        function handleEditPet(event) {
            const petId = event.target.getAttribute('data-id');
            const petName = event.target.getAttribute('data-name');
            const petType = event.target.getAttribute('data-type');

            // Populate the edit form
            document.getElementById('editPetId').value = petId;
            document.getElementById('editPetName').value = petName;
            document.getElementById('editPetType').value = petType;

            // Clear previous messages
            document.getElementById('modalPetEditMsg').innerHTML = '';

            // Show the modal
            editPetModal.show();
        }

        // Save edited pet name
        document.getElementById('saveEditPetBtn').addEventListener('click', function () {
            const form = document.getElementById('editPetForm');
            const petId = document.getElementById('editPetId').value;
            const petName = document.getElementById('editPetName').value.trim();
            const modalMsgDiv = document.getElementById('modalPetEditMsg');

            // Clear previous error messages
            modalMsgDiv.innerHTML = '';

            // Validate pet name
            if (petName === "") {
                modalMsgDiv.innerHTML = '<div class="alert alert-danger">Please enter a name for your pet</div>';
                return;
            } else if (petName.length > 50) {
                modalMsgDiv.innerHTML = '<div class="alert alert-danger">Pet name cannot be more than 50 characters</div>';
                return;
            }

            // Create form data
            const formData = new FormData();
            formData.append('action', 'editUserPet');
            formData.append('userPetID', petId);
            formData.append('petName', petName);

            // Send AJAX request
            fetch('userdetail', {
                method: 'POST',
                body: formData
            })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            // Close modal
                            editPetModal.hide();

                            // Update the pet name in the table
                            updatePetInTable(data.pet);

                            // Show success message
                            document.getElementById('petAddMsg').innerHTML =
                                    '<div class="alert alert-success alert-dismissible fade show">Pet name updated successfully! <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';

                            // Hide message after 5 seconds
                            setTimeout(() => {
                                const alert = document.querySelector('#petAddMsg .alert');
                                if (alert) {
                                    alert.classList.remove('show');
                                    alert.classList.add('hide');
                                    setTimeout(() => {
                                        if (alert.parentNode) {
                                            alert.parentNode.removeChild(alert);
                                        }
                                    }, 500);
                                }
                            }, 5000);
                        } else {
                            modalMsgDiv.innerHTML =
                                    `<div class="alert alert-danger">${data.error || 'Failed to update pet name. Please try again.'}</div>`;
                        }
                    })
                    .catch(error => {
                        modalMsgDiv.innerHTML =
                                '<div class="alert alert-danger">An error occurred. Please try again.</div>';
                    });
        });

        // Function to update a pet in the table after editing
        function updatePetInTable(updatedPet) {
            const rows = document.querySelectorAll('#petsTableBody tr');

            rows.forEach(row => {
                const editBtn = row.querySelector('.edit-pet-btn');
                if (editBtn && editBtn.getAttribute('data-id') == updatedPet.userPetID) {
                    // Update the pet name in the row
                    row.cells[2].textContent = updatedPet.petName;

                    // Update the data attributes for the edit button
                    editBtn.setAttribute('data-name', updatedPet.petName);

                    // Add highlighting effect
                    row.classList.add('highlight-new');
                    setTimeout(() => {
                        row.classList.remove('highlight-new');
                    }, 3000);
                }
            });
        }
    });

    function submitAvatarForm() {
        // Show loading indicator if desired
        document.querySelector('.rounded-circle').style.opacity = '0.5';
        document.getElementById('avatarForm').submit();
    }

    // Booking History Tab AJAX loading and modal

    function loadBookingHistory() {
        const container = document.getElementById('bookingHistoryTableContainer');
        container.innerHTML = '<div class="text-center py-4"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>';
        fetch('userdetail?action=getBookingHistory')
                .then(response => response.json())
                .then(data => {
                    if (!data.success) {
                        container.innerHTML = '<div class="alert alert-danger">Failed to load booking history.</div>';
                        return;
                    }
                    if (!data.bookings || data.bookings.length === 0) {
                        container.innerHTML = '<div class="alert alert-info">No finished bookings found.</div>';
                        return;
                    }
                    let html = '<div class="table-responsive"><table class="table table-hover"><thead><tr><th>Booking ID</th><th>Date</th><th>Total</th><th>Status</th><th>Actions</th></tr></thead><tbody>';
                    data.bookings.forEach((b, index) => {
                        const sequenceNumber = index + 1;
                        let formattedDate = '';
                        if (b.dateBooked) {
                            formattedDate = b.dateBooked.replace('T', ' ').substring(0, 16);
                        } else {
                            formattedDate = 'N/A';
                        }
                        const formattedPrice = new Intl.NumberFormat('vi-VN').format(b.totalPrice) + ' đ';
                        html += `<tr>
                        <td>#BK` + sequenceNumber + `</td>
                        <td>` + formattedDate + `</td>
                        <td>` + formattedPrice + `</td>
                        <td><span class="badge bg-success">Finished</span></td>
                        <td><button class="btn btn-sm btn-outline-primary" onclick="showBookingDetailModal(` + b.bookingID + `)">View Details</button></td>
                    </tr>`;
                    });
                    html += '</tbody></table></div>';
                    html += `<div class="modal fade" id="bookingDetailModal" tabindex="-1" aria-labelledby="bookingDetailModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="bookingDetailModalLabel">Booking Details</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body" id="bookingDetailModalBody">
                                <div class="text-center py-4"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>
                            </div>
                        </div>
                    </div>
                </div>`;
                    container.innerHTML = html;
                })
                .catch(() => {
                    container.innerHTML = '<div class="alert alert-danger">Failed to load booking history.</div>';
                });
    }

    window.showBookingDetailModal = function (bookingID) {
        const modal = new bootstrap.Modal(document.getElementById('bookingDetailModal'));
        const modalBody = document.getElementById('bookingDetailModalBody');
        modalBody.innerHTML = '<div class="text-center py-4"><div class="spinner-border text-primary" role="status"><span class="visually-hidden">Loading...</span></div></div>';
        fetch('booking?action=viewBookingDetailHTML&bookingID=' + bookingID)
                .then(response => response.text())
                .then(html => {
                    modalBody.innerHTML = html;
                })
                .catch(() => {
                    modalBody.innerHTML = '<div class="alert alert-danger">Failed to load booking details.</div>';
                });
        modal.show();
    };

    let currentFeedbackServices = [];
    let currentServiceIndex = 0;
    let feedbackModal;

    window.checkFeedbackAvailability = function (bookingId) {
        fetch('feedbackservice?action=checkFeedbackStatus&bookingId=' + bookingId)
                .then(response => response.json())
                .then(data => {
                    if (data.success && data.canProvideFeedback) {
                        currentFeedbackServices = data.servicesWithoutFeedback;
                        showFeedbackModal();
                    } else if (data.success && !data.canProvideFeedback) {
                        alert('You have already provided feedback for all services in this booking.');
                    } else {
                        alert('Unable to check feedback status: ' + (data.message || 'Unknown error'));
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error checking feedback availability');
                });
    };

    function showFeedbackModal() {
        if (!feedbackModal) {
            feedbackModal = new bootstrap.Modal(document.getElementById('feedbackModal'));
        }

        if (currentFeedbackServices.length === 1) {
            showFeedbackForm(0);
        } else {
            showServiceList();
        }

        feedbackModal.show();
    }

    function showServiceList() {
        document.getElementById('feedbackServiceList').style.display = 'block';
        document.getElementById('feedbackForm').style.display = 'none';
        document.getElementById('submitFeedbackBtn').style.display = 'none';

        let html = '<h6 class="mb-3">Select a service to rate:</h6>';
        currentFeedbackServices.forEach((service, index) => {
            html += `
                <div class="d-flex align-items-center mb-2 p-2 border rounded cursor-pointer" 
                     onclick="showFeedbackForm(` + index + `)" style="cursor: pointer;">
                    <img src="` + service.serviceImage + `" alt="` + service.serviceName + `" 
                         style="width: 40px; height: 40px; object-fit: cover; border-radius: 5px;" class="me-3">
                    <span>` + service.serviceName + `</span>
                </div>
            `;
        });

        document.getElementById('feedbackServiceList').innerHTML = html;
    }

    window.showFeedbackForm = function (serviceIndex) {
        currentServiceIndex = serviceIndex;
        const service = currentFeedbackServices[serviceIndex];

        document.getElementById('feedbackServiceList').style.display = 'none';
        document.getElementById('feedbackForm').style.display = 'block';
        document.getElementById('submitFeedbackBtn').style.display = 'block';

        document.getElementById('feedbackServiceImage').src = service.serviceImage;
        document.getElementById('feedbackServiceName').textContent = service.serviceName;
        document.getElementById('feedbackServiceId').value = service.serviceId;

        document.getElementById('ratingValue').value = '0';
        document.getElementById('feedbackComment').value = '';
        updateStarDisplay(0);
    };

    function updateStarDisplay(rating) {
        const stars = document.querySelectorAll('#starRating .star');
        stars.forEach((star, index) => {
            if (index < rating) {
                star.classList.add('active');
                star.classList.remove('inactive');
            } else {
                star.classList.add('inactive');
                star.classList.remove('active');
            }
        });
    }

    class ProfanityFilterService {
        constructor(apiKey) {
            this.apiKey = apiKey;
        }

        async checkProfanity(text) {
            try {
                const response = await fetch(`https://api.api-ninjas.com/v1/profanityfilter?text=` + encodeURIComponent(text), {
                    method: 'GET',
                    headers: {
                        'X-Api-Key': this.apiKey,
                        'Content-Type': 'application/json'
                    }
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ` + response.status);
                }

                const data = await response.json();
                return {
                    original: data.original,
                    censored: data.censored,
                    hasProfanity: data.has_profanity || data.censored.includes('*')
                };
            } catch (error) {
                console.error('Error checking profanity:', error);
                return {
                    original: text,
                    censored: text,
                    hasProfanity: false
                };
            }
        }
    }

    window.submitFeedback = async function () {
        const rating = document.getElementById('ratingValue').value;
        const comment = document.getElementById('feedbackComment').value;
        const serviceId = document.getElementById('feedbackServiceId').value;
        const profanityFilterService = new ProfanityFilterService('1wBakvP3y3hLKEj1f9oNnQ==dE5FLVIfUEeurEpd');

        if (rating === '0') {
            alert('Please select a rating');
            return;
        }

        const modalBody = document.getElementById('bookingDetailModalBody');
        const bookingIdElement = modalBody.querySelector('[data-booking-id]');
        const bookingId = bookingIdElement ? bookingIdElement.getAttribute('data-booking-id') : null;

        if (!bookingId) {
            alert('Booking ID not found');
            return;
        }

        const submitBtn = document.getElementById('submitFeedbackBtn');
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Checking content...';
        submitBtn.disabled = true;

        try {
            if (comment && comment.trim() !== '') {
                const profanityResult = await profanityFilterService.checkProfanity(comment.trim());

                if (profanityResult.hasProfanity) {
                    alert('Your comment contains inappropriate language. Please revise your feedback.');
                    submitBtn.innerHTML = 'Submit Feedback';
                    submitBtn.disabled = false;
                    return;
                }
            }

            submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Submitting...';

            const formData = new URLSearchParams();
            formData.append('action', 'submitFeedback');
            formData.append('bookingId', bookingId);
            formData.append('serviceId', serviceId);
            formData.append('rating', rating);
            formData.append('comment', comment);

            const response = await fetch('feedbackservice', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: formData
            });

            const data = await response.json();

            if (data.success) {
                currentFeedbackServices.splice(currentServiceIndex, 1);

                if (currentFeedbackServices.length > 0) {
                    showServiceList();
                } else {
                    alert('Thank you for your feedback!');
                    feedbackModal.hide();
                }
            } else {
                alert('Error submitting feedback: ' + (data.message || 'Unknown error'));
            }

        } catch (error) {
            console.error('Error during feedback submission:', error);
            alert('Error submitting feedback. Please try again.');
        } finally {
            submitBtn.innerHTML = 'Submit Feedback';
            submitBtn.disabled = false;
        }
    };

    document.addEventListener('click', function (e) {
        if (e.target.matches('#starRating .star')) {
            const rating = parseInt(e.target.dataset.rating);
            document.getElementById('ratingValue').value = rating;
            updateStarDisplay(rating);
        }
    });

    document.addEventListener('mouseenter', function (e) {
        if (e.target.matches('#starRating .star')) {
            const rating = parseInt(e.target.dataset.rating);
            updateStarDisplay(rating);
        }
    }, true);

    document.addEventListener('mouseleave', function (e) {
        if (e.target.matches('#starRating')) {
            const currentRating = parseInt(document.getElementById('ratingValue').value) || 0;
            updateStarDisplay(currentRating);
        }
    }, true);
</script>