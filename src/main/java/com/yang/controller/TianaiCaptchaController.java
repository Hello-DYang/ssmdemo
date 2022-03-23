package com.yang.controller;

import cloud.tianai.captcha.template.slider.*;
import cloud.tianai.captcha.template.slider.provider.ClassPathResourceProvider;
import cloud.tianai.captcha.template.slider.validator.BasicCaptchaTrackValidator;
import cloud.tianai.captcha.template.slider.validator.SliderCaptchaTrack;
import cloud.tianai.captcha.template.slider.validator.SliderCaptchaValidator;
import com.yang.pojo.CaptchaResponse;
import com.yang.pojo.SliderCaptcha;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
public class TianaiCaptchaController {

    private Map<String, Object> validData;

    @GetMapping("/gen")
    @ResponseBody
    public CaptchaResponse<SliderCaptchaInfo> genCaptcha() {

        SliderCaptchaResourceManager sliderCaptchaResourceManager = new DefaultSliderCaptchaResourceManager();

        StandardSliderCaptchaTemplate sliderCaptchaTemplate = new StandardSliderCaptchaTemplate(sliderCaptchaResourceManager, true);

//        添加自定义图片资源
        ResourceStore resourceStore = sliderCaptchaResourceManager.getResourceStore();
        // 清除内置的背景图片
//        resourceStore.clearResources();
        // 添加classpath目录下的 aa.jpg 图片
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/a.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/b.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/c.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/d.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/e.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/g.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/h.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/i.jpg"));
        resourceStore.addResource(new Resource(ClassPathResourceProvider.NAME, "bgimages/j.jpg"));

        // 负责计算一些数据存到缓存中，用于校验使用
        // SliderCaptchaValidator负责校验用户滑动滑块是否正确和生成滑块的一些校验数据; 比如滑块到凹槽的百分比值
        SliderCaptchaValidator sliderCaptchaValidator = new BasicCaptchaTrackValidator();
        // 这个map数据应该存到缓存中，校验的时候需要用到该数据
        // 生成滑块图片
        SliderCaptchaInfo slideImageInfo = sliderCaptchaTemplate.getSlideImageInfo();
        System.out.println(slideImageInfo);
        validData = sliderCaptchaValidator.generateSliderCaptchaValidData(slideImageInfo);

        String id= UUID.randomUUID().toString().replace("-", "");
        CaptchaResponse<SliderCaptchaInfo> captchaInfoMap=new CaptchaResponse<>();
        captchaInfoMap.setId(id);
        captchaInfoMap.setCaptcha(slideImageInfo);

        return captchaInfoMap;
    }

    @PostMapping("/check")
    @ResponseBody
    public boolean checkCaptcha(@RequestBody SliderCaptcha sliderCaptcha) {
        SliderCaptchaValidator sliderCaptchaValidator = new BasicCaptchaTrackValidator();
        // 用户传来的行为轨迹和进行校验
        // - sliderCaptchaTrack为前端传来的滑动轨迹数据
        // - map 为生成验证码时缓存的map数据
        SliderCaptchaTrack sliderCaptchaTrack=new SliderCaptchaTrack();
        BeanUtils.copyProperties(sliderCaptcha,sliderCaptchaTrack);

        List<SliderCaptchaTrack.Track> trackList=sliderCaptcha.getTrackList().stream().map(item->{
            SliderCaptchaTrack.Track track=new SliderCaptchaTrack.Track(item.getX(), item.getY(), item.getT());
            return track;
        }).collect(Collectors.toList());

        sliderCaptchaTrack.setTrackList(trackList);
        boolean check = sliderCaptchaValidator.valid(sliderCaptchaTrack,validData);
        return check;
    }
}
