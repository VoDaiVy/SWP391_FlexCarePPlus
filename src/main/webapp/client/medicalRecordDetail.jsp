<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <jsp:include page="/client/assets/layout/headerFull.jsp"/>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link type="text/css" href="${pageContext.request.contextPath}/staff/assets/css/managerPage.css" rel="stylesheet">
    <body>
        <div class="container py-5">
            <div class="mb-3">
                <a href="medicalrecords?action=getMedicalRecords&userPetID=${userPetDTO.userPetID}" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left"></i> Back
                </a>
            </div>
            <!-- Pet Info Card -->
            <div class="row justify-content-center mb-4">
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

            <!-- Medical Record Detail Card -->
            <div class="row justify-content-center">
                <div class="col-md-10 col-lg-8">
                    <c:choose>
                        <c:when test="${medicalRecord != null}">
                            <div class="card shadow p-4">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="fw-bold mb-0" style="color:#198754;">Medical Record Details</h4>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Visit Date:</div>
                                    <div class="col-sm-8">${fn:substring(medicalRecord.dateVisit, 0, 16)}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Condition:</div>
                                    <div class="col-sm-8">${medicalRecord.condition}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Diagnosis:</div>
                                    <div class="col-sm-8">${medicalRecord.diagnosis}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment:</div>
                                    <div class="col-sm-8">${medicalRecord.treatment}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Notes:</div>
                                    <div class="col-sm-8">${medicalRecord.notes}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment Start:</div>
                                    <div class="col-sm-8">${fn:substring(medicalRecord.treatmentStart, 0, 16)}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment End:</div>
                                    <div class="col-sm-8">${fn:substring(medicalRecord.treatmentEnd, 0, 16)}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Follow Up Required:</div>
                                    <div class="col-sm-8">${medicalRecord.followUpRequired == true ? 'Yes' : 'No'}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Next Booking ID:</div>
                                    <div class="col-sm-8">${medicalRecord.nextBookingID}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">State:</div>
                                    <div class="col-sm-8">${medicalRecord.state}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Status:</div>
                                    <div class="col-sm-8">${medicalRecord.status == true ? 'Active' : 'Inactive'}</div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-warning text-center" role="alert">
                                No medical record found for this pet.
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <jsp:include page="/client/assets/layout/footer.jsp"/>
    </body>
</html>
