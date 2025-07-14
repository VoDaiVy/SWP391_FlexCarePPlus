package controllers;

import daos.ServiceDAO;
import daos.ServiceImageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.Service;
import models.ServiceImage;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class ServiceImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
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
            case "getServiceImages" -> {
                int serviceID = Integer.parseInt(request.getParameter("serviceID"));
                List<ServiceImage> images = ServiceImageDAO.getByServiceId(serviceID);
                Service service = ServiceDAO.getById(serviceID);
                request.setAttribute("images", images);
                request.setAttribute("service", service);
                request.getRequestDispatcher("adminPages/serviceImages.jsp").forward(request, response);
            }
        }
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "addServiceImage" -> {
                int serviceID = Integer.parseInt(request.getParameter("serviceID"));

                jakarta.servlet.http.Part imagePart = request.getPart("serviceImage");
                if (imagePart != null && imagePart.getSize() > 0) {
                    String fileName = imagePart.getSubmittedFileName();
                    try (java.io.InputStream is = imagePart.getInputStream()) {
                        String imgURL = utils.S3Uploader.uploadToS3(is, fileName, imagePart.getSize());
                        ServiceImage img = new ServiceImage();
                        img.setServiceID(serviceID);
                        img.setImgURL(imgURL);
                        ServiceImageDAO.create(img);
                    }
                }

                response.sendRedirect("admin?action=getServiceImages&serviceID=" + serviceID);
            }
            case "deleteServiceImage" -> {
                int serviceImageID = Integer.parseInt(request.getParameter("serviceImageID"));
                ServiceImage img = ServiceImageDAO.getById(serviceImageID);

                utils.S3Uploader.deleteFromS3(img.getImgURL());
                ServiceImageDAO.delete(serviceImageID);
                
                response.sendRedirect("admin?action=getServiceImages&serviceID=" + img.getServiceID());
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
        // To be implemented
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
}
