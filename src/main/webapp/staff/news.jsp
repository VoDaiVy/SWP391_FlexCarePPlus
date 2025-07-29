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
        .search-section {
            background-color: white;
            padding: 30px 0;
            margin-bottom: 30px;
        }

        .search-box {
            max-width: 500px;
            margin: 0 auto;
        }

        .search-input {
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            padding: 12px 20px;
            font-size: 16px;
        }

        .search-input:focus {
            border-color: var(--primary-green);
            box-shadow: 0 0 0 0.2rem rgba(124, 179, 66, 0.25);
        }

        .search-btn {
            background-color: var(--primary-green);
            border: none;
            border-radius: 25px;
            padding: 12px 25px;
            color: white;
            font-weight: 500;
        }

        .search-btn:hover {
            background-color: var(--light-green);
        }

        .news-container {
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .news-link {
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .news-link:hover {
            text-decoration: none;
            color: inherit;
        }

        .news-item {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s ease;
            background-color: white;
            display: flex;
            align-items: center;
            gap: 20px;
            position: relative;
        }

        .news-link:hover .news-item {
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            transform: translateY(-2px);
            border-color: var(--primary-green);
        }

        .news-image {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            flex-shrink: 0;
        }

        .news-content {
            flex-grow: 1;
        }

        .news-title {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark-gray);
            margin-bottom: 10px;
            line-height: 1.4;
        }

        .news-meta {
            display: flex;
            align-items: center;
            gap: 20px;
            font-size: 14px;
            color: #666;
        }

        .view-count {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .news-date {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .news-actions {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-shrink: 0;
        }

        .delete-btn {
            background-color: #dc3545;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 12px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
        }

        .delete-btn:hover {
            background-color: #c82333;
            color: white;
            text-decoration: none;
            transform: scale(1.05);
        }

        .delete-btn:focus {
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(220, 53, 69, 0.25);
        }

        .page-title {
            color: var(--dark-gray);
            font-weight: 700;
            margin-bottom: 30px;
            text-align: center;
        }

        .no-results {
            text-align: center;
            padding: 40px;
            color: #666;
        }

        .pagination-container {
            margin-top: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .pagination-btn {
            background-color: white;
            border: 2px solid #e0e0e0;
            color: var(--dark-gray);
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .pagination-btn:hover {
            background-color: var(--light-green);
            border-color: var(--primary-green);
            color: white;
        }

        .pagination-btn.active {
            background-color: var(--primary-green);
            border-color: var(--primary-green);
            color: white;
        }

        .pagination-btn:disabled {
            background-color: #f5f5f5;
            border-color: #e0e0e0;
            color: #ccc;
            cursor: not-allowed;
        }

        .pagination-btn:disabled:hover {
            background-color: #f5f5f5;
            border-color: #e0e0e0;
            color: #ccc;
        }

        .pagination-info {
            color: #666;
            font-size: 14px;
            margin: 0 15px;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-active {
            background-color: #e6f7e6;
            color: #2e7d32;
        }

        .status-inactive {
            background-color: #ffebee;
            color: #c62828;
        }

        @media (max-width: 768px) {
            .news-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .news-image {
                width: 100%;
                height: 120px;
            }

            .news-meta {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .news-actions {
                width: 100%;
                justify-content: flex-end;
            }
        }
    </style>
    <body>

        <!-- Search Section -->
        <div class="search-section">
            <div class="container">
                <div class="search-box">
                    <div class="input-group">
                        <input type="text" class="form-control search-input" id="searchInput" placeholder="Tìm kiếm tin tức...">
                        <button class="btn search-btn" type="button" onclick="searchNews()">
                            <i class="fas fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Nút tạo tin tức mới -->
        <div class="container mb-3" style="text-align:right;">
            <a href="staff?action=getCreateNews" class="btn btn-primary" style="min-width:180px;">
                <i class="fas fa-plus"></i> Tạo tin tức mới
            </a>
            <button type="button" class="btn btn-success ms-2" data-bs-toggle="modal" data-bs-target="#aiGenNewsModal">
                <i class="fas fa-robot"></i> Tạo mới với AI
            </button>
        </div>

        <!-- News Content -->
        <div class="container mb-5">
            <div class="news-container">
                <h2 class="page-title">Tin Tức Mới Nhất</h2>

                <div id="newsContainer">
                    <!-- News items will be populated by JavaScript -->
                </div>

                <div id="noResults" class="no-results" style="display: none;">
                    <i class="fas fa-search" style="font-size: 48px; color: #ccc; margin-bottom: 20px;"></i>
                    <h4>Không tìm thấy kết quả</h4>
                    <p>Không có tin tức nào phù hợp với từ khóa tìm kiếm của bạn.</p>
                </div>

                <!-- Pagination -->
                <div id="paginationContainer" class="pagination-container">
                    <!-- Pagination will be populated by JavaScript -->
                </div>
            </div>
        </div>
        <!-- Modal AI Gen News -->
        <div class="modal fade" id="aiGenNewsModal" tabindex="-1" aria-labelledby="aiGenNewsModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form id="aiGenNewsForm" autocomplete="off">
                        <div class="modal-header">
                            <h5 class="modal-title" id="aiGenNewsModalLabel"><i class="fas fa-robot"></i> Tạo tin tức bằng AI</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Đóng"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="aiTopic" class="form-label">Chủ đề tin tức</label>
                                <input type="text" class="form-control" id="aiTopic" name="aiTopic" placeholder="Nhập chủ đề tin tức..." required>
                            </div>
                            <div class="mb-3">
                                <button type="button" class="btn btn-primary" id="aiGenBtn">
                                    <i class="fas fa-magic"></i> AIGEN
                                </button>
                            </div>
                            <div id="aiGenResult" style="margin-bottom:20px;"></div>
                            <div id="aiGenImageSection" style="display:none;">
                                <label class="form-label">Ảnh AI sinh ra</label>
                                <div id="ai-gen-single-image-preview"></div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                            <button type="button" class="btn btn-success" id="aiAddNewsBtn">
                                <i class="fas fa-plus"></i> Thêm tin tức
                            </button>
                        </div>
                        <input type="hidden" id="aiGenImage" name="aiGenImage">
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://esm.run/@google/generative-ai"></script>
        <script type="module">
                            import { GoogleGenAI, Modality } from "https://esm.run/@google/genai";
                            const ai = new GoogleGenAI({apiKey: "AIzaSyARZh7ZkALP9zrvJ5l99vAFfILIQWtHU0k"});
                            document.getElementById('aiGenBtn').onclick = async function () {
                                const topic = document.getElementById('aiTopic').value.trim();
                                const resultDiv = document.getElementById('aiGenResult');
                                resultDiv.innerHTML = '';
                                if (!topic) {
                                    resultDiv.innerHTML = '<div class="alert alert-danger">Vui lòng nhập chủ đề!</div>';
                                    return;
                                }
                                resultDiv.innerHTML = '<div class="alert alert-info">Đang sinh nội dung AI, vui lòng chờ...</div>';

                                try {
                                    const res = await fetch('${pageContext.request.contextPath}/aiGenInfo', {
                                        method: 'POST',
                                        headers: {'Content-Type': 'application/json'},
                                        body: JSON.stringify({topic: topic})
                                    });
                                    const dataR = await res.json();
                                    if (dataR.title && dataR.content) {
                                        resultDiv.innerHTML = `
                                            <div class="mb-3">
                                                <label class="form-label">Tiêu đề AI sinh ra</label>
                                                <input type="text" class="form-control" id="aiGenTitle" value="` + dataR.title + `" readonly>
                                            </div>
                                            <div class="mb-3">
                                                <label class="form-label">Nội dung AI sinh ra</label>
                                                <textarea class="form-control" id="aiGenContent" rows="6" readonly>` + dataR.content + `</textarea>
                                            </div>
                                            <button type="button" class="btn btn-warning" id="aiGenSingleImageBtn">
                                                <i class="fas fa-image"></i> Sinh ảnh AI cho tin tức
                                            </button>
                                        `;
                                        document.getElementById('aiGenImageSection').style.display = 'block';
                                    } else {
                                        resultDiv.innerHTML = '<div class="alert alert-warning">Không nhận được kết quả từ AI!</div>';
                                    }
                                } catch (e) {
                                    resultDiv.innerHTML = '<div class="alert alert-danger">Lỗi khi gọi AI: ' + e.message + '</div>';
                                }
                            };

                            document.addEventListener('click', async function (e) {
                                if (e.target && e.target.id === 'aiGenSingleImageBtn') {
                                    const prompt = document.getElementById('aiGenTitle').value || document.getElementById('aiTopic').value;
                                    const previewDiv = document.getElementById('ai-gen-single-image-preview');
                                    previewDiv.innerHTML = '';
                                    if (!prompt) {
                                        previewDiv.innerHTML = '<div class="alert alert-danger">Vui lòng nhập mô tả để sinh ảnh!</div>';
                                        return;
                                    }
                                    previewDiv.innerHTML = '<div class="alert alert-info">Đang sinh ảnh AI, vui lòng chờ...</div>';

                                    let imageUrl = null;
                                    try {
                                        const response = await ai.models.generateContent({
                                            model: "gemini-2.0-flash-preview-image-generation",
                                            contents: [{role: "user", parts: [{text: prompt}]}],
                                            config: {
                                                responseModalities: [Modality.TEXT, Modality.IMAGE],
                                            },
                                        });
                                        for (const part of response.candidates[0].content.parts) {
                                            if (part.inlineData) {
                                                const imageData = part.inlineData.data;
                                                imageUrl = "data:image/png;base64," + imageData;
                                                break;
                                            }
                                        }
                                    } catch (e) {
                                        imageUrl = null;
                                    }

                                    if (imageUrl) {
                                        previewDiv.innerHTML = '<div class="alert alert-info">Đang upload ảnh lên S3...</div>';
                                        try {
                                            const res = await fetch('${pageContext.request.contextPath}/aiGenImage', {
                                                method: 'POST',
                                                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                                body: 'imageData=' + encodeURIComponent(imageUrl)
                                            });
                                            const dataR = await res.json();
                                            if (dataR.url) {
                                                previewDiv.innerHTML = `
                                                    <div style="text-align:center;">
                                                        <img src="` + dataR.url + `" alt="AI Image" style="max-width:220px;max-height:220px;border-radius:8px;border:2px solid #e65100;display:block;margin-bottom:8px;">
                                                        <a href="` + dataR.url + `" download="ai-image.png" class="btn btn-outline btn-sm" target="_blank" rel="noopener noreferrer">
                                                            <i class="fas fa-download me-2"></i>Tải ảnh
                                                        </a>
                                                    </div>
                                                `;
                                            } else {
                                                previewDiv.innerHTML = '<div class="alert alert-warning">Không upload được ảnh lên S3!</div>';
                                            }
                                            document.getElementById('aiGenImage').value = dataR.url || "";
                                        } catch (e) {
                                            previewDiv.innerHTML = '<div class="alert alert-danger">Lỗi upload ảnh: ' + e.message + '</div>';
                                        }
                                    } else {
                                        previewDiv.innerHTML = '<div class="alert alert-warning">Không nhận được ảnh nào từ AI!</div>';
                                        document.getElementById('aiGenImage').value = "";
                                    }
                                }
                            });

                            document.getElementById('aiAddNewsBtn').onclick = async function () {
                                const title = document.getElementById('aiGenTitle')?.value?.trim();
                                const content = document.getElementById('aiGenContent')?.value?.trim();
                                const imgURL = document.getElementById('aiGenImage')?.value?.trim();

                                if (!title || !content || !imgURL) {
                                    alert('Vui lòng sinh đầy đủ tiêu đề, nội dung và ảnh AI trước khi thêm!');
                                    return;
                                }

                                try {
                                    const res = await fetch('${pageContext.request.contextPath}/staff', {
                                        method: 'POST',
                                        body: new URLSearchParams({
                                            action: 'createNewsAI',
                                            aiGenTitle: title,
                                            aiGenContent: content,
                                            aiGenImage: imgURL
                                        })
                                    });
                                    const text = await res.text();
                                    window.location.reload();
                                } catch (e) {
                                    alert('Lỗi khi thêm tin tức: ' + e.message);
                                }
                            };
        </script>
        <script>
            // Lấy dữ liệu JSON từ request attribute
            var newsData = ${data};
            var filteredNews = newsData.slice();
            var currentPage = 1;
            var itemsPerPage = 7;

            function formatDate(dateString) {
                // Chuyển đổi chuỗi ngày từ JSON sang định dạng hiển thị
                var parts = dateString.split('-');
                if (parts.length === 3) {
                    var year = parts[0];
                    var month = parts[1];
                    var day = parts[2];

                    // Chuyển đổi tháng từ số sang tên
                    var monthNames = [
                        "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6",
                        "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"
                    ];

                    var monthName = monthNames[parseInt(month) - 1];
                    return day + " " + monthName + ", " + year;
                }
                return dateString;
            }

            function formatViews(views) {
                if (views >= 1000) {
                    return (views / 1000).toFixed(1) + 'K';
                }
                return views.toString();
            }

            function confirmDelete(event, newsId, newsTitle) {
                event.preventDefault();
                event.stopPropagation();

                if (confirm('Bạn có chắc chắn muốn xóa tin tức "' + newsTitle + '"?')) {
                    window.location.href = 'DeleteNewsServlet?id=' + newsId;
                }
            }

            function createNewsItem(news) {
                // Tạo container chính
                var newsContainer = document.createElement('div');
                newsContainer.className = 'news-item';

                // Tạo thẻ a cho phần nội dung tin tức
                var newsLink = document.createElement('a');
                newsLink.className = 'news-link';
                newsLink.href = 'staff?action=getNewsById&id=' + news.newsID;
                newsLink.style.cssText = 'flex-grow: 1; display: flex; align-items: center; gap: 20px; text-decoration: none; color: inherit;';

                var image = document.createElement('img');
                // Sử dụng imgURL từ dữ liệu, hoặc placeholder nếu không có
                image.src = news.imgURL || "/placeholder.svg?height=60&width=80";
                image.alt = news.title;
                image.className = 'news-image';

                var newsContent = document.createElement('div');
                newsContent.className = 'news-content';

                var title = document.createElement('div');
                title.className = 'news-title';
                title.textContent = news.title;

                var meta = document.createElement('div');
                meta.className = 'news-meta';

                var dateDiv = document.createElement('div');
                dateDiv.className = 'news-date';
                dateDiv.innerHTML = '<i class="fas fa-calendar-alt"></i><span>' + formatDate(news.dateCreated) + '</span>';

                var viewDiv = document.createElement('div');
                viewDiv.className = 'view-count';
                viewDiv.innerHTML = '<i class="fas fa-eye"></i><span>' + formatViews(news.views) + ' lượt xem</span>';

                var statusDiv = document.createElement('div');
                if (news.status) {
                    statusDiv.className = 'status-badge status-active';
                    statusDiv.textContent = 'Đang hiển thị';
                } else {
                    statusDiv.className = 'status-badge status-inactive';
                    statusDiv.textContent = 'Ẩn';
                }

                meta.appendChild(dateDiv);
                meta.appendChild(viewDiv);
                meta.appendChild(statusDiv);

                newsContent.appendChild(title);
                newsContent.appendChild(meta);

                newsLink.appendChild(image);
                newsLink.appendChild(newsContent);

                // Tạo phần actions (nút xóa)
                var actionsDiv = document.createElement('div');
                actionsDiv.className = 'news-actions';


                // Tạo form xóa (POST)
                var deleteForm = document.createElement('form');
                deleteForm.action = 'staff';
                deleteForm.method = 'post';
                deleteForm.style.display = 'inline';

                var hiddenId = document.createElement('input');
                hiddenId.type = 'hidden';
                hiddenId.name = 'newsID';
                hiddenId.value = news.newsID;
                deleteForm.appendChild(hiddenId);

                var deleteBtn = document.createElement('button');
                deleteBtn.type = 'submit';
                deleteBtn.className = 'delete-btn';
                deleteBtn.name = 'action';
                deleteBtn.value = 'deleteNews';
                deleteBtn.title = 'Xóa tin tức';
                deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
                deleteBtn.onclick = function (event) {
                    if (!confirm('Bạn có chắc chắn muốn xóa tin tức "' + news.title + '"?')) {
                        event.preventDefault();
                    }
                };
                deleteForm.appendChild(deleteBtn);

                actionsDiv.appendChild(deleteForm);

                // Ghép tất cả lại
                newsContainer.appendChild(newsLink);
                newsContainer.appendChild(actionsDiv);

                return newsContainer;
            }

            function getCurrentPageData() {
                var startIndex = (currentPage - 1) * itemsPerPage;
                var endIndex = startIndex + itemsPerPage;
                return filteredNews.slice(startIndex, endIndex);
            }

            function getTotalPages() {
                return Math.ceil(filteredNews.length / itemsPerPage);
            }

            function renderNews() {
                var container = document.getElementById('newsContainer');
                var noResults = document.getElementById('noResults');
                var paginationContainer = document.getElementById('paginationContainer');

                if (filteredNews.length === 0) {
                    container.innerHTML = '';
                    noResults.style.display = 'block';
                    paginationContainer.style.display = 'none';
                    return;
                }

                noResults.style.display = 'none';
                paginationContainer.style.display = 'flex';

                var currentPageData = getCurrentPageData();
                container.innerHTML = '';

                for (var i = 0; i < currentPageData.length; i++) {
                    var newsItem = createNewsItem(currentPageData[i]);
                    container.appendChild(newsItem);
                }

                renderPagination();
            }

            function renderPagination() {
                var paginationContainer = document.getElementById('paginationContainer');
                var totalPages = getTotalPages();

                paginationContainer.innerHTML = '';

                // Previous button
                var prevBtn = document.createElement('button');
                prevBtn.className = 'pagination-btn';
                prevBtn.innerHTML = '<i class="fas fa-chevron-left"></i> Trước';
                prevBtn.disabled = currentPage === 1;
                prevBtn.onclick = function () {
                    if (currentPage > 1) {
                        currentPage--;
                        renderNews();
                    }
                };
                paginationContainer.appendChild(prevBtn);

                // Page info
                var pageInfo = document.createElement('div');
                pageInfo.className = 'pagination-info';
                pageInfo.textContent = 'Trang ' + currentPage + ' / ' + totalPages;
                paginationContainer.appendChild(pageInfo);

                // Page numbers
                var startPage = Math.max(1, currentPage - 2);
                var endPage = Math.min(totalPages, currentPage + 2);

                for (var i = startPage; i <= endPage; i++) {
                    var pageBtn = document.createElement('button');
                    pageBtn.className = 'pagination-btn';
                    if (i === currentPage) {
                        pageBtn.className += ' active';
                    }
                    pageBtn.textContent = i;
                    pageBtn.onclick = (function (page) {
                        return function () {
                            currentPage = page;
                            renderNews();
                        };
                    })(i);
                    paginationContainer.appendChild(pageBtn);
                }

                // Next button
                var nextBtn = document.createElement('button');
                nextBtn.className = 'pagination-btn';
                nextBtn.innerHTML = 'Sau <i class="fas fa-chevron-right"></i>';
                nextBtn.disabled = currentPage === totalPages;
                nextBtn.onclick = function () {
                    if (currentPage < totalPages) {
                        currentPage++;
                        renderNews();
                    }
                };
                paginationContainer.appendChild(nextBtn);
            }

            function searchNews() {
                var searchTerm = document.getElementById('searchInput').value.toLowerCase().trim();

                if (searchTerm === '') {
                    filteredNews = newsData.slice();
                } else {
                    filteredNews = [];
                    for (var i = 0; i < newsData.length; i++) {
                        var news = newsData[i];
                        if (news.title.toLowerCase().indexOf(searchTerm) !== -1 ||
                                (news.description && news.description.toLowerCase().indexOf(searchTerm) !== -1)) {
                            filteredNews.push(news);
                        }
                    }
                }

                currentPage = 1; // Reset về trang đầu khi tìm kiếm
                renderNews();
            }

            // Search on Enter key press
            document.getElementById('searchInput').addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    searchNews();
                }
            });

            // Real-time search
            document.getElementById('searchInput').addEventListener('input', function () {
                setTimeout(searchNews, 300);
            });

            // Initial render
            renderNews();
        </script>
    </body>
</html>