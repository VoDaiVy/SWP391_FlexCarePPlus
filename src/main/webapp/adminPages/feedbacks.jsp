<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Service Feedback Management - FlexCareP+</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body data-topbar="dark">
    <div id="layout-wrapper">
        <jsp:include page="/adminPages/assets/includes/header.jsp" />
        <jsp:include page="/adminPages/assets/includes/navbar.jsp" />
        <div class="main-content">
            <div class="page-content">
                <div class="container-fluid">
                    <div class="page-title-box d-flex align-items-center justify-content-between">
                        <h4 class="mb-0">Feedback Management for Service: <span class="text-primary">${service.name}</span></h4>
                        <a href="admin?action=getServices" class="btn btn-secondary"><i class="fas fa-arrow-left me-2"></i>Back to Services</a>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table class="table table-bordered table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th style="width: 60px;">#</th>
                                        <th>Sender Email</th>
                                        <th>Rating</th>
                                        <th>Comment</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty feedbacks}">
                                            <c:forEach var="fb" items="${feedbacks}" varStatus="loop">
                                                <tr>
                                                    <td>${loop.index + 1}</td>
                                                    <td>
                                                        <c:out value="${users[fb.userID].email}" />
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="fas fa-star"></i> ${fb.rating}
                                                        </span>
                                                    </td>
                                                    <td>${fb.comment}</td>
                                                    <td><c:out value="${fb.dateCreated}" /></td>
                                                    <td>
                                                        <form action="admin" method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="toggleFeedbackStatus" />
                                                            <input type="hidden" name="feedbackServiceID" value="${fb.feedbackServiceID}" />
                                                            <input type="hidden" name="serviceID" value="${service.serviceID}" />
                                                            <button type="submit" class="btn btn-sm ${fb.status ? 'btn-success' : 'btn-secondary'}" title="Toggle Status">
                                                                <i class="fas ${fb.status ? 'fa-toggle-on' : 'fa-toggle-off'}"></i> ${fb.status ? 'Active' : 'Inactive'}
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center text-muted">No feedback found for this service.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="/adminPages/assets/includes/footer.jsp" />
        </div>
    </div>
    <jsp:include page="/adminPages/assets/includes/rightbar.jsp" />
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>
</body>
</html>
