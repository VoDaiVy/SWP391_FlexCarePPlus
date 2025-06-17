package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import daos.UserPetDAO;
import daos.PetDAO;
import daos.UserDAO;
import daos.UserDetailDAO;
import models.UserPet;
import models.Pet;
import dtos.UserPetDTO;
import dtos.UserDetailDTO;
import java.util.ArrayList;
import java.util.List;
import models.User;
import models.UserDetail;

public class UserPetController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String actor = (String) request.getSession().getAttribute("actor");
        if (actor == null) {
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

        if (action == null || action.isEmpty()) {
            List<UserPet> userPets = UserPetDAO.getAll();
            request.setAttribute("userPets", userPets);
            request.getRequestDispatcher("/admin/userpet/list.jsp").forward(request, response);
        } else if ("view".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            UserPet userPet = UserPetDAO.getById(userPetID);
            request.setAttribute("userPet", userPet);
            request.getRequestDispatcher("/admin/userpet/view.jsp").forward(request, response);
        } else if ("add".equals(action)) {
            List<Pet> pets = PetDAO.getAll();
            request.setAttribute("pets", pets);
            request.getRequestDispatcher("/admin/userpet/add.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            UserPet userPet = UserPetDAO.getById(userPetID);
            List<Pet> pets = PetDAO.getAll();
            request.setAttribute("userPet", userPet);
            request.setAttribute("pets", pets);
            request.getRequestDispatcher("/admin/userpet/edit.jsp").forward(request, response);
        }
    }

    private void adminPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            int userID = Integer.parseInt(request.getParameter("userID"));
            int petID = Integer.parseInt(request.getParameter("petID"));
            String petName = request.getParameter("petName");

            UserPet userPet = new UserPet();
            userPet.setUserID(userID);
            userPet.setPetID(petID);
            userPet.setPetName(petName);

            boolean success = UserPetDAO.create(userPet);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/userpet");
            } else {
                request.setAttribute("error", "Failed to create user pet relationship");
                request.getRequestDispatcher("/admin/userpet/add.jsp").forward(request, response);
            }
        }
    }

    private void adminPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("update".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            int userID = Integer.parseInt(request.getParameter("userID"));
            int petID = Integer.parseInt(request.getParameter("petID"));
            String petName = request.getParameter("petName");

            UserPet userPet = new UserPet();
            userPet.setUserPetID(userPetID);
            userPet.setUserID(userID);
            userPet.setPetID(petID);
            userPet.setPetName(petName);

            boolean success = UserPetDAO.update(userPet);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/userpet");
            } else {
                request.setAttribute("error", "Failed to update user pet relationship");
                request.setAttribute("userPet", userPet);
                request.getRequestDispatcher("/admin/userpet/edit.jsp").forward(request, response);
            }
        }
    }

    private void adminDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userPetID = Integer.parseInt(request.getParameter("userPetID"));
        boolean success = UserPetDAO.delete(userPetID);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/userpet");
        } else {
            request.setAttribute("error", "Failed to delete user pet relationship");
            response.sendRedirect(request.getContextPath() + "/userpet");
        }
    }

    // Customer role methods
    private void customerGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "getUserPet":
                getUserPet(request, response);
                break;
            default:
                break;
        }
    }

    private void customerPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");

        if ("create".equals(action)) {
            int petID = Integer.parseInt(request.getParameter("petID"));
            String petName = request.getParameter("petName");

            UserPet userPet = new UserPet();
            userPet.setUserID(userID); // Use session userID for security
            userPet.setPetID(petID);
            userPet.setPetName(petName);

            boolean success = UserPetDAO.create(userPet);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/userpet");
            } else {
                request.setAttribute("error", "Failed to add pet");
                request.getRequestDispatcher("/client/userpet/add.jsp").forward(request, response);
            }
        }
    }

    private void customerPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Customers can only update pet name for their pets
        String action = request.getParameter("action");
        int userID = (int) request.getSession().getAttribute("userID");

        if ("update".equals(action)) {
            int userPetID = Integer.parseInt(request.getParameter("userPetID"));
            UserPet existingUserPet = UserPetDAO.getById(userPetID);

            // Security check - only allow updating own pets
            if (existingUserPet != null && existingUserPet.getUserID() == userID) {
                String petName = request.getParameter("petName");

                existingUserPet.setPetName(petName);

                boolean success = UserPetDAO.update(existingUserPet);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/userpet");
                } else {
                    request.setAttribute("error", "Failed to update pet");
                    request.setAttribute("userPet", existingUserPet);
                    request.getRequestDispatcher("/client/userpet/edit.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/userpet");
            }
        }
    }

    private void customerDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Allow customers to remove their own pets
        int userID = (int) request.getSession().getAttribute("userID");
        int userPetID = Integer.parseInt(request.getParameter("userPetID"));

        UserPet existingUserPet = UserPetDAO.getById(userPetID);

        // Security check - only allow deleting own pets
        if (existingUserPet != null && existingUserPet.getUserID() == userID) {
            boolean success = UserPetDAO.delete(userPetID);

            if (!success) {
                request.setAttribute("error", "Failed to remove pet");
            }
        }

        response.sendRedirect(request.getContextPath() + "/userpet");
    }

    // Staff role methods
    private void staffGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userID = request.getParameter("userID");
        User user = UserDAO.getById(Integer.parseInt(userID));
        UserDetail userDetail = UserDetailDAO.getByUserId(Integer.parseInt(userID));
        UserDetailDTO userDetailDTO = new UserDetailDTO(userDetail, user);
        List<UserPet> userPets = UserPetDAO.getByUserId(Integer.parseInt(userID));
        List<UserPetDTO> userPetDTOs = new ArrayList<>();
        
        for (UserPet userPet : userPets) {
            Pet pet = PetDAO.getById(userPet.getPetID());
            userPetDTOs.add(new UserPetDTO(userPet, pet));
        }
        
        request.setAttribute("userDetailDTO", userDetailDTO);
        request.setAttribute("userPetDTOs", userPetDTOs);
        request.getRequestDispatcher("staff/userPets.jsp").forward(request, response);
    }

    private void staffPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Staff typically doesn't create user-pet relationships, but can view them
        response.sendRedirect(request.getContextPath() + "/userpet");
    }

    private void staffPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Staff typically doesn't update user-pet relationships
        response.sendRedirect(request.getContextPath() + "/userpet");
    }

    private void staffDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Staff typically doesn't delete user-pet relationships
        response.sendRedirect(request.getContextPath() + "/userpet");
    }

    private void getUserPet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            UserDetailDTO userDetailDTO = (UserDetailDTO) request.getSession().getAttribute("userDetailDTO");
            
            if (userDetailDTO == null) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write("{\"error\": \"User not logged in\"}");
                return;
            }
            
            int userID = userDetailDTO.getUser().getUserId();
            
            List<UserPet> userPets = UserPetDAO.getByUserId(userID);
            
            List<UserPetDTO> userPetDTOs = new java.util.ArrayList<>();
            for (UserPet userPet : userPets) {
                Pet pet = PetDAO.getById(userPet.getPetID());
                UserPetDTO dto = new UserPetDTO(userPet, userDetailDTO.getUser(), pet);
                userPetDTOs.add(dto);
            }
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            com.google.gson.Gson gson = new com.google.gson.Gson();
            String jsonResponse = gson.toJson(userPetDTOs);
            
            response.getWriter().write(jsonResponse);
            
        } catch (Exception e) {
            e.printStackTrace();

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write("{\"error\": \"An error occurred: " + e.getMessage() + "\"}");
        }
    }
}
