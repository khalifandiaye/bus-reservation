<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC 
	"-//W3C//DTD XHTML 1.1 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quản lý thành viên</title>
<jsp:include page="../common/xheader.jsp" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/style.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/styles/custom-data-table.css">

<script src="<%=request.getContextPath()%>/js/jquery.validate.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
<script src="<%=request.getContextPath()%>/js/admin/admin-user.js"></script>
</head>
<body> 
	<jsp:include page="../common/header.jsp" />
	<!-- Start register -->
	<section class="container">
	<div class="well small-well">
		<h3 style="border-bottom: 1px solid #ddd; margin-bottom: 20px;">
			Quản lý thành viên
			<a href="#modalAddUser" role="button"
				data-toggle="modal" class="btn btn-primary pull-right">Thêm
				thành viên</a>
		</h3>
		<table cellpadding="0" cellspacing="0" border="0"
			class="table table-striped table-bordered" id="userList"
			style="margin-top: 20px; background: #fff">
			<thead>
				<tr>
					<th>STT</th>
					<th>Tài khoản</th>
					<th>Họ Tên</th>
					<th>Chức vụ</th>
					<th>Trạng thái</th>
					<th>Phục hồi mật khẩu</th>
					<th>Chi tiết</th>
					<th>Khóa Tài khoản</th>
				</tr>
			</thead>
			<tbody>
				<s:if test="%{listUser == null || listUser.size == 0}">

				</s:if>
				<s:else>
					<s:iterator value="listUser" status="status">
						<tr> 
							<td><s:property value="%{#status.count}" /></td>
							<td class="td-username"><s:property value="%{username}" /></td>
							<td><s:property value="%{lastName}" /> <s:property
									value="%{firstName}" /></td>
							<td><s:property value="%{role.name}" /></td> 
							<td><s:property value="%{status}" /></td> 
							<td><a class="resetPassword" href="javascript:void(0);">Phục hồi</a></td> 
							<td><a class="detailUser" href="javascript:void(0);">Chi
									tiết</a></td>    
							<td style="text-align: center"><s:if test="%{status.equals('banned')}"><a class="activeUser" href="javascript:void(0);">Phục hồi</a></s:if><s:else><a class="deleteUser" href="javascript:void(0);">Khóa</a></s:else></td>
						</tr>
					</s:iterator>
				</s:else>
			</tbody>
		</table>
	</div>
	</section>
	<!-- Start section modal add user -->
	<section>
	<div id="modalAddUser" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="modalAddUserLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="modalAddUserLabel">Thêm mới thành viên</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" id="addUserForm">
				<div class="control-group">
					<label class="control-label" for="inputUsername">Tài khoản</label>
					<div class="controls">
						<input type="text" id="inputUsername" name="inputUsername"
							placeholder="Tài khoản">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputPassword">Mật khẩu</label>
					<div class="controls">
						<input type="password" id="inputPassword" name="inputPassword"
							placeholder="Mật khẩu">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputRePassword">Nhập lại
						mật khẩu</label>
					<div class="controls">
						<input type="password" id="inputRePassword" name="inputRePassword"
							placeholder="Mật khẩu">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputLastname">Họ</label>
					<div class="controls">
						<input type="text" id="inputLastname" name="inputLastname"
							placeholder="Họ">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputFirstname">Tên</label>
					<div class="controls">
						<input type="text" id="inputFirstname" name="inputFirstname"
							placeholder="Tên">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputEmail">Email</label>
					<div class="controls">
						<input type="text" id="inputEmail" name="inputEmail"
							placeholder="Email">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputMobilephone">Điện
						thoại</label>
					<div class="controls">
						<input type="text" id="inputMobilephone" name="inputMobilephone"
							placeholder="Điện thoại">
					</div>
				</div>
				<div class="control-group" style="padding-left: 180px;">
					<label class="checkbox"> <input type="checkbox" value=""
						name="checkboxActive"> Active
					</label>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button class="btn btn-primary " id="addUserButton">Thêm mới</button>
		</div>
	</div>
	</section>
	<!-- End section modal add user -->
	<!-- Start section modal edit user -->
	<section>
	<div id="modalEditUser" class="modal hide fade" tabindex="-1"
		role="dialog" aria-labelledby="modalEditUserLabel" aria-hidden="true">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">×</button>
			<h3 id="modalEditUserLabel">Sửa thông tin thành viên</h3>
		</div>
		<div class="modal-body">
			<form class="form-horizontal" id="editUserForm">
				<div class="control-group">
					<label class="control-label" for="inputUsername">Tài khoản</label>
					<div class="controls">
						<input disabled="disabled" type="text" id="inputUsername"
							name="inputUsername" placeholder="Tài khoản">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputLastname">Họ</label>
					<div class="controls">
						<input type="text" id="inputLastname" name="inputLastname"
							placeholder="Họ">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputFirstname">Tên</label>
					<div class="controls">
						<input type="text" id="inputFirstname" name="inputFirstname"
							placeholder="Tên">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputEmail">Email</label>
					<div class="controls">
						<input type="text" id="inputEmail" name="inputEmail"
							placeholder="Email">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="inputMobilephone">Điện
						thoại</label>
					<div class="controls">
						<input type="text" id="inputMobilephone" name="inputMobilephone"
							placeholder="Điện thoại">
					</div>
				</div>
				<div class="control-group" style="padding-left: 180px;">
					<label class="checkbox"> <input type="checkbox" value=""
						name="checkboxActive"> Active
					</label>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
			<button class="btn btn-primary " id="editUserButton">Lưu
				thay đổi</button>
		</div>
	</div> 
	</section> 
	<!-- End section modal edit user -->
<!-- 	<div style="width:100%;"><p style="color:rgb(255,132,0);font-weight:bold;font-size:16px;text-align:center;" >Thông báo thay đổi mật khẩu :companyName:</p><p>Chào :fullName:</p><p>Mật khẩu mới của quý khách tại <a href=":siteurl:">:siteName:</a> là: :newPass:</P>Hân hạnh được phục vụ quý khách.</div> -->
	<!-- End information content -->
	<jsp:include page="../common/footer.jsp" />
</body>
</html>