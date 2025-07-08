<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="/staff/assets/layout/headerFull.jsp"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/staff/assets/css/managerPage.css" rel="stylesheet">
    <style>
        .breadcrumb-section {
            background-color: white;
            padding: 20px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .breadcrumb {
            background-color: transparent;
            margin-bottom: 0;
        }

        .breadcrumb-item a {
            color: var(--primary-green);
            text-decoration: none;
        }

        .breadcrumb-item.active {
            color: var(--dark-gray);
        }

        .news-detail-container {
            background-color: white;
            border-radius: 10px;
            padding: 40px;
            margin: 30px 0;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: var(--primary-green);
            box-shadow: 0 0 0 0.2rem rgba(124, 179, 66, 0.25);
        }

        .news-image-preview {
            max-width: 100%;
            height: auto;
            max-height: 300px;
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            object-fit: contain;
            margin-top: 10px;
        }

        .btn-primary {
            background-color: var(--primary-green) !important;
            border-color: var(--primary-green) !important;
            color: white !important;
            padding: 12px 30px !important;
            font-weight: 600 !important;
            border-radius: 8px !important;
            display: inline-block !important;
            text-decoration: none !important;
        }

        .btn-primary:hover,
        .btn-primary:focus,
        .btn-primary:active {
            background-color: var(--light-green) !important;
            border-color: var(--light-green) !important;
            color: white !important;
            box-shadow: 0 0 0 0.2rem rgba(124, 179, 66, 0.25) !important;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 8px;
        }

        .btn-danger {
            background-color: #dc3545;
            border-color: #dc3545;
            padding: 12px 30px;
            font-weight: 600;
            border-radius: 8px;
        }

        .action-buttons {
            display: flex !important;
            gap: 15px !important;
            justify-content: center !important;
            align-items: center !important;
            margin-top: 30px !important;
            padding-top: 20px !important;
            border-top: 1px solid #e0e0e0 !important;
            flex-wrap: wrap !important;
        }

        .action-buttons > * {
            flex-shrink: 0 !important;
            min-width: 150px !important;
        }

        .news-stats {
            display: flex;
            gap: 30px;
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .stat-item {
            text-align: center;
        }

        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: var(--primary-green);
        }

        .stat-label {
            font-size: 14px;
            color: #666;
            margin-top: 5px;
        }

        .alert {
            border-radius: 8px;
            border: none;
            padding: 15px 20px;
            margin-bottom: 20px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        @media (max-width: 768px) {
            .news-detail-container {
                padding: 20px;
                margin: 15px 0;
            }

            .action-buttons {
                flex-direction: column;
                align-items: center;
            }

            .news-stats {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
    <body>
        <!-- Breadcrumb -->
        <div class="breadcrumb-section">
            <div class="container">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="staff?action=getNews">Tin tức</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Chi tiết tin tức</li>
                    </ol>
                </nav>
            </div>
        </div>

        <!-- News Detail Content -->
        <div class="container">
            <div class="news-detail-container">
                <c:if test="${not empty message}">
                    <div class="alert alert-${type}" id="autoHideAlert">
                        <i class="fas fa-${type.equals("danger")?"exclamation-triangle":"check-circle"}"></i>
                        ${message}
                    </div>
                </c:if>

                <c:if test="${not empty news}">
                    <!-- News Statistics -->
                    <div class="news-stats">
                        <div class="stat-item">
                            <div class="stat-value">${news.views}</div>
                            <div class="stat-label">Lượt xem</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">${news.dateCreated}</div>
                            <div class="stat-label">Ngày tạo</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">${news.status ? "Hiển thị" : "Ẩn"}</div>
                            <div class="stat-label">Trạng thái</div>
                        </div>
                    </div>
                </c:if>

                <!-- News Form: Hiển thị form tạo mới nếu không có news, ngược lại là form cập nhật -->
                <c:choose>
                    <c:when test="${empty news}">
                        <form action="staff" method="post" enctype="multipart/form-data">
                            <input hidden name="action" value="createNews">
                            <div class="form-group">
                                <label for="title" class="form-label">
                                    <i class="fas fa-heading"></i> Tiêu đề tin tức
                                </label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left"></i> Mô tả
                                </label>
                                <textarea class="form-control" id="description" name="description" rows="6" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="newImage" class="form-label">
                                    <i class="fas fa-upload"></i> Ảnh tin tức
                                </label>
                                <input type="file" class="form-control" id="newImage" name="newImage" accept="image/*" onchange="previewImage(this)" required>
                                <img id="imagePreview" src="#" alt="Xem trước hình ảnh" class="news-image-preview" style="display: none; margin-top: 10px;">
                            </div>
                            <div class="action-buttons">
                                <a href="staff?action=getNews" class="btn btn-secondary" style="display: inline-block !important;">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary" style="display: inline-block !important; background-color: #7CB342 !important; border-color: #7CB342 !important; color: white !important;">
                                    <i class="fas fa-plus"></i> Tạo tin tức
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="staff" method="post" enctype="multipart/form-data">
                            <input hidden name="newsID" value="${news.newsID}">
                            <input hidden name="action" value="updateNews">
                            <div class="form-group">
                                <label for="title" class="form-label">
                                    <i class="fas fa-heading"></i> Tiêu đề tin tức
                                </label>
                                <input type="text" class="form-control" id="title" name="title" value="${news.title}" required>
                            </div>
                            <div class="form-group">
                                <label for="description" class="form-label">
                                    <i class="fas fa-align-left"></i> Mô tả
                                </label>
                                <textarea class="form-control" id="description" name="description" rows="6" required>${news.description}</textarea>
                            </div>
                            <div class="form-group">
                                <label for="currentImage" class="form-label">
                                    <i class="fas fa-image"></i> Hình ảnh hiện tại
                                </label>
                                <div>
                                    <img src="${news.imgURL}" alt="Hình ảnh tin tức" class="news-image-preview" 
                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                    <p class="text-muted" style="display: none;">Chưa có hình ảnh</p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="newImage" class="form-label">
                                    <i class="fas fa-upload"></i> Cập nhật hình ảnh mới
                                </label>
                                <input type="file" class="form-control" id="newImage" name="newImage" accept="image/*" onchange="previewImage(this)">
                                <img id="imagePreview" src="#" alt="Xem trước hình ảnh" class="news-image-preview" style="display: none; margin-top: 10px;">
                            </div>
                            <div class="action-buttons">
                                <a href="staff?action=getNews" class="btn btn-secondary" style="display: inline-block !important;">
                                    <i class="fas fa-arrow-left"></i> Quay lại
                                </a>
                                <button type="submit" class="btn btn-primary" name="action" value="updateNews" style="display: inline-block !important; background-color: #7CB342 !important; border-color: #7CB342 !important; color: white !important;" >
                                    <i class="fas fa-save"></i> Cập nhật tin tức
                                </button>
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                    // Chỉ sử dụng JavaScript để xem trước ảnh khi chọn file mới
                                    function previewImage(input) {
                                        var preview = document.getElementById('imagePreview');
                                        if (input.files && input.files[0]) {
                                            var reader = new FileReader();

                                            reader.onload = function (e) {
                                                preview.src = e.target.result;
                                                preview.style.display = 'block';
                                            };

                                            reader.readAsDataURL(input.files[0]);
                                        } else {
                                            preview.style.display = 'none';
                                        }
                                    }
        </script>
        <script>
            setTimeout(function () {
                var alert = document.getElementById('autoHideAlert');
                if (alert)
                    alert.style.display = 'none';
            }, 3000);
        </script>
    </body>
</html>