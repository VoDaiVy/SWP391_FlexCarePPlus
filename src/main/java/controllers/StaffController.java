/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "StaffController", urlPatterns = {"/staff"})
public class StaffController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getBookings" -> {
                getBookings(request, response);
            }
            case "getMessages" -> {
                getMessages(request, response);
            }
            case "getCustomers" -> {
                getCustomers(request, response);
            }
            case "getCustomerPets" -> {
                getCustomerPets(request, response);
            } 
            case "getMedicalRecords" -> {
                getMedicalRecords(request, response);
            } 
            case "getMedicalDetail" -> {
                getMedicalDetail(request, response);
            } 
            case "createMedicalRecord" -> {
                createMedicalRecord(request, response);
            } 
            case "getNews" -> {
                getNews(request, response);
            } 
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    private void getBookings(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("bookingdetail").forward(request, response);
    }

    private void getMessages(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("message").forward(request, response);
    }
    
    private void getCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("user").forward(request, response);
    }
    private void getCustomerPets(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("userpet").forward(request, response);
    }
    private void getMedicalRecords(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("medicalrecords").forward(request, response);
    }
    private void getMedicalDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("medicalrecords").forward(request, response);
    }
    private void createMedicalRecord(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("medicalrecords").forward(request, response);
    }
    private void getNews(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("news").forward(request, response);
    }
}
