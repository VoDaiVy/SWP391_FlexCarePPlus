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
                    <div class="col-md-6 col-lg-6 mb-4 user-card">
                        <div class="card shadow-sm h-100 d-flex flex-row align-items-center p-3">
                            <img src="${u.avatar}" alt="Avatar" class="rounded" style="width:80px; height:100px; object-fit:cover;">
                            <div class="flex-grow-1 ms-3 d-flex flex-column justify-content-between h-100">
                                <div>
                                    <h5 class="mb-1 user-name" style="color:#198754; font-weight:700; font-size:1.3rem;">${u.firstName} ${u.lastName}</h5>
                                    <div class="mb-1 user-email" style="color:#555; font-size:1rem;">${u.user.email}</div>
                                    <div class="mb-2 user-tel" style="color:#555; font-size:1rem;">Tel: ${u.tel == null ? 'N/A' : u.tel}</div>
                                </div>
                                <div class="d-flex flex-row align-items-center mt-2">
                                    <a href="staff?action=getCustomerPets&userID=${u.user.userId}" class="btn btn-outline-success btn-sm me-2" style="width:max-content;">View Pets</a>
                                    <button type="button" class="btn btn-outline-primary btn-sm" style="width:max-content;" onclick="openNotifyModal('${u.user.userId}', '${u.firstName} ${u.lastName}')">
                                        Create notification
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <!-- Notification Modal -->
        <div class="modal fade" id="notifyModal" tabindex="-1" aria-labelledby="notifyModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="notifyModalLabel">Create Notification</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <form id="notifyForm" method="post" action="staff">
                <input type="hidden" name="userId" id="notifyUserId" value="" />
                <input type="hidden" name="action" value="createNotification" />
                <div class="modal-body">
                  <div class="mb-2"><strong>Customer:</strong> <span id="notifyUserName"></span></div>
                  <textarea id="notifyContent" name="content" class="form-control" rows="4" placeholder="Enter notification content..."></textarea>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                  <button type="submit" class="btn btn-primary">Send</button>
                </div>
              </form>
            </div>
          </div>
        </div>
        <script>
        function openNotifyModal(userId, userName) {
            document.getElementById('notifyUserId').value = userId;
            document.getElementById('notifyUserName').textContent = userName;
            document.getElementById('notifyContent').value = '';
            var modal = new bootstrap.Modal(document.getElementById('notifyModal'));
            modal.show();
        }
        document.getElementById('notifyForm').addEventListener('submit', function(e) {
            if (!document.getElementById('notifyContent').value.trim()) {
                alert('Please enter notification content.');
                e.preventDefault();
            }
        });
        </script>
        <!-- Bootstrap JS Bundle (for modal) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>



