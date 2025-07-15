<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">About Us</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="home">Home</a> / <span class="text-white">About</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->

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
                            <h6 class="text-primary text-uppercase">About FlexCareP+</h6>
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
                                            aria-selected="false">Our Vision</button>
                                </li>
                            </ul>
                            <div class="tab-content" id="pills-tabContent">                                <div class="tab-pane fade show active" id="pills-1" role="tabpanel" aria-labelledby="pills-1-tab">
                                    <p class="mb-0">To provide exceptional pet care services that enhance the bond between pets and their owners. We believe every pet deserves love, care, and professional attention to live their happiest and healthiest life.</p>
                                </div>
                                <div class="tab-pane fade" id="pills-2" role="tabpanel" aria-labelledby="pills-2-tab">
                                    <p class="mb-0">To become the leading pet care service provider in Vietnam, known for our compassionate care, professional expertise, and innovative approach to pet wellness and happiness.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>        <!-- About End -->

        <!-- Our Story Start -->
        <div class="container-fluid bg-light py-5">
            <div class="container">
                <div class="row gx-5">
                    <div class="col-lg-7">
                        <div class="border-start border-5 border-primary ps-5 mb-5">
                            <h6 class="text-primary text-uppercase">Our Story</h6>
                            <h1 class="display-5 text-uppercase mb-0">Founded With Love for Pets</h1>
                        </div>
                        <p class="mb-4">FlexCareP+ was founded in 2020 with a simple mission: to provide the best possible care for pets while making it convenient for pet owners. Our journey began when our founders realized the need for comprehensive, reliable, and loving pet care services in Vietnam.</p>
                        <p class="mb-4">Starting with just a small team of passionate pet lovers, we have grown to become a trusted name in pet care services. Our commitment to excellence and genuine love for animals has helped us build lasting relationships with pet owners throughout the region.</p>
                        <div class="row g-3">
                            <div class="col-sm-6">
                                <h6 class="mb-3"><i class="bi bi-check text-primary me-3"></i>Professional Care</h6>
                                <h6 class="mb-0"><i class="bi bi-check text-primary me-3"></i>24/7 Support</h6>
                            </div>
                            <div class="col-sm-6">
                                <h6 class="mb-3"><i class="bi bi-check text-primary me-3"></i>Experienced Staff</h6>
                                <h6 class="mb-0"><i class="bi bi-check text-primary me-3"></i>Affordable Prices</h6>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 mb-5 mb-lg-0" style="min-height: 500px;">
                        <div class="position-relative h-100">
                            <img class="position-absolute w-100 h-100 rounded" src="${pageContext.request.contextPath}/client/assets/img/about.jpg" style="object-fit: cover;">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Our Story End -->

        <!-- Statistics Start -->
        <div class="container-fluid py-5">
            <div class="container">
                <h2 class="text-center fw-bold mb-5" style="letter-spacing: 2px;">OUR ACHIEVEMENTS</h2>
                <div class="row text-center">
                    <div class="col-6 col-md-3 mb-4 mb-md-0">
                        <div class="bg-light p-4 rounded">
                            <h3 class="fw-bold text-primary">1200+</h3>
                            <div class="text-uppercase" style="font-size: 0.9rem;">PARVO CASES CURED</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3 mb-4 mb-md-0">
                        <div class="bg-light p-4 rounded">
                            <h3 class="fw-bold text-primary">700+</h3>
                            <div class="text-uppercase" style="font-size: 0.9rem;">SUCCESSFUL SURGERIES</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="bg-light p-4 rounded">
                            <h3 class="fw-bold text-primary">1700+</h3>
                            <div class="text-uppercase" style="font-size: 0.9rem;">STERILIZATION SURGERIES</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="bg-light p-4 rounded">
                            <h3 class="fw-bold text-primary">600+</h3>
                            <div class="text-uppercase" style="font-size: 0.9rem;">MONTHLY BEAUTY CARE</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Statistics End -->

        <!-- Why Choose Us Start -->
        <div class="container-fluid bg-light py-5">
            <div class="container">
                <div class="border-start border-5 border-primary ps-5 mb-5" style="max-width: 600px;">
                    <h6 class="text-primary text-uppercase">Why Choose Us</h6>
                    <h1 class="display-5 text-uppercase mb-0">What Makes Us Special</h1>
                </div>
                <div class="row g-5">
                    <div class="col-md-6">
                        <div class="service-item bg-white d-flex p-4 shadow-sm">
                            <i class="flaticon-house display-1 text-primary me-4"></i>
                            <div>
                                <h5 class="text-uppercase mb-3">Professional Team</h5>
                                <p>Our experienced veterinarians and pet care specialists are dedicated to providing the highest quality care for your beloved pets.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="service-item bg-white d-flex p-4 shadow-sm">
                            <i class="flaticon-food display-1 text-primary me-4"></i>
                            <div>
                                <h5 class="text-uppercase mb-3">Modern Facilities</h5>
                                <p>State-of-the-art equipment and clean, comfortable facilities ensure your pets receive the best possible care in a safe environment.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="service-item bg-white d-flex p-4 shadow-sm">
                            <i class="flaticon-grooming display-1 text-primary me-4"></i>
                            <div>
                                <h5 class="text-uppercase mb-3">Comprehensive Services</h5>
                                <p>From routine check-ups to emergency care, grooming to boarding, we offer a complete range of services for all your pet's needs.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="service-item bg-white d-flex p-4 shadow-sm">
                            <i class="flaticon-vaccine display-1 text-primary me-4"></i>
                            <div>
                                <h5 class="text-uppercase mb-3">Affordable Pricing</h5>
                                <p>Quality pet care shouldn't break the bank. We offer competitive pricing without compromising on the quality of our services.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Why Choose Us End -->

        <jsp:include page="/client/assets/layout/footer.jsp"/>
