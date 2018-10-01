package com.shop.shop;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.ui.Model;

public interface ShopRepository extends CrudRepository<Shop, String>{

	Shop findBySid(int sid);
	Shop findByTotalid(String totalid);
	void save(Model model);
	List<Shop> findByFlagsLike(int deleted);
	

	
	@Query
	List<Shop> findAllByOrderByNameDesc();
	
	@Query
	List<Shop> findAllByOrderByNameAsc();
	
	@Query
	List<Shop> findAllByOrderByEnrolldtDesc();
	
	@Query
	List<Shop> findAllByOrderByEnrolldtAsc();
	
}
