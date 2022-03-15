package com.yang.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.yang.pojo.User;
import com.yang.pojo.UserExcel;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface UserMapper extends BaseMapper<User> {

    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    List<User> getuserList(User user);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    int updateByIdList(@Param("idList")List<Integer> idList, @Param("sex")String sex);

    int insertByList(List<UserExcel> userExcelList);
}