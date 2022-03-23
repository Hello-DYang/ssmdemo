package com.yang.controller;


import com.yang.common.Result;
import com.yang.dao.UserMapper;
import com.yang.pojo.User;
import com.yang.service.UserService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;


@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private UserService userService;


    private Logger logger = Logger.getLogger ( UserController.class );


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
        User user=userMapper.selectById(id);
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
    public String addUser(User user){
        logger.info("插入User");
        userMapper.insert(user);
        return "redirect:/user/pagingQueryUserList";
    }


    /*
     * @Author Yang
     * @Description 根据主键删除user
     * @Date 15:01 2022/3/4
     * @Param [id]
     * @return com.blog.common.Result
     **/
    @RequestMapping("/deleteByPrimaryKey/{id}")
    public String deleteByPrimaryKey(@PathVariable("id") Integer id){
        logger.info("根据主键删除user");
        int i=userMapper.deleteById(id);
        logger.info("根据主键删除user返回值"+i);
        return "redirect:/user/pagingQueryUserList";
    }

    /*
     * @Author Yang
     * @Description 有选择的更新数据
     * @Date 14:55 2022/3/4
     * @Param [user]
     * @return com.blog.common.Result
     **/
    @RequestMapping("/updateByPrimaryKeySelective")
    public String updateByPrimaryKeySelective(Model model, User user,MultipartFile file, HttpServletRequest request) throws IOException {
        logger.info("有选择的更新数据");
        String filename=file.getOriginalFilename();
        user.setPhoto("access/"+filename);
        userMapper.updateByPrimaryKeySelective(user);

        user = userMapper.selectByPrimaryKey(user.getId());
        model.addAttribute("paper", user);
        return "redirect:/user/pagingQueryUserList";
    }


    /*
     * @Author Yang
     * @Description 分页查询
     * @Date 11:00 2022/3/10
     * @Param [req, resp]
     * @return void
     **/
    @RequestMapping("/pagingQueryUserList")
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String p = req.getParameter("page");
        User user=new User();
        String username=req.getParameter("username");
        Integer sorted;
        if (null==req.getParameter("sorted")){
            sorted=1;
        }else {
            sorted = Integer.valueOf(req.getParameter("sorted"));
        }
        int page;
        try {
            //当前页数
            page = Integer.valueOf(p);
        } catch (NumberFormatException e) {
            page = 1;
        }
        user.setUsername(username)  ;
        List<User> userList=userMapper.getuserList(user);
        if (null !=sorted) {
            if (2 == sorted) {
                userList = userList.stream().sorted(Comparator.comparing(User::getId).reversed()).collect(Collectors.toList());
            }
        }
        //用户总数
        int totalUsers = userList.size();
        //每页用户数
        int usersPerPage = 10;
        //总页数
        int totalPages = totalUsers % usersPerPage == 0 ? totalUsers / usersPerPage : totalUsers / usersPerPage + 1;
        //本页起始用户序号
        int beginIndex = (page - 1) * usersPerPage;
        //本页末尾用户序号的下一个
        int endIndex = beginIndex + usersPerPage;
        if (endIndex > totalUsers)
            endIndex = totalUsers;
        req.setAttribute("totalUsers", totalUsers);
        req.setAttribute("usersPerPage", usersPerPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("beginIndex", beginIndex);
        req.setAttribute("endIndex", endIndex);
        req.setAttribute("page", page);
        req.setAttribute("users", userList);
        req.setAttribute("sorted",sorted);
        req.getRequestDispatcher("/paper/allPaper").forward(req, resp);
    }

    /*
     * @Author Yang 
     * @Description 批量更新用户
     * @Date 13:27 2022/3/11
     * @Param [req, resp]
     * @return void
     **/
    @RequestMapping("updateAllUser")
    public void updateAllUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String ids=req.getParameter("ids");
        String sex=req.getParameter("sex");
        String[] idlist=ids.split(",");
        List<String> strings=Arrays.stream(idlist).filter(id->!id.isEmpty()).collect(Collectors.toList());
        List<Integer> useridList= strings.stream().map(content->{
            Integer userid=Integer.valueOf(content);
            return userid;
        }).collect(Collectors.toList());
        userMapper.updateByIdList(useridList,sex);
        resp.sendRedirect("/paper/allPaper");
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
