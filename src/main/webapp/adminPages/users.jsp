<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <!-- Responsive datatable examples -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />     

        <!-- Bootstrap Css -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
        <!-- Icons Css -->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
        <!-- App Css-->
        <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
        <style>
            #datatable th, #datatable td {
                white-space: nowrap; /* Ngăn không cho nội dung xuống dòng */
                overflow: hidden; /* Ẩn phần nội dung bị tràn ra ngoài */
                text-overflow: ellipsis; /* Thêm dấu ba chấm cho nội dung quá dài */
                max-width: 150px; /* Đặt chiều rộng tối đa cho ô, có thể điều chỉnh theo ý muốn */
                padding: 5px; /* Tạo khoảng cách giữa nội dung và viền ô */
                box-sizing: border-box; /* Đảm bảo padding không làm tăng kích thước ô */
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

                        <div class="row">
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="card-title">
                                            <h4 >Quản Lí Người Dùng</h4>
                                        </div>

                                        <table id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th>Tên Người Dùng</th>
                                                    <th>Họ và tên</th>
                                                    <th>Địa Chỉ Email</th>
                                                    <th>Số điện thoại</th>
                                                    <th>Giới tính</th>
                                                    <th>Vai Trò</th>
                                                    <th>Trạng Thái</th>
                                                    <th>Hành Động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="userDTO" items="${userDTOs}">
                                                    <tr>
                                                        <td><img class="rounded-circle header-profile-user" src="${userDTO.avatar}" alt="avatar"/> ${userDTO.user.userName}</td>
                                                        <td><c:out value="${userDTO.firstName} ${userDTO.lastName}" default="N/A" /></td>
                                                        <td>${userDTO.user.email}</td>
                                                        <td><c:out value="${userDTO.tel}" default="N/A" /></td>
                                                        <td><c:out value="${userDTO.gender}" default="N/A" /></td>
                                                        <td>${userDTO.user.role}</td>
                                                        <td>
                                                            <!--                                                            <input type="checkbox" id="switch" switch="none" name="status" disabled
                                                            <c:if test="${userDTO.user.status == true}">checked</c:if> />
                                                            <label for="switch" data-on-label="On" data-off-label="Off"></label>-->
                                                            <c:choose>
                                                                <c:when test="${userDTO.user.status == true}">
                                                                    <span style="color: green; font-weight: bold;">Đang hoạt động</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span style="color: red; font-weight: bold;">Đã ngưng hoạt động</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <div class="btn-group" role="group">
                                                                <form action="admin" method="get" style="display: inline;">
                                                                    <input type="hidden" name="id" value="${userDTO.user.userId}">
                                                                    <input type="hidden" name="action" value="getUserDetail">
                                                                    <!--<a href="UsersServlet?id=10&action=view&actor=admin">-->
                                                                    <button type="submit" class="btn btn-sm btn-primary" style="margin-right: 5px;">
                                                                        <i class="ri-profile-fill"></i>
                                                                    </button>
                                                                    <!--</a>-->
                                                                </form>
                                                                <c:if test="${userDTO.user.status == true}">
                                                                    <form action="admin" method="post" style="display: inline;">
                                                                        <input type="hidden" name="id" value="${userDTO.user.userId}">
                                                                        <input type="hidden" name="action" value="banUser">

                                                                        <button type="submit" class="btn btn-sm btn-danger">
                                                                            <i class="ri-delete-bin-fill"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:if>

                                                                <c:if test="${userDTO.user.status == false}">
                                                                    <form action="admin" method="GET" style="display: inline;">
                                                                        <input type="hidden" name="id" value="${userDTO.user.userId}">
                                                                        <input type="hidden" name="action" value="allowUser">

                                                                        <button type="submit" class="btn btn-sm btn-success">
                                                                            <i class="ri-check-line"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:if>

                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                    </div>
                                </div>
                            </div> <!-- end col -->
                        </div> <!-- end row -->
                    </div> <!-- container-fluid -->
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