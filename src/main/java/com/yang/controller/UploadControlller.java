package com.yang.controller;

import com.alibaba.excel.EasyExcel;
import com.yang.common.DemoDataListener;
import com.yang.common.EasyExcelUtil;
import com.yang.dao.UserMapper;
import com.yang.pojo.UserExcel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/upload")
public class UploadControlller {

    @Autowired
    private UserMapper userMapper;

    /**
     * 文件上传
     * 1. 创建excel对应的实体对象 参照{@link UserExcel}
     * 2. 由于默认一行行的读取excel，所以需要创建excel一行一行的回调监听器.
     * 3. 直接读即可
     */
    @RequestMapping(value = "excelImport", method = {RequestMethod.GET, RequestMethod.POST })
    public String excelImport(@RequestParam("uploadFile") MultipartFile[] files) throws Exception {
        if(files != null && files.length > 0){
            MultipartFile file = files[0];
            Map<String,Object> result = EasyExcelUtil.readExcel(file, new UserExcel(),1);
            Boolean flag = (Boolean) result.get("flag");
            if(flag){
                List<UserExcel> userExcelList = (List<UserExcel>) result.get("userExcelList");
                userMapper.insertByList(userExcelList);
                userExcelList.stream().forEach(userExcel -> {
                    System.out.println(userExcel);
                });
            }else{
                System.out.println("表头格式错误");
            }
        }
        return "redirect:/user/pagingQueryUserList";
    }



    @RequestMapping(value = "uploadFile", method = {RequestMethod.GET, RequestMethod.POST })
    public String importFile(@RequestParam("uploadFile") MultipartFile files) throws Exception {
            // 有个很重要的点 DemoDataListener 不能被spring管理，要每次读取excel都要new,然后里面用到spring可以构造方法传进去
            // 这里 需要指定读用哪个class去读，然后读取第一个sheet 文件流会自动关闭
            EasyExcel.read(files.getInputStream(), UserExcel.class, new DemoDataListener(userMapper)).sheet().doRead();
         return "redirect:/user/pagingQueryUserList";
    }
    }

