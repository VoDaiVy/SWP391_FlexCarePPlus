<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FlexCarePPlus - Pet Care Service</title>
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
                    <a href="${pageContext.request.contextPath}/client/about.jsp" class="nav-item nav-link">About</a>
                    <a href="${pageContext.request.contextPath}/client/service.jsp" class="nav-item nav-link">Service</a>
                    <a href="${pageContext.request.contextPath}/client/product.jsp" class="nav-item nav-link">Product</a>
                    <div class="nav-item dropdown">
                        <a href="${pageContext.request.contextPath}/client/price.jsp" class="nav-link dropdown-toggle active" data-bs-toggle="dropdown">Pages</a>
                        <div class="dropdown-menu m-0">
                            <a href="${pageContext.request.contextPath}/client/price.jsp" class="dropdown-item">Pricing Plan</a>
                            <a href="${pageContext.request.contextPath}/client/team.jsp" class="dropdown-item">The Team</a>
                            <a href="${pageContext.request.contextPath}/client/testimonial.jsp" class="dropdown-item">Testimonial</a>
                            <a href="${pageContext.request.contextPath}/client/blog.jsp" class="dropdown-item">Blog Grid</a>
                            <a href="${pageContext.request.contextPath}/client/detail.jsp" class="dropdown-item active">Blog Detail</a>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/client/contact.jsp" class="nav-item nav-link">Contact</a>
                    <a href="${pageContext.request.contextPath}/client/login.jsp" class="nav-item nav-link nav-contact bg-primary text-white px-5 ms-lg-5">Login <i class="bi bi-arrow-right"></i></a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

        <!-- Blog Detail Start -->
        <div class="container-fluid py-5">
            <div class="container">
                <div class="row g-5">
                    <div class="col-lg-8">
                        <!-- Blog Detail Start -->
                        <div class="mb-5">
                            <img class="img-fluid w-100 rounded mb-5" src="${pageContext.request.contextPath}/client/assets/img/blog-1.jpg" alt="">
                            <h1 class="text-uppercase mb-4">Essential Pet Grooming Tips for a Healthy Coat</h1>
                            <div class="d-flex mb-4">
                                <div class="text-muted me-4">
                                    <i class="bi bi-person me-2"></i>Admin
                                </div>
                                <div class="text-muted me-4">
                                    <i class="bi bi-calendar-date me-2"></i>01 Jan, 2023
                                </div>
                                <div class="text-muted">
                                    <i class="bi bi-chat-dots me-2"></i>8 Comments
                                </div>
                            </div>
                            <p>Regular grooming is not just about keeping your pet looking good; it's an essential part of their overall health care routine. A well-groomed pet is a healthier and happier pet. Whether you have a dog, cat, or other furry friend, establishing a regular grooming schedule helps prevent skin problems, allows early detection of health issues, and strengthens the bond between you and your pet.</p>
                            <p>Here are some essential grooming tips to help maintain your pet's coat in optimal condition:</p>
                            <h2 class="text-uppercase mt-4 mb-3">Brushing Techniques</h2>
                            <p>The type of brush you use depends on your pet's coat. For short-haired pets, a soft bristle brush or rubber grooming mitt works well. For long-haired pets, a slicker brush helps remove tangles, and a rake-type tool helps with the undercoat. Brush in the direction of hair growth, being gentle around sensitive areas. Regular brushing removes dead hair, distributes natural oils, and prevents matting.</p>
                            <h2 class="text-uppercase mt-4 mb-3">Bathing Your Pet</h2>
                            <p>Most pets don't need frequent baths — once a month is typically sufficient unless they get particularly dirty or have a skin condition that requires special shampoo. Always use pet-specific shampoos, as human products can irritate their skin. Before bathing, brush your pet to remove tangles, which become worse when wet. Make sure the water is lukewarm, not hot, and avoid getting water in their ears and eyes.</p>
                            <img class="img-fluid w-100 rounded my-4" src="${pageContext.request.contextPath}/client/assets/img/blog-2.jpg" alt="">
                            <h2 class="text-uppercase mt-4 mb-3">Nail Care</h2>
                            <p>Trimming your pet's nails is important to prevent them from becoming too long, which can cause discomfort and potential health issues. If you can hear your pet's nails clicking on hard floors, they're likely due for a trim. Be careful not to cut into the quick (the pink part of the nail that contains blood vessels). If you're unsure about doing this yourself, ask your veterinarian or a professional groomer to show you how.</p>
                            <h2 class="text-uppercase mt-4 mb-3">Ear and Eye Cleaning</h2>
                            <p>Check your pet's ears weekly for signs of infection such as redness, swelling, or discharge. Clean the outer ear with a pet-specific ear cleaner and cotton ball — never use cotton swabs, which can damage the ear canal. For eyes, gently wipe away any discharge with a damp cotton ball, being careful not to touch the eye itself. If you notice persistent issues, consult your veterinarian.</p>
                            <h2 class="text-uppercase mt-4 mb-3">Dental Hygiene</h2>
                            <p>Dental care is often overlooked but is crucial for your pet's overall health. Ideally, you should brush your pet's teeth daily using pet-specific toothpaste (human toothpaste can be toxic to pets). There are also dental chews, water additives, and toys designed to help maintain dental health. Regular veterinary dental check-ups are also important.</p>
                            <h2 class="text-uppercase mt-4 mb-3">Professional Grooming</h2>
                            <p>While regular at-home grooming is essential, professional grooming sessions every few months can be beneficial, especially for pets with high-maintenance coats. Professional groomers can handle more complex tasks like trimming hair around sensitive areas, expressing anal glands, and dealing with severe matting.</p>
                            <p>By incorporating these grooming practices into your pet care routine, you'll help ensure your furry friend stays healthy, comfortable, and looking their best. Remember, grooming time is also an opportunity to check for any unusual bumps, sores, or parasites, allowing you to address potential health issues before they become serious.</p>
                        </div>
                        <!-- Blog Detail End -->

                        <!-- Comment List Start -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4">8 Comments</h3>
                            <div class="d-flex mb-4">
                                <img src="${pageContext.request.contextPath}/client/assets/img/user.jpg" class="img-fluid rounded-circle" style="width: 45px; height: 45px;" alt="">
                                <div class="ps-3">
                                    <h6><a href="">John Doe</a> <small><i>01 Jan 2023</i></small></h6>
                                    <p>Thank you for these tips! I've been struggling with my long-haired cat's matting issues, and the brushing techniques you suggested have been a game-changer.</p>
                                    <button class="btn btn-sm btn-primary">Reply</button>
                                </div>
                            </div>
                            <div class="d-flex mb-4">
                                <img src="${pageContext.request.contextPath}/client/assets/img/user.jpg" class="img-fluid rounded-circle" style="width: 45px; height: 45px;" alt="">
                                <div class="ps-3">
                                    <h6><a href="">Sarah Johnson</a> <small><i>01 Jan 2023</i></small></h6>
                                    <p>Could you recommend specific brands of pet shampoo for dogs with sensitive skin? My golden retriever gets itchy after baths with regular shampoo.</p>
                                    <button class="btn btn-sm btn-primary">Reply</button>
                                </div>
                            </div>
                            <div class="d-flex ms-5 mb-4">
                                <img src="${pageContext.request.contextPath}/client/assets/img/user.jpg" class="img-fluid rounded-circle" style="width: 45px; height: 45px;" alt="">
                                <div class="ps-3">
                                    <h6><a href="">Admin</a> <small><i>01 Jan 2023</i></small></h6>
                                    <p>Hi Sarah! For dogs with sensitive skin, we recommend hypoallergenic or oatmeal-based shampoos. Brands like Earthbath, Burt's Bees, and Veterinary Formula Clinical Care have good options. It's also worth checking with your vet for specific recommendations based on your dog's skin condition.</p>
                                    <button class="btn btn-sm btn-primary">Reply</button>
                                </div>
                            </div>
                            <div class="d-flex mb-4">
                                <img src="${pageContext.request.contextPath}/client/assets/img/user.jpg" class="img-fluid rounded-circle" style="width: 45px; height: 45px;" alt="">
                                <div class="ps-3">
                                    <h6><a href="">Michael Brown</a> <small><i>01 Jan 2023</i></small></h6>
                                    <p>I've always been nervous about trimming my dog's nails. Do you offer nail trimming services at your facility? I'd rather leave it to professionals.</p>
                                    <button class="btn btn-sm btn-primary">Reply</button>
                                </div>
                            </div>
                        </div>
                        <!-- Comment List End -->

                        <!-- Comment Form Start -->
                        <div class="bg-light rounded p-5">
                            <h3 class="text-uppercase mb-4">Leave a comment</h3>
                            <form>
                                <div class="row g-3">
                                    <div class="col-12 col-sm-6">
                                        <input type="text" class="form-control bg-white border-0" placeholder="Your Name" style="height: 55px;">
                                    </div>
                                    <div class="col-12 col-sm-6">
                                        <input type="email" class="form-control bg-white border-0" placeholder="Your Email" style="height: 55px;">
                                    </div>
                                    <div class="col-12">
                                        <input type="text" class="form-control bg-white border-0" placeholder="Website" style="height: 55px;">
                                    </div>
                                    <div class="col-12">
                                        <textarea class="form-control bg-white border-0" rows="5" placeholder="Comment"></textarea>
                                    </div>
                                    <div class="col-12">
                                        <button class="btn btn-primary w-100 py-3" type="submit">Leave Your Comment</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <!-- Comment Form End -->
                    </div>

                    <!-- Sidebar Start -->
                    <div class="col-lg-4">
                        <!-- Search Form Start -->
                        <div class="mb-5">
                            <div class="input-group">
                                <input type="text" class="form-control p-3" placeholder="Search">
                                <button class="btn btn-primary px-4"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                        <!-- Search Form End -->                    <!-- Category Start -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4">Categories</h3>
                            <div class="d-flex flex-column justify-content-start">
                                <a class="h5 bg-light py-2 px-3 mb-2" href="${pageContext.request.contextPath}/client/blog.jsp"><i class="bi bi-arrow-right me-2"></i>Pet Health</a>
                                <a class="h5 bg-light py-2 px-3 mb-2" href="${pageContext.request.contextPath}/client/blog.jsp"><i class="bi bi-arrow-right me-2"></i>Nutrition</a>
                                <a class="h5 bg-light py-2 px-3 mb-2" href="${pageContext.request.contextPath}/client/blog.jsp"><i class="bi bi-arrow-right me-2"></i>Training</a>
                                <a class="h5 bg-light py-2 px-3 mb-2" href="${pageContext.request.contextPath}/client/blog.jsp"><i class="bi bi-arrow-right me-2"></i>Grooming</a>
                                <a class="h5 bg-light py-2 px-3 mb-2" href="${pageContext.request.contextPath}/client/blog.jsp"><i class="bi bi-arrow-right me-2"></i>Pet Care</a>
                            </div>
                        </div>
                        <!-- Category End -->

                        <!-- Recent Post Start -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4">Recent Posts</h3>
                            <div class="d-flex mb-3">
                                <img class="img-fluid" src="${pageContext.request.contextPath}/client/assets/img/blog-1.jpg" style="width: 100px; height: 100px; object-fit: cover;" alt="">
                                <a href="" class="h5 d-flex align-items-center bg-light px-3 mb-0">Essential Pet Grooming Tips
                                </a>
                            </div>
                            <div class="d-flex mb-3">
                                <img class="img-fluid" src="${pageContext.request.contextPath}/client/assets/img/blog-2.jpg" style="width: 100px; height: 100px; object-fit: cover;" alt="">
                                <a href="" class="h5 d-flex align-items-center bg-light px-3 mb-0">Nutrition Guide for Pets
                                </a>
                            </div>
                            <div class="d-flex mb-3">
                                <img class="img-fluid" src="${pageContext.request.contextPath}/client/assets/img/blog-3.jpg" style="width: 100px; height: 100px; object-fit: cover;" alt="">
                                <a href="" class="h5 d-flex align-items-center bg-light px-3 mb-0">Pet Training 101
                                </a>
                            </div>
                        </div>
                        <!-- Recent Post End -->

                        <!-- Tags Start -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4">Tag Cloud</h3>
                            <div class="d-flex flex-wrap m-n1">
                                <a href="" class="btn btn-outline-primary m-1">Dogs</a>
                                <a href="" class="btn btn-outline-primary m-1">Cats</a>
                                <a href="" class="btn btn-outline-primary m-1">Grooming</a>
                                <a href="" class="btn btn-outline-primary m-1">Health</a>
                                <a href="" class="btn btn-outline-primary m-1">Training</a>
                                <a href="" class="btn btn-outline-primary m-1">Food</a>
                                <a href="" class="btn btn-outline-primary m-1">Exercise</a>
                                <a href="" class="btn btn-outline-primary m-1">Care</a>
                            </div>
                        </div>
                        <!-- Tags End -->
                    </div>
                    <!-- Sidebar End -->
                </div>
            </div>
        </div>
        <!-- Blog Detail End -->

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
                    </div>                <div class="col-lg-3 col-md-6">
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
                        <h6 class="text-uppercase mt-4 mb-3">Follow Us</h6>
                        <div class="d-flex">
                            <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-twitter"></i></a>
                            <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-facebook"></i></a>
                            <a class="btn btn-outline-primary btn-square me-2" href="#"><i class="bi bi-linkedin"></i></a>
                            <a class="btn btn-outline-primary btn-square" href="#"><i class="bi bi-instagram"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid bg-dark text-white-50 py-4">
            <div class="container">
                <div class="row g-5">                <div class="col-md-6 text-center text-md-start">
                        <p class="mb-md-0">&copy; <a class="text-white" href="${pageContext.request.contextPath}/client/homepage.jsp">FlexCarePPlus</a>. All Rights Reserved.</p>
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <p class="mb-0">Designed by <a class="text-white" href="https://htmlcodex.com">HTML Codex</a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-primary py-3 fs-4 back-to-top" style="position: fixed; right: 30px; bottom: 30px; z-index: 999; box-shadow: 0 5px 20px rgba(0,0,0,0.25); opacity: 0.95; background-color: #6da835 !important; border-color: #6da835 !important; border-radius: 50%; width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; padding: 0;"><i class="bi bi-arrow-up"></i></a>

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
