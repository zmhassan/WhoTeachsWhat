package com.seneca.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seneca.bireports.Swift;
import com.seneca.model.CompHour;
import com.seneca.model.Course;
import com.seneca.model.Faculty;
import com.seneca.model.FacultyToCourseInSemesterYear;
import com.seneca.model.PrepTime;
import com.seneca.model.Semester;
import com.seneca.repository.CompHourDao;
import com.seneca.repository.CourseDao;
import com.seneca.repository.FacultyDao;
import com.seneca.repository.FacultyToCourseInSemesterYearDao;
import com.seneca.repository.PrepTimeDao;
import com.seneca.repository.SemesterDao;

@Service("facultyToCourseInSemesterYearService")
public class FacultyToCourseInSemesterYearService {

	private static final Logger logger = LoggerFactory
			.getLogger(FacultyToCourseInSemesterYearService.class);

	@Autowired
	FacultyToCourseInSemesterYearDao facultyToCourseInSemesterYearDao;

	@Autowired
	CourseDao courseDao;

	@Autowired
	CompHourDao compHourDao;

	@Autowired
	FacultyDao facultyDao;

	@Autowired
	PrepTimeDao prepTimeDao;
	
	@Autowired
	SemesterDao semesterDao;

	// CRUD OPERATIONS:
	public FacultyToCourseInSemesterYear add(Integer faculty_id,
			Integer prepType_id, Integer course_id, Integer compHour_id,
			Integer year, Integer semester_id, Integer section_number,
			float comphoursAllowance, float additionAttribute,
			float comphourAssigned, Integer class_size, Float evalFactor1, Float evalFactor2,
			Float evalFactor3, Integer factor_id) {

			// TODO: You need to map the semester to a semester id
			FacultyToCourseInSemesterYear rToFaculty = new FacultyToCourseInSemesterYear();
			rToFaculty.setCourse(courseDao.getById(course_id));
			rToFaculty.setFaculty(facultyDao.getById(faculty_id));
			rToFaculty.setPrepTime(prepTimeDao.getById(prepType_id));
			rToFaculty.setCompHour(compHourDao.getById(compHour_id));
			rToFaculty.setYear(year);
			rToFaculty.setSectionNumber(section_number);
			rToFaculty.setSemester(semesterDao.getById(semester_id));
			rToFaculty.setCompHour_allowance(comphoursAllowance);
			rToFaculty.setAdditionAttribute(additionAttribute);
			rToFaculty.setCompHour_assigned(comphourAssigned);
			
			rToFaculty.setEvalFactor1(evalFactor1);
			rToFaculty.setEvalFactor2(evalFactor2);
			rToFaculty.setEvalFactor3(evalFactor3);
			rToFaculty.setFactorId(factor_id);
			
		return facultyToCourseInSemesterYearDao.create(rToFaculty);
	}

	public FacultyToCourseInSemesterYear update(Integer id, Integer faculty_id,
			Integer prepType_id, Integer course_id, Integer compHour_id,
			Integer year, Integer semester_id, Integer section_number,
			float comphoursAllowance, float additionAttribute,
			float comphourAssigned, Integer class_size, Float evalFactor1, Float evalFactor2,
			Float evalFactor3, Integer factor_id) {

		FacultyToCourseInSemesterYear rToFaculty = facultyToCourseInSemesterYearDao
				.getById(id);

		// TODO: SET values into rToFaculty

		rToFaculty.setCourse(courseDao.getById(course_id));
		rToFaculty.setFaculty(facultyDao.getById(faculty_id));
		rToFaculty.setPrepTime(prepTimeDao.getById(prepType_id));
		rToFaculty.setCompHour(compHourDao.getById(compHour_id));
		rToFaculty.setYear(year);
		rToFaculty.setSectionNumber(section_number);
		// TODO: You need to map the semester to a semester id
		rToFaculty.setSemester(semesterDao.getById(semester_id));
		rToFaculty.setCompHour_allowance(comphoursAllowance);
		rToFaculty.setAdditionAttribute(additionAttribute);
		rToFaculty.setCompHour_assigned(comphourAssigned);
		
		rToFaculty.setEvalFactor1(evalFactor1);
		rToFaculty.setEvalFactor2(evalFactor2);
		rToFaculty.setEvalFactor3(evalFactor3);
		rToFaculty.setFactorId(factor_id);

		facultyToCourseInSemesterYearDao.update(rToFaculty);
		return rToFaculty;
	}

	public void delete(Integer id) {
		facultyToCourseInSemesterYearDao.delete(id);
	}

	public List<FacultyToCourseInSemesterYear> getAll() {
		return facultyToCourseInSemesterYearDao.getAll();
	}

	public List<Swift> getAllSwifts(Integer id, Integer semester, Integer year) {

		List<FacultyToCourseInSemesterYear> swiftContents = this.getAll();
		int swiftContentsSize = swiftContents.size();
		List swiftList= new ArrayList<Swift>();
		
		for (FacultyToCourseInSemesterYear sc : swiftContents) {
			Swift s = new Swift();
			
			s.setAdditional_attr_hours(sc.getAdditionAttribute());
			s.setAttr_hours(sc.getAdditionAttribute()); // Need attribute
			s.setClass_size(30); // Need attribute
			s.setComp_hours_allowed(sc.getCompHour_allowance());
			s.setAttr_hours(20); // Need attribute
			s.setComp_hours_assigned(sc.getCompHour_assigned());
			s.setCourse_code(sc.getCourse().getCourseCode());
			s.setEval_e_percent((int)sc.getCourse().getEvalFactor1());
			s.setEval_p_percent((int)sc.getCourse().getEvalFactor2());
			s.setEval_r_percent((int)sc.getCourse().getEvalFactor3());
			s.setLang('E');
			s.setTeaching_hours(sc.getFaculty().getHoursToTeach());
			s.setEval_factor(1.7);
			s.setRef('Y');
			s.setPrep_type("DA");
			s.setPrep_additional_hours(0);
			s.setPrep_attributed_hours(0);
			s.setPrep_factor(0);
			swiftList.add(s);
		}
		
		return swiftList;
	}
}
