<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Policy - FlexCareP+</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesdesign" name="author" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">
    <!-- DataTables -->
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-buttons-bs4/css/buttons.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-select-bs4/css//select.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />     
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
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
        .form-label { font-weight: 600; }
        .form-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 32px 24px;
            max-width: 600px;
            margin: 40px auto;
        }
        .page-title {
            color: #333;
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
        }
        .btn-primary {
            background-color: #1976d2;
            border-color: #1976d2;
        }
        .btn-primary:hover {
            background-color: #1565c0;
            border-color: #1565c0;
        }
    </style>
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
            <!-- Header -->
            <div class="header">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h1 class="h3 mb-0 text-dark font-weight-bold">
                                <c:choose>
                                    <c:when test="${not empty policy}">Chá»nh sá»­a chÃ­nh sÃ¡ch</c:when>
                                    <c:otherwise>ThÃªm chÃ­nh sÃ¡ch má»i</c:otherwise>
                                </c:choose>
                            </h1>
                        </div>
                        <div class="col-md-6">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb justify-content-md-end mb-0">
                                    <li class="breadcrumb-item"><a href="#" class="text-muted">FlexCareP+</a></li>
                                    <li class="breadcrumb-item"><a href="admin?action=getPolicies" class="text-muted">ChÃ­nh sÃ¡ch</a></li>
                                    <li class="breadcrumb-item active text-muted" aria-current="page">
                                        <c:choose>
                                            <c:when test="${not empty policy}">Chá»nh sá»­a</c:when>
                                            <c:otherwise>ThÃªm má»i</c:otherwise>
                                        </c:choose>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Main Content -->
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="form-container">
                            <h2 class="page-title">
                                <c:choose>
                                    <c:when test="${not empty policy}">Edit Policy</c:when>
                                    <c:otherwise>Add Policy</c:otherwise>
                                </c:choose>
                            </h2>
                            <form action="admin" method="post">
                                <c:if test="${not empty policy}">
                                    <input type="hidden" name="action" value="updatePolicy" />
                                    <input type="hidden" name="id" value="${policy.policyID}" />
                                </c:if>
                                <c:if test="${empty policy}">
                                    <input type="hidden" name="action" value="createPolicy" />
                                </c:if>
                                <div class="mb-3">
                                    <label for="title" class="form-label">Title</label>
                                    <input type="text" class="form-control" id="title" name="title" required value="<c:out value='${policy.title}'/>" maxlength="255" />
                                </div>
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="5" required maxlength="2000"><c:out value='${policy.description}'/></textarea>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <a href="admin?action=getPolicies" class="btn btn-secondary"><i class="fas fa-arrow-left me-1"></i>Back</a>
                                    <button type="submit" class="btn btn-primary">
                                        <c:choose>
                                            <c:when test="${not empty policy}">Cập nhật</c:when>
                                            <c:otherwise>Tạo mới</c:otherwise>
                                        </c:choose>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div style="height: 50px;"></div>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>
    </div>
</body>
</html>
