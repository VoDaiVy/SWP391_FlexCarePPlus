package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import daos.NewsDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.time.LocalDate;
import java.util.List;
import models.News;
import utils.LocalDateAdapter;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class NewsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        if (actor == null) {
            String action = request.getParameter("action");
            switch (action) {
                case "viewListNews" -> {
                    viewListNews(request, response);
                }
                case "viewNewsDetail" -> {
                    viewNewsDetail(request, response);
                }
                default -> {
                    response.sendRedirect("./");
                }
            }
        }
        switch (actor) {
            case "admin":
                adminGet(request, response);
                break;
            case "customer":
                customerGet(request, response);
                break;
            case "staff":
                staffGet(request, response);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin":
                adminPost(request, response);
                break;
            case "customer":
                customerPost(request, response);
                break;
            case "staff":
                staffPost(request, response);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin":
                adminPut(request, response);
                break;
            case "customer":
                customerPut(request, response);
                break;
            case "staff":
                staffPut(request, response);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        switch (actor) {
            case "admin":
                adminDelete(request, response);
                break;
            case "customer":
                customerDelete(request, response);
                break;
            case "staff":
                staffDelete(request, response);
                break;
            default:
                response.sendRedirect("./");
                break;
        }
    }

    // Admin role methods
    private void adminGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "viewListNews" -> {
                viewListNews(request, response);
            }
            case "viewNewsDetail" -> {
                viewNewsDetail(request, response);
            }
            default -> {
                response.sendRedirect("./");
            }
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void customerDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getNews" -> {
                List<News> listNews = NewsDAO.getAll();
                Gson gson = new GsonBuilder()
                        .registerTypeAdapter(LocalDate.class, new LocalDateAdapter())
                        .create();
                String data = gson.toJson(listNews);
                System.out.println(data);
                request.setAttribute("data", data);
                request.getRequestDispatcher("staff/news.jsp").forward(request, response);
            }
            case "getNewsById" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                News news = NewsDAO.getById(id);
                request.setAttribute("news", news);
                request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
            }
            case "deleteNews" -> {
                int newsId = Integer.parseInt(request.getParameter("id"));
                NewsDAO.hardDelete(newsId);
                response.sendRedirect("staff?action=getNews");
            }
        }
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "createNews" -> {
                // Xử lý tạo mới tin tức
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                Part imagePart = request.getPart("newImage");
                String imgURL = null;
                if (imagePart != null && imagePart.getSize() > 0) {
                    try (java.io.InputStream is = imagePart.getInputStream()) {
                        String fileName = imagePart.getSubmittedFileName();
                        imgURL = utils.S3Uploader.uploadToS3(is, fileName, imagePart.getSize());
                    } catch (Exception e) {
                        request.setAttribute("message", "Lỗi upload ảnh: " + e.getMessage());
                        request.setAttribute("type", "danger");
                        request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                        return;
                    }
                }
                News news = new News();
                news.setTitle(title);
                news.setDescription(description);
                news.setViews(0);
                news.setImgURL(imgURL);
                news.setDateCreated(java.time.LocalDate.now());
                news.setStatus(true);
                boolean created = daos.NewsDAO.create(news);
                if (created) {
                    request.setAttribute("message", "Thêm tin tức thành công!");
                    request.setAttribute("type", "success");
                    request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
//                    response.sendRedirect("staff?action=getNewsById&id=" + news.getNewsID() + "&message=Thêm tin tức thành công&type=success");
                } else {
                    request.setAttribute("message", "Tạo tin tức thất bại!");
                    request.setAttribute("type", "danger");
                    request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                }
            }
            case "createNewsAI" -> {
                String title = request.getParameter("aiGenTitle");
                String description = request.getParameter("aiGenContent");
                String imgURL = request.getParameter("aiGenImage");

                News news = new News();
                news.setTitle(title);
                news.setDescription(description);
                news.setViews(0);
                news.setImgURL(imgURL);
                news.setDateCreated(java.time.LocalDate.now());
                news.setStatus(true);

                boolean created = daos.NewsDAO.create(news);
                if (created) {
                    request.setAttribute("message", "Thêm tin tức AI thành công!");
                    request.setAttribute("type", "success");
                    request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "Tạo tin tức AI thất bại!");
                    request.setAttribute("type", "danger");
                    request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                }
            }
            case "updateNews" -> {
                // Xử lý cập nhật tin tức
                try {
                    int newsID = Integer.parseInt(request.getParameter("newsID"));
                    String title = request.getParameter("title");
                    String description = request.getParameter("description");
                    News news = daos.NewsDAO.getById(newsID);
                    if (news == null) {
                        request.setAttribute("message", "Không tìm thấy tin tức để cập nhật!");
                        request.setAttribute("type", "danger");
                        request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                        return;
                    }
                    news.setTitle(title);
                    news.setDescription(description);
                    Part imagePart = request.getPart("newImage");
                    if (imagePart != null && imagePart.getSize() > 0) {
                        try (java.io.InputStream is = imagePart.getInputStream()) {
                            String fileName = imagePart.getSubmittedFileName();
                            String imgURL = utils.S3Uploader.uploadToS3(is, fileName, imagePart.getSize());
                            news.setImgURL(imgURL);
                        } catch (Exception e) {
                            request.setAttribute("message", "Lỗi upload ảnh: " + e.getMessage());
                            request.setAttribute("type", "danger");
                            request.setAttribute("news", news);
                            request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                            return;
                        }
                    }
                    boolean updated = daos.NewsDAO.update(news);
                    if (updated) {
                        request.setAttribute("message", "Cập nhật tin tức thành công!");
                        request.setAttribute("type", "success");
                        request.setAttribute("news", news);
                        request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
//                        response.sendRedirect("staff?action=getNewsById&id=" + newsID + "&message=Cập nhật tin tức thành công&type=success");
                    } else {
                        request.setAttribute("message", "Cập nhật tin tức thất bại!");
                        request.setAttribute("type", "danger");
                        request.setAttribute("news", news);
                        request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                    }
                } catch (ServletException | IOException | NumberFormatException ex) {
                    request.setAttribute("message", "Lỗi cập nhật tin tức: " + ex.getMessage());
                    request.setAttribute("type", "danger");
                    request.getRequestDispatcher("staff/newsDetail.jsp").forward(request, response);
                }
            }
            case "deleteNews" -> {
                int newsID = Integer.parseInt(request.getParameter("newsID"));
                daos.NewsDAO.hardDelete(newsID);
                response.sendRedirect("staff?action=getNews");
            }
        }
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Common methods for customer news functionality
    private void viewListNews(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int page = 1;
            int recordsPerPage = 9;

            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                page = Integer.parseInt(pageParam);
            }

            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                keyword = keyword.trim();
                if (keyword.isEmpty()) {
                    keyword = null;
                }
            }

            List<News> allNews;
            if (keyword != null && !keyword.isEmpty()) {
                allNews = NewsDAO.searchByTitle(keyword);
            } else {
                allNews = NewsDAO.getAllActive();
            }

            int totalRecords = allNews.size();
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

            int start = (page - 1) * recordsPerPage;
            int end = Math.min(start + recordsPerPage, totalRecords);
            List<News> newsForPage = allNews.subList(start, end);

            request.setAttribute("newsList", newsForPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("/client/list-news.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("news?action=viewListNews");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing news list: " + e.getMessage());
        }
    }

    private void viewNewsDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");

            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("news?action=viewListNews");
                return;
            }

            int newsId = Integer.parseInt(idStr);

            News news = NewsDAO.getById(newsId);

            if (news == null || !news.isStatus()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "News not found");
                return;
            }

            NewsDAO.incrementViews(newsId);

            List<models.NewsImage> newsImages = daos.NewsImageDAO.getByNewsId(newsId);

            List<News> relatedNews = NewsDAO.getRecent(5);
            relatedNews.removeIf(n -> n.getNewsID() == newsId);
            if (relatedNews.size() > 4) {
                relatedNews = relatedNews.subList(0, 4);
            }

            request.setAttribute("news", news);
            request.setAttribute("newsImages", newsImages);
            request.setAttribute("relatedNews", relatedNews);

            request.getRequestDispatcher("/client/news-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("news?action=viewListNews");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing news detail: " + e.getMessage());
        }
    }
}
