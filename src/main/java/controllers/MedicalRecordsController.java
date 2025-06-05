package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import daos.MedicalRecordsDAO;
import daos.UserPetDAO;
import models.MedicalRecords;
import models.UserPet;
import dtos.MedicalRecordsDTO;
import java.util.List;
import java.util.Date;

public class MedicalRecordsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String)request.getSession().getAttribute("actor");
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
        String actor = (String)request.getSession().getAttribute("actor");
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
        String actor = (String)request.getSession().getAttribute("actor");
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
        String actor = (String)request.getSession().getAttribute("actor");
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
        
        if (action == null || action.isEmpty()) {
//            List<MedicalRecords> records = MedicalRecordsDAO.getAll();
//            request.setAttribute("records", records);
//            request.getRequestDispatcher("/admin/medicalrecords/list.jsp").forward(request, response);
        } else if ("viewByPet".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            List<MedicalRecords> records = MedicalRecordsDAO.getByUserPetId(userPetID);
            UserPet userPet = UserPetDAO.getById(userPetID);
            request.setAttribute("records", records);
            request.setAttribute("userPet", userPet);
            request.getRequestDispatcher("/admin/medicalrecords/list_by_pet.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            int recordID = Integer.parseInt(request.getParameter("recordID"));
            MedicalRecords record = MedicalRecordsDAO.getById(recordID);
            request.setAttribute("record", record);
            request.getRequestDispatcher("/admin/medicalrecords/view.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            UserPet userPet = UserPetDAO.getById(userPetID);
            request.setAttribute("userPet", userPet);
            request.getRequestDispatcher("/admin/medicalrecords/add.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int recordID = Integer.parseInt(request.getParameter("recordID"));
            MedicalRecords record = MedicalRecordsDAO.getById(recordID);
            request.setAttribute("record", record);
            request.getRequestDispatcher("/admin/medicalrecords/edit.jsp").forward(request, response);
        }
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            String diagnosis = request.getParameter("diagnosis");
            String treatment = request.getParameter("treatment");
            String medications = request.getParameter("medications");
            String notes = request.getParameter("notes");
            Date recordDate = new Date(); // Current date or could be parsed from form
            
            MedicalRecords record = new MedicalRecords();
            record.setUserPetID(userPetID);
            record.setDiagnosis(diagnosis);
            record.setTreatment(treatment);
//            record.setMedications(medications);
//            record.setNotes(notes);
//            record.setRecordDate(recordDate);
            
            boolean success = MedicalRecordsDAO.create(record);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
            } else {
                request.setAttribute("error", "Failed to create medical record");
                request.setAttribute("userPetID", userPetID);
                request.getRequestDispatcher("/admin/medicalrecords/add.jsp").forward(request, response);
            }
        }
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            int recordID = Integer.parseInt(request.getParameter("recordID"));
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            String diagnosis = request.getParameter("diagnosis");
            String treatment = request.getParameter("treatment");
            String medications = request.getParameter("medications");
            String notes = request.getParameter("notes");
            
            MedicalRecords record = MedicalRecordsDAO.getById(recordID);
            record.setDiagnosis(diagnosis);
            record.setTreatment(treatment);
//            record.setMedications(medications);
            record.setNotes(notes);
            
            boolean success = MedicalRecordsDAO.update(record);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
            } else {
                request.setAttribute("error", "Failed to update medical record");
                request.setAttribute("record", record);
                request.getRequestDispatcher("/admin/medicalrecords/edit.jsp").forward(request, response);
            }
        }
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int recordID = Integer.parseInt(request.getParameter("recordID"));
        int userPetID = Integer.parseInt(request.getParameter("userPetID"));
        
        boolean success = MedicalRecordsDAO.delete(recordID);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
        } else {
            request.setAttribute("error", "Failed to delete medical record");
            response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
        }
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");
        
        if ("viewByPet".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            UserPet userPet = UserPetDAO.getById(userPetID);
            
            // Security check - only allow viewing records for own pets
            if (userPet != null && userPet.getUserID() == userID) {
                List<MedicalRecords> records = MedicalRecordsDAO.getByUserPetId(userPetID);
                request.setAttribute("records", records);
                request.setAttribute("userPet", userPet);
                request.getRequestDispatcher("/client/medicalrecords/list.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/userpet");
            }
        } else if ("view".equals(action)) {
            int recordID = Integer.parseInt(request.getParameter("recordID"));
            MedicalRecords record = MedicalRecordsDAO.getById(recordID);
            
            if (record != null) {
                UserPet userPet = UserPetDAO.getById(record.getUserPetID());
                
                // Security check - only allow viewing records for own pets
                if (userPet != null && userPet.getUserID() == userID) {
                    request.setAttribute("record", record);
                    request.setAttribute("userPet", userPet);
                    request.getRequestDispatcher("/client/medicalrecords/view.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/userpet");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/userpet");
            }
        } else {
            // Default view - show all pets for the user
            response.sendRedirect(request.getContextPath() + "/userpet");
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Customers typically don't create medical records
        response.sendRedirect(request.getContextPath() + "/userpet");
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Customers typically don't update medical records
        response.sendRedirect(request.getContextPath() + "/userpet");
    }

    private void customerDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Customers typically don't delete medical records
        response.sendRedirect(request.getContextPath() + "/userpet");
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null || action.isEmpty()) {
//            List<MedicalRecords> records = MedicalRecordsDAO.getAll();
//            request.setAttribute("records", records);
//            request.getRequestDispatcher("/staff/medicalrecords/list.jsp").forward(request, response);
        } else if ("viewByPet".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            List<MedicalRecords> records = MedicalRecordsDAO.getByUserPetId(userPetID);
            UserPet userPet = UserPetDAO.getById(userPetID);
            request.setAttribute("records", records);
            request.setAttribute("userPet", userPet);
            request.getRequestDispatcher("/staff/medicalrecords/list_by_pet.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            int recordID = Integer.parseInt(request.getParameter("recordID"));
            MedicalRecords record = MedicalRecordsDAO.getById(recordID);
            request.setAttribute("record", record);
            request.getRequestDispatcher("/staff/medicalrecords/view.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            UserPet userPet = UserPetDAO.getById(userPetID);
            request.setAttribute("userPet", userPet);
            request.getRequestDispatcher("/staff/medicalrecords/add.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int recordID = Integer.parseInt(request.getParameter("recordID"));
            MedicalRecords record = MedicalRecordsDAO.getById(recordID);
            request.setAttribute("record", record);
            request.getRequestDispatcher("/staff/medicalrecords/edit.jsp").forward(request, response);
        }
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            String diagnosis = request.getParameter("diagnosis");
            String treatment = request.getParameter("treatment");
            String medications = request.getParameter("medications");
            String notes = request.getParameter("notes");
            Date recordDate = new Date(); // Current date or could be parsed from form
            
            MedicalRecords record = new MedicalRecords();
            record.setUserPetID(userPetID);
            record.setDiagnosis(diagnosis);
            record.setTreatment(treatment);
//            record.setMedications(medications);
//            record.setNotes(notes);
//            record.setRecordDate(recordDate);
            
            boolean success = MedicalRecordsDAO.create(record);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
            } else {
                request.setAttribute("error", "Failed to create medical record");
                request.setAttribute("userPetID", userPetID);
                request.getRequestDispatcher("/staff/medicalrecords/add.jsp").forward(request, response);
            }
        }
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            int recordID = Integer.parseInt(request.getParameter("recordID"));
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            String diagnosis = request.getParameter("diagnosis");
            String treatment = request.getParameter("treatment");
            String medications = request.getParameter("medications");
            String notes = request.getParameter("notes");
            
            MedicalRecords record = MedicalRecordsDAO.getById(recordID);
            record.setDiagnosis(diagnosis);
            record.setTreatment(treatment);
//            record.setMedications(medications);
            record.setNotes(notes);
            
            boolean success = MedicalRecordsDAO.update(record);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
            } else {
                request.setAttribute("error", "Failed to update medical record");
                request.setAttribute("record", record);
                request.getRequestDispatcher("/staff/medicalrecords/edit.jsp").forward(request, response);
            }
        }
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int recordID = Integer.parseInt(request.getParameter("recordID"));
        int userPetID = Integer.parseInt(request.getParameter("userPetID"));
        
        boolean success = MedicalRecordsDAO.delete(recordID);
        
        if (success) {
            response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
        } else {
            request.setAttribute("error", "Failed to delete medical record");
            response.sendRedirect(request.getContextPath() + "/medicalrecords?action=viewByPet&userPetID=" + userPetID);
        }
    }
}
