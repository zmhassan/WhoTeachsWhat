<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Semester - View</title>
<jsp:include page="../includes/static_includes.jsp" />
<script type="text/javascript" src="views_ajax_requests/viewSemesterAJAX.js"></script>
</head>
<body class="body-inner">
	<div class="btn-toolbar btn-mobile-menus">
		<button class="btn btn-main-menu"></button>
		<button class="btn btn-user-menu">
			<i class="icon-logo"></i>
		</button>
	</div>
	<!-- Navigation starts -->
	<jsp:include page="../includes/navigation-template.jsp" />
	<!-- Navigation end -->
	<script>
    $(function(){
        setTimeout(function(){
            $('.nav-fixed-topright').removeAttr('style');
        }, 300);
        
        $(window).scroll(function(){
            if($('.breadcrumb-container').length){
                var scrollState = $(window).scrollTop();
                if (scrollState > 0) $('.nav-fixed-topright').addClass('nav-released');
                else $('.nav-fixed-topright').removeClass('nav-released')
            }
        });
        $('.user-sub-menu-container').on('click', function(){
            $(this).toggleClass('active-user-menu');
        });
        $('.user-sub-menu .light').on('click', function(){
            if ($('body').is('.light-version')) return;
            $('body').addClass('light-version');
            setTimeout(function() {
                $.cookie('themeColor', 'light', {
                    expires: 7,
                    path: '/'
                });
            }, 500);
        });
        $('.user-sub-menu .dark').on('click', function(){
            if ($('body').is('.light-version')) {
                $('body').removeClass('light-version');
                $.cookie('themeColor', 'dark', {
                    expires: 7,
                    path: '/'
                });
            }
        });
    });


</script>
	<div class="wrapper">
		<div class="breadcrumb-container" style="width: 100%">
			<ul class="xbreadcrumbs">
				<li><a href="dashboard.html"> <i class="icon-photon home"></i>
				</a></li>
				<li><a href="viewSemester">Manage Semester</a></li>
			</ul>
		</div>
		<header>
			<i class="icon-big-notepad"></i>
			<h2>
				<small>Semester - View</small>
			</h2>
			<h3>
				<small>Add, Update and Delete semester names</small>
			</h3>
		</header>
		<form method="post" action="api/semester" id="manageSemesterForm" class="form-horizontal">
			<div class="container-fluid">
				<!-- START OF NEW CONTENT -->

				<!-- http://getbootstrap.com/components/ -->

				<!--Sortable Non-responsive Table begin-->

				<style type="text/css">
td.align {
	text-align: right;
}

td {
	vertical-align: middle;
}
</style>

				<div class="row-fluid">
					<div class="span12">
						<table class="table table-striped" id="tableSortable">
							<thead>
								<tr>
									<th>#</th>
									<th>Semester(s)</th>
									<th width="25%" style="text-align: right">Operation(s)</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${allSemesters }" var="semester">
									<tr>

										<td>${semester.getSemesterId() }</td>

										<td>${semester.getSemesterName() }</td>
										<td class="align">
											<a
												onclick="updateForm('${semester.getSemesterId() }', '${semester.getSemesterName() }')"
												data-toggle="modal" data-target="#updateSemesterModal">Update
											</a>
											<a 
												onclick="deleteForm('${semester.getSemesterId() }', ' ${semester.getSemesterName() } ')"
												data-toggle="modal" data-target="#deleteModal">Delete
											</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>

				<!--Sortable Non-responsive Table end-->

				<script>

					   $(document).ready(function() {

						   $('#tableSortable, #tableSortableRes, #tableSortableResMed').dataTable( {

							   "sPaginationType": "bootstrap",

							   "fnInitComplete": function(){

								   $(".dataTables_wrapper select").select2({

									   dropdownCssClass: 'noSearch'

								   });

							   }

						   });

						   //                            $("#simpleSelectBox").select2({

						   //                                dropdownCssClass: 'noSearch'

						   //                            }); 

					   });

					</script>



				<!-- END OF NEW CONTENT-->
			</div>
			<!-- end container -->
		</form>
		<!-- Button trigger modal -->
		<button class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#addSemesterModal">Add semester</button>

		<!-- Modal -->
		<div class="modal fade" id="addSemesterModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Add Semester</h4>
					</div>
					<div class="modal-body">
						<!--  FORM ADD -->
						<form role="form" id="addSemesterForm" class="form-horizonatal">
							<div class="input-group">
								<span class="input-group-addon">Semester Name:</span> <br /> <input
									type="text" class="form-control" name="Semester name" id="semesterName"
									placeholder="Semester Name" />
							</div>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<button type="button" onclick="addSemester();"
								class="btn btn-primary">Save changes</button>
						</form>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>

		<!--  END OF ADD MODAL -->

		<!-- Modal -->
		<div class="modal fade" id="updateSemesterModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Update Semester</h4>
					</div>
					<div class="modal-body">
						<!--  FORM ADD -->
						<form role="form" id="updateSemesterForm" class="form-horizonatal">
							<div class="input-group">
								<input type="hidden" class="form-control" name="up_semesterId"
									id="up_semesterId" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Semester Name: </span><br /> <input
									type="text" class="form-control" name="Semester name"
									id="up_semesterName" placeholder="Semester Name" />
							</div>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<button type="button" onclick="updateSemester();"
								class="btn btn-primary">Save changes</button>
						</form>
					</div>
					<div class="modal-footer">
					</div>
				</div>
			</div>
		</div>

		<!--  END OF UPDATE MODAL -->
		
		<!--  BEGIN DELETE MODAL -->
		
		<div id="deleteModal" class="modal hide fade">
			<input type="hidden" id="del_semesterId" name="del_semesterId" />
			<input type="hidden" id="del_semesterName" name="del_semesterName" />
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Delete Confirmation</h3>
            </div>
            <div class="modal-body">
				Are you sure you want to delete?
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-primary" data-dismiss="modal"
                	onclick="deleteSemester()">Yes</a>
                <a href="javascript:;" class="btn" data-dismiss="modal">Close</a>
            </div>
        </div>
		
		<!--  END DELETE MODAL -->

	</div>
</body>
</html>
