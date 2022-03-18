package com.yang.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.yang.common.DescribeCaptchaResult;
import com.yang.common.Result;
import com.yang.common.ResultStatus;
import com.yang.dao.UserMapper;
import com.yang.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Wrapper;

@Controller
@RequestMapping("verify")
public class VerifyController {

    @Autowired
    private UserMapper userMapper;

    @PostMapping("getVerify")
    @ResponseBody
    public Result<String> getVerify(HttpServletRequest req, HttpServletResponse resp){
        Result<String> result=new Result<>();
        String ticket = req.getParameter("ticket");
        String randstr = req.getParameter("randstr");
        DescribeCaptchaResult describeCaptchaResult = new DescribeCaptchaResult();
        if (describeCaptchaResult.codeResponse(ticket,randstr)){
            result.setResult(ResultStatus.SUCCESS);
        }else{
            result.setResult(ResultStatus.ERROR);
            result.setMessage("验证不通过！");
            return result;
        }
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("username",username);
        User user=userMapper.selectOne(queryWrapper);
        if (user!=null){
            if (user.getPassword().equals(password)){
                result.setMessage("登录成功！");
            }else {
                result.setCode(4000);
                result.setMessage("用户名或密码错误！");
            }
        }else {
            result.setCode(4000);
            result.setMessage("用户不存在，请注册！");
        }
        return result;
    }
}
