<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <title>Data Tables | Upcube - Admin & Dashboard Template</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
        <meta content="Themesdesign" name="author" />
        <!-- App favicon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">

        <!-- DataTables -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-select-bs4/css//select.bootstrap4.min.css" rel="stylesheet" type="text/css" />

        <!-- Sweet Alert-->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
        <!-- Responsive datatable examples -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />     
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Bootstrap Css -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
        <style>
            /* Main container */
            .user-profile {
                width: 100%;
                max-width: 800px;
                margin: auto;
                background-color: #f9f9f9;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                font-family: Arial, sans-serif;
                color: #333;
            }

            /* Avatar styling */
            .user-profile .avatar-md {
                width: 120px;
                height: 120px;
                display: block;
                margin: 0 auto;
                border-radius: 50%;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Name styling */
            .user-profile h2 {
                text-align: center;
                margin-top: 10px;
                font-size: 24px;
                font-weight: bold;
                color: #333;
            }

            /* Section styling */
            .section {
                margin-top: 20px;
                padding: 10px;
            }

            .section h3 {
                font-size: 18px;
                font-weight: bold;
                color: #444;
                margin-bottom: 10px;
                text-align: left;
                padding-left: 10px;
                border-left: 3px solid #007bff;
            }

            /* List styling */
            .section ul {
                list-style-type: none;
                padding: 0;
            }

            .section ul li {
                display: flex;
                justify-content: space-between;
                padding: 8px 0;
                border-bottom: 1px solid #ddd;
            }

            .section ul li strong {
                color: #555;
                font-weight: bold;
            }

            .section ul li:last-child {
                border-bottom: none;
            }

            /* Chart Container */
            .chart-container {
                margin-top: 30px;
                background-color: #ffffff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .chart-container h4 {
                font-size: 18px;
                color: #444;
                font-weight: bold;
                margin-bottom: 15px;
            }

            /* Canvas Styling */
            .chart-container canvas {
                max-width: 100%;
                height: auto;
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

            <div class="main-content">

                <div class="page-content">
                    <div class="container-fluid">

                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-title text-center">
                                            <h4>Thông Tin Người Dùng</h4>
                                        </div>

                                        <div class="user-profile">
                                            <div class="text-center">
                                                <img src="${userDetail.avatar}" alt="User Avatar" class="avatar-md">
                                                <h2><c:out value="${userDTO.firstName} ${userDTO.lastName}" default="N/A" /></h2>
                                            </div>

                                            <div class="row mt-4">
                                                <!-- Personal Information Section -->
                                                <div class="col-12 col-md-6 section">
                                                    <h3>Personal Information</h3>
                                                    <ul>
                                                        <li><strong>Telephone:</strong> <c:out value="${userDetail.tel}" default="N/A" /></li>
                                                        <li><strong>Gender:</strong> <c:out value="${userDetail.gender}" default="N/A" /></li>
                                                        <li><strong>Date of Birth:</strong> <c:out value="${userDetail.dob}" default="N/A" /></li>
                                                        <li><strong>Email:</strong> ${user.email}</li>
                                                    </ul>
                                                </div>

                                                <!-- Financial Information Section -->
                                                <div class="col-12 col-md-6 section">
                                                    <h3>Financial Information</h3>
                                                    <ul>
                                                        <li><strong>Money in Wallet:</strong>                             
                                                            <fmt:formatNumber value="${wallet.amount}" type="number" groupingUsed="true" />₫
                                                        </li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="mb-0">
                                            <div>
                                                <a href="admin?action=getUsers" class="btn btn-secondary waves-effect">
                                                    Quay trở lại
                                                </a>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div> <!-- container-fluid -->
        </div>
        <!-- End Page-content -->

        <!-- ========== Footer Start ========== -->
        <jsp:include page="/adminPages/assets/includes/footer.jsp" />
        <!-- ========== Footer End ========== -->

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
    <!-- Sweet Alerts js -->
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/sweetalert2/sweetalert2.min.js"></script>

    <!-- Sweet alert init js-->
    <script src="${pageContext.request.contextPath}/adminPages/assets/js/pages/sweet-alerts.init.js"></script>

    <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>

</body>
