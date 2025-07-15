<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    .pagination-info {
        font-size: 0.9rem;
        color: #6c757d;
    }    .policy-item {
        transition: transform 0.2s;
        border-left: 4px solid #007bff;
    }

    .policy-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    .policy-preview {
        height: 4.8em;
        overflow: hidden;
        line-height: 1.2em;
        text-align: justify;
    }
</style>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">Our Policies</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="${pageContext.request.contextPath}">Home</a> / <span class="text-white">Policies</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Policy Listing Start -->
<div class="container-fluid py-5">
    <div class="container">
        <!-- Search Bar -->
        <div class="mb-5">
            <div class="bg-light p-4 rounded">
                <form action="policy" method="get" class="row g-3">
                    <input type="hidden" name="action" value="viewListPolicy">

                    <div class="col-md-8">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search policies by title..." name="keyword" value="${param.keyword}">
                            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i> Search</button>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="d-grid">
                            <a href="policy?action=viewListPolicy" class="btn btn-outline-primary">Clear Search</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Search Results Info -->
        <c:if test="${not empty keyword}">
            <div class="mb-4">
                <div class="alert alert-info">
                    <i class="bi bi-search"></i> 
                    Search results for "<strong>${keyword}</strong>" - ${totalRecords} policy(ies) found
                </div>
            </div>
        </c:if>

        <!-- Policies Grid -->
        <div class="row g-4">
            <c:forEach var="policy" items="${policyList}">
                <div class="col-lg-4 col-md-6">
                    <div class="policy-item bg-light rounded d-flex flex-column h-100 shadow-sm">
                        <div class="p-4 flex-grow-1 d-flex flex-column">
                            <!-- Policy Header -->
                            <div class="d-flex align-items-center mb-3">                                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" 
                                     style="width: 50px; height: 50px;">
                                    <i class="bi bi-shield-check fs-4"></i>
                                </div>
                                <div class="ms-3 flex-grow-1">
                                    <small class="text-muted">
                                        <i class="bi bi-calendar3"></i> 
                                        <c:choose>
                                            <c:when test="${policy.dateCreated != null}">
                                                <fmt:parseDate value="${policy.dateCreated}" pattern="yyyy-MM-dd" var="parsedDate" />
                                                <fmt:formatDate value="${parsedDate}" pattern="MM dd, yyyy"/>
                                            </c:when>
                                            <c:otherwise>
                                                Date not specified
                                            </c:otherwise>
                                        </c:choose>
                                    </small>
                                </div>
                            </div>

                            <!-- Policy Title -->
                            <h5 class="text-uppercase mb-3 fw-bold text-primary" style="height: 2.4em; overflow: hidden; line-height: 1.2em;">
                                <c:choose>
                                    <c:when test="${fn:length(policy.title) > 60}">
                                        ${fn:substring(policy.title, 0, 60)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${policy.title}
                                    </c:otherwise>
                                </c:choose>
                            </h5>

                            <!-- Policy Preview -->
                            <div class="policy-preview mb-3 flex-grow-1">
                                <c:choose>
                                    <c:when test="${fn:length(policy.description) > 150}">
                                        ${fn:substring(policy.description, 0, 150)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${policy.description}
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <!-- Action Button -->
                            <div class="text-center mt-auto">                                <a href="policy?action=viewPolicyDetail&id=${policy.policyID}" class="btn btn-primary">
                                    <i class="bi bi-file-text"></i> Read Full Policy
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty policyList && totalPages > 1}">
            <div class="row mt-5">
                <div class="col-12">
                    <!-- Pagination Info -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="pagination-info">
                            <small class="text-muted">
                                Showing ${((currentPage - 1) * 9) + 1} to ${currentPage * 9 > totalRecords ? totalRecords : currentPage * 9} of ${totalRecords} policies
                            </small>
                        </div>
                        <div class="pagination-info">
                            <small class="text-muted">
                                Page ${currentPage} of ${totalPages}
                            </small>
                        </div>
                    </div>

                    <nav aria-label="Policy pagination">
                        <ul class="pagination justify-content-center">
                            <!-- First Page -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="policy?action=viewListPolicy&page=1${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    <i class="bi bi-chevron-double-left"></i> First
                                </a>
                            </li>

                            <!-- Previous Page -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="policy?action=viewListPolicy&page=${currentPage - 1}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    <i class="bi bi-chevron-left"></i> Previous
                                </a>
                            </li>

                            <!-- Page Numbers Logic -->
                            <c:if test="${totalPages <= 10}">
                                <!-- Show all pages if total <= 10 -->
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="policy?action=viewListPolicy&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                            </c:if>

                            <c:if test="${totalPages > 10 && currentPage <= 5}">
                                <!-- Show first 7 pages + ... + last page -->
                                <c:forEach begin="1" end="7" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="policy?action=viewListPolicy&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <li class="page-item">
                                    <a class="page-link" href="policy?action=viewListPolicy&page=${totalPages}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${totalPages}</a>
                                </li>
                            </c:if>

                            <c:if test="${totalPages > 10 && currentPage >= totalPages - 4}">
                                <!-- Show first page + ... + last 7 pages -->
                                <li class="page-item">
                                    <a class="page-link" href="policy?action=viewListPolicy&page=1${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">1</a>
                                </li>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <c:forEach begin="${totalPages - 6}" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="policy?action=viewListPolicy&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                            </c:if>

                            <c:if test="${totalPages > 10 && currentPage > 5 && currentPage < totalPages - 4}">
                                <!-- Show first page + ... + current range + ... + last page -->
                                <li class="page-item">
                                    <a class="page-link" href="policy?action=viewListPolicy&page=1${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">1</a>
                                </li>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <c:forEach begin="${currentPage - 2}" end="${currentPage + 2}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="policy?action=viewListPolicy&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <li class="page-item">
                                    <a class="page-link" href="policy?action=viewListPolicy&page=${totalPages}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${totalPages}</a>
                                </li>
                            </c:if>

                            <!-- Next Page -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="policy?action=viewListPolicy&page=${currentPage + 1}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    Next <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>

                            <!-- Last Page -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="policy?action=viewListPolicy&page=${totalPages}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    Last <i class="bi bi-chevron-double-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>

        <!-- No Policies Found -->
        <c:if test="${empty policyList}">
            <div class="alert alert-info text-center p-5">
                <i class="bi bi-shield-exclamation fs-1 mb-3"></i>
                <h4>No Policies Found</h4>
                <c:choose>
                    <c:when test="${not empty keyword}">
                        <p>We couldn't find any policies matching "<strong>${keyword}</strong>". Please try a different search term.</p>
                        <a href="policy?action=viewListPolicy" class="btn btn-primary mt-3">View All Policies</a>
                    </c:when>
                    <c:otherwise>
                        <p>No policies are currently available. Please check back later.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</div>
<!-- Policy Listing End -->

<!-- Call to Action Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row g-5 align-items-center">
            <div class="col-md-6 text-white">
                <h1 class="display-5 text-uppercase mb-4">Transparent & Fair Policies</h1>
                <p class="fs-5 mb-4">We believe in clear, fair, and transparent policies that protect both our customers and their beloved pets</p>
                <c:if test="${not empty sessionScope.userDetailDTO}">
                    <a href="service?action=viewListService" class="btn btn-light py-md-3 px-md-5 text-uppercase">Browse Our Services</a>
                </c:if>
                <c:if test="${empty sessionScope.userDetailDTO}">
                    <a href="${pageContext.request.contextPath}/sign-in" class="btn btn-light py-md-3 px-md-5 text-uppercase">Join Our Community</a>
                </c:if>
            </div>
            <div class="col-md-6">
                <div class="position-relative rounded overflow-hidden h-100" style="min-height: 300px">
                    <img src="${pageContext.request.contextPath}/client/assets/img/about.jpg" class="position-absolute w-100 h-100" style="object-fit: cover">
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Call to Action End -->

<jsp:include page="/client/assets/layout/footer.jsp"/>
