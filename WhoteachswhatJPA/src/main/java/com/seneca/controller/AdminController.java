package com.seneca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.seneca.service.FacultyToCourseInSemesterYearService;

/**
 * This class is the controller which regulates all faculty operations.
 * 
 * @author Zakeria Hassan <zak.hassan1010@gmail.com>
 * @lastmodified Dec 31, 2013
 * @version 0.0.1
 */

// This controller is not needed. It does nothing but call on actions that other controllers
// should manage


@Controller
public class AdminController {
	//private static final Logger logger = LoggerFactory
	//		.getLogger(AdminController.class);

	@Autowired
	FacultyToCourseInSemesterYearService facultyToCourseInSemesterYearService;
	
	
	@RequestMapping(value = "/manageCourseSection", method = RequestMethod.GET)
	public String updateFaculty() {
		//logger.info("WTWNavigator: \t /manageCourseSection");
		return "Anil_ManageCourseSections";
	}
	
	@RequestMapping(value = "/facultyswiftreport", method = RequestMethod.GET)
	public String swiftFaculty(ModelMap model,
			@RequestParam(value = "id", required = true) Integer id){
		//logger.info("WTWNavigator: \t /manageCourseSection");
		if(id!=null){
		model.addAttribute("swift", facultyToCourseInSemesterYearService.getAllSwifts(id));
		}
		return "Reports/swiftreport";
	}
	
	
}
