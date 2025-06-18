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
        <div class="container py-4">
            <div class="row mb-3">
                <div class="col-12 col-md-6 mx-auto">
                    <input id="userSearchInput" type="text" class="form-control" placeholder="Tìm kiếm theo tên, email hoặc số điện thoại...">
                </div>
            </div>
            <div class="row" id="userList">
                <c:forEach var="u" items="${userDetailDTOs}">
                    <div class="col-md-6 col-lg-4 mb-4 user-card">
                        <div class="card shadow-sm h-100 d-flex flex-row align-items-center p-3">
                            <img src="${u.avatar}" alt="Avatar" class="rounded" style="width:80px; height:100px; object-fit:cover;">
                            <div class="flex-grow-1 ms-3 d-flex flex-column justify-content-between h-100">
                                <div>
                                    <h5 class="mb-1 user-name" style="color:#198754; font-weight:700; font-size:1.3rem;">${u.firstName} ${u.lastName}</h5>
                                    <div class="mb-1 user-email" style="color:#555; font-size:1rem;">${u.user.email}</div>
                                    <div class="mb-2 user-tel" style="color:#555; font-size:1rem;">Tel: ${u.tel == null ? 'N/A' : u.tel}</div>
                                </div>
                                <a href="staff?action=getCustomerPets&userID=${u.user.userId}" class="btn btn-outline-success btn-sm mt-2" style="width:max-content;">View Pets</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('userSearchInput');
            const userCards = document.querySelectorAll('#userList .user-card');
            searchInput.addEventListener('input', function() {
                const value = this.value.toLowerCase();
                userCards.forEach(card => {
                    const name = card.querySelector('.user-name').textContent.toLowerCase();
                    const email = card.querySelector('.user-email').textContent.toLowerCase();
                    const tel = card.querySelector('.user-tel').textContent.toLowerCase();
                    if (name.includes(value) || email.includes(value) || tel.includes(value)) {
                        card.style.display = '';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });
        </script>
    </body>
</html>



