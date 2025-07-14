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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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
                                deleteBtn.onclick = function(event) {
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