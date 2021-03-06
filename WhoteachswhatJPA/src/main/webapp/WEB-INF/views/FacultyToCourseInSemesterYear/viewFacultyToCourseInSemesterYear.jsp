<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Manage Faculty - Course in Semester Year</title>
<jsp:include page="../includes/static_includes.jsp" />
<script type="text/javascript" src="views_ajax_requests/viewFacultyToCourseInSemesterYearAJAX.js"></script>
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
				<li><a href="#">Manage Faculty</a></li>
				<li><a href="viewFacultyToCourseInSemesterYear">Manage Course to Semester Year</a></li>
			</ul>
		</div>
		<header>
			<i class="icon-big-notepad"></i>
			<h2>
				<small>Manage Faculty Courses in a Semester Year</small>
			</h2>
			<h3>
				<small>Add, Update and Delete a faculty member's courses per semester year</small>
			</h3>
		</header>
		<form method="post" action="api/course" id="addCourseForm"
			onsubmit="return validateAddCourse();" class="form-horizontal">
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
									<th>Faculty</th>
									<th>Course Section</th>
									<th>Semester Year</th>
									<th>Comp Hour</th>
									<th>Hours</th>
									<th>Prep Time</th>
									<th>Addition</th>
									<th width="25%" style="text-align: right">Operation(s)</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="facultyId">
								    <c:out value = "${param.id}" />
								</c:set>
								
								
								<c:forEach items="${allFacultyToCourseInSemesterYear}" var="facToCourse">
									<c:if test="${facToCourse.getFaculty().getFacultyId() == facultyId || empty facultyId}"> 
									<tr>
										<td>
											${facToCourse.getFaculty().getFacultyFirstName() } 
											${facToCourse.getFaculty().getFacultyLastName() }
										</td>
										<td>${facToCourse.getCourse().getCourseCode() } x ${facToCourse.getSectionNumber() }</td>
										<td>${facToCourse.getSemester().getSemesterName() } ${facToCourse.getYear() }</td>
										<td>${facToCourse.getCompHour().getCompHour_name()}</td>
										<td>${facToCourse.getCompHour_assigned() }</td>
										<td>
											${facToCourse.getPrepTime().getPrepName() } 
											${facToCourse.getPrepTime().getPrepFactor()}
										</td>
										<td>${facToCourse.getAdditionAttribute() }</td>
										
										<td class="align">
											 <a
											 	class="bootstrap-tooltip" data-original-title="Update"
												onclick="updateForm('${facToCourse.getCisyId() }',
													'${facToCourse.getFaculty().getFacultyId()}',
													'${facToCourse.getAdditionAttribute()}',
													'${facToCourse.getCompHour_allowance() }',
													'${facToCourse.getCompHour_assigned() }',
													'${facToCourse.getSectionNumber() }',
													'${facToCourse.getSemester().getSemesterId() }',
													'${facToCourse.getYear() }',
													'${facToCourse.getCompHour().getCompHour_id() }',
													'${facToCourse.getCourse().getCourseId() }',
													'${facToCourse.getPrepTime().getPrepId() }',
													'${facToCourse.getEvalFactor1() }',
													'${facToCourse.getEvalFactor2() }',
													'${facToCourse.getEvalFactor3() }',
													'${facToCourse.getFactorId() }'
													)"
												data-toggle="modal" data-target="#updateFacToCourseSemModal">
												<i class="icon-edit"></i>
											</a>
											
											<a
												class="bootstrap-tooltip" data-original-title="Delete"
												onclick="deleteForm('${facToCourse.getCisyId() }',
													'${facToCourse.getCourse().getCourseCode() }',
													'${facToCourse.getFaculty().getFacultyFirstName()}',
													'${facToCourse.getFaculty().getFacultyLastName()}' )"
												data-toggle="modal" data-target="#deleteModal">
												<i class="icon-trash"></i>
											</a>
										</td>
									</tr>
									</c:if>
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
			data-target="#addFacToCourseSemModal" onclick="loadEvalFactor(document.getElementById('courseId'))">
			Add Faculty to Course</button>

		<!-- Modal -->
		<div class="modal fade" id="addFacToCourseSemModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Add Faculty to Course</h4>
					</div>
					<div class="modal-body">
						<!--  FORM ADD -->
						<form role="form" id="addFacToCourseSemForm" class="form-horizonatal">
							<c:if test="${ empty facultyId }">
								<div class="input-group">
									<span class="input-group-addon">Faculty:</span> <br /> 
										<select class="form-control" id="facultyId">
											<c:forEach items="${allFaculty }" var="fac">
												<option value="${fac.getFacultyId() }">
													${fac.getFacultyFirstName() } ${fac.getFacultyLastName() }
												</option>
											</c:forEach>
									</select>
								</div>
							</c:if>
							<div class="input-group">
								<span class="input-group-addon">Addition: </span><br /> <input
									type="text" class="form-control" name="Addition attribute" id="additionAttribute"
									placeholder="" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Comp Hour Type:</span> <br /> <select
									class="form-control" id="comphourId" name="Complimentary hour id">
									<c:forEach items="${allCompHours }" var="ch">
									<option value="${ch.getCompHour_id() }">${ch.getCompHour_name() }</option>
									</c:forEach>
								</select>
							</div>
							<div class="input-group">
								<span class="input-group-addon">Comp Hour Allowance: </span><br /> <input
									type="text" class="form-control" name="Complimentary hour allowance" id="comphourAllowance"
									placeholder="" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Section Number: </span><br /> <input
									type="text" class="form-control" name="Section number" id="sectionNumber"
									placeholder="5" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Comp Hours Assigned: </span><br /> <input
									type="text" class="form-control" name="Complimentary hour assigned" id="comphourAssigned"
									placeholder="" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Semester:</span> <br /> <select
									class="form-control" id="semesterId" name="Semester id">
									<c:forEach items="${allSemesters }" var="semester">
									<option value="${semester.getSemesterId() }">${semester.getSemesterName() }</option>
									</c:forEach>
								</select>
							</div>
							<div class="input-group">
								<span class="input-group-addon">Year: </span><br /> <input
									type="text" class="form-control" name="Year" id="year"
									placeholder="2014" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Course:</span> <br /> <select
									class="form-control" id="courseId" name="Course id">
									<c:forEach items="${allCourses }" var="course">
									<option value="${course.getCourseId() }" 
										onclick="loadEvalFactor(document.getElementById('courseId'))">
										${course.getCourseCode() }
									</option>
									</c:forEach>
								</select>
							</div>
							<div class="input-group">
								<span class="input-group-addon">Class size: </span><br /> <input
									type="text" class="form-control" name="Class size" id="classSize"
									placeholder="30" />
							</div>
							
							
							<!--  Preload evalfactors from course when server side is finished -->
							
							<div class="input-group">
								<span class="input-group-addon">Evaluation 1: </span><br /> <input
									type="text" class="form-control" name="Evaluation 1" id="evalFactor1" disabled />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Evaluation 2: </span><br /> <input
									type="text" class="form-control" name="Evaluation 2" id="evalFactor2" disabled />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Evaluation 3: </span><br /> <input
									type="text" class="form-control" name="Evaluation 3" id="evalFactor3" disabled />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Override? </span><br /> <input
									type="checkbox" class="form-control" name="Override" id="override" 
									onclick="changeEvalFactorStatus(this)" value="1" />
									<br />
							</div>
							
							<div class="input-group">
								<span class="input-group-addon">Prep Time:</span> <br /> <select
									class="form-control" id="prepTimeId" name="Prep time id">
									<c:forEach items="${allPrepTime}" var="pt">
									<option value="${pt.getPrepId() }">
										${pt.getPrepName() }
									</option>
									</c:forEach>
								</select>
							</div>
							<div class="input-group">
								<span class="input-group-addon">Factor:</span> <br /> <select
									class="form-control" id="factorId" name="Factor id">
									<c:forEach items="${allFactors}" var="factor">
									<option value="${factor.getFactorId() }">
										${factor.getFactorName() }
									</option>
									</c:forEach>
								</select>
							</div>
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<button type="button" onclick="addFacToCourseSem();"
								class="btn btn-primary">Save changes</button>

						</form>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>

		<!--  END OF ADD MODAL -->
			<!-- Modal -->
		<div class="modal fade" id="updateFacToCourseSemModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">Update Faculty to Course</h4>
					</div>
					<div class="modal-body">
						<!--  FORM ADD -->
						<form role="form" id="updateFacToCourseSemForm" class="form-horizonatal">
							<div class="input-group">
								<input type="hidden" class="form-control" name="Faculty to course id" id="up_cisId" />
							</div>
							<c:if test="${ empty facultyId }">
								<div class="input-group">
									<span class="input-group-addon">Faculty:</span> <br /> 
										<select class="form-control" id="up_facultyId" name="Faculty id">
											<c:forEach items="${allFaculty }" var="fac">
												<option value="${fac.getFacultyId() }">
													${fac.getFacultyFirstName() } ${fac.getFacultyLastName() }
												</option>
											</c:forEach>
									</select>
								</div>
							</c:if>
							<div class="input-group">
								<span class="input-group-addon">Addition: </span><br /> <input
									type="text" class="form-control" name="Addition attribute" id="up_additionAttribute"
									placeholder="" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Comp Hour Type:</span> <br /> <select
									class="form-control" id="up_comphourId" name="Complimentary hour id">
									<c:forEach items="${allCompHours }" var="ch">
									<option value="${ch.getCompHour_id() }">${ch.getCompHour_name() }</option>
									</c:forEach>
								</select>
							</div>
							<div class="input-group">
								<span class="input-group-addon">Comp Hour Allowance: </span><br /> <input
									type="text" class="form-control" name="Complimentary hour allowance" 
										id="up_comphourAllowance"
									placeholder="" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Section Number: </span><br /> <input
									type="text" class="form-control" name="Section number" id="up_sectionNumber"
									placeholder="5" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Comp Hours Assigned: </span><br /> <input
									type="text" class="form-control" name="Complimentary hour assigned" id="up_comphourAssigned"
									placeholder="" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Semester:</span> <br /> <select
									class="form-control" id="up_semesterId" name="Semester id">
									<c:forEach items="${allSemesters }" var="semester">
									<option value="${semester.getSemesterId() }">${semester.getSemesterName() }</option>
									</c:forEach>
								</select>
							</div>
							<div class="input-group">
								<span class="input-group-addon">Year: </span><br /> <input
									type="text" class="form-control" name="Year" id="up_year"
									placeholder="2014" />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Course:</span> <br /> <select
									class="form-control" id="up_courseId" name="Course id"
									onclick="loadEvalFactor(document.getElementById('up_courseId'))">
									<c:forEach items="${allCourses }" var="course">
									<option value="${course.getCourseId() }">
										${course.getCourseCode() }
									</option>
									</c:forEach>
								</select>
							</div>
							
							<div class="input-group">
								<span class="input-group-addon">Class size: </span><br /> <input
									type="text" class="form-control" name="Class size" id="up_classSize"
									placeholder="30" />
							</div>
							
							
							<!--  Preload evalfactors from course when server side is finished -->
							
							<div class="input-group">
								<span class="input-group-addon">Evaluation 1: </span><br /> <input
									type="text" class="form-control" name="Evaluation 1" id="up_evalFactor1" disabled />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Evaluation 2: </span><br /> <input
									type="text" class="form-control" name="Evaluation 2" id="up_evalFactor2" disabled />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Evaluation 3: </span><br /> <input
									type="text" class="form-control" name="Evaluation 3" id="up_evalFactor3" disabled />
							</div>
							<div class="input-group">
								<span class="input-group-addon">Override? </span><br /> <input
									type="checkbox" class="form-control" name="Override" id="up_override" 
									onclick="changeEvalFactorStatus(this)" value="1" />
									<br />
							</div>
							
							<div class="input-group">
								<span class="input-group-addon">Prep Time:</span> <br /> <select
									class="form-control" id="up_prepTimeId" name="Prep time id">
									<c:forEach items="${allPrepTime}" var="pt">
									<option value="${pt.getPrepId() }">
										${pt.getPrepName() }
									</option>
									</c:forEach>
								</select>
							</div>
							
							<div class="input-group">
								<span class="input-group-addon">Factor:</span> <br /> <select
									class="form-control" id="up_factorId" name="Factor id">
									<c:forEach items="${allFactors}" var="factor">
									<option value="${factor.getFactorId() }">
										${factor.getFactorName() }
									</option>
									</c:forEach>
								</select>
							</div>
							
							<button type="button" class="btn btn-default"
								data-dismiss="modal">Close</button>
							<button type="button" onclick="updateFacToCourseSem();"
								class="btn btn-primary">Save changes</button>

						</form>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>
		
		<!--  END OF UPDATE MODAL -->
		
		<!--  BEGIN DELETE MODAL -->
		
		<div id="deleteModal" class="modal hide fade">
			<input type="hidden" id="del_cisId" name="Faculty to course id" />
			<input type="hidden" id="del_course_name" />
			<input type="hidden" id="del_fname" />
			<input type="hidden" id="del_lname" />
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h3>Delete Confirmation</h3>
            </div>
            <div class="modal-body">
				Are you sure you want to delete?
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn" data-dismiss="modal">Close</a>
                <a href="javascript:;" class="btn btn-primary" data-dismiss="modal"
                	onclick="deleteFacToCourseSem()">Yes</a>
            </div>
        </div>
		
		<!--  END DELETE MODAL -->
		
	</div>
</body>
</html>
