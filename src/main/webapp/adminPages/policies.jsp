<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>>Chính Sách - FlexCareP+</title>
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
            #datatable th, #datatable td {
                white-space: nowrap; /* Ngăn không cho nội dung xuống dòng */
                overflow: hidden; /* Ẩn phần nội dung bị tràn ra ngoài */
                text-overflow: ellipsis; /* Thêm dấu ba chấm cho nội dung quá dài */
                max-width: 150px; /* Đặt chiều rộng tối đa cho ô, có thể điều chỉnh theo ý muốn */
                padding: 5px; /* Tạo khoảng cách giữa nội dung và viền ô */
                box-sizing: border-box; /* Đảm bảo padding không làm tăng kích thước ô */
            }
            body {
                background-color: #f8f9fa;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .header {
                background-color: #ffffff;
                padding: 20px 0;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                margin-bottom: 30px;
            }

            .breadcrumb {
                background: none;
                padding: 0;
                margin: 0;
            }

            .breadcrumb-item + .breadcrumb-item::before {
                content: ">";
                color: #6c757d;
            }

            .policy-card {
                background: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                margin-bottom: 20px;
                overflow: hidden;
            }

            .accordion-button {
                background-color: white;
                border: none;
                padding: 20px;
                font-weight: 600;
                color: #333;
            }

            .accordion-button:not(.collapsed) {
                background-color: #e3f2fd;
                color: #1976d2;
                box-shadow: none;
            }

            .accordion-button:focus {
                box-shadow: 0 0 0 0.25rem rgba(25, 118, 210, 0.25);
                border-color: #1976d2;
            }

            .accordion-body {
                padding: 20px;
                background-color: #fafafa;
            }

            .policy-icon {
                color: #1976d2;
                margin-right: 10px;
                width: 20px;
            }

            .policy-title {
                color: #333;
                font-size: 1.1rem;
                font-weight: 600;
            }

            .policy-summary {
                color: #666;
                font-size: 0.9rem;
                margin-top: 5px;
            }

            .btn-primary {
                background-color: #1976d2;
                border-color: #1976d2;
            }

            .btn-primary:hover {
                background-color: #1565c0;
                border-color: #1565c0;
            }

            .page-title {
                color: #333;
                font-weight: 700;
                margin-bottom: 30px;
            }
        </style>
    </head>
    <body data-topbar="dark">

        <!-- <body data-layout="horizontal" data-topbar="dark"> -->

        <!-- Begin page -->
        <div id="layout-wrapper">
            <!-- ========== Header Start ========== -->
            <jsp:include page="/adminPages/assets/includes/header.jsp" />
            <!-- ========== Header End ========== -->
            <!-- ========== Left Sidebar Start ========== -->
            <jsp:include page="/adminPages/assets/includes/navbar.jsp" /> 
            <!-- Left Sidebar End -->

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">


                <!-- Header -->
                <div class="header">
                    <div class="container">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <h1 class="h3 mb-0 text-dark font-weight-bold">CHÍNH SÁCH</h1>
                            </div>
                            <div class="col-md-6">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb justify-content-md-end mb-0">
                                        <li class="breadcrumb-item"><a href="#" class="text-muted">FlexCareP+</a></li>
                                        <li class="breadcrumb-item active text-muted" aria-current="page">Chính sách</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Content -->
                <div class="container">
                    <div class="row">
                        <div class="col-12">
                            <h2 class="page-title">Danh sách chính sách</h2>
                            <!-- Tạo nút Create ở trên danh sách chính sách -->
                            <div class="mb-4 d-flex justify-content-end">
                                <a href="admin?action=getPolicyDetail" class="btn btn-primary">
                                    <i class="fas fa-plus me-2"></i> Tạo chính sách mới
                                </a>
                            </div>
                            <!-- Policies Accordion -->
                            <div class="accordion" id="policiesAccordion">

                                <!-- Policy 1: Privacy Policy -->
                                <c:forEach var="p" items="${policies}" varStatus="status">
                                    <div class="policy-card">
                                        <div class="accordion-item border-0">
                                            <h2 class="accordion-header" id="heading${status.index}">
                                                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                                        data-bs-target="#collapse${status.index}" aria-expanded="false"
                                                        aria-controls="collapse${status.index}">
                                                    <i class="fas fa-shield-alt policy-icon"></i>
                                                    <div>
                                                        <div class="policy-title">${p.title}</div>
                                                        <div class="policy-summary">Chính sách FlexCareP+</div>
                                                    </div>
                                                </button>
                                            </h2>
                                            <div id="collapse${status.index}" class="accordion-collapse collapse"
                                                 aria-labelledby="heading${status.index}" data-bs-parent="#policiesAccordion">
                                                <div class="accordion-body">
                                                    <div class="policy-content">
                                                        <textarea class="form-control" id="description" name="description" rows="10" disabled readonly  maxlength="2000"><c:out value='${p.description}'/></textarea>

                                                    </div>

                                                    <!-- Action buttons -->
                                                    <div class="d-flex justify-content-end mt-3 gap-2">
                                                        <a href="admin?action=getPolicyDetail&id=${p.policyID}" class="btn btn-sm btn-outline-primary">
                                                            <i class="fas fa-edit me-1"></i> Edit
                                                        </a>
                                                        <form action="policy" method="post" onsubmit="return confirm('Bạn có chắc chắn muốn xóa chính sách này?');">
                                                            <input type="hidden" name="action" value="deletePolicy">
                                                            <input type="hidden" name="id" value="${p.policyID}">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger">
                                                                <i class="fas fa-trash-alt me-1"></i> Delete
                                                            </button>
                                                        </form>
                                                    </div>
                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                            <!-- Contact Section -->
                            <div class="row mt-5">
                                <div class="col-12">
                                    <div class="card policy-card">
                                        <div class="card-body text-center p-4">
                                            <h5 class="card-title">Cần hỗ trợ thêm?</h5>
                                            <p class="card-text text-muted">Nếu bạn có thắc mắc về các chính sách trên, vui lòng liên hệ với chúng tôi.</p>
                                            <a href="#" class="btn btn-primary">
                                                <i class="fas fa-phone me-2"></i>Liên hệ hỗ trợ
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer spacing -->
                <div style="height: 50px;"></div>

                <!-- End Page-content -->
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

        <!-- Datatable init js -->
        <script src="${pageContext.request.contextPath}/adminPages/assets/js/pages/datatables.init.js"></script>

        <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>

    </body>
</html>