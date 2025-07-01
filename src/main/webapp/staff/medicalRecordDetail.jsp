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
        <!-- Success Message -->
        <c:if test="${not empty successMsg}">
            <div class="row mb-3" id="successMsgRow">
                <div class="col-md-10 col-lg-8 mx-auto">
                    <div class="alert alert-success text-center" id="successMsgAlert">${successMsg}</div>
                </div>
            </div>
            <script>
                setTimeout(function() {
                    var msgRow = document.getElementById('successMsgRow');
                    if (msgRow) msgRow.style.display = 'none';
                }, 3000);
            </script>
        </c:if>
        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="row mb-3" id="errorMsgRow">
                <div class="col-md-10 col-lg-8 mx-auto">
                    <div class="alert alert-danger text-center" id="errorMsgAlert">${error}</div>
                </div>
            </div>
            <script>
                setTimeout(function() {
                    var msgRow = document.getElementById('errorMsgRow');
                    if (msgRow) msgRow.style.display = 'none';
                }, 3000);
            </script>
        </c:if>
            <div class="col-md-10 col-lg-8">
                <c:choose>
                    <c:when test="${medicalRecord != null}">
                        <div class="card shadow p-4">
                            <form method="post" action="medicalrecords">
                                <input type="hidden" name="action" value="update" />
                                <input type="hidden" name="medicalRecordsID" value="${medicalRecord.medicalRecordsID}" />
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="fw-bold mb-0" style="color:#198754;">Update Medical Record</h4>
                                    <button type="submit" class="btn btn-success btn-sm">Update</button>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Visit Date:</div>
                                    <div class="col-sm-8"><input type="datetime-local" class="form-control" name="dateVisit" value="${medicalRecord.dateVisit}" required></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Condition:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="condition" value="${medicalRecord.condition}" required></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Diagnosis:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="diagnosis" value="${medicalRecord.diagnosis}" required></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="treatment" value="${medicalRecord.treatment}"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Notes:</div>
                                    <div class="col-sm-8"><textarea class="form-control" name="notes">${medicalRecord.notes}</textarea></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment Start:</div>
                                    <div class="col-sm-8"><input type="datetime-local" class="form-control" name="treatmentStart" value="${medicalRecord.treatmentStart}"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment End:</div>
                                    <div class="col-sm-8"><input type="datetime-local" class="form-control" name="treatmentEnd" value="${medicalRecord.treatmentEnd}"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Follow Up Required:</div>
                                    <div class="col-sm-8">
                                        <select class="form-select" name="followUpRequired">
                                            <option value="true" ${medicalRecord.followUpRequired ? 'selected' : ''}>Yes</option>
                                            <option value="false" ${!medicalRecord.followUpRequired ? 'selected' : ''}>No</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Next Booking ID:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="nextBookingID" value="${medicalRecord.nextBookingID}"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">State:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="state" value="${medicalRecord.state}"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Status:</div>
                                    <div class="col-sm-8">
                                        <select class="form-select" name="status">
                                            <option value="true" ${medicalRecord.status ? 'selected' : ''}>Active</option>
                                            <option value="false" ${!medicalRecord.status ? 'selected' : ''}>Inactive</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="card shadow p-4">
                            <form method="post" action="medicalrecords">
                                <input type="hidden" name="action" value="create" />
                                <input type="hidden" name="userPetID" value="${userPetDTO.userPetID}" />
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h4 class="fw-bold mb-0" style="color:#198754;">Create Medical Record</h4>
                                    <button type="submit" class="btn btn-success btn-sm">Create</button>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Visit Date:</div>
                                    <div class="col-sm-8"><input type="datetime-local" class="form-control" name="dateVisit" required></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Condition:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="condition" required></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Diagnosis:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="diagnosis" required></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="treatment"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Notes:</div>
                                    <div class="col-sm-8"><textarea class="form-control" name="notes"></textarea></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment Start:</div>
                                    <div class="col-sm-8"><input type="datetime-local" class="form-control" name="treatmentStart"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Treatment End:</div>
                                    <div class="col-sm-8"><input type="datetime-local" class="form-control" name="treatmentEnd"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Follow Up Required:</div>
                                    <div class="col-sm-8">
                                        <select class="form-select" name="followUpRequired">
                                            <option value="true">Yes</option>
                                            <option value="false">No</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Next Booking ID:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="nextBookingID"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">State:</div>
                                    <div class="col-sm-8"><input type="text" class="form-control" name="state"></div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-sm-4 fw-bold">Status:</div>
                                    <div class="col-sm-8">
                                        <select class="form-select" name="status">
                                            <option value="true">Active</option>
                                            <option value="false">Inactive</option>
                                        </select>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>
