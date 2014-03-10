package com.seneca.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seneca.model.Course;
import com.seneca.repository.CourseDao;

@Service("courseService")
public class CourseService {

	private static final Logger logger = LoggerFactory.getLogger(CourseService.class);
	
	
	@Autowired
	private CourseDao courseDao;
	
	
	//CRUD OPERATIONS:
	
	
	public Course add(String course_code, String course_name){
		
			Course course= new Course();
			course.setCourseCode(course_code);
			course.setCourseName(course_name);
			logger.info("Entering courseDao.create : ");
			courseDao.create(course);
			logger.info("Exiting courseDao.create : ");
		
		return null;
	}

	
	public void update(Long id, String course_code, String course_name) {
		Course course=courseDao.getById(id);
		course.setCourseCode(course_code);
		course.setCourseName(course_name);
		
		courseDao.update(course);
	}
	
	public void delete(Long id) {
		courseDao.delete(id);
	}

	public List<Course> getAll() {
		return 	courseDao.getAll();
	}
	
}
