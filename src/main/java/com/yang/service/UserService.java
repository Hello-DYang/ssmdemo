package com.yang.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.yang.pojo.User;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;


public interface UserService extends IService<User> {

    void upload(MultipartFile files) throws IOException;

}
