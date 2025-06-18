<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="/staff/assets/layout/headerFull.jsp"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/staff/assets/css/managerPage.css" rel="stylesheet">
    <!-- Content -->
    <div class="content container-fluid">
        <div class="row">
            <div class="col-lg-3 mb-3 mb-lg-5">
                <a class="card card-hover-shadow mb-4" href="staff?action=getBookings">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between">
                            <img
                                class="w-25 rounded me-3"
<<<<<<< HEAD
                                src="https://cdn-icons-png.flaticon.com/512/616/616408.png"
                                alt="Pet Paw Calendar" /> <!-- Booking: paw calendar -->
=======
                                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbjn72SrsaiEVrU7UPjmW9dp7QwapTenbILhKbq6jUJ_3EyS5GZE_DFvMR_J6wFAaWQUE&usqp=CAU"
                                alt="Image Description"
                                />

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="flex-grow-1">
                                <h3 class="text-hover-primary mb-1">Booking</h3>
                                <span class="text-body">View Booking</span>
                            </div>
<<<<<<< HEAD
=======

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="ms-3">
                                <i class="tio-chevron-right tio-lg text-body text-hover-primary"></i>
                            </div>
                        </div>
<<<<<<< HEAD
=======

                        <!-- End Row -->
>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                    </div>
                </a>
                <!-- End Card -->
                <a class="card card-hover-shadow mb-4" href="staff?action=getMessages">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between">
                            <img
                                class="w-25 rounded me-3"
<<<<<<< HEAD
                                src="https://cdn-icons-png.flaticon.com/512/616/616408.png"
                                alt="Pet Chat" style="filter: hue-rotate(120deg);" /> <!-- Messages: paw chat (color shifted for demo) -->
=======
                                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbjn72SrsaiEVrU7UPjmW9dp7QwapTenbILhKbq6jUJ_3EyS5GZE_DFvMR_J6wFAaWQUE&usqp=CAU"
                                alt="Image Description"
                                />

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="flex-grow-1">
                                <h3 class="text-hover-primary mb-1">Messages</h3>
                                <span class="text-body">Support customer</span>
                            </div>
<<<<<<< HEAD
=======

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="ms-3">
                                <i class="tio-chevron-right tio-lg text-body text-hover-primary"></i>
                            </div>
                        </div>
<<<<<<< HEAD
=======
                        <!-- End Row -->
>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                    </div>
                </a>
                <!-- Card -->
                <a class="card card-hover-shadow" href="${pageContext.request.contextPath}/VoucherServlet?actor=ownerRestaurant&action=view">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between">
                            <img
                                class="w-25 rounded me-3"
<<<<<<< HEAD
                                src="https://cdn-icons-png.flaticon.com/512/616/616408.png"
                                alt="Veterinary Services" style="filter: hue-rotate(240deg);" /> <!-- Services: paw stethoscope (color shifted for demo) -->
=======
                                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbjn72SrsaiEVrU7UPjmW9dp7QwapTenbILhKbq6jUJ_3EyS5GZE_DFvMR_J6wFAaWQUE&usqp=CAU"
                                alt="Image Description"
                                />

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="flex-grow-1">
                                <h3 class="text-hover-primary mb-1">Services</h3>
                                <span class="text-body"></span>
                            </div>
<<<<<<< HEAD
=======

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="ms-3">
                                <i class="tio-chevron-right tio-lg text-body text-hover-primary"></i>
                            </div>
                        </div>
<<<<<<< HEAD
=======
                        <!-- End Row -->
>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                    </div>
                </a>
                <!-- End Card -->
                <br><!-- comment -->

                <a class="card card-hover-shadow mb-4" href="${pageContext.request.contextPath}/EventServlet?actor=ownerRestaurant">
                    <div class="card-body">
                        <div class="d-flex align-items-center justify-content-between">
                            <img
                                class="w-25 rounded me-3"
<<<<<<< HEAD
                                src="https://cdn-icons-png.flaticon.com/512/616/616408.png"
                                alt="Pet Policy" style="filter: grayscale(1) brightness(0.7);" /> <!-- Policies: paw document (grayscale for demo) -->
=======
                                src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbjn72SrsaiEVrU7UPjmW9dp7QwapTenbILhKbq6jUJ_3EyS5GZE_DFvMR_J6wFAaWQUE&usqp=CAU"
                                alt="Image Description"
                                />

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="flex-grow-1">
                                <h3 class="text-hover-primary mb-1">Policies</h3>
                                <span class="text-body">View Booking</span>
                            </div>
<<<<<<< HEAD
=======

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                            <div class="ms-3">
                                <i class="tio-chevron-right tio-lg text-body text-hover-primary"></i>
                            </div>
                        </div>
<<<<<<< HEAD
=======
                        <!-- End Row -->
>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                    </div>
                </a>
            </div>

<<<<<<< HEAD
            <c:if test="${not empty services}">
                <div class="col-lg-9">
                    <div class="timeline-container" style="overflow-x:auto; padding-bottom: 8px;">
                        <form id="dateForm" class="d-flex align-items-center justify-content-center mb-3" method="get" action="bookingdetail">
                            <input type="hidden" name="action" value="getBookings" />
                            <label for="bookingDate" class="me-2 mb-0 fw-bold">Chọn ngày:</label>
                            <input type="date" id="bookingDate" name="date" class="form-control" style="max-width: 180px;"
                                   value="${selectedDate}" required />
                            <button type="submit" class="btn btn-primary ms-2">Xem lịch</button>
                        </form>
                        <h2 class="mb-4 text-center">
                            Schedule Booking Service
                            <span id="selected-date-label">
                                <c:choose>
                                    <c:when test="${not empty selectedDate}">
                                        <fmt:parseDate value="${selectedDate}" pattern="yyyy-MM-dd" var="parsedDate"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy"/>
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatDate value="${now}" pattern="dd/MM/yyyy"/>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </h2>
                        <div class="timeline-inner" style="width: 100%; min-width: 0; display: flex; flex-direction: column;">
                            <div class="time-header" id="time-header"></div>
                            <div id="services-container"></div>
                        </div>
                    </div>
=======
            <c:if test="${action eq 'getBookings'}">
                <div class="col-lg-9 mb-3 mb-lg-5">
                    <!-- Card -->
                    <div class="card h-100">
                        <!-- Header -->
                        <div class="card-header">
                            <h4 class="card-header-title">Đơn hàng</h4>
                        </div>
                        <!-- End Header -->

                        <!-- Body -->
                        <!-- Body -->
                        <div class="card-body-height">
                            <!-- Table -->
                            <div class="table-responsive">
                                <table class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table table-custom">
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="text-center column-image"></th>
                                            <th class="text-center column-name">Khách hàng</th>
                                            <th class="text-center column-price">Thời gian</th>
                                            <th class="text-center column-status">Trạng thái</th>
                                            <th class="text-center column-button"></th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="order" items="${orders}">
                                            <tr>
                                                <td class="text-center column-image"><img src="${pageContext.request.contextPath}/staff/asset/img/order.jpg" alt="Order" class="avatar avatar-xl" height="10%"></td>
                                                <td class="text-center column-name">${order.userName}</td>
                                                <td class="text-center column-type">${order.dateCreated}</td>
                                                <td class="text-right column-description" id="CSSDescription" style="color:
                                                    <c:choose>
                                                        <c:when test="${order.status == 'Đơn hàng mới'}">
                                                            black
                                                        </c:when>
                                                        <c:otherwise>
                                                            green
                                                        </c:otherwise>
                                                    </c:choose>">
                                                    ${order.status}
                                                </td>

                                                <td class="text-center column-button">
                                                    <a href="OrderDetailServlet?actor=ownerRestaurant&action=getOrderDetail&orderID=${order.orderID}">
                                                        <button class="btn btn-customdetail" style="background-color: #28a745; /* Màu xanh lá */
                                                                color: white; /* Màu chữ */
                                                                border: none; /* Không viền */
                                                                border-radius: 5px; /* Bo góc nút */
                                                                padding: 5px 10px; /* Kích thước nút */
                                                                font-size: 14px; /* Kích thước chữ */
                                                                cursor: pointer; /* Hình dạng con trỏ khi hover */
                                                                transition: background-color 0.3s ease, box-shadow 0.3s ease; /* Hiệu ứng hover */">
                                                            <i class="fas fa-edit"></i>Detail
                                                        </button>
                                                    </a>
                                                </td>
                                            </tr>

                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- End Table -->
                        </div>
                        <!-- End Body -->
                    </div>
                    <!-- End Card -->
>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                </div>
            </c:if>

            <c:if test="${action eq 'getMessages'}">
                <div class="col-lg-9">
<<<<<<< HEAD
                    <div class="card h-100 shadow-sm">
                        <div class="card-header bg-white border-bottom-0 d-flex align-items-center">
                            <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="Chat Icon" class="me-2" style="width:32px;height:32px;">
                            <h4 class="card-header-title mb-0">Pet Chat Support</h4>
                        </div>
                        <div class="card-body d-flex p-0" style="height: 70vh;">
                            <!-- User List -->
                            <div id="listUsers" class="border-end bg-light" style="width: 240px; overflow-y: auto;">
                                <c:forEach var="u" items="${users}" varStatus="status">
                                    <div class="user-list-item px-3 py-2 d-flex align-items-center card-hover-shadow ${status.first ? 'bg-white border-start border-3 border-success' : ''}" style="cursor:pointer;">
                                        <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="User" class="rounded-circle me-2" style="width:36px;height:36px;object-fit:cover;">
                                        <span class="flex-grow-1 text-truncate ${status.first ? 'fw-bold text-success' : ''}">${u.userName}</span>
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- Chat Area -->
                            <div class="flex-grow-1 d-flex flex-column bg-white">
                                <div class="border-bottom px-4 py-3 d-flex align-items-center" style="min-height:60px;">
                                    <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="User" class="rounded-circle me-2" style="width:36px;height:36px;object-fit:cover;">
                                    <h5 id="nameChatUser" class="mb-0 fw-bold">${users[0].userName}</h5>
                                </div>
                                <div id="chatMessages" class="flex-grow-1 overflow-auto px-4 py-3 d-flex flex-column gap-2" style="background:#f8f9fa;">
                                    <c:forEach var="m" items="${messages}">
                                        <div class="d-flex ${m.userID == 8 ? 'justify-content-end' : 'justify-content-start'}">
                                            <div class="chat-bubble ${m.userID == 8 ? 'bg-success text-white' : 'bg-light text-dark'} px-3 py-2 rounded-3 shadow-sm" style="max-width:60%;">
                                                ${m.content}
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <div class="border-top px-4 py-3 bg-white">
                                    <form class="d-flex gap-2" onsubmit="sendMessage(); return false;">
                                        <input type="text" id="chatInput" class="form-control rounded-pill" placeholder="Type your message..." autocomplete="off">
                                        <button class="btn btn-success rounded-pill px-4" type="submit">
                                            <i class="fas fa-paper-plane"></i> Send
                                        </button>
                                    </form>
=======
                    <!-- Card -->
                    <div class="card h-100">
                        <!-- Header -->
                        <div class="card-header">
                            <h4 class="card-header-title">Chat box</h4>
                        </div>

                        <div class="card-body-height">
                            <div class="container-fluid" style="padding-left: 12px">
                                <!-- Table -->
                                <div class="row">
                                    <div id="listUsers" class="col-lg-3" style="overflow-y: auto; padding: 0">
                                        <c:forEach var="u" items="${users}" varStatus="status">
                                            <div class="card card-hover-shadow ${status.first ? 'bg-light' : ''}">
                                                <div class="card-body">
                                                    <div class="d-flex align-items-center justify-content-between">
                                                        <div class="flex-grow-1">
                                                            <p class="text-hover-primary ${status.first ? 'text-primary' : ''}">${u.userName}</p>
                                                        </div>
                                                        <div class="ms-3">
                                                            <i class="tio-chevron-right tio-lg text-body text-hover-primary"></i>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>

                                    <div class="col-lg-9" style="padding: 0">
                                        <div class="card h-100">
                                            <div class="card-header">
                                                <h4 id="nameChatUser" class="card-header-title">${users[0].userName}</h4>
                                            </div>

                                            <div class="card-body d-flex flex-column" style="height: 75vh">
                                                <!-- Chat messages -->
                                                <div id="chatMessages" class="flex-grow-1 overflow-auto mb-3 d-flex flex-column">
                                                    <c:forEach var="m" items="${messages}">
                                                        <div class="message ${m.userID == 8 ? "user" : "bot"}">${m.content}</div>
                                                    </c:forEach>
                                                </div>

                                                <!-- Input -->
                                                <div class="chat-input d-flex">
                                                    <input type="text" id="chatInput" class="form-control me-2" placeholder="Enter your message">
                                                    <button class="btn btn-primary" onclick="sendMessage()">Send</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                                </div>
                            </div>
                        </div>
                    </div>
<<<<<<< HEAD
=======
                    <!-- End Card -->

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
                </div>
            </c:if>

            <c:if test="${vouchers != null}">
                <div class="col-lg-9 mb-3 mb-lg-5">
                    <!-- Card -->
                    <div class="card h-100">
                        <!-- Header -->
                        <div class="card-header">
                            <h4 class="card-header-title">Phiếu giảm giá</h4>
                            <button class="btn btn-customedit" data-bs-toggle="modal" data-bs-target="#createVoucherModal" style="background: greenyellow; color: black">
                                <i class="fa fa-plus" aria-hidden="true"></i>Tạo mới
                            </button>
                        </div>
                        <!-- End Header -->

                        <!-- Body -->
                        <div class="card-body-height">
                            <!-- Table -->
                            <div class="table-responsive">
                                <table
                                    class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table"
                                    >
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="text-center column-name">Tên</th>
                                            <th class="text-center column-sale">Giảm giá</th>
                                            <th class="text-center column-condition">Điều kiện</th>
                                            <th class="text-center column-dateCreated">Ngày tạo</th>
                                            <th class="text-center column-dateExpired">Ngày hết hạn</th>
                                            <th class="text-center column-quantity">Số lượng</th>
                                            <th class="text-center column-status">Trạng thái</th>
                                            <th class="text-center column-button"></th>
                                            <th class="text-center column-button"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="voucher" items="${vouchers}">
                                            <tr>
                                                <td class="text-center column-name" id="CSSNameVoucher">${voucher.name}</td>
                                                <td class="text-center column-sale">
                                                    <fmt:formatNumber value="${voucher.sale}" type="number" groupingUsed="true" /><strong><span class="text-xs/sp14 font-medium mr-px">₫</span></strong>
                                                </td>
                                                <td class="text-center column-condition">
                                                    <fmt:formatNumber value="${voucher.condition}" type="number" groupingUsed="true" /><strong><span class="text-xs/sp14 font-medium mr-px">₫</span></strong>
                                                </td>
                                                <td class="text-center column-dateCreated">${voucher.dateCreated}</td>
                                                <td class="text-center column-dateExpired">${voucher.dateExpired}</td>
                                                <td class="text-center column-quantity">${voucher.quantity}</td>
                                                <c:if test="${voucher.status}"><td class="text-center column-status">True</td></c:if>
                                                <c:if test="${!voucher.status}"><td class="text-center column-status">False</td></c:if>
                                                    <td class="text-center column-button">
                                                        <button class="btn btn-customedit" data-bs-toggle="modal" data-bs-target="#editVoucherModal${voucher.voucherID}">
                                                        <i class="fas fa-edit"></i>Chỉnh sửa
                                                    </button>
                                                </td>
                                                <td class="text-center column-button">
                                                    <button class="btn btn-customdelete" data-bs-toggle="modal" data-bs-target="#deleteVoucherModal${voucher.voucherID}">
                                                        <i class="fa fa-ban"></i>Xóa
                                                    </button>
                                                </td>
                                            </tr>

                                        <div class="modal fade" id="editVoucherModal${voucher.voucherID}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="editModalLabel">Chỉnh sửa chi tiết món ăn</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="VoucherServlet" method="post">
                                                            <input hidden="true" type="text" class="form-control" name="userID" value="${sessionScope.acc.userID}">
                                                            <input hidden="true" type="text" class="form-control" name="actor" value="ownerRestaurant">
                                                            <input hidden="true" type="text" class="form-control" name="voucherID" value="${voucher.voucherID}">
                                                            <div class="mb-3">
                                                                <label for="name" class="form-label">Tên</label>
                                                                <input type="text" class="form-control" id="name" name="name" value="${voucher.name}" min="1" max="100" required>
                                                            </div>       
                                                            <div class="mb-3">
                                                                <label for="sale" class="form-label">Giá</label>
                                                                <input type="number" class="form-control" id="sale" name="sale" value="${Math.round(voucher.sale)}" required>
                                                            </div>     
                                                            <div class="mb-3">
                                                                <label for="condition" class="form-label">Điều kiện</label>
                                                                <input type="number" class="form-control" id="condition" name="condition" value="${Math.round(voucher.condition)}" required>
                                                            </div>     
                                                            <div class="mb-3">
                                                                <label for="dateExpired" class="form-label">Ngày hết hạn</label>
                                                                <input type="date" class="form-control" id="dateExpired" name="dateExpired" value="${voucher.dateExpired}"required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="quantity" class="form-label">Số lượng</label>
                                                                <input type="number" class="form-control" id="quantity" name="quantity" value="${voucher.quantity}" required>
                                                            </div> 
                                                            <div class="mb-3">
                                                                <label for="status" class="form-label">Trạng thái</label>
                                                                <select id="status" name="status" value="${voucher.status}" class="form-select">
                                                                    <option value="True">True</option>
                                                                    <option value="False">False</option>
                                                                </select>
                                                            </div>  
                                                            <button name="action" type="submit" value="update" class="btn btn-primary">Lưu thông tin</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal fade" id="deleteVoucherModal${voucher.voucherID}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered"> <!-- Thêm class modal-dialog-centered -->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="DeleteModalLabel">Bạn có chắc chắn xóa</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>

                                                    <div class="modal-body">
                                                        <form action="VoucherServlet" method="post">
                                                            <input hidden="true" type="text" class="form-control" name="actor" value="ownerRestaurant" required>
                                                            <input hidden="true" type="text" class="form-control" name="voucherID" value="${voucher.voucherID}" required>
                                                            <div class="d-flex justify-content-center">
                                                                <button name="action" type="submit" value="delete" class="btn btn-primary">Xóa</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                            <!-- End Table -->
                        </div>
                        <!-- End Body -->
                    </div>
                    <!-- End Card -->
                    <div class="modal fade" id="createVoucherModal" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="createVoucherModalLabel">Thêm mới mã giảm giá</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <form action="VoucherServlet" method="post">
                                        <input hidden="true" type="text" class="form-control" name="actor" value="ownerRestaurant" required>
                                        <input hidden="true" type="text" class="form-control" name="userID" value="${sessionScope.acc.userID}" required>
                                        <div class="mb-3">
                                            <label for="name" class="form-label">Tên</label>
                                            <input type="text" class="form-control" id="name" name="name" min="1" max="100" required>
                                        </div>       
                                        <div class="mb-3">
                                            <label for="sale" class="form-label">Giảm giá</label>
                                            <input type="number" class="form-control" id="sale" name="sale" required>
                                        </div>     
                                        <div class="mb-3">
                                            <label for="condition" class="form-label">Điều kiện</label>
                                            <input type="number" class="form-control" id="condition" name="condition" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="dateExpired" class="form-label">Ngày hết hạn</label>
                                            <input type="date" class="form-control" id="dateExpired" name="dateExpired" required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="quantity" class="form-label">Số lượng</label>
                                            <input type="number" class="form-control" id="quantity" name="quantity" required>
                                        </div>    
                                        <div class="mb-3">
                                            <label for="status" class="form-label">Trạng thái</label>
                                            <select id="status" name="status" class="form-select">
                                                <option value="True">True</option>
                                                <option value="False">False</option>
                                            </select>
                                        </div> 
                                        <button name="action" type="create" value="create" class="btn btn-primary">Thêm mới</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${events != null}">
                <div class="col-lg-9 mb-3 mb-lg-5">
                    <!-- Card -->
                    <div class="card h-100">
                        <!-- Header -->
                        <div class="card-header">
                            <h4 class="card-header-title">Sự kiện</h4>
                            <button class="btn btn-customedit" data-bs-toggle="modal" data-bs-target="#createEventModal" style="background: greenyellow; color: black">
                                <i class="fa fa-plus" aria-hidden="true"></i>Tạo mới
                            </button>
                        </div>
                        <!-- End Header -->

                        <!-- Body -->
                        <div class="card-body-height">
                            <!-- Table -->
                            <div class="table-responsive">
                                <table class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table table-custom">
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="text-center column-title">Tiêu đề</th>
                                            <th class="text-center column-sale">Giảm giá</th>
                                            <th class="text-center column-date">Ngày diễn ra sự kiện</th>
                                            <th class="text-center column-status">Trạng thái</th>
                                            <th class="text-center column-button"></th>
                                            <th class="text-center column-button"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="event" items="${events}">
                                            <tr>
                                                <td class="text-center column-title">${event.name}</td>
                                                <td class="text-center column-sale">${event.sale} %</td>
                                                <td class="text-center column-date">${event.dateCreated}</td>
                                                <c:if test="${event.status}"><td class="text-center column-status">True</td></c:if>
                                                <c:if test="${!event.status}"><td class="text-center column-status">False</td></c:if>
                                                    <td class="text-center column-button">
                                                        <button class="btn btn-customedit" data-bs-toggle="modal" data-bs-target="#editEventModal${event.eventID}">
                                                        <i class="fas fa-edit"></i>Chỉnh sửa
                                                    </button>
                                                </td>
                                                <td class="text-center column-button">
                                                    <button class="btn btn-customdelete" data-bs-toggle="modal" data-bs-target="#deleteEventModal${event.eventID}">
                                                        <i class="fa fa-ban"></i>Xóa
                                                    </button>
                                                </td>
                                            </tr>

                                        <div class="modal fade" id="editEventModal${event.eventID}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="editProfileModalLabel">Chỉnh sửa chi tiết sự kiện</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <form action="EventServlet" method="post">
                                                            <input hidden="true" type="text" class="form-control" name="id" value="${event.eventID}" required>
                                                            <input hidden="true" type="text" class="form-control" name="actor" value="ownerRestaurant" required>
                                                            <div class="mb-3">
                                                                <label for="name" class="form-label">Tiêu đề</label>
                                                                <input type="text" class="form-control" id="name" name="name" value="${event.name}" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="sale" class="form-label">Giảm giá (%)</label>
                                                                <input type="number" class="form-control" id="sale" name="sale" value="${event.sale}" min="1" max="100" required>
                                                            </div>       
                                                            <div class="mb-3">
                                                                <label for="dateCreate" class="form-label">Ngày diễn ra sự kiện</label>
                                                                <input type="date" class="form-control" id="dateCreate" name="dateCreate" value="${event.dateCreated}"required>
                                                            </div>     
                                                            <div class="mb-3">
                                                                <label for="status" class="form-label">Trạng thái</label>
                                                                <select id="status" name="status" class="form-select">
                                                                    <option value="True" ${event.status == 'True' ? 'selected' : ''}>True</option>
                                                                    <option value="False" ${event.status == 'False' ? 'selected' : ''}>False</option>
                                                                </select>
                                                            </div> 
                                                            <button name="submit" type="submit" value="edit" class="btn btn-primary">Lưu thông tin</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="modal fade" id="deleteEventModal${event.eventID}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered"> <!-- Thêm class modal-dialog-centered -->
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="editProfileModalLabel">Bạn có chắc chắn xóa</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>

                                                    <div class="modal-body">
                                                        <form action="EventServlet" method="post">
                                                            <input hidden="true" type="text" class="form-control" name="actor" value="ownerRestaurant" required>
                                                            <input hidden="true" type="text" class="form-control" name="id" value="${event.eventID}" required>
                                                            <div class="d-flex justify-content-center">
                                                                <button name="submit" type="submit" value="delete" class="btn btn-primary">Xóa</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <!-- End Table -->
                        </div>
                        <!-- End Body -->
                    </div>
                    <!-- End Card -->
                </div>
                <div class="modal fade" id="createEventModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editProfileModalLabel">Thêm mới Event</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form action="EventServlet" method="post">
                                    <input hidden="true" type="text" class="form-control" name="actor" value="ownerRestaurant" required>
                                    <input hidden="true" type="text" class="form-control" name="userID" value="${sessionScope.acc.userID}" required>
                                    <div class="mb-3">
                                        <label for="name" class="form-label">Title</label>
                                        <input type="text" class="form-control" id="name" name="name" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="sale" class="form-label">Sale (%)</label>
                                        <input type="number" class="form-control" id="sale" name="sale" min="1" max="100" required>
                                    </div>       
                                    <div class="mb-3">
                                        <label for="dateCreate" class="form-label">Event Date</label>
                                        <input type="date" class="form-control" id="dateCreate" name="dateCreate" required>
                                    </div>     
                                    <div class="mb-3">
                                        <label for="status" class="form-label">Activated</label>
                                        <select id="status" name="status" class="form-select">
                                            <option value="True">True</option>
                                            <option value="False">False</option>
                                        </select>
                                    </div> 
                                    <button name="submit" type="submit" value="create" class="btn btn-primary">Thêm mới</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

            </c:if>

            <c:if test="${ingredients != null}">
                <div class="col-lg-9 mb-3 mb-lg-5">
                    <!-- Card -->
                    <div class="card h-100">
                        <!-- Header -->
                        <div class="card-header">
                            <h4 class="card-header-title">${dish.name}</h4>
                            <button type="sumbit" class="btn btn-customedit" data-bs-toggle="modal" data-bs-target="#createIngredientModal${dish.dishID}" style="background: greenyellow; color: black">
                                <i class="fa fa-plus" aria-hidden="true"></i>Thêm mới
                            </button>
                        </div>
                        <!-- End Header -->

                        <!-- Body -->
                        <!-- Body -->
                        <div class="card-body-height">
                            <!-- Table -->
                            <div class="table-responsive">
                                <form action="DishServlet" method="post">
                                    <input type="hidden" name="dishID" value="${dish.dishID}">
                                    <input type="hidden" name="actor" value="ownerRestaurant">
                                    <table class="table table-borderless table-thead-bordered table-nowrap table-align-middle card-table table-custom">
                                        <thead class="thead-light">
                                            <tr>
                                                <th class="text-center column-ingredient">Thành phần</th>
                                                <th class="text-center column-quantitative">Định lượng</th>
                                                <th class="text-center column-quantitative">
                                                    <button type="submit" class="btn btn-primary" name="action" value="updateIngredients" style="background: greenyellow; color: black">
                                                        <i class="fa fa-save" aria-hidden="true"></i> Lưu thông tin
                                                    </button>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="ingredients" items="${ingredients}">
                                                <tr>
                                                    <td class="text-center column-ingredient">
                                                        ${ingredients.name}
                                                        <input type="hidden" name="ingredientName" value="${ingredients.name}">
                                                    </td>
                                                    <td class="text-center column-quantitative">
                                                        <input type="text" name="quantitative" value="${ingredients.quantitative}">
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </form>
                                <div class="modal fade" id="createIngredientModal${dish.dishID}" tabindex="-1" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="viewIngredientModalLabel">Chỉnh sửa thành phần món ăn</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="DishServlet" method="post" enctype="multipart/form-data">
                                                    <input hidden="true" type="text" class="form-control" name="userID" value="${sessionScope.acc.userID}">
                                                    <input hidden="true" type="text" class="form-control" name="actor" value="ownerRestaurant">
                                                    <input hidden="true" type="text" class="form-control" name="dishID" value="${dish.dishID}">                                         
                                                    <div class="mb-3">
                                                        <label for="ingredient" class="form-label">Thành phần món ăn </label>
                                                        <div class="col-sm-12">
                                                            <p class="form-control-plaintext">
                                                                <button type="button" id="CSSButtonIngredients" class="btn btn-thirdly w-100" data-bs-toggle="modal" data-bs-target="#ingredientModal">Chọn thành phần</button>
                                                            </p>
                                                            <div id="selected-ingredient">
                                                                <c:choose>
                                                                    <c:when test="${not empty ingredientsMap[dish.dishID]}">
                                                                        <c:forEach var="ingredient" items="${ingredientsMap[dish.dishID]}">
                                                                            ${ingredient.name}
                                                                            <c:if test="${!status.last}">, </c:if>
                                                                        </c:forEach>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div id="selected-ingredient">
                                                                            <p style="text-align: center">Không có</p>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <button name="action" type="submit" value="addIngredient" class="btn btn-primary">Lưu thông tin</button>
                                                    <!-- Modal -->
                                                    <div class="modal fade" id="ingredientModal" tabindex="-1" aria-labelledby="ingredientModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog">
                                                            <div class="modal-content">
                                                                <!-- Header -->
                                                                <div class="modal-header">
                                                                    <h5 class="modal-title" id="ingredientModalLabel">Chọn thành phần</h5>
                                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>

                                                                <!-- Body -->
                                                                <div class="modal-body">
                                                                    <!-- Tìm kiếm -->
                                                                    <div class="mb-3">
                                                                        <input type="text" id="search-ingredient" class="form-control" placeholder="Tìm kiếm thành phần...">
                                                                    </div>

                                                                    <!-- Danh sách gợi ý -->
                                                                    <ul class="list-group" id="ingredient-list">
                                                                        <c:forEach var="item" items="${nutrion}">
                                                                            <li class="list-group-item">
                                                                                <input class="form-check-input me-1 ingredient-item" type="checkbox" name="ingredient" value="${item.name}">
                                                                                <label class="form-check-label">${item.name}</label>
                                                                            </li>
                                                                        </c:forEach>
                                                                    </ul>

                                                                </div>

                                                                <!-- Footer -->
                                                                <div class="modal-footer">
                                                                    <button type="button" class="btn btn-primary" id="save-ingredient" data-bs-dismiss="modal" onclick="saveSelectedIngredients()">Lưu</button>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- End Table -->
                        </div>
                        <!-- End Body -->
                        <!-- create Dish Modal -->                    
                    </div>
                    <!-- End Card -->
                </div>
            </c:if>
        </div>
        <!-- End Row -->

        <!-- Card -->

        <!-- End Card -->
    </div>
</html>

<c:if test="${action eq 'getMessages'}">
    <style>
        .message {
            padding: 8px 12px;
            border-radius: 18px;
            max-width: 75%;
            margin-bottom: 10px;
            word-wrap: break-word;
        }

        .user {
            align-self: flex-end;
            background-color: #dcf8c6;
        }

        .bot {
            align-self: flex-start;
            background-color: #f1f0f0;
        }
        .card.card-hover-shadow:hover {
            cursor: pointer; /* Thêm hiệu ứng khi hover */
            background-color: #f0f0f0; /* Màu nền khi hover */
        }
    </style>

    <script>
<<<<<<< HEAD

        document.addEventListener('DOMContentLoaded', function () {
        var selectedUserID = null;
        let lastMessageCount = 0;
        let lastUserListStr = '';
        if (${not empty users}) {
        selectedUserID = ${users[0].userId};
        }

        const chatMessages = document.getElementById('chatMessages');
        const listUsersDiv = document.getElementById('listUsers');
        const chatInput = document.getElementById('chatInput');
        function scrollToBottom() {
        chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        window.sendMessage = function () {
        const text = chatInput.value.trim();
        if (!text)
                return;
        chatInput.value = '';
        fetch('message', {
        method: 'POST',
                headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                receiverID: selectedUserID,
                        content: text
                })
        })
                .then(() => {
                getMessages(selectedUserID, true); // fetch ngay sau gửi
                scrollToBottom();
                })
                .catch(error => console.error('Send error:', error));
        };
        chatInput.addEventListener('keydown', function (e) {
        if (e.key === 'Enter') {
        e.preventDefault();
        sendMessage();
        }
        });
        window.changeUserID = function (userID, userName) {
        const nameChatUser = document.getElementById('nameChatUser');
        nameChatUser.innerHTML = userName;
        selectedUserID = userID;
        getMessages(selectedUserID, true); // fetch ngay khi đổi user
        };
        function getMessages(userID, forceUpdate) {
        fetch('message?action=getUserMessages&senderID=8&receiverID=' + selectedUserID, {
        method: 'GET',
                headers: {
                'Accept': 'application/json',
                        'Content-Type': 'application/json'
                }
        })
                .then(response => response.json())
                .then(datas => {
                if (userID !== selectedUserID)
                        return;
                if (forceUpdate || datas.length !== lastMessageCount) {
                lastMessageCount = datas.length;
                chatMessages.innerHTML = '';
                datas.forEach(data => {
                // Render exactly as initial HTML (chat bubble, alignment, color)
                const isStaff = data.userID === 8;
                const wrapper = document.createElement('div');
                wrapper.className = 'd-flex ' + (isStaff ? 'justify-content-end' : 'justify-content-start');
                const bubble = document.createElement('div');
                bubble.className = 'chat-bubble ' + (isStaff ? 'bg-success text-white' : 'bg-light text-dark') + ' px-3 py-2 rounded-3 shadow-sm';
                bubble.style.maxWidth = '60%';
                bubble.innerHTML = data.content;
                wrapper.appendChild(bubble);
                chatMessages.appendChild(wrapper);
                });
                scrollToBottom();
                }
                })
                .catch(error => console.error('Error: vào đây' + selectedUserID, error));
        }

        function getUsers(forceUpdate) {
        fetch('message?action=getUsers', {
        method: 'GET',
                headers: {
                'Accept': 'application/json',
                        'Content-Type': 'application/json'
                }
        })
                .then(response => response.json())
                .then(datas => {
                const datasStr = JSON.stringify(datas);
                if (forceUpdate || datasStr !== lastUserListStr) {
                lastUserListStr = datasStr;
                listUsersDiv.innerHTML = '';
                datas.forEach(u => {
                const card = document.createElement('div');
                card.className = 'card card-hover-shadow';
                card.setAttribute('onclick', `changeUserID(` + u.userID + `, '` + u.userName + `')`);
                card.innerHTML =
                        '<div class="user-list-item px-3 py-2 d-flex align-items-center card-hover-shadow ' + (u.userID === selectedUserID ? 'bg-white border-start border-3 border-success' : '') + '" style="cursor:pointer;">' +
                        '<img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="User" class="rounded-circle me-2" style="width:36px;height:36px;object-fit:cover;">' +
                        '<span class="flex-grow-1 text-truncate ' + (u.userID === selectedUserID ? 'fw-bold text-success' : '') + '">' + u.userName + '</span>' +
                        '</div>';
                listUsersDiv.appendChild(card);
                });
                }
                })
                .catch(error => {
                console.error('Error fetching users:', error);
                });
        }

        // Polling mỗi 2s, chỉ update khi có thay đổi
        setInterval(() => {
        getUsers(false);
        getMessages(selectedUserID, false);
        }, 2000);
        });
    </script>
</c:if>

<c:if test="${not empty services}">
    <style>
        body {
            padding: 0;
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6fb;
        }
        .timeline-container {
            max-width: 1100px;
            margin: 40px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 8px 32px rgba(60,60,100,0.08);
            padding: 32px 24px 24px 24px;
            user-select: none;
        }
        .time-header {
            display: flex;
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 5px;
            background: #f8f9fa;
            border-radius: 8px 8px 0 0;
            min-width: 0;
            width: 100%;
        }
        .time-hour {
            flex: 1 1 0;
            text-align: center;
            font-size: 13px;
            color: #6c757d;
            border-right: 1px solid #dee2e6;
            padding: 2px 0;
            font-weight: 500;
        }
        .service-row {
            display: flex;
            align-items: center;
            position: relative;
            height: 54px;
            border-bottom: 1px solid #f1f3f6;
            margin-bottom: 8px;
            transition: background 0.2s;
        }
        .service-row:hover {
            background: #f8f9fa;
        }
        .service-label {
            width: 140px;
            min-width: 140px;
            max-width: 140px;
            font-weight: 600;
            color: #343a40;
            padding-right: 10px;
            font-size: 15px;
            letter-spacing: 0.5px;
        }
        .time-row {
            flex-grow: 1;
            position: relative;
            display: flex;
            background: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 6px;
            height: 40px;
            overflow: hidden;
            min-width: 0;
            width: 100%;
        }
        .time-cell {
            flex: 1 1 0;
            border-right: 1px solid #e9ecef;
            height: 100%;
        }
        .booking-bar {
            position: absolute;
            top: 5px;
            height: 30px;
            border-radius: 8px;
            color: #fff;
            padding: 0 10px;
            font-size: 13px;
            line-height: 30px;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0,0,0,0.12);
            user-select: none;
            transition: transform 0.2s, box-shadow 0.2s;
            border: 2px solid #fff;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .booking-bar:hover {
            transform: scale(1.06);
            z-index: 10;
            box-shadow: 0 4px 16px rgba(0,0,0,0.18);
            border-color: #dee2e6;
        }
        .booking-time {
            font-size: 12px;
            opacity: 0.85;
            margin-left: 6px;
            font-weight: 400;
        }
    </style>

    <script
        src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-zrZ5xJ9eEjE7yqkJxXQIrBOMDhY0iY8hN6HsS8L+VqCZh1kZQETOTkR5EnlHjvlj"
        crossorigin="anonymous"
    ></script>
    <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"
        integrity="sha384-Ns3ZqvQFR+Pmi1igLy3uENJ5St6Cvw5nK+DlGXtKlPL88q5tht8V2PP9JKcpPH9L"
        crossorigin="anonymous"
    ></script>

    <script>
        // Dữ liệu thực tế từ backend (services, bookingDetails)
        // Tạo mảng màu cho các service (cố định hoặc random)
        var serviceColors = [
                '#FF6F61', '#6B5B95', '#88B04B', '#FFA500', '#009B77', '#F7CAC9', '#92A8D1', '#955251', '#B565A7', '#DD4124', '#45B8AC', '#EFC050'
        ];
        // Convert Java List<Service> to JS array
        var services = [
        <c:forEach var="s" items="${services}" varStatus="loop">
        {
        id: ${s.serviceID},
                name: '<c:out value="${s.name}"/>',
                color: serviceColors[${loop.index} % serviceColors.length]
        }<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
        ];
        // Convert Java List<BookingDetail> to JS array
        var bookingServices = [
        <c:forEach var="b" items="${bookingDetails}" varStatus="loop">
        {
        id: ${b.bookingDetailID},
                serviceId: ${b.serviceID},
                start: (function(){
                var t = '<c:out value="${b.startTime}"/>';
                if (!t) return null;
                var parts = t.split(":");
                return parseInt(parts[0], 10) + parseInt(parts[1], 10) / 60;
                })(),
                end: (function(){
                var t = '<c:out value="${b.endTime}"/>';
                if (!t) return null;
                var parts = t.split(":");
                return parseInt(parts[0], 10) + parseInt(parts[1], 10) / 60;
                })(),
                name: 'Booking #' + ${b.bookingDetailID}
        }<c:if test="${!loop.last}">,</c:if>
        </c:forEach>
        ];
        var hourWidth = 35; // pixel per hour
        var timelineStart = 7;
        var timelineEnd = 22;
        var timeHeader = document.getElementById('time-header');
        var servicesContainer = document.getElementById('services-container');
        // Tạo header trục thời gian 0-23
        function renderTimeHeader() {
        // Thêm cột trống đầu tiên để căn lề cho label dịch vụ
        var emptyDiv = document.createElement('div');
        emptyDiv.style.width = '140px';
        emptyDiv.style.minWidth = '140px';
        emptyDiv.style.maxWidth = '140px';
        emptyDiv.style.flex = '0 0 140px';
        timeHeader.appendChild(emptyDiv);
        for (var h = timelineStart; h <= timelineEnd; h++) {
        var hourDiv = document.createElement('div');
        hourDiv.className = 'time-hour';
        hourDiv.textContent = h + 'h';
        timeHeader.appendChild(hourDiv);
        }
        }

        // Hàm chuyển số thực sang chuỗi giờ:phút (8.75 => 8h45)
        function formatHour(h) {
        var hour = Math.floor(h);
        var min = Math.round((h - hour) * 60);
        return min === 0 ? (hour + 'h') : (hour + 'h' + (min < 10 ? '0' : '') + min);
        }

        function renderServices() {
        services.forEach(function (service) {
        var row = document.createElement('div');
        row.className = 'service-row';
        var label = document.createElement('div');
        label.className = 'service-label';
        label.textContent = service.name;
        var timeRow = document.createElement('div');
        timeRow.className = 'time-row';
        // Tạo ô giờ trống để tạo lưới (chỉ từ 7h đến 22h)
        for (var i = timelineStart; i <= timelineEnd; i++) {
        var cell = document.createElement('div');
        cell.className = 'time-cell';
        timeRow.appendChild(cell);
        }

        // Lấy booking của service
        var bookings = bookingServices.filter(function (b) {
        return b.serviceId === service.id && b.start !== null && b.end !== null;
        });
        bookings.forEach(function (booking) {
        // Nếu booking nằm ngoài khung giờ thì cắt lại
        var start = Math.max(booking.start, timelineStart);
        var end = Math.min(booking.end, timelineEnd);
        if (end <= start) return;
        var totalHours = timelineEnd - timelineStart + 1;
        var leftPercent = ((start - timelineStart) / totalHours) * 100;
        var widthPercent = ((end - start) / totalHours) * 100;
        var bar = document.createElement('div');
        bar.className = 'booking-bar';
        bar.style.left = leftPercent + '%';
        bar.style.width = widthPercent + '%';
        bar.style.backgroundColor = service.color;
        bar.setAttribute('data-bs-toggle', 'tooltip');
        bar.setAttribute('title', booking.name + ': ' + formatHour(booking.start) + ' - ' + formatHour(booking.end));
        bar.innerHTML = '';
        timeRow.appendChild(bar);
        });
        row.appendChild(label);
        row.appendChild(timeRow);
        servicesContainer.appendChild(row);
        });
        }

        // Khởi tạo tooltip Bootstrap
        function enableTooltips() {
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
        });
        }

        // Hiển thị ngày đã chọn lên tiêu đề
        function setSelectedDateLabel() {
        var dateInput = document.getElementById('bookingDate');
        var label = document.getElementById('selected-date-label');
        if (dateInput && label) {
        var val = dateInput.value;
        if (val) {
        var d = new Date(val);
        var day = d.getDate().toString().padStart(2, '0');
        var month = (d.getMonth() + 1).toString().padStart(2, '0');
        var year = d.getFullYear();
        label.textContent = day + '/' + month + '/' + year;
        } else {
        label.textContent = '';
        }
        }
        }

        // Render toàn bộ
        renderTimeHeader();
        renderServices();
        enableTooltips();
        setSelectedDateLabel();
        var dateInput = document.getElementById('bookingDate');
        if (dateInput) {
        dateInput.addEventListener('change', setSelectedDateLabel);
        }
    </script>
    <script>
        // Nếu không có selectedDate (hoặc rỗng/null), set ngày hiện tại cho input date và label
        document.addEventListener('DOMContentLoaded', function() {
        var dateInput = document.getElementById('bookingDate');
        var label = document.getElementById('selected-date-label');
        if (!dateInput.value) {
        var today = new Date();
        var yyyy = today.getFullYear();
        var mm = String(today.getMonth() + 1).padStart(2, '0');
        var dd = String(today.getDate()).padStart(2, '0');
        var iso = yyyy + '-' + mm + '-' + dd;
        dateInput.value = iso;
        if (label) {
        label.textContent = dd + '/' + mm + '/' + yyyy;
        }
        }
        });
=======
        document.addEventListener('DOMContentLoaded', function () {
            var selectedUserID = null;

            if (${not empty users}) {
                selectedUserID = ${users[0].userId};
            }

            const chatMessages = document.getElementById('chatMessages');
            const listUsersDiv = document.getElementById('listUsers');
            const chatInput = document.getElementById('chatInput');

            function scrollToBottom() {
                chatMessages.scrollTop = chatMessages.scrollHeight;
            }

            window.sendMessage = function () {
                const text = chatInput.value.trim();
                if (!text)
                    return;
                chatInput.value = '';

                fetch('message', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: new URLSearchParams({
                        receiverID: selectedUserID,
                        content: text
                    })
                })
                        .then(() => {
                            getMessages(selectedUserID);
                            scrollToBottom();
                        })
                        .catch(error => console.error('Send error:', error));
            };

            chatInput.addEventListener('keydown', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    sendMessage();
                }
            });

            window.changeUserID = function (userID, userName) {
                const nameChatUser = document.getElementById('nameChatUser');
                nameChatUser.innerHTML = userName;
                selectedUserID = userID;
                console.log('User selected:', userID);
            };

            function getMessages(userID) {
                fetch('message?action=getUserMessages&senderID=8&receiverID=' + selectedUserID, {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    }
                })
                        .then(response => response.json())
                        .then(datas => {
                            if (userID !== selectedUserID) {
                                return;
                            }
                            chatMessages.innerHTML = '';
                            datas.forEach(data => {
                                const msgDiv = document.createElement('div');
                                msgDiv.className = 'message ' + (data.userID === 8 ? 'user' : 'bot');
                                msgDiv.innerHTML = data.content;
                                chatMessages.appendChild(msgDiv);
                            });
                        })
                        .catch(error => console.error('Error: vào đây' + selectedUserID, error));
            }

            function getUsers() {
                fetch('message?action=getUsers', {
                    method: 'GET',
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json'
                    }
                })
                        .then(response => response.json())
                        .then(datas => {
                            listUsersDiv.innerHTML = ''; // Clear existing content

                            datas.forEach(u => {
                                const card = document.createElement('div');
                                card.className = 'card card-hover-shadow';
                                card.setAttribute('onclick', `changeUserID(` + u.userID + `, '` + u.userName + `')`);

                                card.innerHTML =
                                        '<div class="card-body ' + (u.userID === selectedUserID ? 'bg-light' : '') + '">' +
                                        '<div class="d-flex align-items-center justify-content-between">' +
                                        '<div class="flex-grow-1">' +
                                        '<p class="text-hover-primary ' + (u.userID === selectedUserID ? 'text-primary' : '') + '">' + u.userName + '</p>' +
                                        '</div>' +
                                        '</div>' +
                                        '</div>';
                                listUsersDiv.appendChild(card);
                            });
                        })
                        .catch(error => {
                            console.error('Error fetching users:', error);
                        });
            }

            setInterval(() => {
                getUsers();
                getMessages(selectedUserID);
            }, 500);
        });

>>>>>>> 81fea04b829f4661506c561b87504c6bf2363ca1
    </script>
</c:if>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
