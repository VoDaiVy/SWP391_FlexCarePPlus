<%@page import="java.util.ArrayList"%>
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
        <style>
            .invisible-button {
                background: none;
                border: none;
                padding: 0;
                margin: 0;
                cursor: pointer;
                outline: none;
            }

            .invisible-button input[type="checkbox"] {
                display: none;
            }

            .chart-container {
                width: 80%;
                margin: auto;
                padding-top: 50px;
            }
            h1, .stats {
                text-align: center;
            }
            .stats {
                display: flex;
                justify-content: center;
                gap: 30px;
                font-size: 18px;
            }
            .stat-item {
                display: flex;
                flex-direction: column;
                align-items: center;
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

                <div class="page-content">
                    <div class="container-fluid">

                        <!-- start page title -->
                        <div class="row">
                            <div class="col-12">
                                <div class="page-title-box d-sm-flex align-items-center justify-content-between">
                                    <h4 class="mb-sm-0">Trang tổng quan</h4>

                                    <div class="page-title-right">
                                        <ol class="breadcrumb m-0">
                                            <li class="breadcrumb-item"><a href="javascript: void(0);">FlexCareP+</a></li>
                                            <li class="breadcrumb-item active">Trang tổng quan</li>
                                        </ol>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!-- end page title -->

                        <div class="row d-flex">
                            <!-- Card 1 -->
                            <div class="col-xl-4 col-md-4 d-flex">
                                <div class="card w-100">
                                    <div class="card-body d-flex flex-column">
                                        <div class="d-flex">
                                            <div class="flex-grow-1">
                                                <p class="text-truncate font-size-14 mb-2">Số lượng đặt dịch vụ</p>
                                                <h4 class="mb-2">${totalorder} 12222</h4>
                                            </div>
                                            <div class="avatar-sm">
                                                <span class="avatar-title bg-light text-primary rounded-3">
                                                    <i class="ri-shopping-cart-2-line font-size-24"></i>  
                                                </span>
                                            </div>
                                        </div>
                                    </div><!-- end cardbody -->
                                </div><!-- end card -->
                            </div><!-- end col -->

                            <!-- Card 2 -->
                            <div class="col-xl-4 col-md-4 d-flex">
                                <div class="card w-100">
                                    <div class="card-body d-flex flex-column">
                                        <div class="d-flex">
                                            <div class="flex-grow-1">
                                                <p class="text-truncate font-size-14 mb-2">Số lượng người dùng</p>
                                                <h4 class="mb-2">${totaluser} 2100</h4>
                                            </div>
                                            <div class="avatar-sm">
                                                <span class="avatar-title bg-light text-primary rounded-3">
                                                    <i class="ri-user-3-line font-size-24"></i>  
                                                </span>
                                            </div>
                                        </div>
                                    </div><!-- end cardbody -->
                                </div><!-- end card -->
                            </div><!-- end col -->

                            <!-- Card 3 -->
                            <div class="col-xl-4 col-md-4 d-flex">
                                <div class="card w-100">
                                    <div class="card-body d-flex flex-column">
                                        <div class="d-flex">
                                            <div class="flex-grow-1">
                                                <p class="text-truncate font-size-14 mb-2">Quản lí ví</p>
                                                <c:if test="${wallet.status == true}">
                                                    <form action="${pageContext.request.contextPath}/WalletServlet" method="post" style="display: inline;">
                                                        <input type="hidden" name="action" value="change">
                                                        <input type="hidden" name="actor" value="admin">
                                                        <button type="submit" class="invisible-button">
                                                            <input type="checkbox" id="switch" switch="none" name="status" checked/>
                                                            <label for="switch" data-on-label="On" data-off-label="Off"></label>
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${wallet.status == false}">
                                                    <form action="${pageContext.request.contextPath}/WalletServlet" method="post" style="display: inline;">
                                                        <input type="hidden" name="action" value="change">
                                                        <input type="hidden" name="actor" value="admin">
                                                        <button type="submit" class="invisible-button">
                                                            <input type="checkbox" id="switch" switch="none" name="status"/>
                                                            <label for="switch" data-on-label="On" data-off-label="Off"></label>
                                                        </button>
                                                    </form>
                                                </c:if>
                                            </div>
                                            <div class="avatar-sm">
                                                <span class="avatar-title bg-light text-success rounded-3">
                                                    <i class="mdi mdi-currency-btc font-size-24"></i>  
                                                </span>
                                            </div>
                                        </div>
                                    </div><!-- end cardbody -->
                                </div><!-- end card -->
                            </div><!-- end col -->
                        </div><!-- end row -->


                        <div class="row">
                            <div class="card">
                                <div class="card-body pb-0">
                                    <h4 class="card-title mb-4">Doanh thu</h4>


                                </div>
                                <div class="chart-container">
                                    <canvas id="revenueChart" width="400" height="200"></canvas>
                                </div>
                            </div>
                            <script>
                                // Dữ liệu từ server (ví dụ)
                                const labels = ${revenueday};
                                const revenueData = ${revenue};

                                // Thiết lập biểu đồ
                                document.addEventListener("DOMContentLoaded", function () {
                                    const ctx = document.getElementById('revenueChart').getContext('2d');
                                    new Chart(ctx, {
                                        type: 'bar',
                                        data: {
                                            labels: labels,
                                            datasets: [
                                                {
                                                    label: 'Revenue',
                                                    data: revenueData,
                                                    backgroundColor: 'rgba(54, 162, 235, 0.5)',
                                                    borderColor: 'rgba(54, 162, 235, 1)',
                                                    borderWidth: 1
                                                }
                                            ]
                                        },
                                        options: {
                                            responsive: true,
                                            scales: {
                                                y: {
                                                    beginAtZero: true,
                                                    max: ${maxrevenue}
                                                }
                                            }
                                        }
                                    });
                                });
                            </script>

                        </div>
                        <!-- end row -->
                    </div>

                </div>
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