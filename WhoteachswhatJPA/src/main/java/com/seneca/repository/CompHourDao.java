package com.seneca.repository;

import java.util.List;

import com.seneca.model.CompHour;

public interface CompHourDao
{
   public List<CompHour> getAll();

	public CompHour getById(Integer id);

   public void update(CompHour entity);

	public CompHour create(CompHour entity);

	public void delete(Integer id);

	public List<CompHour> search(CompHour search, Integer first,
			Integer maxItems);

   public Long getCount(CompHour search);
}
