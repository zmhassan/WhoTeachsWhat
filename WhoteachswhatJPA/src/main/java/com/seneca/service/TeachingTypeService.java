package com.seneca.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seneca.model.Faculty;
import com.seneca.model.TeachingType;
import com.seneca.repository.TeachingTypeDao;

@Service("teachingTypeService")
public class TeachingTypeService {

	@Autowired
	TeachingTypeDao teachingTypeDao;
	
	/*
	 *  CRUD OPERATIONS SERVICE METHODS:
	 *  
	 *   add    -       addFaculty(String, String, TeachingType);
	 *   update - 	 	update();
	 *   delete -       delete();
	 *   get    - 		getAllFaculty();
	 *   
	 */
	
	//TODO: Faculty should accept 'TeachingType_id'
	public void add(String name) {
		TeachingType teachingType = new TeachingType();
		teachingType.setTeachingType_name(name);
		teachingTypeDao.create(teachingType);
	}

	public void update(Integer id, String name) {
		TeachingType teachingType = teachingTypeDao.getById(id);
		teachingType.setTeachingType_name(name);
		teachingTypeDao.update(teachingType);
	}
	
	public void delete(Integer id) {
		teachingTypeDao.delete(id);
	}

	public  List<TeachingType>  getAll() {
		return teachingTypeDao.getAll();
	}


}