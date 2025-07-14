package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import daos.MedicalRecordsDAO;
import daos.PetDAO;
import daos.UserPetDAO;
import models.MedicalRecords;
import models.UserPet;
import dtos.MedicalRecordsDTO;
import dtos.UserPetDTO;
import java.util.List;
import java.util.Date;

public class MedicalRecordsController extends HttpServlet {

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
        switch (action) {
            case "getMedicalRecords" -> {
                int userPetID = Integer.parseInt(request.getParameter("userPetID"));
                UserPet userPet = UserPetDAO.getById(userPetID);
                UserPetDTO userPetDTO = new UserPetDTO(userPet, PetDAO.getById(userPet.getPetID()));
                List<MedicalRecords> medicalRecords = MedicalRecordsDAO.getByUserPetId(userPetID);
                request.setAttribute("userPetDTO", userPetDTO);
                request.setAttribute("medicalRecords", medicalRecords);
                request.getRequestDispatcher("client/medicalRecords.jsp").forward(request, response);
            }
            case "getMedicalDetail" -> {
                int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
                MedicalRecords medicalRecord = MedicalRecordsDAO.getById(medicalRecordID);
                UserPet userPet = UserPetDAO.getById(medicalRecord.getUserPetID());
                UserPetDTO userPetDTO = new UserPetDTO(userPet, PetDAO.getById(userPet.getPetID()));
                request.setAttribute("userPetDTO", userPetDTO);
                request.setAttribute("medicalRecord", medicalRecord);
                request.getRequestDispatcher("client/medicalRecordDetail.jsp").forward(request, response);
            }
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
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
        switch (action) {
            case "getMedicalRecords" -> {
                int userPetID = Integer.parseInt(request.getParameter("userPetID"));
                UserPet userPet = UserPetDAO.getById(userPetID);
                UserPetDTO userPetDTO = new UserPetDTO(userPet, PetDAO.getById(userPet.getPetID()));
                List<MedicalRecords> medicalRecords = MedicalRecordsDAO.getByUserPetId(userPetID);
                request.setAttribute("userPetDTO", userPetDTO);
                request.setAttribute("medicalRecords", medicalRecords);
                request.getRequestDispatcher("staff/medicalRecords.jsp").forward(request, response);
            }
            case "getMedicalDetail" -> {
                int medicalRecordID = Integer.parseInt(request.getParameter("medicalRecordID"));
                MedicalRecords medicalRecord = MedicalRecordsDAO.getById(medicalRecordID);
                UserPet userPet = UserPetDAO.getById(medicalRecord.getUserPetID());
                UserPetDTO userPetDTO = new UserPetDTO(userPet, PetDAO.getById(userPet.getPetID()));
                request.setAttribute("userPetDTO", userPetDTO);
                request.setAttribute("medicalRecord", medicalRecord);
                request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
            }
            case "createMedicalRecord" -> {
                int userPetID = Integer.parseInt(request.getParameter("userPetID"));
                UserPet userPet = UserPetDAO.getById(userPetID);
                UserPetDTO userPetDTO = new UserPetDTO(userPet, PetDAO.getById(userPet.getPetID()));
                request.setAttribute("userPetDTO", userPetDTO);
                request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
            }

        }

    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "create" -> {
                try {
                    int userPetID = Integer.parseInt(request.getParameter("userPetID"));
                    UserPet userPet = UserPetDAO.getById(userPetID);
                    String dateVisitStr = request.getParameter("dateVisit");
                    String condition = request.getParameter("condition");
                    String diagnosis = request.getParameter("diagnosis");
                    String treatment = request.getParameter("treatment");
                    String notes = request.getParameter("notes");
                    String treatmentStartStr = request.getParameter("treatmentStart");
                    String treatmentEndStr = request.getParameter("treatmentEnd");
                    String followUpRequiredStr = request.getParameter("followUpRequired");
                    String nextBookingIDStr = request.getParameter("nextBookingID");
                    String state = request.getParameter("state");
                    String statusStr = request.getParameter("status");

                    MedicalRecords record = new MedicalRecords();
                    record.setUserPetID(userPetID);
                    record.setUserID(userPet.getUserID());
                    if (dateVisitStr != null && !dateVisitStr.isEmpty()) {
                        record.setDateVisit(java.time.LocalDateTime.parse(dateVisitStr));
                    }
                    record.setCondition(condition);
                    record.setDiagnosis(diagnosis);
                    record.setTreatment(treatment);
                    record.setNotes(notes);
                    if (treatmentStartStr != null && !treatmentStartStr.isEmpty()) {
                        record.setTreatmentStart(java.time.LocalDateTime.parse(treatmentStartStr));
                    }
                    if (treatmentEndStr != null && !treatmentEndStr.isEmpty()) {
                        record.setTreatmentEnd(java.time.LocalDateTime.parse(treatmentEndStr));
                    }
                    record.setFollowUpRequired("true".equals(followUpRequiredStr));
                    if (nextBookingIDStr != null && !nextBookingIDStr.isEmpty()) {
                        record.setNextBookingID(Integer.valueOf(nextBookingIDStr));
                    }
                    record.setState(state);
                    record.setStatus("true".equals(statusStr));

                    boolean success = MedicalRecordsDAO.create(record);
                    if (success) {
                        // Hiển thị lại trang chi tiết với thông báo thành công
                        request.setAttribute("medicalRecord", record);
                        UserPetDTO userPetDTO = new UserPetDTO(userPet, PetDAO.getById(userPet.getPetID()));
                        request.setAttribute("userPetDTO", userPetDTO);
                        request.setAttribute("successMsg", "Tạo hồ sơ bệnh án thành công!");
                        request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Failed to create medical record");
                        request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
                    }
                } catch (ServletException | IOException | NumberFormatException e) {
                    request.setAttribute("error", "Exception: " + e.getMessage());
                    request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
                }
            }
            case "update" -> {
                try {
                    int medicalRecordsID = Integer.parseInt(request.getParameter("medicalRecordsID"));
                    String dateVisitStr = request.getParameter("dateVisit");
                    String condition = request.getParameter("condition");
                    String diagnosis = request.getParameter("diagnosis");
                    String treatment = request.getParameter("treatment");
                    String notes = request.getParameter("notes");
                    String treatmentStartStr = request.getParameter("treatmentStart");
                    String treatmentEndStr = request.getParameter("treatmentEnd");
                    String followUpRequiredStr = request.getParameter("followUpRequired");
                    String nextBookingIDStr = request.getParameter("nextBookingID");
                    String state = request.getParameter("state");
                    String statusStr = request.getParameter("status");

                    MedicalRecords record = MedicalRecordsDAO.getById(medicalRecordsID);
                    if (dateVisitStr != null && !dateVisitStr.isEmpty()) {
                        record.setDateVisit(java.time.LocalDateTime.parse(dateVisitStr));
                    }
                    record.setCondition(condition);
                    record.setDiagnosis(diagnosis);
                    record.setTreatment(treatment);
                    record.setNotes(notes);
                    if (treatmentStartStr != null && !treatmentStartStr.isEmpty()) {
                        record.setTreatmentStart(java.time.LocalDateTime.parse(treatmentStartStr));
                    } else {
                        record.setTreatmentStart(null);
                    }
                    if (treatmentEndStr != null && !treatmentEndStr.isEmpty()) {
                        record.setTreatmentEnd(java.time.LocalDateTime.parse(treatmentEndStr));
                    } else {
                        record.setTreatmentEnd(null);
                    }
                    record.setFollowUpRequired("true".equals(followUpRequiredStr));
                    if (nextBookingIDStr != null && !nextBookingIDStr.isEmpty()) {
                        record.setNextBookingID(Integer.valueOf(nextBookingIDStr));
                    } else {
                        record.setNextBookingID(null);
                    }
                    record.setState(state);
                    record.setStatus("true".equals(statusStr));

                    boolean success = MedicalRecordsDAO.update(record);
                    if (success) {
                        // Hiển thị lại trang chi tiết với thông báo thành công
                        request.setAttribute("medicalRecord", record);
                        UserPet userPet = UserPetDAO.getById(record.getUserPetID());
                        UserPetDTO userPetDTO = new UserPetDTO(userPet, PetDAO.getById(userPet.getPetID()));
                        request.setAttribute("userPetDTO", userPetDTO);
                        request.setAttribute("successMsg", "Cập nhật hồ sơ bệnh án thành công!");
                        request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Failed to update medical record");
                        request.setAttribute("medicalRecord", record);
                        request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
                    }
                } catch (ServletException | IOException | NumberFormatException e) {
                    request.setAttribute("error", "Exception: " + e.getMessage());
                    request.getRequestDispatcher("staff/medicalRecordDetail.jsp").forward(request, response);
                }
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
