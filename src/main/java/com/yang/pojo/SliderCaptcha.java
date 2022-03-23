package com.yang.pojo;

import lombok.Data;

import java.util.Date;
import java.util.List;
@Data
public class SliderCaptcha {
    private Integer bgImageWidth;
    private Integer bgImageHeight;
    private Integer sliderImageWidth;
    private Integer sliderImageHeight;
    private Date startSlidingTime;
    private Date entSlidingTime;
    private List<SliderCaptcha.Track> trackList;
    @Data
    public static class Track {
        private Integer x;
        private Integer y;
        private Integer t;
    }
}
