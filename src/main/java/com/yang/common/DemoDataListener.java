package com.yang.common;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.event.AnalysisEventListener;
import com.yang.dao.UserMapper;
import com.yang.pojo.UserExcel;
import org.apache.poi.xssf.usermodel.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// 有个很重要的点 DemoDataListener 不能被spring管理，要每次读取excel都要new,然后里面用到spring可以构造方法传进去
public class DemoDataListener extends AnalysisEventListener<UserExcel> {
    private static final Logger LOGGER = LoggerFactory.getLogger(DemoDataListener.class);
    /**
     * 每隔5条存储数据库，实际使用中可以3000条，然后清理list ，方便内存回收
     */
    private static final int BATCH_COUNT = 10;
    List<UserExcel> userExcelList = new ArrayList<>();
    /**
     * 假设这个是一个DAO，当然有业务逻辑这个也可以是一个service。当然如果不用存储这个对象没用。
     */
    private UserMapper userMapper;

    private Map<String, String> map;

    /**
     * 如果使用了spring,请使用这个构造方法。每次创建Listener的时候需要把spring管理的类传进来
     * @param userMapper
     */
    public DemoDataListener(UserMapper userMapper,Map<String, String> map) {
        this.userMapper = userMapper;
        this.map=map;
    }

    /**
     * 这个每一条数据解析都会来调用
     * @param userExcel
     * @param analysisContext
     */
    @Override
    public void invoke(UserExcel userExcel, AnalysisContext analysisContext) {
        LOGGER.info("解析到一条数据:{}", userExcel);
        String row=analysisContext.readRowHolder().getRowIndex().toString();
        String cloum="4";
        String key=row+"-"+cloum;
        String pictureName=map.get(key);
        userExcel.setPhoto(pictureName);
        userExcelList.add(userExcel);
        // 达到BATCH_COUNT了，需要去存储一次数据库，防止数据几万条数据在内存，容易OOM
        if (userExcelList.size() >= BATCH_COUNT) {
            saveData();
            // 存储完成清理 list
            userExcelList.clear();
        }
    }

    /**
     * 所有数据解析完成了 都会来调用
     * @param context
     */
    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        // 这里也要保存数据，确保最后遗留的数据也存储到数据库
        saveData();
        LOGGER.info("所有数据解析完成！");
    }

    /**
     * 存储数据库
     */
    private void saveData() {
        LOGGER.info("{}条数据，开始存储数据库！", userExcelList.size());
        userMapper.insertByList(userExcelList);
        LOGGER.info("存储数据库成功！");
    }

    /**
     * 获取Excel中的图片
     * @param xssfSheet
     * @return
     */
    public static Map<String, XSSFPictureData> getPictures(XSSFSheet xssfSheet){

        Map<String,XSSFPictureData> map=new HashMap<>();
        List<XSSFShape> list=xssfSheet.getDrawingPatriarch().getShapes();

        for (XSSFShape shape:list){

            XSSFPicture picture = (XSSFPicture) shape;
            XSSFClientAnchor xssfClientAnchor=(XSSFClientAnchor) picture.getAnchor();
            XSSFPictureData pdata = picture.getPictureData();
            // 行号-列号
            String key = xssfClientAnchor.getRow1() + "-" + xssfClientAnchor.getCol1();
            LOGGER.info("key数据:{}",key);
            map.put(key, pdata);

        }

        return map;
    }
}
