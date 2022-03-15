package com.yang.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yang.dao.UserMapper;
import com.yang.pojo.User;
import com.yang.service.UserService;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper,User> implements UserService {

}
