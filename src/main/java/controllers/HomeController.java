package controllers;

import daos.NewsDAO;
import daos.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.News;
import models.Service;
import utils.ConfigGetter;

public class HomeController extends HttpServlet {
//set actor
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        if (actor == null) {
            customerView(request, response);
        } else {
            switch (actor) {
                case "admin":
                    break;
                case "customer":
                    customerView(request, response);
                    break;
                case "staff":
                    break;
                default:
                    break;
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    private void customerView(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String APIkey = ConfigGetter.getProperty("gemini.api");
        request.setAttribute("msg", "Hello Homepage");
        request.setAttribute("apiKey", APIkey);

        List<Service> serviceList = ServiceDAO.getAll();
        List<News> newsList = NewsDAO.getAllActive();
        List<Service> topServices = serviceList.stream()
                .sorted((s1, s2) -> Integer.compare(s2.getViews(), s1.getViews()))
                .limit(6)
                .toList();
        List<News> latestNews = newsList.stream().limit(2).toList();

        request.setAttribute("serviceList", topServices);
        request.setAttribute("newsList", latestNews);
        request.getRequestDispatcher("/client/homepage.jsp").forward(request, response);
    }
}
