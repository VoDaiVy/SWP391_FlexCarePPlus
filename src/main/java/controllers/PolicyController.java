package controllers;

import daos.PolicyDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Policy;

public class PolicyController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        if (actor == null) {
            // Handle guest access for policy viewing
            String action = request.getParameter("action");
            switch (action) {
                case "viewListPolicy" -> {
                    viewListPolicy(request, response);
                }
                case "viewPolicyDetail" -> {
                    viewPolicyDetail(request, response);
                }
                default -> {
                    response.sendRedirect("./");
                }
            }
            return;
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
        String action = request.getParameter("action");
        switch (action) {
            case "getPolicies" -> {
                request.setAttribute("policies", PolicyDAO.getAll());
                request.getRequestDispatcher("adminPages/policies.jsp").forward(request, response);
            }
            case "getPolicyDetail" -> {
                String idString = request.getParameter("id");
                if (idString != null) {
                    int policyID = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("policy", PolicyDAO.getById(policyID));
                }
                request.getRequestDispatcher("adminPages/policyDetail.jsp").forward(request, response);
            }
        }
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "updatePolicy" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                Policy policy = PolicyDAO.getById(id);
                policy.setTitle(title);
                policy.setDescription(description);
                PolicyDAO.update(policy);
                response.sendRedirect("admin?action=getPolicyDetail&id=" + id);
            }
            case "createPolicy" -> {
                String title = request.getParameter("title");
                String description = request.getParameter("description");
                Policy policy = new Policy();
                policy.setTitle(title);
                policy.setDescription(description);
                policy.setStatus(true);
                PolicyDAO.create(policy);
                response.sendRedirect("admin?action=getPolicies");
            }
            case "deletePolicy" -> {
                int id = Integer.parseInt(request.getParameter("id"));
                PolicyDAO.hardDelete(id);
                response.sendRedirect("admin?action=getPolicies");
            }
        }
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
            case "viewListPolicy" -> {
                viewListPolicy(request, response);
            }
            case "viewPolicyDetail" -> {
                viewPolicyDetail(request, response);
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
    
    // Common methods for policy functionality
    private void viewListPolicy(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get page parameter, default to 1
            String pageStr = request.getParameter("page");
            int page = 1;
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            }
            
            // Set records per page
            int recordsPerPage = 9;
            
            // Get search parameter
            String keyword = request.getParameter("keyword");
            if (keyword != null) {
                keyword = keyword.trim();
                if (keyword.isEmpty()) {
                    keyword = null;
                }
            }
            
            // Get active policies with search functionality
            List<Policy> allPolicies;
            if (keyword != null && !keyword.isEmpty()) {
                allPolicies = PolicyDAO.searchByTitle(keyword);
            } else {
                allPolicies = PolicyDAO.getAllActive();
            }
            
            // Calculate pagination
            int totalRecords = allPolicies.size();
            int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);
            
            // Get policies for current page
            int start = (page - 1) * recordsPerPage;
            int end = Math.min(start + recordsPerPage, totalRecords);
            List<Policy> policiesForPage = allPolicies.subList(start, end);
            
            // Set attributes for JSP
            request.setAttribute("policyList", policiesForPage);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("keyword", keyword);
            
            // Forward to policy listing page
            request.getRequestDispatcher("/client/list-policy.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("policy?action=viewListPolicy");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing policy list: " + e.getMessage());
        }
    }
    
    private void viewPolicyDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String idStr = request.getParameter("id");
            
            if (idStr == null || idStr.isEmpty()) {
                response.sendRedirect("policy?action=viewListPolicy");
                return;
            }
            
            int policyId = Integer.parseInt(idStr);
            
            // Get policy by ID
            Policy policy = PolicyDAO.getById(policyId);
            
            if (policy == null || !policy.isStatus()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Policy not found");
                return;
            }
            
            // Get related policies (recent policies excluding current one)
            List<Policy> relatedPolicies = PolicyDAO.getAllActive();
            relatedPolicies.removeIf(p -> p.getPolicyID() == policyId);
            if (relatedPolicies.size() > 4) {
                relatedPolicies = relatedPolicies.subList(0, 4);
            }
            
            // Set attributes for JSP
            request.setAttribute("policy", policy);
            request.setAttribute("relatedPolicies", relatedPolicies);
            
            // Forward to policy detail page
            request.getRequestDispatcher("/client/policy-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect("policy?action=viewListPolicy");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing policy detail: " + e.getMessage());
        }
    }
}
