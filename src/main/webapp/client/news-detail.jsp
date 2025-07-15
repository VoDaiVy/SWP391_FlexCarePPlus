<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    .img-preview {
        object-fit: contain;
        cursor: pointer;
    }

    .image-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.7);
        z-index: 10000;
        justify-content: center;
        align-items: center;
    }

    .image-overlay img {
        max-width: 80%;
        max-height: 80vh;
        object-fit: contain;
        border-radius: 8px;
    }

    .image-overlay.active {
        display: flex;
    }

    .gallery-container {
        position: relative;
        overflow-x: auto;
        white-space: nowrap;
        padding: 10px 0;
    }

    .gallery-container::-webkit-scrollbar {
        display: none;
    }

    .gallery-item {
        display: inline-block;
        width: 25%;
        padding: 0 5px;
    }

    .gallery-item img {
        width: 100%;
        height: 100px;
        object-fit: cover;
        border-radius: 8px;
        cursor: pointer;
    }

    .scroll-btn {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        background: rgba(0, 0, 0, 0.5);
        color: white;
        border: none;
        padding: 10px;
        cursor: pointer;
        z-index: 10;
        border-radius: 50%;
        font-size: 1.2rem;
    }

    .scroll-btn.left {
        left: 0;
    }

    .scroll-btn.right {
        right: 0;
    }

    .scroll-btn:hover {
        background: rgba(0, 0, 0, 0.8);
    }

    .news-content {
        line-height: 1.8;
        font-size: 1.1rem;
    }

    .news-content p {
        margin-bottom: 1.5rem;
        text-align: justify;
    }

    .news-meta {
        border-left: 4px solid #0d6efd;
        padding-left: 1rem;
        background-color: #f8f9fa;
    }

    .related-news-item:hover {
        transform: translateY(-2px);
        transition: all 0.3s ease;
    }

    .share-buttons .btn {
        margin-right: 0.5rem;
        margin-bottom: 0.5rem;
    }
</style>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-4 text-uppercase text-white mb-3">${news.title}</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="home">Home</a> / <a class="text-white" href="news?action=viewListNews">News</a> / <span class="text-white">Article</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- News Detail Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-8">
                <!-- Main News Content -->
                <article class="mb-5">
                    <!-- Featured Image -->
                    <div class="position-relative mb-4">
                        <img class="img-fluid rounded w-100 img-preview" src="${news.imgURL}" alt="${news.title}" 
                             style="max-height: 400px; object-fit: cover;" onclick="showImage(this.src, this.alt)">
                    </div>

                    <!-- News Meta Information -->
                    <div class="news-meta p-3 rounded mb-4">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <small class="text-muted">
                                    <i class="bi bi-calendar-event text-primary"></i> 
                                    Published on 
                                    <c:choose>
                                        <c:when test="${news.dateCreated != null}">
                                            <fmt:parseDate value="${news.dateCreated}" pattern="yyyy-MM-dd" var="parsedDate" />
                                            <fmt:formatDate value="${parsedDate}" pattern="MM dd, yyyy"/>
                                        </c:when>
                                        <c:otherwise>
                                            Date not specified
                                        </c:otherwise>
                                    </c:choose>
                                </small>
                            </div>
                            <div class="col-md-6 text-md-end">
                                <small class="text-muted">
                                    <i class="bi bi-eye text-primary"></i> 
                                    <c:choose>
                                        <c:when test="${news.views != null}">
                                            <fmt:formatNumber value="${news.views}" type="number" maxFractionDigits="0"/>
                                        </c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                    views
                                </small>
                            </div>
                        </div>
                    </div>

                    <!-- News Title -->
                    <h1 class="display-5 mb-4">${news.title}</h1>

                    <!-- News Content -->
                    <div class="news-content mb-5">
                        <p class="lead">${news.description}</p>
                    </div>

                    <!-- Image Gallery -->
                    <c:if test="${not empty newsImages && newsImages.size() > 0}">
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-3">Gallery</h3>
                            <div class="position-relative">
                                <div class="gallery-container" id="galleryContainer">
                                    <c:forEach var="img" items="${newsImages}">
                                        <div class="gallery-item">
                                            <img class="img-preview" src="${img.imgURL}" alt="News Image" 
                                                 onclick="showImage(this.src, this.alt)">
                                        </div>
                                    </c:forEach>
                                </div>
                                <c:if test="${newsImages.size() > 4}">
                                    <button class="scroll-btn left" onclick="scrollGallery(-200)">◀</button>
                                    <button class="scroll-btn right" onclick="scrollGallery(200)">▶</button>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                    <!-- Image Overlay for Full View -->
                    <div class="image-overlay" id="imageOverlay">
                        <img id="largeImage" src="" alt="">
                    </div>

                    <!-- Share Section -->
                    <div class="bg-light p-4 rounded mb-5">
                        <h5 class="text-uppercase mb-3">Share This Article</h5>
                        <div class="share-buttons">
                            <a href="https://www.facebook.com/sharer/sharer.php?u=${pageContext.request.requestURL}" 
                               target="_blank" class="btn btn-primary btn-sm">
                                <i class="bi bi-facebook"></i> Facebook
                            </a>
                            <a href="https://twitter.com/intent/tweet?url=${pageContext.request.requestURL}&text=${news.title}" 
                               target="_blank" class="btn btn-info btn-sm text-white">
                                <i class="bi bi-twitter"></i> Twitter
                            </a>
                            <a href="mailto:?subject=${news.title}&body=Check out this article: ${pageContext.request.requestURL}" 
                               class="btn btn-secondary btn-sm">
                                <i class="bi bi-envelope"></i> Email
                            </a>
                            <button onclick="copyToClipboard()" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-clipboard"></i> Copy Link
                            </button>
                        </div>
                    </div>

                    <!-- Navigation -->
                    <div class="d-flex justify-content-between align-items-center">
                        <a href="news?action=viewListNews" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Back to News
                        </a>
                        <a href="#relatedNews" class="btn btn-primary">
                            View Related Articles <i class="bi bi-arrow-down"></i>
                        </a>
                    </div>
                </article>
            </div>

            <div class="col-lg-4">
                <!-- Sidebar -->
                <div class="mb-5">
                    <!-- Article Info -->
                    <div class="bg-light p-4 rounded mb-4">
                        <h3 class="text-uppercase mb-4">Article Information</h3>
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-calendar3 text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Published</h6>
                                <p class="mb-0">
                                    <c:choose>
                                        <c:when test="${news.dateCreated != null}">
                                            <fmt:parseDate value="${news.dateCreated}" pattern="yyyy-MM-dd" var="sidebarParsedDate" />
                                            <fmt:formatDate value="${sidebarParsedDate}" pattern="MM dd, yyyy"/>
                                        </c:when>
                                        <c:otherwise>
                                            Date not specified
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-eye text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Views</h6>
                                <p class="mb-0">
                                    <c:choose>
                                        <c:when test="${news.views != null}">
                                            <fmt:formatNumber value="${news.views}" type="number" maxFractionDigits="0"/>
                                        </c:when>
                                        <c:otherwise>0</c:otherwise>
                                    </c:choose>
                                    readers
                                </p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-tag text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Category</h6>
                                <p class="mb-0">Pet Care News</p>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <div class="bg-light p-4 rounded mb-4">
                        <h3 class="text-uppercase mb-4">Contact Us</h3>
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-telephone-fill text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Call Us</h6>
                                <p class="mb-0">0767658269</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-envelope-fill text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Email Us</h6>
                                <p class="mb-0">flexcarepplus@gmail.com</p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-geo-alt-fill text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Visit Us</h6>
                                <p class="mb-0">FPT City, Ngu Hanh Son, Da Nang</p>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div class="bg-light p-4 rounded mb-4">
                        <h3 class="text-uppercase mb-3">Quick Actions</h3>
                        <div class="d-grid gap-2">
                            <a href="service?action=viewListService" class="btn btn-primary">
                                <i class="bi bi-heart-pulse"></i> Browse Our Services
                            </a>
                            <c:if test="${not empty sessionScope.userDetailDTO}">
                                <a href="booking?action=viewCart" class="btn btn-outline-primary">
                                    <i class="bi bi-cart"></i> View My Cart
                                </a>
                                <a href="user?action=profile" class="btn btn-outline-secondary">
                                    <i class="bi bi-person"></i> My Profile
                                </a>
                            </c:if>
                            <c:if test="${empty sessionScope.userDetailDTO}">
                                <a href="${pageContext.request.contextPath}/sign-in" class="btn btn-outline-primary">
                                    <i class="bi bi-box-arrow-in-right"></i> Sign In
                                </a>
                            </c:if>
                        </div>
                    </div>

                    <!-- Related News -->
                    <div class="bg-light p-4 rounded" id="relatedNews">
                        <h3 class="text-uppercase mb-4">Related Articles</h3>
                        <c:choose>
                            <c:when test="${not empty relatedNews && relatedNews.size() > 0}">
                                <c:forEach var="relatedNewsItem" items="${relatedNews}">
                                    <div class="related-news-item d-flex mb-3 p-2 rounded">
                                        <img src="${relatedNewsItem.imgURL}" class="img-fluid rounded" alt="${relatedNewsItem.title}" 
                                             style="width: 80px; height: 60px; object-fit: cover;">
                                        <div class="ms-3 flex-grow-1">
                                            <h6 class="mb-1">
                                                <a href="news?action=viewNewsDetail&id=${relatedNewsItem.newsID}" 
                                                   class="text-decoration-none text-dark">
                                                    <c:choose>
                                                        <c:when test="${fn:length(relatedNewsItem.title) > 60}">
                                                            ${fn:substring(relatedNewsItem.title, 0, 60)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${relatedNewsItem.title}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </h6>
                                            <small class="text-muted">
                                                <i class="bi bi-calendar"></i> 
                                                <c:choose>
                                                    <c:when test="${relatedNewsItem.dateCreated != null}">
                                                        <fmt:parseDate value="${relatedNewsItem.dateCreated}" pattern="yyyy-MM-dd" var="relatedParsedDate" />
                                                        <fmt:formatDate value="${relatedParsedDate}" pattern="MM dd, yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        Date not specified
                                                    </c:otherwise>
                                                </c:choose>
                                            </small>
                                            <br>
                                            <small class="text-muted">
                                                <i class="bi bi-eye"></i> 
                                                <c:choose>
                                                    <c:when test="${relatedNewsItem.views != null}">
                                                        <fmt:formatNumber value="${relatedNewsItem.views}" type="number" maxFractionDigits="0"/>
                                                    </c:when>
                                                    <c:otherwise>0</c:otherwise>
                                                </c:choose>
                                                views
                                            </small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info text-center">
                                    <i class="bi bi-newspaper"></i>
                                    <p class="mb-0">No related articles available at the moment.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="text-center mt-3">
                            <a href="news?action=viewListNews" class="btn btn-outline-primary btn-sm">
                                View All News <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- News Detail End -->

<!-- Call to Action Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row g-5 align-items-center">
            <div class="col-md-6 text-white">
                <h1 class="display-5 text-uppercase mb-4">Ready to Care for Your Pet?</h1>
                <p class="fs-5 mb-4">Book our professional pet care services and give your furry friend the best treatment they deserve</p>
                <c:if test="${not empty sessionScope.userDetailDTO}">
                    <a href="service?action=viewListService" class="btn btn-light py-md-3 px-md-5 text-uppercase">Book Services Now</a>
                </c:if>
                <c:if test="${empty sessionScope.userDetailDTO}">
                    <a href="${pageContext.request.contextPath}/sign-in" class="btn btn-light py-md-3 px-md-5 text-uppercase">Join Us Today</a>
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

<script>
    // Image gallery functionality
    function showImage(src, alt) {
        const overlay = document.getElementById('imageOverlay');
        const largeImage = document.getElementById('largeImage');

        largeImage.src = src;
        largeImage.alt = alt;

        overlay.classList.add('active');
    }

    document.getElementById('imageOverlay').addEventListener('click', function (e) {
        if (e.target === this) {
            this.classList.remove('active');
        }
    });

    function scrollGallery(amount) {
        const container = document.getElementById('galleryContainer');
        container.scrollLeft += amount;
    }

    // Copy link functionality
    function copyToClipboard() {
        const url = window.location.href;
        navigator.clipboard.writeText(url).then(function() {
            // Show success message
            const btn = event.target.closest('button');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="bi bi-check"></i> Copied!';
            btn.classList.remove('btn-outline-secondary');
            btn.classList.add('btn-success');
            
            setTimeout(function() {
                btn.innerHTML = originalText;
                btn.classList.remove('btn-success');
                btn.classList.add('btn-outline-secondary');
            }, 2000);
        });
    }

    // Smooth scrolling for anchor links
    document.addEventListener('DOMContentLoaded', function() {
        const links = document.querySelectorAll('a[href^="#"]');
        links.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const targetId = this.getAttribute('href').substring(1);
                const targetElement = document.getElementById(targetId);
                if (targetElement) {
                    targetElement.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });
    });
</script>

<jsp:include page="/client/assets/layout/footer.jsp"/>
