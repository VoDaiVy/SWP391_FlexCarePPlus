<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/client/assets/layout/headerFull.jsp"/>
<script src="client/assets/js/jquery-1.11.3.min.js"></script>

<!-- Page Header End -->
<!-- Profile Start -->
<div class="container-fluid py-5 d-flex justify-content-center bg-light">
    <div class="container py-5 bg-white shadow rounded">
        <c:if test="${isSuccess == true}">
            <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="successModalLabel">Thông báo</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <i class="fas fa-check-circle" id="success-icon"></i>
                            <strong>Giao dịch thành công!</strong>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${isSuccess == false}">
            <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="successModalLabel">Thông báo</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <i class="fas fa-times-circle" id="failed-icon"></i>
                            <strong>Giao dịch thất bại!</strong>
                        </div>
                        <div class="modal-footer">
                            <button style="background: red" type="button" class="btn btn-primary" data-bs-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
            <c:remove var="isSuccess" scope="session"/>
        </c:if>
        <c:if test="${sessionScope.checkoutURL != null}">
            <div class="d-flex justify-content-start mt-4">
                <a href="${sessionScope.checkoutURL}" class="btn btn-secondary px-4 py-2" style="border-radius: 5px; font-size: 14px;">
                    Đến trang thanh toán
                </a>
            </div>
        </c:if>

        <h1 class="mb-4 text-center">Hồ sơ của tôi</h1>
        <div class="row g-4 justify-content-center">
            <!-- Profile Details and Overview Start -->
            <div class="col-lg-6 d-flex align-items-stretch">
                <div class="card mb-4 w-100 shadow-sm" style="border-radius: 10px; overflow: hidden;">
                    <div class="card-body d-flex flex-column justify-content-center align-items-center p-3">
                        <!-- Hình ảnh ví bên trên -->
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5OKScId2X41UclXUV0nPr67KcyJ7BkVvb-Q&s"
                             alt="Wallet Icon" style="width: 50%; height: 50%; object-fit: contain;">

                        <!-- Số tiền căn giữa -->
                        <p style="font-size: 24px; font-weight: bold; margin: 20px 0;">
                            <fmt:formatNumber value="${sessionScope.wallet.amount}" type="number" groupingUsed="true" /><strong><span class="text-xs/sp14 font-medium mr-px">₫</span></strong> 
                        </p>


                        <!-- Nút nạp tiền và rút tiền bên dưới -->
                        <div class="d-flex">
                            <button class="btn btn-primary mb-2 px-4 py-2 mx-2" style="border-radius: 5px; font-size: 14px;" data-bs-toggle="modal" <c:if test="${wallet.status == true}">data-bs-target="#depositModal"</c:if> onclick="checkStatusWallet()">
                                    Nạp tiền
                                </button>

                                <button class="btn btn-primary mb-2 px-4 py-2 mx-2" style="border-radius: 5px; font-size: 14px;" data-bs-toggle="modal" data-bs-target="#refundModal">
                                    Lịch sử
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- Profile End -->

    <!-- Edit Profile Modal -->
    <div class="modal fade" id="depositModal" tabindex="-1" aria-labelledby="depositModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered"> <!-- Thêm modal-dialog-centered -->
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="depositModalLabel">Nạp tiền vào ví</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="wallet" id="frmCreateOrder" method="post">     
                        <input type="hidden" name="action" value="deposit">

                        <div class="form-group mb-4">
                            <label for="amount" class="form-label">Số tiền</label>
                            <input class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." 
                                   id="amount" max="100000000" min="10000" name="amount" type="number" value="10000" step="1000" placeholder="Nhập số tiền..." />
                        </div>

                        <h4 class="mb-3">Chọn phương thức thanh toán</h4>
                        <div class="form-group mb-4">
                            <div class="form-check">
                                <input type="radio" class="form-check-input" id="vnpayQR" name="bankCode" value="" >
                                <label class="form-check-label" for="vnpayQR">Cổng thanh toán VNPAYQR</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" class="form-check-input" id="vnpayQRApp" name="bankCode" value="VNPAYQR">
                                <label class="form-check-label" for="vnpayQRApp">Thanh toán bằng ứng dụng hỗ trợ VNPAYQR</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" class="form-check-input" id="vnbank" name="bankCode" value="VNBANK" checked>
                                <label class="form-check-label" for="vnbank">Thanh toán qua thẻ ATM/Tài khoản nội địa</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" class="form-check-input" id="intlCard" name="bankCode" value="INTCARD">
                                <label class="form-check-label" for="intlCard">Thanh toán qua thẻ quốc tế</label>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <h5>Chọn ngôn ngữ giao diện thanh toán:</h5>
                            <div class="form-check">
                                <input type="radio" class="form-check-input" id="languageVietnamese" name="language" value="vn" checked>
                                <label class="form-check-label" for="languageVietnamese">Tiếng Việt</label>
                            </div>
                            <div class="form-check">
                                <input type="radio" class="form-check-input" id="languageEnglish" name="language" value="en">
                                <label class="form-check-label" for="languageEnglish">Tiếng Anh</label>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-primary w-100">Thanh toán</button>
                    </form>

                </div>

            </div>
        </div>
    </div>


    <div class="modal fade" id="refundModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">Lịch sử giao dịch</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-0">
                    <div class="table-responsive" style="width: 90%">
                        <table class="table table-striped table-bordered m-0">
                            <thead class="table-dark">
                                <tr>
                                    <th class="text-center" style="width: 12%;">Mã giao dịch</th>
                                    <th class="text-center" style="width: 45%;">Nội dung</th>
                                    <th class="text-center" style="width: 17%;">Thời gian</th>
                                    <th class="text-center" style="width: 15%;">Số tiền</th>
                                    
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${walletTransfers}" var="wt">
                                <tr>
                                    <!-- Mã giao dịch -->
                                    <td class="text-center fw-bold">${wt.transCode}</td>

                                    <!-- Nội dung -->
                                    <td class="text-break">${wt.content}</td>

                                    <!-- Thời gian -->
                                    <td class="text-center">
                                        ${wt.timeCode}
                                    </td>

                                    <!-- Số tiền -->
                                    <td class="text-center fw-bold">
                                        <fmt:formatNumber value="${wt.amount}" type="number" groupingUsed="true" />
                                        <span class="text-xs font-medium">₫</span>
                                    </td>
                                </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />
    <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
    <script type="text/javascript">
                                $(document).ready(function () {
        <c:if test="${isSuccess == true}">
                                    $("#successModal").modal("show");
        </c:if>
        <c:if test="${isSuccess == false}">
                                    $("#successModal").modal("show");
        </c:if>
                                });
    </script>
    <script type="text/javascript">
        $("#frmCreateOrder").submit(function () {
            var postData = $("#frmCreateOrder").serialize();
            var submitUrl = $("#frmCreateOrder").attr("action");
            $.ajax({
                type: "POST",
                url: submitUrl,
                data: postData,
                dataType: 'JSON',
                success: function (x) {
                    if (x.code === '00') {
                        if (window.vnpay) {
                            vnpay.open({width: 1000, height: 600, url: x.data});
                        } else {
                            location.href = x.data;
                        }
                        return false;
                    } else {
                        alert(x.Message);
                    }
                }
            });
            return false;
        });
    </script>      
    <script>
        function checkStatusWallet() {
            if (${sessionScope.wallet.status == false}) {
                alert("Ví của bạn bị tạm khóa!\nVui lòng liên hệ tới Hotline: 0123456789 để biết thêm thông tin!");
            }
        }
    </script>
    <style>
        /* Đặt modal giữa màn hình */
        .modal-content {
            border-radius: 10px;
            border: none;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            border-bottom: none;
            text-align: center;
        }

        .modal-title {
            font-size: 20px;
            font-weight: bold;
        }

        .modal-body {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px 30px;
            text-align: center;
        }

        #success-icon {
            color: #8AC73F; /* Màu xanh lá đậm cho biểu tượng tick */
            font-size: 4rem; /* Tăng kích thước biểu tượng */
            margin-right: 10px;
        }

        #failed-icon {
            color: red;
            font-size: 4rem;
            margin-right: 10px;
        }

        .modal-body strong {
            font-size: 1.2rem;
            color: #555;
        }

        /* Tùy chỉnh nút OK */
        .modal-footer .btn-primary {
            background-color: #8AC73F;
            border: none;
            color: white;
            font-size: 16px;
            padding: 10px 30px;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .modal-footer .btn-primary:hover {
            background-color: #218838;
        }

        .modal-footer {
            justify-content: center;
            border-top: none;
        }

        #success-icon {
            animation: pulse 1s infinite; /* Hiệu ứng nhấp nháy */
        }

        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
            100% {
                transform: scale(1);
            }
        }

        /* Form tổng quát */
        #frmCreateOrder {
            background-color: #f9f9f9;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #f9f9f9;

            text-align: left; /* Căn nội dung về bên trái */
            max-width: 500px; /* Giới hạn độ rộng của form */
            margin: 0 auto; /* Căn form giữa màn hình theo chiều ngang */
        }

        /* Tiêu đề form */
        #frmCreateOrder h4 {
            font-size: 20px;
            font-weight: 600;
            color: #333;
        }

        /* Label của các input */
        #frmCreateOrder label {
            font-weight: bold;
            color: #555;
        }

        /* Input và Select */
        #frmCreateOrder input.form-control, #frmCreateOrder select.form-control {
            padding: 10px;
            font-size: 16px;
            border-radius: 5px;
            border: 1px solid #ccc;
            transition: border-color 0.3s ease;
        }

        /* Thay đổi màu viền khi focus vào input */
        #frmCreateOrder input.form-control:focus {
            border-color: #8AC73F; /* Màu viền khi được chọn */
            box-shadow: 0 0 5px rgba(138, 199, 63, 0.5);
        }

        /* Form-check (cho các radio buttons) */
        #frmCreateOrder .form-check {
            margin-bottom: 10px;
        }

        #frmCreateOrder .form-check-input {
            margin-right: 10px;
            transform: scale(1.2); /* Tăng kích thước của radio buttons */
        }

        #frmCreateOrder .form-check-label {
            font-size: 16px;
            color: #333;
        }

        /* Nút submit */
        #frmCreateOrder button[type="submit"] {
            background-color: #8AC73F; /* Màu xanh lá */
            border: none;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }

        /* Hiệu ứng hover cho nút submit */
        #frmCreateOrder button[type="submit"]:hover {
            background-color: #76B22F; /* Màu xanh lá khi hover */
        }

        /* Khoảng cách giữa các nhóm input */
        .form-group {
            margin-bottom: 20px;
        }

    </style>
    <jsp:include page="/client/assets/layout/footer.jsp"/>