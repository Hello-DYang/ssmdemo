package com.yang.service.impl;


import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yang.common.DemoDataListener;
import com.yang.common.ExcelImgUtil;
import com.yang.dao.UserMapper;
import com.yang.pojo.User;
import com.yang.pojo.UserExcel;
import com.yang.service.UserService;
import org.apache.poi.ss.usermodel.PictureData;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper,User> implements UserService {

    @Autowired
    private UserMapper userMapper;

    /*
     * @Author Yang
     * @Description 文件上传
     * @Date 14:16 2022/3/16
     * @Param [fileInputStream]
     * @return void
     **/
    @Override
    public void upload(MultipartFile files) throws IOException {

        String filePath = "D:/yc/ssmdemo/src/main/webapp/access/upload/";//图片保存路径

        XSSFWorkbook wb = new XSSFWorkbook(files.getInputStream());

        XSSFSheet sheet = wb.getSheetAt(0);// 得到Excel工作表对象

        Map<String, PictureData> map = ExcelImgUtil.getPictures(sheet);//获取图片和位置

        Map<String, String> pathMap = ExcelImgUtil.printImg(map, filePath);//写入图片，并返回图片路径，key：图片坐标，value：图片路径
        EasyExcel.read(files.getInputStream(), UserExcel.class, new DemoDataListener(userMapper,pathMap)).sheet().doRead();

    }
}
