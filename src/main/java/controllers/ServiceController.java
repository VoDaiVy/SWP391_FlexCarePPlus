package controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ServiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        if (actor == null) {
            String action = request.getParameter("action");
            if (action != null && (action.equals("viewListService") || action.equals("viewDetail"))) {
                if (action.equals("viewListService")) {
                    viewListService(request, response);
                } else {
                    viewServiceDetail(request, response);
                }
                return;
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
                viewListService(request, response);
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

        if (action == null) {
            action = "viewListService"; // Default action
        }

        switch (action) {
            case "viewListService":
                viewListService(request, response);
                break;
            case "viewDetail":
                viewServiceDetail(request, response);
                break;
            default:
                viewListService(request, response);
                break;
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
        // To be implemented
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // To be implemented
    }

    // Common methods for all roles
    private void viewListService(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String keyword = request.getParameter("keyword");
            String categoryIdStr = request.getParameter("categoryId");
            String sortParam = request.getParameter("sortBy");
            String pageStr = request.getParameter("page");

            int categoryId = 0;
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                try {
                    categoryId = Integer.parseInt(categoryIdStr);
                } catch (NumberFormatException e) {
                    // Ignore and keep categoryId as 0
                }
            }

            int page = 1;
            int recordsPerPage = 6;

            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    // Keep default page = 1
                }
            }

            String sortField = "Name";
            String sortDirection = "ASC";

            if (sortParam != null) {
                switch (sortParam) {
                    case "name_asc":
                        sortField = "Name";
                        sortDirection = "ASC";
                        break;
                    case "name_desc":
                        sortField = "Name";
                        sortDirection = "DESC";
                        break;
                    case "price_asc":
                        sortField = "Price";
                        sortDirection = "ASC";
                        break;
                    case "price_desc":
                        sortField = "Price";
                        sortDirection = "DESC";
                        break;
                }
            }

            int totalRecords = daos.ServiceDAO.countServices(categoryId, keyword);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

            List<models.Service> services = daos.ServiceDAO.getServicesByFilter(
                    categoryId, keyword, sortField, sortDirection,
                    (page - 1) * recordsPerPage, recordsPerPage);

            List<models.CategoryService> categories = daos.CategoryServiceDAO.getAll();

            request.setAttribute("services", services);
            request.setAttribute("categories", categories);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);

            request.getRequestDispatcher("/client/list-service.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing service list: " + e.getMessage());
        }
    }

    private void viewServiceDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");

            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("service?action=viewListService");
                return;
            }

            int serviceId = Integer.parseInt(idStr);

            models.Service service = daos.ServiceDAO.getById(serviceId);

            if (service == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Service not found");
                return;
            }

            daos.ServiceDAO.incrementViews(serviceId);

            List<models.ServiceImage> serviceImages = daos.ServiceImageDAO.getByServiceId(serviceId);

            List<models.FeedbackService> feedbackServices = daos.FeedbackServiceDAO.getByServiceId(serviceId);
            
            List<dtos.FeedbackServiceDTO> feedbacks = new java.util.ArrayList<>();
            for (models.FeedbackService feedback : feedbackServices) {
                models.UserDetail userDetail = daos.UserDetailDAO.getByUserId(feedback.getUserID());
                dtos.FeedbackServiceDTO feedbackDTO = new dtos.FeedbackServiceDTO();
                feedbackDTO.setRating(feedback.rating);
                feedbackDTO.setDateCreated(feedback.dateCreated);
                feedbackDTO.setDateCreatedString(feedback.getDateCreated());
                feedbackDTO.setComment(feedback.getComment());
                feedbackDTO.setUserDetail(userDetail);
                feedbacks.add(feedbackDTO);
            }

            double averageRating = 0;
            if (feedbackServices != null && !feedbackServices.isEmpty()) {
                int totalRating = 0;
                for (models.FeedbackService feedback : feedbackServices) {
                    totalRating += feedback.getRating();
                }
                averageRating = (double) totalRating / feedbacks.size();
            }

            Map<Integer, Integer> starCounts = new HashMap<>();
            for (int i = 1; i <= 5; i++) {
                starCounts.put(i, 0);
            }

            if (feedbackServices != null) {
                for (models.FeedbackService feedback : feedbackServices) {
                    int stars = feedback.getRating();
                    starCounts.put(stars, starCounts.getOrDefault(stars, 0) + 1);
                }
            }

            List<models.Service> relatedServices = daos.ServiceDAO.getRelatedServices(serviceId, service.getCategoryServiceID(), 4);

            request.setAttribute("service", service);
            request.setAttribute("serviceImages", serviceImages);
            request.setAttribute("feedbacks", feedbacks);
            request.setAttribute("relatedServices", relatedServices);
            request.setAttribute("averageRating", averageRating);
            request.setAttribute("starCounts", starCounts);

            request.getRequestDispatcher("/client/service-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("service?action=viewListService");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing service detail: " + e.getMessage());
        }
    }

    // Phương thức quản lý dịch vụ cho admin
    private void manageServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Logic quản lý dịch vụ dành cho admin
            // Có thể triển khai sau

            // Forward đến trang quản lý dịch vụ cho admin
            request.getRequestDispatcher("/admin/manage-services.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error in service management: " + e.getMessage());
        }
    }
}
