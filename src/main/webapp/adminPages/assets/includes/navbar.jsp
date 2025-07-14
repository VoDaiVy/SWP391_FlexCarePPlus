<!-- ========== Left Sidebar Start ========== -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="vertical-menu">

    <div data-simplebar class="h-100">

        <!-- User details -->
        <div class="user-profile text-center mt-3">
            <div class="">
                <img src="${sessionScope.accDetail.avatar}" alt="" class="avatar-md rounded-circle">
            </div>
            <div class="mt-3">
                <h4 class="font-size-16 mb-1">${sessionScope.acc.username}</h4>
                <span class="text-muted"><i class="ri-record-circle-line align-middle font-size-14 text-success"></i>Online</span>
            </div>
        </div>

        <!--- Sidemenu -->
        <div id="sidebar-menu">
            <!-- Left Menu Start -->
            <ul class="metismenu list-unstyled" id="side-menu">
                <li class="menu-title">Danh mục</li>

                <li>
                    <a href="admin" class="waves-effect">
                        <i class="ri-dashboard-line"></i><span class="badge rounded-pill bg-success float-end">3</span>
                        <span>Tổng quan</span>
                    </a>
                </li>

                <li class="menu-title">Trang</li>

                <li>
                    <a href="javascript: void(0);" class="has-arrow waves-effect">
                        <i class="ri-profile-line"></i>
                        <span>Quản lý</span>
                    </a>
                    <ul class="sub-menu" aria-expanded="false">
                        <li><a href="admin?action=getUsers">Quản Lý Người Dùng</a></li>
                        <li><a href="admin?action=getRooms">Quản Lý Phòng</a></li>
                        <li><a href="admin?action=getBookings">Quản Lý Đặt Dịch Vụ</a></li>
                        <li><a href="admin?action=getCategoryServices">Quản Lý Loại Hình Dịch Vụ</a></li>
                        <li><a href="admin?action=getServices">Quản Lý Dịch Vụ</a></li>
                        <li><a href="admin?action=getNotifications">Quản Lý Thông Báo</a></li>
                        <li><a href="admin?action=getPolicies">Quản Lý Chính Sách</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <!-- Sidebar -->
    </div>
</div>
<!-- Left Sidebar End -->
