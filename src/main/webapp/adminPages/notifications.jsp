<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Admin Pages</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
        <meta content="Themesdesign" name="author" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-select-bs4/css//select.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Responsive datatable examples -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />     

        <!-- Bootstrap Css -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
    </head>
    <body data-topbar="dark">
        <div id="layout-wrapper">
            <!-- ========== Header Start ========== -->
            <jsp:include page="/adminPages/assets/includes/header.jsp" />
            <!-- ========== Header End ========== -->
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="/adminPages/assets/includes/navbar.jsp" /> 
            <!-- Left Sidebar End -->
            <div class="main-content">
                <div class="page-content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0">Danh sách thông báo</h4>
                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="admin">FlexCareP+</a></li>
                                            <li class="breadcrumb-item active">Thông báo</li>
                                        </ol>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <button id="btnCreateNotification" class="btn btn-primary mb-3">Tạo thông báo</button>
                                        <!-- Popup tạo thông báo -->
                                        <div id="createNotificationModal" class="modal" tabindex="-1" style="display:none; background:rgba(0,0,0,0.3); position:fixed; top:0; left:0; width:100vw; height:100vh; z-index:1050; align-items:center; justify-content:center;">
                                            <div class="modal-dialog" style="max-width:700px; width:90vw; margin:auto;">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title">Tạo thông báo mới</h5>
                                                        <button type="button" class="btn-close" id="closeCreateModal" aria-label="Close"></button>
                                                    </div>
                                                    <form method="post" action="admin">
                                                        <input name="action" value="createNotification" hidden/>
                                                        <div class="modal-body">
                                                            <div class="mb-3">
                                                                <label for="content" class="form-label">Nội dung</label>
                                                                <textarea class="form-control" id="content" name="content" rows="3" required></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="submit" class="btn btn-success">Tạo mới</button>
                                                            <button type="button" class="btn btn-secondary" id="cancelCreateModal">Hủy</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <table class="table table-bordered table-hover">
                                            <script>
                                                // Popup create notification logic
                                                const btnCreate = document.getElementById('btnCreateNotification');
                                                const modal = document.getElementById('createNotificationModal');
                                                const closeBtn = document.getElementById('closeCreateModal');
                                                const cancelBtn = document.getElementById('cancelCreateModal');
                                                if (btnCreate && modal && closeBtn && cancelBtn) {
                                                    btnCreate.onclick = function () {
                                                        modal.style.display = 'flex';
                                                    };
                                                    closeBtn.onclick = function () {
                                                        modal.style.display = 'none';
                                                    };
                                                    cancelBtn.onclick = function () {
                                                        modal.style.display = 'none';
                                                    };
                                                    // Đóng popup khi click ra ngoài
                                                    window.onclick = function (event) {
                                                        if (event.target === modal) {
                                                            modal.style.display = 'none';
                                                        }
                                                    };
                                                }
                                            </script>
                                            <thead class="thead-light">
                                                <tr>
                                                    <th scope="col">#</th>
                                                    <th scope="col">Nội dung</th>
                                                    <th scope="col">Ngày tạo</th>
                                                    <th scope="col">Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody id="notification-table-body">
                                            </tbody>
                                            <!-- Search and pagination controls -->
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <input type="text" id="searchInput" class="form-control" placeholder="Tìm kiếm nội dung thông báo...">
                                                </div>
                                            </div>
                                            <nav>
                                                <ul class="pagination justify-content-center" id="pagination"></ul>
                                            </nav>
                                            <script>
                                                // Lấy dữ liệu notifications từ EL và truyền sang JS dưới dạng JSON
                                                const notifications = [
                                                <c:forEach var="noti" items="${notifications}" varStatus="loop">
                                                {
                                                index: ${loop.index + 1},
                                                        content: '<c:out value="${noti.content}"/>',
                                                        dateCreated: '<c:out value="${noti.dateCreated}"/>',
                                                        notificationID: '<c:out value="${noti.notificationID}"/>'
                                                }<c:if test="${!loop.last}">,</c:if>
                                                </c:forEach>
                                                ];
                                                const rowsPerPage = 10;
                                                let currentPage = 1;

                                                document.addEventListener('DOMContentLoaded', function () {
                                                    renderTable();
                                                    document.getElementById('searchInput').addEventListener('input', function () {
                                                        currentPage = 1;
                                                        renderTable();
                                                    });
                                                });

                                                function renderTable() {
                                                    const searchValue = document.getElementById('searchInput').value.toLowerCase();
                                                    let filtered = notifications.filter(noti => noti.content.toLowerCase().includes(searchValue));
                                                    const totalPages = Math.ceil(filtered.length / rowsPerPage) || 1;
                                                    currentPage = Math.min(currentPage, totalPages);
                                                    const start = (currentPage - 1) * rowsPerPage;
                                                    const end = start + rowsPerPage;
                                                    const pageData = filtered.slice(start, end);
                                                    let html = '';
                                                    for (var i = 0; i < pageData.length; i++) {
                                                        var noti = pageData[i];
                                                        html += '<tr>' +
                                                                '<th scope="row">' + noti.index + '</th>' +
                                                                '<td>' + noti.content + '</td>' +
                                                                '<td>' + noti.dateCreated + '</td>' +
                                                                '<td>' +
                                                                '<form method="post" action="admin" style="display:inline;">' +
                                                                '<input type="hidden" name="notificationID" value="' + noti.notificationID + '" />' +
                                                                '<input type="hidden" name="action" value="deleteNotification" />' +
                                                                '<button type="submit" class="btn btn-danger btn-sm" onclick="return confirm(\'Bạn có chắc muốn xóa thông báo này?\');">Xóa</button>' +
                                                                '</form>' +
                                                                '</td>' +
                                                                '</tr>';
                                                    }
                                                    document.getElementById('notification-table-body').innerHTML = html;
                                                    renderPagination(totalPages);
                                                }

                                                function renderPagination(totalPages) {
                                                    var html = '';
                                                    if (totalPages > 1) {
                                                        html += '<li class="page-item' + (currentPage === 1 ? ' disabled' : '') + '"><a class="page-link" href="#" onclick="gotoPage(' + (currentPage - 1) + ');return false;">&laquo;</a></li>';
                                                        for (var i = 1; i <= totalPages; i++) {
                                                            html += '<li class="page-item' + (i === currentPage ? ' active' : '') + '"><a class="page-link" href="#" onclick="gotoPage(' + i + ');return false;">' + i + '</a></li>';
                                                        }
                                                        html += '<li class="page-item' + (currentPage === totalPages ? ' disabled' : '') + '"><a class="page-link" href="#" onclick="gotoPage(' + (currentPage + 1) + ');return false;">&raquo;</a></li>';
                                                    }
                                                    document.getElementById('pagination').innerHTML = html;
                                                }

                                                window.gotoPage = function (page) {
                                                    currentPage = page;
                                                    renderTable();
                                                };
                                            </script>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- ========== Footer Start ========== -->
                <jsp:include page="/adminPages/assets/includes/footer.jsp" />
                <!-- ========== Footer End ========== -->
            </div>
            <!-- end main content-->
        </div>
        <!-- END layout-wrapper -->
        <!-- ========== Rightbar Start ========== -->
        <jsp:include page="/adminPages/assets/includes/rightbar.jsp" />
        <!-- ========== Rightbar End ========== -->
        <!-- JAVASCRIPT -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/metismenu/metisMenu.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/simplebar/simplebar.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/node-waves/waves.min.js"></script>
        <!-- apexcharts -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/apexcharts/apexcharts.min.js"></script>

        <!-- jquery.vectormap map -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-us-merc-en.js"></script>

        <!-- Required datatable js -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>

        <!-- Responsive examples -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>

        <script src="${pageContext.request.contextPath}/adminPages/assets/js/pages/dashboard.init.js"></script>

        <!-- App js -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>
    </body>
</html>
