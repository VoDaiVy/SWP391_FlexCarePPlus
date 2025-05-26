<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

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

                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Booking ID</th>
                                            <th>Date</th>
                                            <th>Service</th>
                                            <th>Provider</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>#BK12345</td>
                                            <td>2025-05-15</td>
                                            <td>Health Checkup</td>
                                            <td>Dr. Smith</td>
                                            <td><span class="badge bg-success">Completed</span></td>
                                            <td><button class="btn btn-sm btn-outline-primary">View Details</button></td>
                                        </tr>
                                        <tr>
                                            <td>#BK12344</td>
                                            <td>2025-05-22</td>
                                            <td>Consultation</td>
                                            <td>Dr. Johnson</td>
                                            <td><span class="badge bg-warning text-dark">Upcoming</span></td>
                                            <td>
                                                <button class="btn btn-sm btn-outline-primary me-1">View Details</button>
                                                <button class="btn btn-sm btn-outline-danger">Cancel</button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>#BK12343</td>
                                            <td>2025-05-05</td>
                                            <td>Lab Tests</td>
                                            <td>Metro Lab</td>
                                            <td><span class="badge bg-info">Processing</span></td>
                                            <td><button class="btn btn-sm btn-outline-primary">View Details</button></td>
                                        </tr>
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
                body: formData,
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
                        document.getElementById('infoUpdateMsg').innerHTML = '<div class="alert alert-danger alert-dismissible fade show">Có lỗi xảy ra!</div>';
                    });
        });

        document.getElementById('passwordChangeForm').addEventListener('submit', function (e) {
            e.preventDefault();
            const form = e.target;
            const formData = new FormData(form);

            fetch('userdetail', {
                method: 'POST',
                body: formData,
            })
                    .then(response => response.text())
                    .then(html => {
                        document.getElementById('passwordChangeMsg').innerHTML = html;
                        autoHideAlerts();
                        form.reset();
                    })
                    .catch(error => {
                        document.getElementById('passwordChangeMsg').innerHTML =
                                '<div class="alert alert-danger alert-dismissible fade show">Có lỗi xảy ra!</div>';
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

                // Remove active class from all tabs
                document.querySelectorAll('[data-bs-toggle="tab"]').forEach(el => {
                    el.classList.remove('active');
                });

                // Add active class to clicked tab
                this.classList.add('active');

                // Show the corresponding tab content
                const target = this.getAttribute('href').substring(1);
                document.querySelectorAll('.tab-pane').forEach(pane => {
                    pane.classList.remove('show', 'active');
                });
                document.getElementById(target).classList.add('show', 'active');
            });
        });
    });

    function submitAvatarForm() {
        // Show loading indicator if desired
        document.querySelector('.rounded-circle').style.opacity = '0.5';
        document.getElementById('avatarForm').submit();
    }
</script>

<jsp:include page="/client/assets/layout/footer.jsp"/>