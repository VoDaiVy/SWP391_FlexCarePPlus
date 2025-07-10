<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Service Detail - FlexCareP+</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesdesign" name="author" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">

    <!-- Bootstrap Css -->
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        .page-title-box {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .card {
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border: none;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #1976d2;
            border-color: #1976d2;
        }

        .btn-primary:hover {
            background-color: #1565c0;
            border-color: #1565c0;
        }

        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
            font-weight: 600;
        }

        /* Image Upload Styles */
        .image-upload-area {
            border: 2px dashed #dee2e6;
            border-radius: 8px;
            padding: 40px;
            text-align: center;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .image-upload-area:hover {
            border-color: #1976d2;
            background-color: #e3f2fd;
        }

        .image-upload-area.dragover {
            border-color: #1976d2;
            background-color: #e3f2fd;
            transform: scale(1.02);
        }

        .upload-icon {
            font-size: 3rem;
            color: #6c757d;
            margin-bottom: 15px;
        }

        .upload-text {
            color: #6c757d;
            margin-bottom: 10px;
        }

        /* Image Gallery Styles */
        .image-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }

        .image-item {
            position: relative;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }

        .image-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }

        .image-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .image-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.7);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .image-item:hover .image-overlay {
            opacity: 1;
        }

        .image-actions {
            display: flex;
            gap: 10px;
        }

        .image-actions .btn {
            padding: 8px 12px;
            font-size: 0.875rem;
        }

        .primary-badge {
            position: absolute;
            top: 8px;
            left: 8px;
            background: #28a745;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        /* Progress Bar */
        .upload-progress {
            margin-top: 15px;
            display: none;
        }

        .progress {
            height: 8px;
            border-radius: 4px;
        }

        /* Form Styles */
        .form-section {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }

        .required {
            color: #dc3545;
        }

        /* Status Toggle */
        .status-toggle {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
        }

        .status-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-right: 8px;
        }

        .status-active {
            background-color: #28a745;
        }

        .status-inactive {
            background-color: #dc3545;
        }

        /* Action Buttons */
        .action-buttons {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            position: sticky;
            bottom: 20px;
            z-index: 100;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .image-gallery {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 10px;
            }
            
            .image-item img {
                height: 120px;
            }
        }

        /* Loading Spinner */
        .loading-spinner {
            display: none;
            text-align: center;
            padding: 20px;
        }

        .spinner-border {
            width: 2rem;
            height: 2rem;
        }
        
        /* Image Preview */
        .image-preview-container {
            margin-top: 15px;
            text-align: center;
        }
        
        .image-preview {
            max-width: 100%;
            max-height: 300px;
            border-radius: 8px;
            border: 1px solid #dee2e6;
            display: none;
        }
    </style>
</head>

<body data-topbar="dark">
    <!-- Hidden inputs for JavaScript data -->
    <input type="hidden" id="hiddenMessage" value="${not empty message ? message : ''}">
    <input type="hidden" id="hiddenError" value="${not empty error ? error : ''}">
    <input type="hidden" id="serviceId" value="${not empty service ? service.serviceID : ''}">
    <input type="hidden" id="isEditMode" value="${not empty service ? 'true' : 'false'}">

    <div id="layout-wrapper">
        <!-- Header -->
        <jsp:include page="/adminPages/assets/includes/header.jsp" />

        <!-- Sidebar -->
        <jsp:include page="/adminPages/assets/includes/navbar.jsp" /> 

        <!-- Main Content -->
        <div class="main-content">
            <div class="page-content">
                <div class="container-fluid">

                    <!-- Page Title -->
                    <div class="page-title-box">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h4 class="page-title mb-1">
                                    <c:choose>
                                        <c:when test="${not empty service}">Edit Service</c:when>
                                        <c:otherwise>Add New Service</c:otherwise>
                                    </c:choose>
                                </h4>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb mb-0">
                                        <li class="breadcrumb-item"><a href="#">Home</a></li>
                                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/service">Services</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">
                                            <c:choose>
                                                <c:when test="${not empty service}">Edit</c:when>
                                                <c:otherwise>Add New</c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="col-md-4">
                                <div class="float-end d-none d-md-block">
                                    <a href="${pageContext.request.contextPath}/admin/service" class="btn btn-secondary me-2">
                                        <i class="fas fa-arrow-left me-2"></i>Back to List
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <form id="serviceForm" action="admin" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="${not empty service ? 'updateService' : 'createService'}">
                        <c:if test="${not empty service}">
                            <input type="hidden" name="id" value="${service.serviceID}">
                        </c:if>

                        <div class="row">
                            <!-- Left Column -->
                            <div class="col-lg-8">
                                
                                <!-- Basic Information -->
                                <div class="form-section">
                                    <h5 class="section-title">
                                        <i class="fas fa-info-circle me-2"></i>Basic Information
                                    </h5>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="serviceName" class="form-label">Service Name <span class="required">*</span></label>
                                                <input type="text" class="form-control" id="serviceName" name="name" 
                                                       value="${not empty service ? service.name : ''}" required>
                                                <div class="form-text">Enter a descriptive name for the service</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="categoryServiceID" class="form-label">Category <span class="required">*</span></label>
                                                <select class="form-select" id="categoryServiceID" name="categoryServiceID" required>
                                                    <option value="">Select Category</option>
                                                    <c:forEach var="entry" items="${categories.entrySet()}">
                                                        <option value="${entry.key}" 
                                                                ${not empty service && service.categoryServiceID == entry.key ? 'selected' : ''}>
                                                            ${entry.value.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="servicePrice" class="form-label">Price <span class="required">*</span></label>
                                                <div class="input-group">
                                                    <span class="input-group-text">$</span>
                                                    <input type="number" class="form-control" id="servicePrice" name="price" 
                                                           value="${not empty service ? service.price : '0.00'}" step="0.01" min="0" required>
                                                </div>
                                                <div class="form-text">Enter the price for this service</div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="mb-3">
                                                <label for="serviceTime" class="form-label">Service Time (minutes)</label>
                                                <div class="input-group">
                                                    <input type="number" class="form-control" id="serviceTime" name="time" 
                                                           value="${not empty service ? service.time : '0'}" min="0">
                                                    <span class="input-group-text">min</span>
                                                </div>
                                                <div class="form-text">Estimated time to complete this service</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="serviceDescription" class="form-label">Description</label>
                                        <textarea class="form-control" id="serviceDescription" name="description" rows="5" 
                                                  placeholder="Enter detailed description of the service...">${not empty service ? service.description : ''}</textarea>
                                        <div class="form-text">Provide a comprehensive description of what this service includes</div>
                                    </div>
                                </div>

                                <!-- Image Management -->
                                <div class="form-section">
                                    <h5 class="section-title">
                                        <i class="fas fa-images me-2"></i>Service Image
                                    </h5>

                                    <div class="mb-3">
                                        <label class="form-label">Current Image</label>
                                        <div>
                                            <c:choose>
                                                <c:when test="${not empty service && not empty service.imgURL}">
                                                    <img src="${service.imgURL}" alt="Service Image" class="image-preview" style="display: block; max-height: 200px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <p class="text-muted">No image available</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="imageFile" class="form-label">Upload New Image</label>
                                        <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" onchange="previewImage(this)">
                                        <div class="form-text">Select an image file (JPG, PNG, GIF) - Max 5MB</div>
                                        
                                        <div class="image-preview-container">
                                            <img id="imagePreview" class="image-preview" alt="Image Preview">
                                        </div>
                                    </div>
                                </div>

                            </div>

                            <!-- Right Column -->
                            <div class="col-lg-4">
                                
                                <!-- Status & Settings -->
                                <div class="form-section">
                                    <h5 class="section-title">
                                        <i class="fas fa-cog me-2"></i>Settings
                                    </h5>

                                    <div class="status-toggle">
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="serviceStatus" name="status" 
                                                   value="true" ${empty service || service.status ? 'checked' : ''}>
                                            <label class="form-check-label" for="serviceStatus">
                                                <span class="status-indicator" id="statusIndicator"></span>
                                                <span id="statusText">Active</span>
                                            </label>
                                        </div>
                                        <div class="form-text mt-2">
                                            <small>Enable to make this service available to customers</small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Service Information -->
                                <c:if test="${not empty service}">
                                    <div class="form-section">
                                        <h5 class="section-title">
                                            <i class="fas fa-info me-2"></i>Service Information
                                        </h5>
                                        
                                        <div class="mb-3">
                                            <label class="form-label text-muted">Service ID</label>
                                            <div class="fw-bold">#${service.serviceID}</div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label class="form-label text-muted">Views</label>
                                            <div class="fw-bold">${service.views}</div>
                                        </div>
                                    </div>
                                </c:if>

                                <!-- Quick Actions -->
                                <div class="form-section">
                                    <h5 class="section-title">
                                        <i class="fas fa-bolt me-2"></i>Quick Actions
                                    </h5>
                                    
                                    <div class="d-grid gap-2">
                                        <button type="button" class="btn btn-outline-primary" id="previewBtn">
                                            <i class="fas fa-eye me-2"></i>Preview Service
                                        </button>
                                        <button type="button" class="btn btn-outline-secondary" id="resetFormBtn">
                                            <i class="fas fa-undo me-2"></i>Reset Form
                                        </button>
                                        <c:if test="${not empty service}">
                                            <button type="button" class="btn btn-outline-danger" id="deleteServiceBtn">
                                                <i class="fas fa-trash me-2"></i>Delete Service
                                            </button>
                                        </c:if>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <!-- Action Buttons -->
                        <div class="action-buttons">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="d-flex gap-2">
                                        <button type="button" class="btn btn-outline-secondary" id="saveDraftBtn">
                                            <i class="fas fa-save me-2"></i>Save as Draft
                                        </button>
                                        <button type="button" class="btn btn-outline-info" id="autoSaveToggle">
                                            <i class="fas fa-clock me-2"></i>Auto Save: <span id="autoSaveStatus">ON</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="d-flex gap-2 justify-content-md-end">
                                        <a href="admin?action=getServices" class="btn btn-secondary">
                                            <i class="fas fa-times me-2"></i>Cancel
                                        </a>
                                        <button type="submit" class="btn btn-primary" id="submitBtn">
                                            <i class="fas fa-save me-2"></i>
                                            <c:choose>
                                                <c:when test="${not empty service}">Update Service</c:when>
                                                <c:otherwise>Create Service</c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>

                </div>
            </div>

            <!-- Footer -->
            <jsp:include page="/adminPages/assets/includes/footer.jsp" />
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="deleteConfirmModalLabel">
                        <i class="fas fa-exclamation-triangle me-2"></i>Confirm Delete
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="text-center">
                        <i class="fas fa-exclamation-triangle text-danger" style="font-size: 3rem;"></i>
                        <h4 class="mt-3">Are you sure?</h4>
                        <p class="text-muted" id="deleteMessage">This action cannot be undone.</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">
                        <i class="fas fa-trash me-2"></i>Delete
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Rightbar -->
    <jsp:include page="/adminPages/assets/includes/rightbar.jsp" />

    <!-- JAVASCRIPT -->
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/metismenu/metisMenu.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/simplebar/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/node-waves/waves.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>

    <script>
        // Global variables
        var isEditMode = document.getElementById('isEditMode').value === 'true';
        var serviceId = document.getElementById('serviceId').value;
        var autoSaveEnabled = true;
        var autoSaveInterval;

        // Initialize page
        document.addEventListener('DOMContentLoaded', function () {
            initializeStatusToggle();
            initializeFormValidation();
            initializeAutoSave();
            initializeEventListeners();
            
            // Show success/error messages
            showMessages();
        });

        // Preview image from file input
        function previewImage(input) {
            var preview = document.getElementById('imagePreview');
            
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    
                    // Clear URL input when file is selected
                    document.getElementById('imgURL').value = '';
                };
                
                reader.readAsDataURL(input.files[0]);
            } else {
                preview.style.display = 'none';
            }
        }
        
        // Preview image from URL
        function previewImageURL(input) {
            var preview = document.getElementById('imagePreview');
            
            if (input.value.trim() !== '') {
                preview.src = input.value;
                preview.style.display = 'block';
                
                // Clear file input when URL is entered
                document.getElementById('imageFile').value = '';
                
                // Handle image load error
                preview.onerror = function() {
                    preview.style.display = 'none';
                    alert('Invalid image URL or image cannot be loaded');
                };
            } else {
                preview.style.display = 'none';
            }
        }

        // Initialize status toggle
        function initializeStatusToggle() {
            var statusToggle = document.getElementById('serviceStatus');
            var statusIndicator = document.getElementById('statusIndicator');
            var statusText = document.getElementById('statusText');

            function updateStatusUI() {
                if (statusToggle.checked) {
                    statusIndicator.className = 'status-indicator status-active';
                    statusText.textContent = 'Active';
                } else {
                    statusIndicator.className = 'status-indicator status-inactive';
                    statusText.textContent = 'Inactive';
                }
            }

            statusToggle.addEventListener('change', updateStatusUI);
            updateStatusUI(); // Initial update
        }

        // Initialize form validation
        function initializeFormValidation() {
            var form = document.getElementById('serviceForm');
            
            form.addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                }
            });
        }

        // Validate form
        function validateForm() {
            var serviceName = document.getElementById('serviceName').value.trim();
            var categoryId = document.getElementById('categoryServiceID').value;
            var price = document.getElementById('servicePrice').value;

            if (!serviceName) {
                alert('Please enter service name!');
                document.getElementById('serviceName').focus();
                return false;
            }

            if (!categoryId) {
                alert('Please select a category!');
                document.getElementById('categoryServiceID').focus();
                return false;
            }
            
            if (price === '' || isNaN(price) || parseFloat(price) < 0) {
                alert('Please enter a valid price!');
                document.getElementById('servicePrice').focus();
                return false;
            }

            return true;
        }

        // Initialize auto save
        function initializeAutoSave() {
            if (autoSaveEnabled) {
                autoSaveInterval = setInterval(function() {
                    if (isFormDirty()) {
                        saveFormData();
                    }
                }, 30000); // Auto save every 30 seconds
            }
        }

        // Check if form is dirty
        function isFormDirty() {
            // Simple check - in real implementation, compare with original values
            var serviceName = document.getElementById('serviceName').value.trim();
            return serviceName.length > 0;
        }

        // Save form data
        function saveFormData() {
            var formData = new FormData(document.getElementById('serviceForm'));
            formData.append('action', 'draft');

            fetch('/admin/service/save-draft', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showAutoSaveIndicator();
                }
            })
            .catch(error => {
                console.error('Auto save failed:', error);
            });
        }

        // Show auto save indicator
        function showAutoSaveIndicator() {
            var indicator = document.createElement('div');
            indicator.className = 'alert alert-success alert-dismissible fade show position-fixed';
            indicator.style.top = '20px';
            indicator.style.right = '20px';
            indicator.style.zIndex = '9999';
            
            var iconElement = document.createElement('i');
            iconElement.className = 'fas fa-check me-2';
            indicator.appendChild(iconElement);
            
            var textNode = document.createTextNode('Draft saved automatically');
            indicator.appendChild(textNode);
            
            var closeBtn = document.createElement('button');
            closeBtn.type = 'button';
            closeBtn.className = 'btn-close';
            closeBtn.setAttribute('data-bs-dismiss', 'alert');
            indicator.appendChild(closeBtn);
            
            document.body.appendChild(indicator);
            
            setTimeout(function() {
                if (indicator.parentNode) {
                    indicator.parentNode.removeChild(indicator);
                }
            }, 3000);
        }

        // Initialize event listeners
        function initializeEventListeners() {
            // Auto save toggle
            document.getElementById('autoSaveToggle').addEventListener('click', function() {
                autoSaveEnabled = !autoSaveEnabled;
                var statusSpan = document.getElementById('autoSaveStatus');
                statusSpan.textContent = autoSaveEnabled ? 'ON' : 'OFF';
                
                if (autoSaveEnabled) {
                    initializeAutoSave();
                } else {
                    clearInterval(autoSaveInterval);
                }
            });

            // Save draft button
            document.getElementById('saveDraftBtn').addEventListener('click', function() {
                saveFormData();
            });

            // Reset form button
            document.getElementById('resetFormBtn').addEventListener('click', function() {
                if (confirm('Are you sure you want to reset the form? All unsaved changes will be lost.')) {
                    document.getElementById('serviceForm').reset();
                    document.getElementById('imagePreview').style.display = 'none';
                    initializeStatusToggle();
                }
            });

            // Preview button
            document.getElementById('previewBtn').addEventListener('click', function() {
                // Implement preview functionality
                alert('Preview functionality will be implemented');
            });

            // Delete service button
            var deleteBtn = document.getElementById('deleteServiceBtn');
            if (deleteBtn) {
                deleteBtn.addEventListener('click', function() {
                    var modal = new bootstrap.Modal(document.getElementById('deleteConfirmModal'));
                    document.getElementById('deleteMessage').textContent = 
                        'This will permanently delete the service.';
                    modal.show();
                });
            }

            // Confirm delete
            document.getElementById('confirmDeleteBtn').addEventListener('click', function() {
                if (serviceId) {
                    window.location.href = '${pageContext.request.contextPath}/admin/service?action=delete&serviceID=' + serviceId;
                }
            });
        }

        // Show messages
        function showMessages() {
            var messageInput = document.getElementById('hiddenMessage');
            var errorInput = document.getElementById('hiddenError');
            
            if (messageInput && messageInput.value.trim() !== '') {
                showAlert('success', messageInput.value);
            }
            
            if (errorInput && errorInput.value.trim() !== '') {
                showAlert('danger', 'Error: ' + errorInput.value);
            }
        }

        // Show alert
        function showAlert(type, message) {
            var alert = document.createElement('div');
            alert.className = 'alert alert-' + type + ' alert-dismissible fade show position-fixed';
            alert.style.top = '20px';
            alert.style.right = '20px';
            alert.style.zIndex = '9999';
            
            var textNode = document.createTextNode(message);
            alert.appendChild(textNode);
            
            var closeBtn = document.createElement('button');
            closeBtn.type = 'button';
            closeBtn.className = 'btn-close';
            closeBtn.setAttribute('data-bs-dismiss', 'alert');
            alert.appendChild(closeBtn);
            
            document.body.appendChild(alert);
            
            setTimeout(function() {
                if (alert.parentNode) {
                    alert.parentNode.removeChild(alert);
                }
            }, 5000);
        }
    </script>

</body>
</html>