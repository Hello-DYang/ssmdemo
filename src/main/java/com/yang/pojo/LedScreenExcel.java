package com.yang.pojo;

import com.alibaba.excel.annotation.ExcelProperty;
import com.alibaba.excel.annotation.write.style.ColumnWidth;
import com.alibaba.excel.annotation.write.style.ContentStyle;
import com.alibaba.excel.annotation.write.style.HeadStyle;
import lombok.Data;
import lombok.experimental.Accessors;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;

@Data
@ColumnWidth(30)
@HeadStyle(fillPatternType = FillPatternType.SOLID_FOREGROUND, fillForegroundColor = 44)
@ContentStyle(
        borderTop = BorderStyle.THIN,
        borderRight = BorderStyle.THIN,
        borderBottom = BorderStyle.THIN,
        borderLeft = BorderStyle.THIN,
        horizontalAlignment = HorizontalAlignment.CENTER,
        wrapped = true
)
@Accessors(chain = true)
public class LedScreenExcel {
//名称
    @ExcelProperty("Led名称")
    private String name;
//高度
    @ExcelProperty("高度")
    private Double width;
//宽度
    @ExcelProperty("宽度")
    private Double hight;
//所属组织机构
    @ColumnWidth(50)
    @ExcelProperty("所属组织机构")
    private String affiliatedOrganization;
//设备编号
    @ExcelProperty("设备编号")
    private String deviceId;
//型号名称
    @ExcelProperty("型号名称")
    private String modelName;
//备注
    @ExcelProperty("备注")
    private String remark;
}
