<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Service Management - FlexCareP+</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
        <meta content="Themesdesign" name="author" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-select-bs4/css//select.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Responsive datatable examples -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />     

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
            }

            .btn-primary {
                background-color: #1976d2;
                border-color: #1976d2;
            }

            .btn-primary:hover {
                background-color: #1565c0;
                border-color: #1565c0;
            }

            .modal-header {
                background-color: #f8f9fa;
                border-bottom: 1px solid #dee2e6;
            }

            .service-item {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                padding: 20px;
                transition: all 0.3s ease;
                border-left: 4px solid #1976d2;
            }

            .service-item:hover {
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
                transform: translateY(-2px);
            }

            .service-item.inactive {
                background-color: #f8f9fa;
                border-left-color: #dc3545;
                opacity: 0.8;
            }

            .service-header {
                display: flex;
                justify-content: between;
                align-items: flex-start;
                margin-bottom: 15px;
            }

            .service-title {
                font-size: 1.25rem;
                font-weight: 600;
                color: #333;
                margin-bottom: 5px;
            }

            .service-category {
                display: inline-block;
                background-color: #e3f2fd;
                color: #1976d2;
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 0.875rem;
                font-weight: 500;
                margin-bottom: 10px;
            }

            .service-description {
                color: #666;
                line-height: 1.6;
                margin-bottom: 15px;
            }

            .service-actions {
                display: flex;
                gap: 8px;
                margin-left: auto;
            }

            .btn-sm {
                padding: 0.375rem 0.75rem;
                font-size: 0.875rem;
            }

            .search-filter-section {
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 20px;
            }

            .status-indicator {
                display: inline-block;
                width: 8px;
                height: 8px;
                border-radius: 50%;
                margin-right: 8px;
            }

            .status-active {
                background-color: #28a745;
            }

            .status-inactive {
                background-color: #dc3545;
            }

            /* Service Image Styles */
            .service-image {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #e9ecef;
                margin-right: 15px;
            }

            .service-image-placeholder {
                width: 80px;
                height: 80px;
                background-color: #f8f9fa;
                border: 2px dashed #dee2e6;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #6c757d;
                margin-right: 15px;
            }

            .service-content {
                display: flex;
                align-items: flex-start;
            }

            .service-info {
                flex: 1;
            }

            /* Image preview in modal */
            .image-preview {
                max-width: 200px;
                max-height: 150px;
                object-fit: cover;
                border-radius: 8px;
                border: 1px solid #dee2e6;
                margin-top: 10px;
            }

            .image-preview-container {
                display: none;
            }

            /* No results message */
            .no-results {
                text-align: center;
                padding: 40px;
                color: #6c757d;
                display: none;
            }

            .no-results i {
                font-size: 3rem;
                margin-bottom: 15px;
                opacity: 0.5;
            }
        </style>
    </head>

    <body data-topbar="dark">
        <!-- Hidden inputs for JavaScript data -->
        <input type="hidden" id="hiddenMessage" value="${not empty message ? message : ''}">
        <input type="hidden" id="hiddenError" value="${not empty error ? error : ''}">

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
                                    <h4 class="page-title mb-1">Service Management</h4>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Services</li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-md-4">
                                    <div class="float-end d-none d-md-block">
                                        <a href="${pageContext.request.contextPath}/admin/service-detail" class="btn btn-primary">
                                            <i class="fas fa-plus me-2"></i>Add Service
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Search and Filter Section -->
                        <div class="search-filter-section">
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="mb-3">
                                        <label class="form-label">Search Services</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fas fa-search"></i></span>
                                            <input type="text" class="form-control" id="searchInput" placeholder="Enter service name...">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label class="form-label">Category</label>
                                        <select class="form-select" id="categoryFilter">
                                            <option value="">All Categories</option>
                                            <c:forEach var="entry" items="${categories.entrySet()}">
                                                <option value="${entry.key}">${entry.value.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="mb-3">
                                        <label class="form-label">Status</label>
                                        <select class="form-select" id="statusFilter">
                                            <option value="">All Status</option>
                                            <option value="true">Active</option>
                                            <option value="false">Inactive</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="mb-3">
                                        <label class="form-label">&nbsp;</label>
                                        <div class="d-grid">
                                            <button type="button" class="btn btn-outline-secondary" onclick="clearFilters()">
                                                <i class="fas fa-times me-1"></i>Clear
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="text-muted" id="resultCount">Showing all services</span>
                                        <div class="btn-group btn-group-sm" role="group">
                                            <input type="radio" class="btn-check" name="viewMode" id="listView" checked>
                                            <label class="btn btn-outline-primary" for="listView">
                                                <i class="fas fa-list"></i> List
                                            </label>
                                            <input type="radio" class="btn-check" name="viewMode" id="gridView">
                                            <label class="btn btn-outline-primary" for="gridView">
                                                <i class="fas fa-th"></i> Grid
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Service List -->
                        <div class="row">
                            <div class="col-12">
                                <div id="serviceList">
                                    <c:forEach var="service" items="${services}">
                                        <div class="service-item ${service.status ? '' : 'inactive'}" 
                                             data-service-id="${service.serviceID}"
                                             data-service-name="${fn:escapeXml(service.name)}"
                                             data-service-description="${fn:escapeXml(service.description)}"
                                             data-service-imgurl="${fn:escapeXml(service.imgURL)}"
                                             data-category="${service.categoryServiceID}" 
                                             data-status="${service.status}"
                                             data-name="${fn:toLowerCase(service.name)}"
                                             data-description="${fn:toLowerCase(service.description)}">
                                            <div class="row">
                                                <div class="col-md-10">
                                                    <div class="service-content">
                                                        <!-- Service Image -->
                                                        <div class="service-image-container">
                                                            <c:choose>
                                                                <c:when test="${not empty service.imgURL}">
                                                                    <img src="${service.imgURL}" alt="${service.name}" class="service-image" 
                                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                                    <div class="service-image-placeholder" style="display: none;">
                                                                        <i class="fas fa-image fa-2x"></i>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="service-image-placeholder">
                                                                        <i class="fas fa-image fa-2x"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>

                                                        <!-- Service Info -->
                                                        <div class="service-info">
                                                            <div class="service-header">
                                                                <div>
                                                                    <div class="service-title">
                                                                        <span class="status-indicator ${service.status ? 'status-active' : 'status-inactive'}"></span>
                                                                        ${service.name}
                                                                    </div>
                                                                    <div class="service-category">
                                                                        <i class="fas fa-tag me-1"></i>
                                                                        ${categories[service.categoryServiceID].name}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="service-description">
                                                                <c:choose>
                                                                    <c:when test="${fn:length(service.description) > 150}">
                                                                        ${fn:substring(service.description, 0, 150)}...
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        ${service.description}
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-2">
                                                    <div class="service-actions">
                                                        <a href="${pageContext.request.contextPath}/admin/service-detail?serviceID=${service.serviceID}" class="btn btn-warning btn-sm" title="Edit">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <form action="${pageContext.request.contextPath}/admin/service" method="post" class="d-inline">
                                                            <input type="hidden" name="action" value="delete">
                                                            <input type="hidden" name="serviceID" value="${service.serviceID}">
                                                            <button type="submit" class="btn btn-danger btn-sm delete-service-btn" 
                                                                    title="Delete" onclick="return confirm('Are you sure you want to delete this service?');">
                                                                <i class="fas fa-trash"></i>
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- No Results Message -->
                                <div class="no-results" id="noResults">
                                    <i class="fas fa-search"></i>
                                    <h5>No services found</h5>
                                    <p>Try adjusting your search criteria or filters</p>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Footer -->
                <jsp:include page="/adminPages/assets/includes/footer.jsp" />
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

        <!-- Required datatable js -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
        <!-- Buttons examples -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/jszip/jszip.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/pdfmake/build/pdfmake.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/pdfmake/build/vfs_fonts.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons/js/buttons.html5.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons/js/buttons.print.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons/js/buttons.colVis.min.js"></script>

        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-select/js/dataTables.select.min.js"></script>

        <!-- Responsive examples -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>

        <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>

        <script>
            // Global variables for filtering
            var totalServices = 0;
            var visibleServices = 0;

            // Image Preview Function
            function previewImage(input, previewContainerId) {
                var previewContainer = document.getElementById(previewContainerId);
                var previewImg = previewContainer.querySelector('img');

                if (input.value.trim() !== '') {
                    previewImg.src = input.value;
                    previewContainer.style.display = 'block';

                    // Handle image load error
                    previewImg.onerror = function () {
                        previewContainer.style.display = 'none';
                    };
                } else {
                    previewContainer.style.display = 'none';
                }
            }

            // Clear all filters
            function clearFilters() {
                document.getElementById('searchInput').value = '';
                document.getElementById('categoryFilter').value = '';
                document.getElementById('statusFilter').value = '';
                filterServices();
            }

            // Update result count
            function updateResultCount() {
                var resultCountElement = document.getElementById('resultCount');
                if (visibleServices === totalServices) {
                    resultCountElement.textContent = 'Showing all ' + totalServices + ' services';
                } else {
                    resultCountElement.textContent = 'Showing ' + visibleServices + ' of ' + totalServices + ' services';
                }
            }

            // Enhanced filter function
            function filterServices() {
                var searchText = document.getElementById('searchInput').value.toLowerCase().trim();
                var categoryFilter = document.getElementById('categoryFilter').value;
                var statusFilter = document.getElementById('statusFilter').value;

                visibleServices = 0;
                var hasVisibleItems = false;

                var serviceItems = document.querySelectorAll('.service-item');
                for (var i = 0; i < serviceItems.length; i++) {
                    var item = serviceItems[i];
                    var serviceName = item.getAttribute('data-name') || '';
                    var serviceDescription = item.getAttribute('data-description') || '';
                    var serviceCategory = item.getAttribute('data-category');
                    var serviceStatus = item.getAttribute('data-status');

                    var showItem = true;

                    // Search filter (search in both name and description)
                    if (searchText) {
                        var searchInName = serviceName.indexOf(searchText) !== -1;
                        var searchInDescription = serviceDescription.indexOf(searchText) !== -1;
                        if (!searchInName && !searchInDescription) {
                            showItem = false;
                        }
                    }

                    // Category filter
                    if (categoryFilter && serviceCategory !== categoryFilter) {
                        showItem = false;
                    }

                    // Status filter
                    if (statusFilter && serviceStatus !== statusFilter) {
                        showItem = false;
                    }

                    // Show/hide item
                    if (showItem) {
                        item.style.display = 'block';
                        visibleServices++;
                        hasVisibleItems = true;
                    } else {
                        item.style.display = 'none';
                    }
                }

                // Show/hide no results message
                var noResultsElement = document.getElementById('noResults');
                if (hasVisibleItems) {
                    noResultsElement.style.display = 'none';
                } else {
                    noResultsElement.style.display = 'block';
                }

                // Update result count
                updateResultCount();
            }

            // Initialize page
            document.addEventListener('DOMContentLoaded', function () {
                // Count total services
                totalServices = document.querySelectorAll('.service-item').length;
                visibleServices = totalServices;
                updateResultCount();

                // Search functionality with debounce
                var searchTimeout;
                document.getElementById('searchInput').addEventListener('keyup', function () {
                    clearTimeout(searchTimeout);
                    searchTimeout = setTimeout(function () {
                        filterServices();
                    }, 300);
                });

                // Category filter
                document.getElementById('categoryFilter').addEventListener('change', function () {
                    filterServices();
                });

                // Status filter
                document.getElementById('statusFilter').addEventListener('change', function () {
                    filterServices();
                });

                // Show success/error messages if they exist
                var messageInput = document.getElementById('hiddenMessage');
                var errorInput = document.getElementById('hiddenError');

                if (messageInput && messageInput.value.trim() !== '') {
                    alert(messageInput.value);
                }

                if (errorInput && errorInput.value.trim() !== '') {
                    alert('Error: ' + errorInput.value);
                }
            });
        </script>

    </body>
</html>