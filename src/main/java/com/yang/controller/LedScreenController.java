package com.yang.controller;

import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.yang.pojo.LedScreen;
import com.yang.pojo.LedScreenExcel;
import com.yang.service.LedScreenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/led")
public class LedScreenController {

    @Autowired
    private LedScreenService ledScreenService;;

    /**
     * @Author Yang
     * @Description 根据主键删除led信息
     * @Date 16:52 2022/3/24
     * @Param [id]
     * @return java.lang.String
     **/
    @RequestMapping("/deleteLedById/{id}")
    public String deleteLedById(@PathVariable("id") Integer id){
        ledScreenService.removeById(id);
        return "redirect:/led/pagingQueryLedList";
    }

    /**
     * @Author Yang
     * @Description 添加led信息
     * @Date 16:57 2022/3/24
     * @Param [ledScreen]
     * @return java.lang.String
     **/
    @RequestMapping("addLed")
    public String addLed(LedScreen ledScreen){
        ledScreenService.save(ledScreen);
        return "redirect:/led/pagingQueryLedList";
    }

    /*
     * @Author Yang
     * @Description 更新Led信息
     * @Date 16:57 2022/3/24
     * @Param [ledScreen]
     * @return java.lang.String
     **/
    @RequestMapping("updateLed")
    public String updateLed(LedScreen ledScreen){
        ledScreenService.updateById(ledScreen);
        return "redirect:/led/pagingQueryLedList";
    }

    /*
     * @Author Yang
     * @Description 分页查询
     * @Date 11:00 2022/3/10
     * @Param [req, resp]
     * @return void
     **/
    @RequestMapping("/pagingQueryLedList")
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String p = req.getParameter("page");
        String name=req.getParameter("name");
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
        QueryWrapper queryWrapper=new QueryWrapper<>();
        queryWrapper.like(StringUtils.isNotBlank(name), "name",name);
        List<LedScreen> ledScreens=ledScreenService.list(queryWrapper);
        if (null !=sorted) {
            if (2 == sorted) {
                ledScreens = ledScreens.stream().sorted(Comparator.comparing(LedScreen::getId).reversed()).collect(Collectors.toList());
            }
        }
        //用户总数
        int totalLeds = ledScreens.size();
        //每页用户数
        int usersPerPage = 10;
        //总页数
        int totalPages = totalLeds % usersPerPage == 0 ? totalLeds / usersPerPage : totalLeds / usersPerPage + 1;
        //本页起始用户序号
        int beginIndex = (page - 1) * usersPerPage;
        //本页末尾用户序号的下一个
        int endIndex = beginIndex + usersPerPage;
        if (endIndex > totalLeds)
            endIndex = totalLeds;
        req.setAttribute("totalUsers", totalLeds);
        req.setAttribute("usersPerPage", usersPerPage);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("beginIndex", beginIndex);
        req.setAttribute("endIndex", endIndex);
        req.setAttribute("page", page);
        req.setAttribute("users", ledScreens);
        req.setAttribute("sorted",sorted);
        req.getRequestDispatcher("/paper/toLedPaper").forward(req, resp);
    }


    /*
     * @Author Yang
     * @Description 批量删除用户
     * @Date 13:27 2022/3/11
     * @Param [req, resp]
     * @return void
     **/
    @RequestMapping("deleteAllChooseLed")
    public void deleteAllChooseLed(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String ids=req.getParameter("ids");
        String[] idlist=ids.split(",");
        List<String> strings= Arrays.stream(idlist).filter(id->!id.isEmpty()).collect(Collectors.toList());
        List<Integer> ledidList= strings.stream().map(content->{
            Integer ledid=Integer.valueOf(content);
            return ledid;
        }).collect(Collectors.toList());
        ledScreenService.removeByIds(ledidList);
        resp.sendRedirect("/paper/toLedPaper");
    }

    /**
     * 文件下载（失败了会返回一个有部分数据的Excel）
     * 3. 直接写，这里注意，finish的时候会自动关闭OutputStream,当然你外面再关闭流问题不大
     */
    @GetMapping("download")
    public void download(HttpServletResponse response) throws IOException {
        // 这里注意 有同学反应使用swagger 会导致各种问题，请直接用浏览器或者用postman
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setCharacterEncoding("utf-8");
        // 这里URLEncoder.encode可以防止中文乱码 当然和easyexcel没有关系
        String fileName = URLEncoder.encode("Led列表", "UTF-8").replaceAll("\\+", "%20");
        response.setHeader("Content-disposition", "attachment;filename*=utf-8''" + fileName + ".xlsx");
        List<LedScreen> ledScreens=ledScreenService.list();
        List<LedScreenExcel> ledScreenExcels=ledScreens.stream().map(excel->{
            LedScreenExcel ledScreenExcel=new LedScreenExcel();
            ledScreenExcel.setAffiliatedOrganization(excel.getAffiliatedOrganization())
                    .setHight(excel.getHight())
                    .setDeviceId(excel.getDeviceId())
                    .setModelName(excel.getModelName())
                    .setWidth(excel.getWidth())
                    .setName(excel.getName())
                    .setRemark(excel.getRemark());
            return ledScreenExcel;
        }).collect(Collectors.toList());
        EasyExcel.write(response.getOutputStream(), LedScreenExcel.class).sheet("Led列表").doWrite(ledScreenExcels);
    }
}
