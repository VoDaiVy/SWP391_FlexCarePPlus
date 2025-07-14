<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    .pagination-info {
        font-size: 0.9rem;
        color: #6c757d;
    }

    .news-item {
        transition: transform 0.2s;
        border-left: 4px solid #007bff;
    }

    .news-item:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
</style>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">Latest News</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="${pageContext.request.contextPath}">Home</a> / <span class="text-white">News</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- News Listing Start -->
<div class="container-fluid py-5">
    <div class="container">
        <!-- Search Bar -->
        <div class="mb-5">
            <div class="bg-light p-4 rounded">
                <form action="news" method="get" class="row g-3">
                    <input type="hidden" name="action" value="viewListNews">

                    <div class="col-md-8">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search news by title..." name="keyword" value="${param.keyword}">
                            <button class="btn btn-primary" type="submit"><i class="bi bi-search"></i> Search</button>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="d-grid">
                            <a href="news?action=viewListNews" class="btn btn-outline-primary">Clear Search</a>
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
                    Search results for "<strong>${keyword}</strong>" - ${totalRecords} article(s) found
                </div>
            </div>
        </c:if>

        <!-- News Grid -->
        <div class="row g-4">
            <c:forEach var="news" items="${newsList}">
                <div class="col-lg-4 col-md-6">
                    <div class="news-item bg-light rounded d-flex flex-column h-100 shadow-sm">
                        <div class="position-relative" style="height: 200px;">
                            <img class="img-fluid rounded-top w-100" src="${news.imgURL}" alt="${news.title}" 
                                 style="height: 100%; object-fit: cover;">
                            <div class="position-absolute top-0 start-0 bg-primary text-white px-3 py-1 rounded-end">
                                <small>
                                    <i class="bi bi-calendar"></i> 
                                    <c:choose>
                                        <c:when test="${news.dateCreated != null}">
                                            <!-- Parse date từ database format và format lại -->
                                            <fmt:parseDate value="${news.dateCreated}" pattern="yyyy-MM-dd" var="parsedDate" />
                                            <fmt:formatDate value="${parsedDate}" pattern="MM dd, yyyy"/>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Fallback nếu dateCreated là null -->
                                            Not specified
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                        </div>
                        <div class="p-4 flex-grow-1 d-flex flex-column">
                            <h5 class="text-uppercase mb-3" style="height: 2.4em; overflow: hidden; line-height: 1.2em;">
                                <c:choose>
                                    <c:when test="${fn:length(news.title) > 50}">
                                        ${fn:substring(news.title, 0, 50)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${news.title}
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <p class="mb-3 flex-grow-1" style="text-align: justify;">
                                <c:choose>
                                    <c:when test="${fn:length(news.description) > 120}">
                                        ${fn:substring(news.description, 0, 120)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${news.description}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <div class="d-flex justify-content-between align-items-center mt-auto">
                                <small class="text-muted">
                                    <i class="bi bi-eye"></i> 
                                    <c:choose>
                                        <c:when test="${news.views != null}">
                                            <fmt:formatNumber value="${news.views}" type="number" maxFractionDigits="0"/>
                                        </c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                    views
                                </small>
                                <a href="news?action=viewNewsDetail&id=${news.newsID}" class="btn btn-primary">
                                    Read More <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <c:if test="${not empty newsList && totalPages > 1}">
            <div class="row mt-5">
                <div class="col-12">
                    <!-- Pagination Info -->
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div class="pagination-info">
                            <small class="text-muted">
                                Showing ${((currentPage - 1) * 9) + 1} to ${currentPage * 9 > totalRecords ? totalRecords : currentPage * 9} of ${totalRecords} articles
                            </small>
                        </div>
                        <div class="pagination-info">
                            <small class="text-muted">
                                Page ${currentPage} of ${totalPages}
                            </small>
                        </div>
                    </div>

                    <nav aria-label="News pagination">
                        <ul class="pagination justify-content-center">
                            <!-- First Page -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="news?action=viewListNews&page=1${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    <i class="bi bi-chevron-double-left"></i> First
                                </a>
                            </li>

                            <!-- Previous Page -->
                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                <a class="page-link" href="news?action=viewListNews&page=${currentPage - 1}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    <i class="bi bi-chevron-left"></i> Previous
                                </a>
                            </li>

                            <!-- Page Numbers Logic -->
                            <c:if test="${totalPages <= 10}">
                                <!-- Show all pages if total <= 10 -->
                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="news?action=viewListNews&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                            </c:if>

                            <c:if test="${totalPages > 10 && currentPage <= 5}">
                                <!-- Show first 7 pages + ... + last page -->
                                <c:forEach begin="1" end="7" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="news?action=viewListNews&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <li class="page-item">
                                    <a class="page-link" href="news?action=viewListNews&page=${totalPages}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${totalPages}</a>
                                </li>
                            </c:if>

                            <c:if test="${totalPages > 10 && currentPage >= totalPages - 4}">
                                <!-- Show first page + ... + last 7 pages -->
                                <li class="page-item">
                                    <a class="page-link" href="news?action=viewListNews&page=1${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">1</a>
                                </li>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <c:forEach begin="${totalPages - 6}" end="${totalPages}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="news?action=viewListNews&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                            </c:if>

                            <c:if test="${totalPages > 10 && currentPage > 5 && currentPage < totalPages - 4}">
                                <!-- Show first page + ... + current range + ... + last page -->
                                <li class="page-item">
                                    <a class="page-link" href="news?action=viewListNews&page=1${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">1</a>
                                </li>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <c:forEach begin="${currentPage - 2}" end="${currentPage + 2}" var="i">
                                    <li class="page-item ${currentPage == i ? 'active' : ''}">
                                        <a class="page-link" href="news?action=viewListNews&page=${i}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${i}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item disabled"><span class="page-link">...</span></li>
                                <li class="page-item">
                                    <a class="page-link" href="news?action=viewListNews&page=${totalPages}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">${totalPages}</a>
                                </li>
                            </c:if>

                            <!-- Next Page -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="news?action=viewListNews&page=${currentPage + 1}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    Next <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>

                            <!-- Last Page -->
                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                <a class="page-link" href="news?action=viewListNews&page=${totalPages}${not empty param.keyword ? '&keyword='.concat(param.keyword) : ''}">
                                    Last <i class="bi bi-chevron-double-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>

        <!-- No News Found -->
        <c:if test="${empty newsList}">
            <div class="alert alert-info text-center p-5">
                <i class="bi bi-newspaper fs-1 mb-3"></i>
                <h4>No News Found</h4>
                <c:choose>
                    <c:when test="${not empty keyword}">
                        <p>We couldn't find any news articles matching "<strong>${keyword}</strong>". Please try a different search term.</p>
                        <a href="news?action=viewListNews" class="btn btn-primary mt-3">View All News</a>
                    </c:when>
                    <c:otherwise>
                        <p>No news articles are currently available. Please check back later.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
    </div>
</div>
<!-- News Listing End -->

<!-- Call to Action Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row g-5 align-items-center">
            <div class="col-md-6 text-white">
                <h1 class="display-5 text-uppercase mb-4">Stay Updated with Pet Care Tips!</h1>
                <p class="fs-5 mb-4">Get the latest news and expert advice on pet care, health tips, and exciting updates from FlexCare Pet Plus</p>
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
