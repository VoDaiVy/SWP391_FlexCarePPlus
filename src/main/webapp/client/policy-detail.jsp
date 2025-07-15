<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<style>
    .policy-content {
        line-height: 1.8;
        font-size: 1.1rem;
    }

    .policy-content p {
        margin-bottom: 1.5rem;
        text-align: justify;
    }    .policy-meta {
        border-left: 4px solid #0d6efd;
        padding-left: 1rem;
        background-color: #f8f9fa;
    }

    .related-policy-item:hover {
        transform: translateY(-2px);
        transition: all 0.3s ease;
    }

    .share-buttons .btn {
        margin-right: 0.5rem;
        margin-bottom: 0.5rem;
    }    
    
    .policy-header-icon {
        background: linear-gradient(135deg, #198754, #8ec24f);
        width: 80px;
        height: 80px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
        font-size: 2rem;
        margin-bottom: 2rem;
    }
</style>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-4 text-uppercase text-white mb-3">${policy.title}</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="home">Home</a> / <a class="text-white" href="policy?action=viewListPolicy">Policies</a> / <span class="text-white">Policy Detail</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

<!-- Policy Detail Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-8">
                <!-- Main Policy Content -->
                <article class="mb-5">
                    <!-- Policy Header Icon -->
                    <div class="text-center">
                        <div class="policy-header-icon mx-auto">
                            <i class="bi bi-shield-check"></i>
                        </div>
                    </div>

                    <!-- Policy Meta Information -->
                    <div class="policy-meta p-3 rounded mb-4">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <small class="text-muted">
                                    <i class="bi bi-calendar-event text-primary"></i> 
                                    Policy effective from 
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
                            <div class="col-md-4 text-md-end">                                <span class="badge bg-primary fs-6">
                                    <i class="bi bi-check-circle"></i> Active Policy
                                </span>
                            </div>
                        </div>
                    </div>

                    <!-- Policy Title -->
                    <h1 class="display-5 mb-4 text-primary">${policy.title}</h1>

                    <!-- Policy Content -->
                    <div class="policy-content mb-5">
                        <div class="bg-light p-4 rounded mb-4">
                            <h5 class="text-primary mb-3"><i class="bi bi-info-circle"></i> Policy Overview</h5>
                            <p class="lead">${policy.description}</p>
                        </div>

                        <!-- Additional Policy Sections (you can customize based on your needs) -->
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="bg-light p-4 rounded h-100">
                                    <h6 class="text-primary mb-3"><i class="bi bi-shield-fill-check"></i> Coverage</h6>
                                    <p class="mb-0">This policy covers all aspects mentioned in the description and applies to all services provided by FlexCare Pet Plus.</p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="bg-light p-4 rounded h-100">
                                    <h6 class="text-success mb-3"><i class="bi bi-clock-history"></i> Effective Period</h6>
                                    <p class="mb-0">This policy is effective immediately and will remain in force until updated or superseded by a new version.</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Share Section -->
                    <div class="bg-light p-4 rounded mb-5">
                        <h5 class="text-uppercase mb-3">Share This Policy</h5>
                        <div class="share-buttons">
                            <a href="https://www.facebook.com/sharer/sharer.php?u=${pageContext.request.requestURL}" 
                               target="_blank" class="btn btn-primary btn-sm">
                                <i class="bi bi-facebook"></i> Facebook
                            </a>
                            <a href="https://twitter.com/intent/tweet?url=${pageContext.request.requestURL}&text=${policy.title}" 
                               target="_blank" class="btn btn-info btn-sm text-white">
                                <i class="bi bi-twitter"></i> Twitter
                            </a>
                            <a href="mailto:?subject=${policy.title}&body=Check out this policy: ${pageContext.request.requestURL}" 
                               class="btn btn-secondary btn-sm">
                                <i class="bi bi-envelope"></i> Email
                            </a>
                            <button onclick="copyToClipboard()" class="btn btn-outline-secondary btn-sm">
                                <i class="bi bi-clipboard"></i> Copy Link
                            </button>
                        </div>
                    </div>

                    <!-- Navigation -->
                    <div class="d-flex justify-content-between align-items-center">                        <a href="policy?action=viewListPolicy" class="btn btn-outline-primary">
                            <i class="bi bi-arrow-left"></i> Back to Policies
                        </a>
                        <a href="#relatedPolicies" class="btn btn-primary">
                            View Related Policies <i class="bi bi-arrow-down"></i>
                        </a>
                    </div>
                </article>
            </div>

            <div class="col-lg-4">
                <!-- Sidebar -->
                <div class="mb-5">
                    <!-- Policy Info -->
                    <div class="bg-light p-4 rounded mb-4">
                        <h3 class="text-uppercase mb-4">Policy Information</h3>
                        <div class="d-flex align-items-center mb-3">
                            <i class="bi bi-calendar3 text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Effective Date</h6>
                                <p class="mb-0">
                                    <c:choose>
                                        <c:when test="${policy.dateCreated != null}">
                                            <fmt:parseDate value="${policy.dateCreated}" pattern="yyyy-MM-dd" var="sidebarParsedDate" />
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
                            <i class="bi bi-shield-check text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Status</h6>
                                <p class="mb-0">
                                    <span class="badge bg-success">Active</span>
                                </p>
                            </div>
                        </div>
                        <div class="d-flex align-items-center">
                            <i class="bi bi-tag text-primary me-3 fs-5"></i>
                            <div>
                                <h6 class="mb-1">Category</h6>
                                <p class="mb-0">Service Policy</p>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <div class="bg-light p-4 rounded mb-4">
                        <h3 class="text-uppercase mb-4">Questions About This Policy?</h3>
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
                        <div class="d-grid gap-2">                            <a href="service?action=viewListService" class="btn btn-primary">
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

                    <!-- Related Policies -->
                    <div class="bg-light p-4 rounded" id="relatedPolicies">
                        <h3 class="text-uppercase mb-4">Related Policies</h3>
                        <c:choose>
                            <c:when test="${not empty relatedPolicies && relatedPolicies.size() > 0}">
                                <c:forEach var="relatedPolicy" items="${relatedPolicies}">
                                    <div class="related-policy-item d-flex mb-3 p-2 rounded">
                                        <div class="bg-success text-white rounded-circle d-flex align-items-center justify-content-center me-3" 
                                             style="width: 50px; height: 50px; min-width: 50px;">
                                            <i class="bi bi-shield-check"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-1">
                                                <a href="policy?action=viewPolicyDetail&id=${relatedPolicy.policyID}" 
                                                   class="text-decoration-none text-dark">
                                                    <c:choose>
                                                        <c:when test="${fn:length(relatedPolicy.title) > 50}">
                                                            ${fn:substring(relatedPolicy.title, 0, 50)}...
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${relatedPolicy.title}
                                                        </c:otherwise>
                                                    </c:choose>
                                                </a>
                                            </h6>
                                            <small class="text-muted">
                                                <i class="bi bi-calendar"></i> 
                                                <c:choose>
                                                    <c:when test="${relatedPolicy.dateCreated != null}">
                                                        <fmt:parseDate value="${relatedPolicy.dateCreated}" pattern="yyyy-MM-dd" var="relatedParsedDate" />
                                                        <fmt:formatDate value="${relatedParsedDate}" pattern="MM dd, yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        Date not specified
                                                    </c:otherwise>
                                                </c:choose>
                                            </small>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-info text-center">
                                    <i class="bi bi-shield-exclamation"></i>
                                    <p class="mb-0">No related policies available at the moment.</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                        
                        <div class="text-center mt-3">                            <a href="policy?action=viewListPolicy" class="btn btn-outline-primary btn-sm">
                                View All Policies <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Policy Detail End -->

<!-- Call to Action Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row g-5 align-items-center">
            <div class="col-md-6 text-white">
                <h1 class="display-5 text-uppercase mb-4">Ready to Experience Our Services?</h1>
                <p class="fs-5 mb-4">Now that you understand our policies, book our professional pet care services with confidence</p>
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
