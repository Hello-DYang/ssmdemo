package com.yang.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

@Data
public class LedScreen {
//    id
   @TableId(type= IdType.AUTO)
    private Integer id;
//名称
    private String name;
//高度
    private Double width;
//宽度
    private Double hight;
//所属组织机构
    private String affiliatedOrganization;
//设备编号
    private String deviceId;
//型号名称
    private String modelName;
//备注
    private String remark;
}
