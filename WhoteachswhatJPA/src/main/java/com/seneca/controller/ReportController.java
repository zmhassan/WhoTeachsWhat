package com.seneca.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.seneca.repository.FacultyToCourseInSemesterYearDao;
import com.seneca.service.CourseService;

/**
 * This class is the controller which regulates all faculty operations.
 * 
 * @author Zakeria Hassan <zak.hassan1010@gmail.com>, Anil Santokhi <anil.d.santokhi@gmail.com>
 * @lastmodified May 3, 2014
 * @version 1.0
 */

@Controller
public class ReportController {

	@Autowired
	CourseService courseService;

	@Autowired
	FacultyToCourseInSemesterYearDao facultyToCourseInSemesterYearDao;

	@RequestMapping(value = "/whoTeachesWhat", method = RequestMethod.GET)
	public String whoTeachesWhat(ModelMap model) {
		model.addAttribute("entityList", courseService.getAll());
		// TODO: make a fetch from the database for who teachs what course
		return "Reports/whoteacheswhat";
	}

	@RequestMapping(value = "/teachingHistory", method = RequestMethod.GET)
	public String teachingHistory(ModelMap model) {
		// TODO: JASPER REPORT generation to be done with this data.

		model.addAttribute("entityList",
				facultyToCourseInSemesterYearDao.getAll());
		return "teachinghistory";
	}

	/*
	 * JASPER REPORT Example:
	 * 
	 * 
	 * 
	 * @RequestMapping(value = "/processReport", params = { "teachingHistory" })
	 * public ResponseEntity<byte[]>
	 * processReport(@RequestParam("teachingHistory") String selectedMeeting) {
	 * byte[] content =
	 * reportingDao.getReports(Integer.parseInt(selectedMeeting)); HttpHeaders
	 * headers = new HttpHeaders();
	 * headers.setContentType(MediaType.parseMediaType("application/pdf"));
	 * String filename = "output.pdf";
	 * headers.setContentDispositionFormData(filename, filename);
	 * headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");
	 * ResponseEntity<byte[]> response1 = new
	 * ResponseEntity<byte[]>(content,headers, HttpStatus.OK); return response1;
	 * }
	 */

}
