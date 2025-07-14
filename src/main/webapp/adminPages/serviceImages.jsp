<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Service Images - FlexCareP+</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesdesign" name="author" />
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .image-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 20px;
        }
        .image-item {
            position: relative;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            background: #fff;
        }
        .image-item img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        .delete-btn {
            position: absolute;
            top: 8px;
            right: 8px;
            z-index: 2;
        }
        .form-section {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
    </style>
</head>
<body data-topbar="dark">
    <div id="layout-wrapper">
        <jsp:include page="/adminPages/assets/includes/header.jsp" />
        <jsp:include page="/adminPages/assets/includes/navbar.jsp" />
        <div class="main-content">
            <div class="page-content">
                <div class="container-fluid">
                    <div class="page-title-box">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h4 class="page-title mb-1">
                                    Service Images - <span class="text-primary fw-bold">${service.name}</span>
                                </h4>
                            </div>
                            <div class="col-md-4">
                                <div class="float-end d-none d-md-block">
                                    <a href="admin?action=getServiceDetail&id=${service.serviceID}" class="btn btn-secondary me-2">
                                        <i class="fas fa-arrow-left me-2"></i>Back to Detail
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Gallery -->
                    <div class="form-section">
                        <h5 class="section-title"><i class="fas fa-images me-2"></i>Gallery</h5>
                        <div class="image-gallery">
                            <c:forEach var="img" items="${images}">
                                <div class="image-item">
                                    <img src="${img.imgURL}" alt="Service Image" />
                                    <form action="admin" method="post" style="position:absolute;top:8px;right:8px;z-index:2;">
                                        <input type="hidden" name="action" value="deleteServiceImage" />
                                        <input type="hidden" name="serviceImageID" value="${img.serviceImageID}" />
                                        <button type="submit" class="btn btn-danger btn-sm delete-btn" title="Delete image" onclick="return confirm('Do you want to delete?');">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </form>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Add Image Form -->
                    <div class="form-section">
                        <h5 class="section-title"><i class="fas fa-plus me-2"></i>Add New Image</h5>
                        <form action="admin" method="post" enctype="multipart/form-data" id="addImageForm">
                            <input type="hidden" name="action" value="addServiceImage" />
                            <input type="hidden" name="serviceID" value="${service.serviceID}" />
                            <div class="mb-3">
                                <input class="form-control" type="file" name="serviceImage" accept="image/*" required id="serviceImageInput" />
                            </div>
                            <div class="mb-3" id="previewContainer" style="display:none;">
                                <label class="form-label">Preview:</label>
                                <img id="imagePreview" src="#" alt="Image Preview" style="max-width: 220px; max-height: 180px; border-radius: 8px; border: 1px solid #ddd; display: block;" />
                            </div>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-upload me-2"></i>Add Image
                            </button>
                        </form>
                    </div>
                </div>
            </div>
            <jsp:include page="/adminPages/assets/includes/footer.jsp" />
        </div>
    </div>
    <jsp:include page="/adminPages/assets/includes/rightbar.jsp" />
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/metismenu/metisMenu.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/simplebar/simplebar.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/libs/node-waves/waves.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>
    <script>
    // Image preview for add image form
    document.addEventListener('DOMContentLoaded', function() {
        var input = document.getElementById('serviceImageInput');
        var preview = document.getElementById('imagePreview');
        var previewContainer = document.getElementById('previewContainer');
        if (input) {
            input.addEventListener('change', function(event) {
                const file = event.target.files[0];
                if (file && file.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        preview.src = e.target.result;
                        previewContainer.style.display = 'block';
                    };
                    reader.readAsDataURL(file);
                } else {
                    preview.src = '#';
                    previewContainer.style.display = 'none';
                }
            });
        }
    });
    </script>
</body>
</html>

