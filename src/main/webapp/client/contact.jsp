<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/client/assets/layout/headerFull.jsp"/>

<!-- Page Header Start -->
<div class="container-fluid bg-primary py-5 mb-5">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-10 text-center">
                <h1 class="display-3 text-uppercase text-white mb-3">Contact Us</h1>
                <div class="d-inline-block text-white">
                    <p class="m-0"><a class="text-white" href="home">Home</a> / <span class="text-white">Contact</span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Page Header End -->        <!-- Contact Start -->
        <div class="container-fluid py-5">
            <div class="container">
                <div class="border-start border-5 border-primary ps-5 mb-5" style="max-width: 600px;">
                    <h6 class="text-primary text-uppercase">Contact Us</h6>
                    <h1 class="display-5 text-uppercase mb-0">Get In Touch With FlexCareP+</h1>
                </div>
                <div class="row g-5">
                    <div class="col-lg-7">
                        <div class="bg-light p-5 rounded">
                            <h4 class="text-uppercase mb-4">Send Us A Message</h4>
                            <form>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <input type="text" class="form-control bg-white border-0 px-4" placeholder="Your Name" style="height: 55px;" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="email" class="form-control bg-white border-0 px-4" placeholder="Your Email" style="height: 55px;" required>
                                    </div>
                                    <div class="col-md-6">
                                        <input type="tel" class="form-control bg-white border-0 px-4" placeholder="Your Phone" style="height: 55px;">
                                    </div>
                                    <div class="col-md-6">
                                        <select class="form-select bg-white border-0 px-4" style="height: 55px;">
                                            <option selected>Select Service</option>
                                            <option value="grooming">Pet Grooming</option>
                                            <option value="boarding">Pet Boarding</option>
                                            <option value="veterinary">Veterinary Care</option>
                                            <option value="training">Pet Training</option>
                                            <option value="other">Other Services</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <input type="text" class="form-control bg-white border-0 px-4" placeholder="Subject" style="height: 55px;" required>
                                    </div>
                                    <div class="col-12">
                                        <textarea class="form-control bg-white border-0 px-4 py-3" rows="6" placeholder="Tell us about your pet and what you need help with..." required></textarea>
                                    </div>
                                    <div class="col-12">
                                        <button class="btn btn-primary w-100 py-3" type="submit">Send Message</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="bg-light mb-4 p-5 rounded">
                            <h4 class="text-uppercase mb-4">Contact Information</h4>
                            <div class="d-flex align-items-center mb-4">
                                <i class="bi bi-geo-alt fs-1 text-primary me-3"></i>
                                <div class="text-start">
                                    <h6 class="text-uppercase mb-1">Our Office</h6>
                                    <span>FPT City, Ngu Hanh Son, Da Nang</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-4">
                                <i class="bi bi-envelope-open fs-1 text-primary me-3"></i>
                                <div class="text-start">
                                    <h6 class="text-uppercase mb-1">Email Us</h6>
                                    <span>flexcarepplus@gmail.com</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-4">
                                <i class="bi bi-phone-vibrate fs-1 text-primary me-3"></i>
                                <div class="text-start">
                                    <h6 class="text-uppercase mb-1">Call Us</h6>
                                    <span>0767658269</span>
                                </div>
                            </div>
                            <div class="d-flex align-items-center mb-4">
                                <i class="bi bi-clock fs-1 text-primary me-3"></i>
                                <div class="text-start">
                                    <h6 class="text-uppercase mb-1">Opening Hours</h6>
                                    <span>Mon - Sun: 8:00 AM - 5:30 PM</span>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Google Map -->
                        <div class="bg-light p-3 rounded">
                            <h6 class="text-uppercase mb-3">Find Us On Map</h6>
                            <iframe class="w-100 rounded"
                                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3833.8412179685093!2d108.25019917521135!3d16.074106084619145!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314218083a843f91%3A0x9a0182df4d7b522!2sFPT%20University%20Danang!5e0!3m2!1sen!2s!4v1703152844556!5m2!1sen!2s"
                                    frameborder="0" style="height: 250px;" allowfullscreen="" aria-hidden="false"
                                    tabindex="0"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact End -->

        <!-- Why Choose Us Start -->
        <div class="container-fluid bg-light py-5">
            <div class="container">
                <div class="border-start border-5 border-primary ps-5 mb-5" style="max-width: 600px;">
                    <h6 class="text-primary text-uppercase">Why Contact Us</h6>
                    <h1 class="display-5 text-uppercase mb-0">We're Here To Help You</h1>
                </div>
                <div class="row g-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="bg-white text-center p-4 rounded shadow-sm h-100">
                            <i class="bi bi-headset fs-1 text-primary mb-3"></i>
                            <h5 class="text-uppercase mb-3">24/7 Support</h5>
                            <p class="mb-0">We're always here to help with any questions or emergencies regarding your pet's care.</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="bg-white text-center p-4 rounded shadow-sm h-100">
                            <i class="bi bi-lightning fs-1 text-primary mb-3"></i>
                            <h5 class="text-uppercase mb-3">Quick Response</h5>
                            <p class="mb-0">We respond to all inquiries within 2 hours during business hours and 24 hours on weekends.</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="bg-white text-center p-4 rounded shadow-sm h-100">
                            <i class="bi bi-people fs-1 text-primary mb-3"></i>
                            <h5 class="text-uppercase mb-3">Expert Team</h5>
                            <p class="mb-0">Our experienced team of veterinarians and pet care specialists are ready to assist you.</p>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="bg-white text-center p-4 rounded shadow-sm h-100">
                            <i class="bi bi-geo-alt fs-1 text-primary mb-3"></i>
                            <h5 class="text-uppercase mb-3">Convenient Location</h5>
                            <p class="mb-0">Located in the heart of Da Nang, easily accessible by car or public transportation.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Why Choose Us End -->

        <jsp:include page="/client/assets/layout/footer.jsp"/>
