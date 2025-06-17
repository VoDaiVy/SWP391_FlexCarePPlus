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
        <!-- Pet Info Card -->
        <div class="row justify-content-center mb-5">
            <div class="col-md-8 col-lg-6">
                <div class="card shadow-lg p-4 d-flex flex-row align-items-center">
                    <img src="https://cdn-icons-png.flaticon.com/512/616/616408.png" alt="Pet Avatar" class="rounded" style="width:100px; height:120px; object-fit:cover;">
                    <div class="ms-4 flex-grow-1">
                        <h3 style="color:#198754; font-weight:700;">${userPetDTO.petName}</h3>
                        <div class="mb-1" style="color:#555; font-size:1.1rem;">PetID: <span style="font-weight:500;">${userPetDTO.userPetID}</span></div>
                        <div class="mb-1" style="color:#555; font-size:1.1rem;">Breed: <span style="font-weight:500;">${userPetDTO.pet.name}</span></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Medical Records List (Dynamic) -->
        <div class="row mb-4">
            <div class="col-12 text-center mb-4">
                <h4 class="fw-bold" style="color:#198754;">Medical Records List</h4>
            </div>
            <c:forEach var="mr" items="${medicalRecords}">
                <div class="col-12 mb-3">
                    <div class="card shadow-sm p-3 d-flex flex-row align-items-center justify-content-between">
                        <div>
                            <div style="font-size:1.1rem; color:#198754; font-weight:600;">Visit Date: ${mr.dateVisit}</div>
                            <div style="color:#555;">Condition: <span style="font-weight:500;">${mr.condition}</span></div>
                            <div style="color:#555;">Diagnosis: <span style="font-weight:500;">${mr.diagnosis}</span></div>
                            <div style="color:#555;">Treatment: <span style="font-weight:500;">${mr.treatment}</span></div>
                            <div style="color:#888; font-size:0.95rem;">Notes: ${mr.notes}</div>
                        </div>
                        <a href="staff?action=getMedicalDetail&medicalRecordID=${mr.medicalRecordsID}" class="btn btn-outline-success btn-sm" style="height:max-content;">View Details</a>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty medicalRecords}">
                <div class="col-12 text-center">
                    <div class="alert alert-info">No medical records found for this pet.</div>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>

