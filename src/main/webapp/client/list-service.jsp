<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">Our Services</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="${pageContext.request.contextPath}">Home</a> / <span class="text-white">Services</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Service Listing Start -->
<div class="container-fluid py-5">
    <div class="container">
        <!-- Search & Filter Bar -->
        <div class="mb-5">
            <div class="bg-light p-4 rounded">
                <form action="service" method="get" class="row g-3">
                    <input type="hidden" name="action" value="viewListService">

                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search services..." name="keyword" value="${param.keyword}">
                            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i></button>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <select class="form-select" name="sortBy" onchange="this.form.submit()">
                            <option value="name_asc" ${param.sortBy == 'name_asc' ? 'selected' : ''}>Name (A-Z)</option>
                            <option value="name_desc" ${param.sortBy == 'name_desc' ? 'selected' : ''}>Name (Z-A)</option>
                            <option value="price_asc" ${param.sortBy == 'price_asc' ? 'selected' : ''}>Price (Low to High)</option>
                            <option value="price_desc" ${param.sortBy == 'price_desc' ? 'selected' : ''}>Price (High to Low)</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <div class="d-grid">
                            <a href="service?action=viewListService" class="btn btn-outline-primary">Clear Filters</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Category Tabs -->
        <ul class="nav nav-tabs mb-4">
            <li class="nav-item">
                <a class="nav-link ${empty param.categoryId ? 'active' : ''}" 
                   href="service?action=viewListService${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                    All Services
                </a>
            </li>
            <c:forEach var="category" items="${categories}">
                <li class="nav-item">
                    <c:set var="url" value="service?action=viewListService&categoryId=${category.categoryServiceID}"/>
                    <c:if test="${not empty param.keyword}">
                        <c:set var="url" value="${url}&keyword=${fn:escapeXml(param.keyword)}"/>
                    </c:if>
                    <a class="nav-link ${not empty param.categoryId and param.categoryId + 0 eq category.categoryServiceID ? 'active' : ''}" 
                       href="${url}">
                        ${category.name}
                    </a>
                </li>
            </c:forEach>
        </ul>

        <!-- Services Grid -->
        <div class="row g-4">
            <c:forEach var="service" items="${services}">
                <div class="col-lg-4 col-md-6">
                    <div class="service-item bg-light rounded d-flex flex-column h-100">
                        <div class="position-relative" style="height: 200px;">
                    <img class="img-fluid rounded-top w-100" src="${service.imgURL}" alt="${service.name}" style="height: 100%; object-fit: contain; background-color: #f8f9fa;">
                </div>
                        <div class="p-4 flex-grow-1 d-flex flex-column">
                            <div class="d-flex justify-content-between mb-3 align-items-center">
                                <h5 class="text-uppercase mb-0" style="max-width: 60%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${service.name}</h5>
                                <span class="bg-primary text-white rounded-pill py-1 px-3">
                                    <fmt:formatNumber value="${service.price}" type="number" maxFractionDigits="0"/> đ
                                </span>
                            </div>
                            <p class="mb-3">${fn:substring(service.description, 0, 150)}${fn:length(service.description) > 150 ? '...' : ''}</p>
                            <div class="mt-auto">
                                <a href="service?action=viewDetail&id=${service.serviceID}" class="btn btn-primary">Learn More</a>
                                <c:if test="${not empty sessionScope.userDetailDTO}">
                                    <a href="service?action=viewDetail&id=${service.serviceID}" class="btn btn-outline-primary ms-2">
                                        <i class="bi bi-cart-plus"></i> Book Now
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty services && totalPages > 1}">
            <div class="row mt-5">
                <div class="col-12">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center">
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="service?action=viewListService&page=${currentPage - 1}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">Previous</a>
                            </li>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${currentPage == i}">
                                        <li class="page-item active"><a class="page-link">${i}</a></li>
                                        </c:when>
                                        <c:otherwise>
                                        <li class="page-item">
                                            <a class="page-link" href="service?action=viewListService&page=${i}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">${i}</a>
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="service?action=viewListService&page=${currentPage + 1}${not empty param.categoryId ? '&categoryId='.concat(param.categoryId) : ''}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}${not empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}">Next</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>

        <!-- No Services Found -->
        <c:if test="${empty services}">
            <div class="alert alert-info text-center p-5">
                <i class="bi bi-info-circle fs-1 mb-3"></i>
                <h4>No Services Found</h4>
                <p>We couldn't find any services matching your criteria. Please try a different search or category.</p>
                <a href="service?action=viewListService" class="btn btn-primary mt-3">View All Services</a>
            </div>
        </c:if>
    </div>
</div>
<!-- Service Listing End -->

<!-- Call to Action Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-md-6 text-white">
                <h1 class="display-5 text-uppercase mb-4">Book Services For Your Pets Today!</h1>
                <p class="fs-5 mb-4">Treat your pet to the best care with our professional services</p>
                <c:if test="${not empty sessionScope.userDetailDTO}">
                    <a href="booking?action=viewCart" class="btn btn-light py-md-3 px-md-5 text-uppercase">View Cart</a>
                </c:if>
                <c:if test="${empty sessionScope.userDetailDTO}">
                    <a href="${pageContext.request.contextPath}/sign-in" class="btn btn-light py-md-3 px-md-5 text-uppercase">Sign In to Book</a>
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
