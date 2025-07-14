<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Quản Lý Danh Mục Dịch Vụ - FlexCareP+</title>
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
            #categoryTable th, #categoryTable td {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                max-width: 200px;
                padding: 12px;
                box-sizing: border-box;
            }

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

            .table-actions {
                display: flex;
                gap: 5px;
            }

            .btn-sm {
                padding: 0.25rem 0.5rem;
                font-size: 0.875rem;
            }
            
            /* Styles for inactive rows */
            tr.inactive-row {
                background-color: #f8f9fa !important;
                color: #6c757d;
            }
            
            tr.inactive-row td {
                opacity: 0.7;
            }
        </style>
    </head>

    <body data-topbar="dark">
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
                                    <h4 class="page-title mb-1">Quản Lý Danh Mục Dịch Vụ</h4>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb mb-0">
                                            <li class="breadcrumb-item"><a href="#">Trang chủ</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Danh Mục Dịch Vụ</li>
                                        </ol>
                                    </nav>
                                </div>
                                <div class="col-md-4">
                                    <div class="float-end d-none d-md-block">
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                                            <i class="fas fa-plus me-2"></i>Thêm Danh Mục
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Category List Card -->
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Danh Sách Danh Mục Dịch Vụ</h4>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table id="categoryTable" class="table table-striped table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                                <thead class="table-dark">
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Tên Danh Mục</th>
                                                        <th>Trạng Thái</th>
                                                        <th>Thao Tác</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <!-- Sample data - replace with JSTL loop -->
                                                    <c:forEach var="category" items="${categories}">
                                                        <tr class="${category.status ? '' : 'inactive-row'}">
                                                            <td>${category.categoryServiceID}</td>
                                                            <td>
                                                                <c:if test="${!category.status}">
                                                                    <i class="fas fa-ban text-danger me-2" title="Đã vô hiệu"></i>
                                                                </c:if>
                                                                ${category.name}
                                                            </td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${category.status}">
                                                                        <span class="badge bg-success">Hoạt động</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-danger">Không hoạt động</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td>
                                                                <div class="table-actions">
                                                                    <!-- Edit button -->
                                                                    <button type="button" class="btn btn-warning btn-sm" 
                                                                            onclick="editCategory(${category.categoryServiceID}, '${category.name}', ${category.status})"
                                                                            data-bs-toggle="modal" data-bs-target="#editCategoryModal"
                                                                            title="Chỉnh sửa">
                                                                        <i class="fas fa-edit"></i>
                                                                    </button>
                                                                    
                                                                    <!-- Delete button -->
                                                                    <button type="button" class="btn btn-danger btn-sm" 
                                                                            onclick="deleteCategory(${category.categoryServiceID}, '${category.name}')"
                                                                            title="Xóa">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <!-- Footer -->
                <jsp:include page="/adminPages/assets/includes/footer.jsp" />
            </div>
        </div>

        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addCategoryModalLabel">
                            <i class="fas fa-plus me-2"></i>Thêm Danh Mục Dịch Vụ
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="admin" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="createCategoryService">
                            <div class="mb-3">
                                <label for="categoryName" class="form-label">Tên Danh Mục <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="categoryName" name="name" required>
                                <div class="form-text">Nhập tên danh mục dịch vụ</div>
                            </div>
                            <div class="mb-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="categoryStatus" name="status" value="true" checked>
                                    <label class="form-check-label" for="categoryStatus">
                                        Hoạt động
                                    </label>
                                    <div class="form-text">Bật để kích hoạt danh mục ngay sau khi tạo</div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Lưu
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="editCategoryModalLabel">
                            <i class="fas fa-edit me-2"></i>Chỉnh Sửa Danh Mục Dịch Vụ
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="admin" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="updateCategoryService">
                            <input type="hidden" id="editCategoryId" name="id">
                            <div class="mb-3">
                                <label for="editCategoryName" class="form-label">Tên Danh Mục <span class="text-danger">*</span></label>
                                <input type="text" class="form-control" id="editCategoryName" name="name" required>
                                <div class="form-text">Nhập tên danh mục dịch vụ</div>
                            </div>
                            <div class="mb-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="editCategoryStatus" name="status" value="true">
                                    <label class="form-check-label" for="editCategoryStatus">
                                        Hoạt động
                                    </label>
                                    <div class="form-text">Bật để kích hoạt danh mục, tắt để vô hiệu hóa</div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save me-2"></i>Cập Nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteCategoryModal" tabindex="-1" aria-labelledby="deleteCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title" id="deleteCategoryModalLabel">
                            <i class="fas fa-exclamation-triangle me-2"></i>Xác Nhận Xóa
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="admin" method="post">
                        <div class="modal-body">
                            <input type="hidden" name="action" value="deleteCategoryService">
                            <input type="hidden" id="deleteCategoryId" name="id">
                            <div class="text-center">
                                <i class="fas fa-exclamation-triangle text-danger" style="font-size: 3rem;"></i>
                                <h4 class="mt-3">Bạn có chắc chắn muốn xóa?</h4>
                                <p class="text-muted">Danh mục: <strong id="deleteCategoryName"></strong></p>
                                <p class="text-danger"><strong>Cảnh báo:</strong> Hành động này sẽ xóa vĩnh viễn danh mục và không thể hoàn tác!</p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                            <button type="submit" class="btn btn-danger">
                                <i class="fas fa-trash me-2"></i>Xóa Vĩnh Viễn
                            </button>
                        </div>
                    </form>
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
            $(document).ready(function () {
                // Initialize DataTable
                $('#categoryTable').DataTable({
                    "responsive": true,
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json"
                    },
                    "columnDefs": [
                        {"orderable": false, "targets": 3} // Disable sorting for Actions column
                    ]
                });
            });

            // Edit Category Function - now includes status parameter
            function editCategory(id, name, status) {
                document.getElementById('editCategoryId').value = id;
                document.getElementById('editCategoryName').value = name;
                document.getElementById('editCategoryStatus').checked = status;
            }

            // Delete Category Function (Hard Delete)
            function deleteCategory(id, name) {
                document.getElementById('deleteCategoryId').value = id;
                document.getElementById('deleteCategoryName').textContent = name;

                var deleteModal = new bootstrap.Modal(document.getElementById('deleteCategoryModal'));
                deleteModal.show();
            }

            // Form validation
            document.addEventListener('DOMContentLoaded', function () {
                // Add form validation
                const forms = document.querySelectorAll('form');
                forms.forEach(form => {
                    form.addEventListener('submit', function (event) {
                        const nameInput = form.querySelector('input[name="name"]');
                        if (nameInput && nameInput.value.trim() === '') {
                            event.preventDefault();
                            alert('Vui lòng nhập tên danh mục!');
                            nameInput.focus();
                        }
                    });
                });
            });

            // Show success/error messages if they exist
            <c:if test="${not empty message}">
                alert('${message}');
            </c:if>

            <c:if test="${not empty error}">
                alert('Lỗi: ${error}');
            </c:if>
        </script>

    </body>
</html>