<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<!-- Hero Start -->
<div class="container-fluid bg-primary py-5 mb-5 hero-header">
    <div class="container py-5">
        <div class="row justify-content-start">
            <div class="col-lg-8 text-center text-lg-start">
                <h1 class="display-1 text-uppercase text-dark mb-lg-4">Pet Service</h1>
                <h1 class="text-uppercase text-white mb-lg-4">Make Your Pets Happy</h1>
                <p class="fs-4 text-white mb-lg-4">At FlexCareP+, we offer personalized pet care, grooming, and health services to keep your furry friends happy and healthy every day.</p>
                <div class="d-flex align-items-center justify-content-center justify-content-lg-start pt-5">
                    <a href="" class="btn btn-outline-light border-2 py-md-3 px-md-5 me-5">Read More</a>
                    <button type="button" class="btn-play" data-bs-toggle="modal"
                            data-src="https://www.youtube.com/embed/TyEaWGHfSKM" data-bs-target="#videoModal">
                        <span></span>
                    </button>
                    <h5 class="font-weight-normal text-white m-0 ms-4 d-none d-sm-block">Play Video</h5>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Hero End -->


<!-- Video Modal Start -->
<div class="modal fade" id="videoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content rounded-0">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Youtube Video</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <!-- 16:9 aspect ratio -->
                <div class="ratio ratio-16x9">
                    <iframe class="embed-responsive-item" src="" id="video" allowfullscreen allowscriptaccess="always"
                            allow="autoplay"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Video Modal End -->

<div class="container-fluid py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-bold mb-5" style="letter-spacing: 2px;">OUR CAPACITY</h2>
        <div class="row text-center">
            <div class="col-6 col-md-3 mb-4 mb-md-0">
                <h3 class="fw-bold">1200+</h3>
                <div class="text-uppercase" style="font-size: 1rem;">NUMBER OF PARVO CASES CURED</div>
            </div>
            <div class="col-6 col-md-3 mb-4 mb-md-0">
                <h3 class="fw-bold">700+</h3>
                <div class="text-uppercase" style="font-size: 1rem;">NUMBER OF SUCCESSFUL BONE SURGERIES</div>
            </div>
            <div class="col-6 col-md-3">
                <h3 class="fw-bold">1700+</h3>
                <div class="text-uppercase" style="font-size: 1rem;">NUMBER OF SUCCESSFUL STERILIZATION SURGERIES</div>
            </div>
            <div class="col-6 col-md-3">
                <h3 class="fw-bold">600+</h3>
                <div class="text-uppercase" style="font-size: 1rem;">PETS GET MONTHLY BEAUTY CARE</div>
            </div>
        </div>
    </div>
</div>

<!-- About Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="row gx-5">
            <div class="col-lg-5 mb-5 mb-lg-0" style="min-height: 500px;">
                <div class="position-relative h-100">
                    <img class="position-absolute w-100 h-100 rounded" src="${pageContext.request.contextPath}/client/assets/img/about.jpg" style="object-fit: cover;">
                </div>
            </div>
            <div class="col-lg-7">
                <div class="border-start border-5 border-primary ps-5 mb-5">
                    <h6 class="text-primary text-uppercase">About Us</h6>
                    <h1 class="display-5 text-uppercase mb-0">We Keep Your Pets Happy All Time</h1>
                </div>
                <h4 class="text-body mb-4">At FlexCareP+, we are dedicated to providing comprehensive care for your beloved pets. Our experienced team ensures every pet receives the attention, love, and professional services they deserve.</h4>
                <div class="bg-light p-4">
                    <ul class="nav nav-pills justify-content-between mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item w-50" role="presentation">
                            <button class="nav-link text-uppercase w-100 active" id="pills-1-tab" data-bs-toggle="pill"
                                    data-bs-target="#pills-1" type="button" role="tab" aria-controls="pills-1"
                                    aria-selected="true">Our Mission</button>
                        </li>
                        <li class="nav-item w-50" role="presentation">
                            <button class="nav-link text-uppercase w-100" id="pills-2-tab" data-bs-toggle="pill"
                                    data-bs-target="#pills-2" type="button" role="tab" aria-controls="pills-2"
                                    aria-selected="false">Our Vission</button>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-1" role="tabpanel" aria-labelledby="pills-1-tab">
                            <p class="mb-0">
                                Our mission is to deliver high-quality veterinary care, grooming, and wellness services to keep your pets healthy and happy. We strive to create a safe, friendly environment where every pet feels at home.
                                <br>
                                We are committed to continuous improvement and innovation in our services, ensuring that every pet receives personalized attention tailored to their unique needs. Our team believes that every animal deserves compassion, respect, and the best possible care throughout their life.
                            </p>
                        </div>
                        <div class="tab-pane fade" id="pills-2" role="tabpanel" aria-labelledby="pills-2-tab">
                            <p class="mb-0">
                                Our vision is to become the leading pet care provider in the region, known for our compassion, expertise, and commitment to animal welfare. We aim to build lasting relationships with our clients and their pets through trust and excellence.
                                <br>
                                We envision a future where every pet enjoys a healthy, joyful life alongside their family. By fostering a culture of learning and collaboration, we aspire to set new standards in pet care and inspire positive change in our community.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- About End -->


<!-- Services Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="border-start border-5 border-primary ps-5 mb-5" style="max-width: 600px;">
            <h6 class="text-primary text-uppercase">Services</h6>
            <h1 class="display-5 text-uppercase mb-0">Our Excellent Pet Care Services</h1>
        </div>
        <div class="row g-5">
            <div class="col-md-6">
                <div class="service-item bg-light d-flex p-4">
                    <i class="flaticon-house display-1 text-primary me-4"></i>
                    <div>
                        <h5 class="text-uppercase mb-3">Pet Boarding</h5>
                        <p>Kasd dolor no lorem sit tempor at justo rebum rebum stet justo elitr dolor amet sit</p>
                        <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service-item bg-light d-flex p-4">
                    <i class="flaticon-food display-1 text-primary me-4"></i>
                    <div>
                        <h5 class="text-uppercase mb-3">Pet Feeding</h5>
                        <p>Kasd dolor no lorem sit tempor at justo rebum rebum stet justo elitr dolor amet sit</p>
                        <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service-item bg-light d-flex p-4">
                    <i class="flaticon-grooming display-1 text-primary me-4"></i>
                    <div>
                        <h5 class="text-uppercase mb-3">Pet Grooming</h5>
                        <p>Kasd dolor no lorem sit tempor at justo rebum rebum stet justo elitr dolor amet sit</p>
                        <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service-item bg-light d-flex p-4">
                    <i class="flaticon-cat display-1 text-primary me-4"></i>
                    <div>
                        <h5 class="text-uppercase mb-3">Pet Training</h5>
                        <p>Kasd dolor no lorem sit tempor at justo rebum rebum stet justo elitr dolor amet sit</p>
                        <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service-item bg-light d-flex p-4">
                    <i class="flaticon-dog display-1 text-primary me-4"></i>
                    <div>
                        <h5 class="text-uppercase mb-3">Pet Exercise</h5>
                        <p>Kasd dolor no lorem sit tempor at justo rebum rebum stet justo elitr dolor amet sit</p>
                        <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="service-item bg-light d-flex p-4">
                    <i class="flaticon-vaccine display-1 text-primary me-4"></i>
                    <div>
                        <h5 class="text-uppercase mb-3">Pet Treatment</h5>
                        <p>Kasd dolor no lorem sit tempor at justo rebum rebum stet justo elitr dolor amet sit</p>
                        <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                    </div>
                </div>
            </div>
            <c:forEach var="service" items="${serviceList}">
                <div class="col-md-6">
                    <div class="service-item bg-light d-flex p-4">
                        <img class="me-4" src="${service.imgURL}" alt="${service.name}" style="width:64px;height:64px;object-fit:cover;">
                        <div>
                            <h5 class="text-uppercase mb-3">${service.name}</h5>
                            <p>
                                <c:choose>
                                    <c:when test="${fn:length(service.description) > 50}">
                                        ${fn:substring(service.description, 0, 50)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${service.description}
                                    </c:otherwise>
                                </c:choose>
                            </p>
                            <a class="text-primary text-uppercase" href="service?action=viewDetail&id=${service.serviceID}">
                                Read More <i class="bi bi-chevron-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<!-- Services End -->

<!-- Team Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="border-start border-5 border-primary ps-5 mb-5" style="max-width: 600px;">
            <h6 class="text-primary text-uppercase">Team Members</h6>
            <h1 class="display-5 text-uppercase mb-0">Qualified Pets Care Professionals</h1>
        </div>
        <div class="owl-carousel team-carousel position-relative" style="padding-right: 25px;">
            <div class="team-item">
                <div class="position-relative overflow-hidden">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/client/assets/img/team-1.jpg" alt="">
                    <div class="team-overlay">
                        <div class="d-flex align-items-center justify-content-start">
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-twitter"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>
                <div class="bg-light text-center p-4">
                    <h5 class="text-uppercase">Full Name</h5>
                    <p class="m-0">Designation</p>
                </div>
            </div>
            <div class="team-item">
                <div class="position-relative overflow-hidden">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/client/assets/img/team-2.jpg" alt="">
                    <div class="team-overlay">
                        <div class="d-flex align-items-center justify-content-start">
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-twitter"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>
                <div class="bg-light text-center p-4">
                    <h5 class="text-uppercase">Full Name</h5>
                    <p class="m-0">Designation</p>
                </div>
            </div>
            <div class="team-item">
                <div class="position-relative overflow-hidden">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/client/assets/img/team-3.jpg" alt="">
                    <div class="team-overlay">
                        <div class="d-flex align-items-center justify-content-start">
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-twitter"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>
                <div class="bg-light text-center p-4">
                    <h5 class="text-uppercase">Full Name</h5>
                    <p class="m-0">Designation</p>
                </div>
            </div>
            <div class="team-item">
                <div class="position-relative overflow-hidden">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/client/assets/img/team-4.jpg" alt="">
                    <div class="team-overlay">
                        <div class="d-flex align-items-center justify-content-start">
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-twitter"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>
                <div class="bg-light text-center p-4">
                    <h5 class="text-uppercase">Full Name</h5>
                    <p class="m-0">Designation</p>
                </div>
            </div>
            <div class="team-item">
                <div class="position-relative overflow-hidden">
                    <img class="img-fluid w-100" src="${pageContext.request.contextPath}/client/assets/img/team-5.jpg" alt="">
                    <div class="team-overlay">
                        <div class="d-flex align-items-center justify-content-start">
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-twitter"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-light btn-square mx-1" href="#"><i class="bi bi-linkedin"></i></a>
                        </div>
                    </div>
                </div>
                <div class="bg-light text-center p-4">
                    <h5 class="text-uppercase">Full Name</h5>
                    <p class="m-0">Designation</p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Team End -->


<!-- Testimonial Start -->
<div class="container-fluid bg-testimonial py-5" style="margin: 45px 0;">
    <div class="container py-5">
        <div class="row justify-content-end">
            <div class="col-lg-7">
                <div class="owl-carousel testimonial-carousel bg-white p-5">
                    <div class="testimonial-item text-center">
                        <div class="position-relative mb-4">
                            <img class="img-fluid mx-auto" src="${pageContext.request.contextPath}/client/assets/img/testimonial-1.jpg" alt="">
                            <div class="position-absolute top-100 start-50 translate-middle d-flex align-items-center justify-content-center bg-white" style="width: 45px; height: 45px;">
                                <i class="bi bi-chat-square-quote text-primary"></i>
                            </div>
                        </div>
                        <p>Dolores sed duo clita tempor justo dolor et stet lorem kasd labore dolore lorem ipsum. At lorem lorem magna ut et, nonumy et labore et tempor diam tempor erat. Erat dolor rebum sit ipsum.</p>
                        <hr class="w-25 mx-auto">
                        <h5 class="text-uppercase">Client Name</h5>
                        <span>Profession</span>
                    </div>
                    <div class="testimonial-item text-center">
                        <div class="position-relative mb-4">
                            <img class="img-fluid mx-auto" src="${pageContext.request.contextPath}/client/assets/img/testimonial-2.jpg" alt="">
                            <div class="position-absolute top-100 start-50 translate-middle d-flex align-items-center justify-content-center bg-white" style="width: 45px; height: 45px;">
                                <i class="bi bi-chat-square-quote text-primary"></i>
                            </div>
                        </div>
                        <p>Dolores sed duo clita tempor justo dolor et stet lorem kasd labore dolore lorem ipsum. At lorem lorem magna ut et, nonumy et labore et tempor diam tempor erat. Erat dolor rebum sit ipsum.</p>
                        <hr class="w-25 mx-auto">
                        <h5 class="text-uppercase">Client Name</h5>
                        <span>Profession</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Testimonial End -->


<!-- News Start -->
<div class="container-fluid py-5">
    <div class="container">
        <div class="border-start border-5 border-primary ps-5 mb-5" style="max-width: 600px;">
            <h6 class="text-primary text-uppercase">Latest News</h6>
            <h1 class="display-5 text-uppercase mb-0">Latest Articles From Our News Post</h1>
        </div>
        <div class="row g-5">
            <div class="col-lg-6">
                <div class="blog-item">
                    <div class="row g-0 bg-light overflow-hidden">
                        <div class="col-12 col-sm-5 h-100">
                            <img class="img-fluid h-100" src="${pageContext.request.contextPath}/client/assets/img/blog-1.jpg" style="object-fit: cover;">
                        </div>
                        <div class="col-12 col-sm-7 h-100 d-flex flex-column justify-content-center">
                            <div class="p-4">
                                <div class="d-flex mb-3">
                                    <small class="me-3"><i class="bi bi-bookmarks me-2"></i>Web Design</small>
                                    <small><i class="bi bi-calendar-date me-2"></i>01 Jan, 2045</small>
                                </div>
                                <h5 class="text-uppercase mb-3">Dolor sit magna rebum clita rebum dolor</h5>
                                <p>Ipsum sed lorem amet dolor amet duo ipsum amet et dolore est stet tempor eos dolor</p>
                                <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="blog-item">
                    <div class="row g-0 bg-light overflow-hidden">
                        <div class="col-12 col-sm-5 h-100">
                            <img class="img-fluid h-100" src="${pageContext.request.contextPath}/client/assets/img/blog-2.jpg" style="object-fit: cover;">
                        </div>
                        <div class="col-12 col-sm-7 h-100 d-flex flex-column justify-content-center">
                            <div class="p-4">
                                <div class="d-flex mb-3">
                                    <small class="me-3"><i class="bi bi-bookmarks me-2"></i>Web Design</small>
                                    <small><i class="bi bi-calendar-date me-2"></i>01 Jan, 2045</small>
                                </div>
                                <h5 class="text-uppercase mb-3">Dolor sit magna rebum clita rebum dolor</h5>
                                <p>Ipsum sed lorem amet dolor amet duo ipsum amet et dolore est stet tempor eos dolor</p>
                                <a class="text-primary text-uppercase" href="">Read More<i class="bi bi-chevron-right"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <c:forEach var="news" items="${newsList}">
                <div class="col-lg-6">
                    <div class="blog-item">
                        <div class="row g-0 bg-light overflow-hidden">
                            <div class="col-12 col-sm-5 h-100">
                                <img class="img-fluid h-100" src="${news.imgURL}" alt="${news.title}" style="object-fit: cover;">
                            </div>
                            <div class="col-12 col-sm-7 h-100 d-flex flex-column justify-content-center">
                                <div class="p-4">
                                    <small class="me-3">
                                        <i class="bi bi-calendar-date me-2"></i>
                                        <c:out value="${news.dateCreated}"/>
                                    </small>
                                    <h5 class="text-uppercase mb-3">${news.title}</h5>
                                    <p>
                                        <c:choose>
                                            <c:when test="${fn:length(news.description) > 120}">
                                                ${fn:substring(news.description, 0, 120)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${news.description}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <a class="text-primary text-uppercase" href="news?action=viewdetail&id=${news.newsID}">
                                        Read More <i class="bi bi-chevron-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<jsp:include page="/client/assets/layout/footer.jsp"/>