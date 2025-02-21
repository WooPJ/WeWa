package com.springboot.wearwave.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CheckDaoImpl implements CheckDao {
	@Autowired
	private SqlSession sqlSession;
	@Override
	public Integer checkDupId(String user_id) {
		Integer count = this.sqlSession.selectOne("checkMapper.checkDupId",user_id);
		return count;
	}

}


