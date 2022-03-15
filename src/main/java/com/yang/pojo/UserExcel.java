package com.yang.pojo;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.metadata.BaseRowModel;
import lombok.Data;

@Data
public class UserExcel extends BaseRowModel {

    @ExcelProperty(index = 0,value = "用户名")
    private String username;

    @ExcelProperty(index = 1,value = "性别")
    private String sex;

    @ExcelProperty(index = 2,value = "年龄")
    private String age;

    @ExcelProperty(index = 3,value = "地址")
    private String address;

    @ExcelProperty(index = 4,value = "照片")
    private String photo;
}
