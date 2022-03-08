package com.yang.controller;


import com.yang.common.Result;
import com.yang.common.ResultStatus;
import com.yang.dao.UserMapper;
import com.yang.pojo.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@RestController
@RequestMapping("/blog/api")
public class MainController {

    @Autowired
    private UserMapper userMapper;


    private Logger logger = Logger.getLogger ( MainController.class );


    /*
     * @Author Yang
     * @Description
     * @Date 14:47 2022/3/4
     * @Param [id]
     * @return com.blog.common.Result<com.blog.mybatis.model.User>
     **/
    @RequestMapping("/selectByPrimaryKey")
    public Result<User> selectByPrimaryKey(Integer id){
        logger.info("根据id查找");
        Result result = new Result();
        User user= userMapper.selectByPrimaryKey(id);
        result.setData(user);
        result.setMessage("sucess");
        return result;
    }

    /*
     * @Author Yang
     * @Description 插入数据
     * @Date 14:54 2022/3/4
     * @Param [user]
     * @return com.blog.common.Result
     **/
    @RequestMapping("/addUser")
    public Result addUser(@RequestBody User user){
        logger.info("插入User");
        Result result=new Result();
        int i=userMapper.insert(user);
        logger.info("插入User返回值"+i);
        if (i>0){
            logger.info("数据插入成功！");
            result.setResult(ResultStatus.SUCCESS);
        }else {
            logger.info("数据插入失败！");
            result.setResult(ResultStatus.ERROR);
        }
        return result;
    }

    /*
     * @Author Yang
     * @Description 根据主键删除user
     * @Date 15:01 2022/3/4
     * @Param [id]
     * @return com.blog.common.Result
     **/
    @RequestMapping("/deleteByPrimaryKey")
    public Result deleteByPrimaryKey(Integer id){
        logger.info("根据主键删除user");
        Result result=new Result();
        int i=userMapper.deleteByPrimaryKey(id);
        logger.info("根据主键删除user返回值"+i);
        if (i>0){
            logger.info("根据主键删除user成功！");
            result.setResult(ResultStatus.SUCCESS);
        }else {
            logger.info("根据主键删除user失败！");
            result.setResult(ResultStatus.USER_NOT_EXISTS);
        }
        return result;
    }

    /*
     * @Author Yang
     * @Description 有选择的更新数据
     * @Date 14:55 2022/3/4
     * @Param [user]
     * @return com.blog.common.Result
     **/
    @RequestMapping("/updateByPrimaryKeySelective")
    public Result updateByPrimaryKeySelective(@RequestBody User user){
        logger.info("有选择的更新数据");
        Result result=new Result();
        int i= userMapper.updateByPrimaryKeySelective(user);
        logger.info("更新数据返回值"+i);
        if (i>0){
            logger.info("有选择的更新数据成功！");
            result.setResult(ResultStatus.SUCCESS);
        }else {
            logger.info("有选择的更新数据失败！");
            result.setResult(ResultStatus.ERROR);
        }
        return result;
    }



    /*
     * @Author Yang 
     * @Description 测试接口
     * @Date 15:12 2022/3/4
     * @Param []
     * @return com.blog.common.Result
     **/
    @RequestMapping ( value = "/check", method = RequestMethod.POST )
    @CrossOrigin
    public Result check () {
        logger.info("MainController run");
        Result result = new Result();
        result.setMessage("SSM后端框架搭建成功");
        return result;
    }

}
