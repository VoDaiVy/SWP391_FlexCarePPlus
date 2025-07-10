<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Room Management - FlexCareP+</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/adminPages/assets/images/favicon.ico">
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/adminPages/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body data-topbar="dark">
    <div id="layout-wrapper">
        <jsp:include page="/adminPages/assets/includes/header.jsp" />
        <jsp:include page="/adminPages/assets/includes/navbar.jsp" />
        <div class="main-content">
            <div class="page-content">
                <div class="container-fluid">
                    <div class="page-title-box d-flex align-items-center justify-content-between">
                        <h4 class="mb-0">Room Management</h4>
                    </div>
                    <!-- Add New Room Form -->
                    <div class="card mb-4">
                        <div class="card-body">
                            <form action="admin" method="post" class="row g-3 align-items-end">
                                <input type="hidden" name="action" value="createRoom" />
                                <div class="col-md-2">
                                    <label class="form-label">Room Name</label>
                                    <input type="text" class="form-control" name="name" required />
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Room Number</label>
                                    <input type="number" class="form-control" name="roomNumber" required />
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Service Category</label>
                                    <select class="form-select" name="categoryServiceID" required>
                                        <c:forEach var="cat" items="${categories.values()}">
                                            <option value="${cat.categoryServiceID}">${cat.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Status</label>
                                    <select class="form-select" name="status">
                                        <option value="true">Active</option>
                                        <option value="false">Inactive</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary"><i class="fas fa-plus me-2"></i>Add New</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <!-- Room List Table -->
                    <div class="card">
                        <div class="card-body">
                            <table id="roomTable" class="table table-bordered dt-responsive nowrap w-100">
                                <thead class="table-light">
                                    <tr>
                                        <th>ID</th>
                                        <th>Room Name</th>
                                        <th>Room Number</th>
                                        <th>Service Category</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="room" items="${rooms}">
                                        <tr>
                                            <td>${room.roomID}</td>
                                            <td>${room.name}</td>
                                            <td>${room.roomNumber}</td>
                                            <td>
                                                <c:out value="${categories[room.categoryServiceID].name}" />
                                            </td>
                                            <td>
                                                <span class="badge bg-${room.status ? 'success' : 'secondary'}">
                                                    ${room.status ? 'Active' : 'Inactive'}
                                                </span>
                                            </td>
                                            <td>
                                                <button class="btn btn-warning btn-sm me-1" data-bs-toggle="modal" data-bs-target="#updateRoomModal"
                                                    onclick="editRoom(${room.roomID}, '${room.name}', ${room.roomNumber}, ${room.categoryServiceID}, ${room.status})">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                <form action="admin" method="post" class="d-inline">
                                                    <input type="hidden" name="action" value="deleteRoom" />
                                                    <input type="hidden" name="roomID" value="${room.roomID}" />
                                                    <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this room?');">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- Update Room Modal -->
                    <div class="modal fade" id="updateRoomModal" tabindex="-1" aria-labelledby="updateRoomModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form action="admin" method="post" id="updateRoomForm">
                                    <input type="hidden" name="action" value="updateRoom" />
                                    <input type="hidden" name="roomID" id="editRoomID" />
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="updateRoomModalLabel">Update Room</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Room Name</label>
                                            <input type="text" class="form-control" name="name" id="editRoomName" required />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Room Number</label>
                                            <input type="number" class="form-control" name="roomNumber" id="editRoomNumber" required />
                                        </div>
                                        <div class="col-md-12">
                                            <label class="form-label">Service Category</label>
                                            <select class="form-select" name="categoryServiceID" id="editCategoryServiceID" required>
                                                <c:forEach var="cat" items="${categories.values()}">
                                                    <option value="${cat.categoryServiceID}">${cat.name}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="col-md-12">
                                            <label class="form-label">Status</label>
                                            <select class="form-select" name="status" id="editRoomStatus">
                                                <option value="true">Active</option>
                                                <option value="false">Inactive</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="submit" class="btn btn-primary">Save changes</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <jsp:include page="/adminPages/assets/includes/footer.jsp" />
            </div>
        </div>
        <jsp:include page="/adminPages/assets/includes/rightbar.jsp" />
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/libs/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js"></script>
        <script src="${pageContext.request.contextPath}/adminPages/assets/js/app.js"></script>
        <script>
            $(document).ready(function () {
                $('#roomTable').DataTable({
                    "responsive": true,
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Vietnamese.json"
                    },
                    "columnDefs": [
                        {"orderable": false, "targets": 5}
                    ]
                });
            });
            // HÃ m fill dá»¯ liá»u vÃ o modal update
            function editRoom(id, name, roomNumber, categoryServiceID, status) {
                $("#editRoomID").val(id);
                $("#editRoomName").val(name);
                $("#editRoomNumber").val(roomNumber);
                $("#editCategoryServiceID").val(categoryServiceID);
                $("#editRoomStatus").val(status ? 'true' : 'false');
            }
        </script>
    </div>
</body>
</html>
