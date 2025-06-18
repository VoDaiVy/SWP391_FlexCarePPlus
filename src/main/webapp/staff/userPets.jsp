<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="/staff/assets/layout/headerFull.jsp"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/staff/assets/css/managerPage.css" rel="stylesheet">
    <body>
        <div class="container py-5">
            <!-- User Info Card -->
            <div class="row justify-content-center mb-5">
                <div class="col-md-8 col-lg-6">
                    <div class="card shadow-lg p-4 d-flex flex-row align-items-center">
                        <img src="${userDetailDTO.avatar}" alt="Avatar" class="rounded" style="width:100px; height:120px; object-fit:cover;">
                        <div class="ms-4 flex-grow-1">
                            <h3 style="color:#198754; font-weight:700;">${userDetailDTO.firstName} ${userDetailDTO.lastName}</h3>
                            <div class="mb-1" style="color:#555; font-size:1.1rem;"><i class="fas fa-envelope me-2"></i>${userDetailDTO.user.email}</div>
                            <div class="mb-1" style="color:#555; font-size:1.1rem;"><i class="fas fa-phone me-2"></i>${userDetailDTO.tel == null ? 'N/A' : userDetailDTO.tel}</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pet List -->
            <div class="row mb-4">
                <div class="col-12 text-center mb-4">
                    <h4 class="fw-bold" style="color:#198754;">Danh sách thú cưng</h4>
                </div>
                <c:forEach var="p" items="${userPetDTOs}">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card h-100 shadow-sm p-3 d-flex flex-column align-items-center">
                            <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="Pet Avatar" class="rounded mb-3" style="width:90px; height:90px; object-fit:cover; border:3px solid #198754;">
                            <h5 class="mb-1" style="color:#198754; font-weight:600;">${p.petName}</h5>
                            <div class="mb-1" style="color:#555;">PetID: <span style="font-weight:500;">${p.userPetID}</span></div>
                            <div class="mb-1" style="color:#555;">Breed: <span style="font-weight:500;">${p.pet.name}</span></div>
                            <div class="d-flex gap-2 mt-2">
                                <a href="staff?action=createMedicalRecord&userPetID=${p.userPetID}" class="btn btn-outline-success btn-sm" style="width:max-content;">Create Medical Record</a>
                                <a href="staff?action=getMedicalRecords&userPetID=${p.userPetID}" class="btn btn-outline-success btn-sm" title="Xem danh sách hồ sơ y tế" style="width:max-content; display: flex; align-items: center;">
                                    <i class="fas fa-notes-medical"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

