package com.yang.controller;

import com.yang.dao.UserMapper;
import com.yang.pojo.LedScreen;
import com.yang.pojo.User;
import com.yang.service.LedScreenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/paper")
public class RouterController {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private LedScreenService ledScreenService;

    /**
     * @Author Yang
     * @Description 首页跳转
     * @Date 17:44 2022/3/8
     * @Param [model]
     * @return java.lang.String
     **/
    @RequestMapping("/allPaper")
    public String list(Model model) {
        User user=new User();
        List<User> list = userMapper.getuserList(user);
        model.addAttribute("list", list);
        return "allPaper";
    }


    @RequestMapping("/toLedPaper")
    public String toLedPaper(Model model) {
        List<LedScreen> ledScreens = ledScreenService.list();
        model.addAttribute("list", ledScreens);
        return "ledPaper";
    }


    /*
     * @Author Yang
     * @Description 添加页面跳转
     * @Date 17:45 2022/3/8
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping("toAddPaper")
    public String toAddPaper() {
        return "addPaper";
    }

    /*
     * @Author Yang
     * @Description 添加页面跳转
     * @Date 17:45 2022/3/8
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping("toAddLedPaper")
    public String toAddLedPaper() {
        return "addLedPaper";
    }



    /*
     * @Author Yang
     * @Description 跳转到verfy页面
     * @Date 11:18 2022/3/17
     * @Param []
     * @return java.lang.String
     **/
    @RequestMapping("toVerify")
    public String toVerfyPaper() {
        return "verify";
    }


    /*
     * @Author Yang
     * @Description 更新页面跳转
     * @Date 17:45 2022/3/8
     * @Param [model, id]
     * @return java.lang.String
     **/
    @RequestMapping("toUpdatePaper")
    public String toUpdatePaper(Model model, int id) {
        model.addAttribute("paper", userMapper.selectByPrimaryKey(id));
        return "updatePaper";
    }

    /*
     * @Author Yang
     * @Description 更新页面跳转
     * @Date 17:45 2022/3/8
     * @Param [model, id]
     * @return java.lang.String
     **/
    @RequestMapping("toUpdateLed")
    public String toUpdateLed(Model model, int id) {
        model.addAttribute("paper", ledScreenService.getById(id));
        return "updateLed";
    }

    @RequestMapping("toCaptcha")
    public String toCaptcha() {
        return "captcha";
    }

}
