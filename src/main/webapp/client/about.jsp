<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <title>FlexCarePPlus - About Us</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Favicon -->
        <link href="${pageContext.request.contextPath}/client/assets/img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Poppins&family=Roboto:wght@700&display=swap" rel="stylesheet">  

        <!-- Icon Font Stylesheet -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/client/assets/lib/flaticon/font/flaticon.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="${pageContext.request.contextPath}/client/assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="${pageContext.request.contextPath}/client/assets/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="${pageContext.request.contextPath}/client/assets/css/style.css" rel="stylesheet">
    </head>

    <body>
        <!-- Topbar Start -->
        <div class="container-fluid border-bottom d-none d-lg-block">
            <div class="row gx-0">
                <div class="col-lg-4 text-center py-2">
                    <div class="d-inline-flex align-items-center">
                        <i class="bi bi-geo-alt fs-1 text-primary me-3"></i>
                        <div class="text-start">
                            <h6 class="text-uppercase mb-1">Our Office</h6>
                            <span>123 Street, FPT University, Vietnam</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 text-center border-start border-end py-2">
                    <div class="d-inline-flex align-items-center">
                        <i class="bi bi-envelope-open fs-1 text-primary me-3"></i>
                        <div class="text-start">
                            <h6 class="text-uppercase mb-1">Email Us</h6>
                            <span>flexcareplus@example.com</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 text-center py-2">
                    <div class="d-inline-flex align-items-center">
                        <i class="bi bi-phone-vibrate fs-1 text-primary me-3"></i>
                        <div class="text-start">
                            <h6 class="text-uppercase mb-1">Call Us</h6>
                            <span>+012 345 6789</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Topbar End -->

        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg bg-white navbar-light shadow-sm py-3 py-lg-0 px-3 px-lg-0">
            <a href="${pageContext.request.contextPath}/client/homepage.jsp" class="navbar-brand ms-lg-5">
                <h1 class="m-0 text-uppercase text-dark"><i class="bi bi-shop fs-1 text-primary me-3"></i>FlexCarePPlus</h1>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0">
                    <a href="${pageContext.request.contextPath}/client/homepage.jsp" class="nav-item nav-link">Home</a>
                    <a href="${pageContext.request.contextPath}/client/about.jsp" class="nav-item nav-link active">About</a>
                    <a href="${pageContext.request.contextPath}/client/service.jsp" class="nav-item nav-link">Service</a>
                    <a href="${pageContext.request.contextPath}/client/product.jsp" class="nav-item nav-link">Product</a>
                    <div class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/client/price.jsp" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">Pages</a>
                        <div class="dropdown-menu m-0">
                            <a href="${pageContext.request.contextPath}/client/price.jsp" class="dropdown-item">Pricing Plan</a>
                            <a href="${pageContext.request.contextPath}/client/team.jsp" class="dropdown-item">The Team</a>
                            <a href="${pageContext.request.contextPath}/client/testimonial.jsp" class="dropdown-item">Testimonial</a>
                            <a href="${pageContext.request.contextPath}/client/blog.jsp" class="dropdown-item">Blog Grid</a>
                            <a href="${pageContext.request.contextPath}/client/detail.jsp" class="dropdown-item">Blog Detail</a>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/client/contact.jsp" class="nav-item nav-link nav-contact bg-primary text-white px-5 ms-lg-5">Contact <i class="bi bi-arrow-right"></i></a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

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
                        <h4 class="text-body mb-4">Diam dolor diam ipsum tempor sit. Clita erat ipsum et lorem stet no labore lorem sit clita duo justo magna dolore</h4>
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
                            <div class="tab-content" id="pills-tabContent">
                                <div class="tab-pane fade show active" id="pills-1" role="tabpanel" aria-labelledby="pills-1-tab">
                                    <p class="mb-0">Tempor erat elitr at rebum at at clita aliquyam consetetur. Diam dolor diam ipsum et, tempor voluptua sit consetetur sit. Aliquyam diam amet diam et eos sadipscing labore. Clita erat ipsum et lorem et sit, sed stet no labore lorem sit. Sanctus clita duo justo et tempor consetetur takimata eirmod, dolores takimata consetetur invidunt magna dolores aliquyam dolores dolore. Amet erat amet et magna</p>
                                </div>
                                <div class="tab-pane fade" id="pills-2" role="tabpanel" aria-labelledby="pills-2-tab">
                                    <p class="mb-0">Tempor erat elitr at rebum at at clita aliquyam consetetur. Diam dolor diam ipsum et, tempor voluptua sit consetetur sit. Aliquyam diam amet diam et eos sadipscing labore. Clita erat ipsum et lorem et sit, sed stet no labore lorem sit. Sanctus clita duo justo et tempor consetetur takimata eirmod, dolores takimata consetetur invidunt magna dolores aliquyam dolores dolore. Amet erat amet et magna</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- About End -->

        <!-- Footer Start -->
        <div class="container-fluid bg-light mt-5 py-5">
            <div class="container pt-5">
                <div class="row g-5">
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Get In Touch</h5>
                        <p class="mb-4">No dolore ipsum accusam no lorem. Invidunt sed clita kasd clita et et dolor sed dolor</p>
                        <p class="mb-2"><i class="bi bi-geo-alt text-primary me-2"></i>123 Street, FPT University, Vietnam</p>
                        <p class="mb-2"><i class="bi bi-envelope-open text-primary me-2"></i>flexcareplus@example.com</p>
                        <p class="mb-0"><i class="bi bi-telephone text-primary me-2"></i>+012 345 67890</p>
                    </div>                <div class="col-lg-3 col-md-6">
                        <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Quick Links</h5>
                        <div class="d-flex flex-column justify-content-start">
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/homepage.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Home</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/about.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>About Us</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/service.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Our Services</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/team.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Meet The Team</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/blog.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Latest Blog</a>
                            <a class="text-body" href="${pageContext.request.contextPath}/client/contact.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Contact Us</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Popular Links</h5>
                        <div class="d-flex flex-column justify-content-start">
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/homepage.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Home</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/about.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>About Us</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/service.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Our Services</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/team.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Meet The Team</a>
                            <a class="text-body mb-2" href="${pageContext.request.contextPath}/client/blog.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Latest Blog</a>
                            <a class="text-body" href="${pageContext.request.contextPath}/client/contact.jsp"><i class="bi bi-arrow-right text-primary me-2"></i>Contact Us</a>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <h5 class="text-uppercase border-start border-5 border-primary ps-3 mb-4">Newsletter</h5>
                        <form action="">
                            <div class="input-group">
                                <input type="text" class="form-control p-3" placeholder="Your Email">
                                <button class="btn btn-primary">Sign Up</button>
                            </div>
                        </form>
                        <h6 class="text-uppercase mt-4 mb-3">Follow Us</h6>                    <div class="d-flex">
                            <a class="btn btn-outline-primary btn-square me-2" href="${pageContext.request.contextPath}/client/about.jsp"><i class="bi bi-twitter"></i></a>
                            <a class="btn btn-outline-primary btn-square me-2" href="${pageContext.request.contextPath}/client/about.jsp"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-outline-primary btn-square me-2" href="${pageContext.request.contextPath}/client/about.jsp"><i class="bi bi-linkedin"></i></a>
                            <a class="btn btn-outline-primary btn-square" href="${pageContext.request.contextPath}/client/about.jsp"><i class="bi bi-instagram"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid bg-dark text-white-50 py-4">
            <div class="container">
                <div class="row g-5">
                    <div class="col-md-6 text-center text-md-start">
                        <p class="mb-md-0">&copy; <a class="text-white" href="${pageContext.request.contextPath}/client/homepage.jsp">FlexCarePPlus</a>. All Rights Reserved.</p>
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <p class="mb-0">Designed by <a class="text-white" href="https://htmlcodex.com">HTML Codex</a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->    <!-- Back to Top -->
        <a href="${pageContext.request.contextPath}/client/about.jsp" class="btn btn-primary py-3 fs-4 back-to-top" style="position: fixed; right: 30px; bottom: 30px; z-index: 999; box-shadow: 0 5px 20px rgba(0,0,0,0.25); opacity: 0.95; background-color: #6da835 !important; border-color: #6da835 !important; border-radius: 50%; width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; padding: 0;"><i class="bi bi-arrow-up"></i></a>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/client/assets/lib/easing/easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/client/assets/lib/waypoints/waypoints.min.js"></script>
        <script src="${pageContext.request.contextPath}/client/assets/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="${pageContext.request.contextPath}/client/assets/js/main.js"></script>
    </body>

</html>
