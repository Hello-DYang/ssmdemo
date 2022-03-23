<%--
  Created by IntelliJ IDEA.
  User: Yang
  Date: 2022/3/22
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="http://libs.baidu.com/jquery/2.0.0/jquery.min.js"></script>
    <style>
        .slider {
            background-color: #fff;
            width: 278px;
            height: 285px;
            z-index: 999;
            box-sizing: border-box;
            padding: 9px;
            border-radius: 6px;
            box-shadow: 0 0 11px 0 #999999;
        }

        .slider .content {
            width: 100%;
            height: 159px;
            position: relative;
        }

        .bg-img-div {
            width: 100%;
            height: 100%;
            position: absolute;
            transform: translate(0px, 0px);
        }
        .slider-img-div {
            height: 100%;
            position: absolute;
            transform: translate(0px, 0px);
        }

        .bg-img-div img {
            width: 100%;
        }

        .slider-img-div img {
            height: 100%;
        }

        .slider .slider-move {
            height: 60px;
            width: 100%;
            margin: 11px 0;
            position: relative;
        }

        .slider .bottom {
            height: 19px;
            width: 100%;
        }

        .refresh-btn, .close-btn, .slider-move-track, .slider-move-btn {
            background: url(https://static.geetest.com/static/ant/sprite.1.2.4.png) no-repeat;
        }

        .refresh-btn, .close-btn {
            display: inline-block;
        }

        .slider-move .slider-move-track {
            line-height: 38px;
            font-size: 14px;
            text-align: center;
            white-space: nowrap;
            color: #88949d;
            -moz-user-select: none;
            -webkit-user-select: none;
            user-select: none;
        }
        .slider {
            user-select: none;
            margin-top: 10%;
            margin-left: 40%;
        }

        .slider-move .slider-move-btn {
            transform: translate(0px, 0px);
            background-position: -5px 11.79625%;
            position: absolute;
            top: -12px;
            left: 0;
            width: 66px;
            height: 66px;
        }

        .slider-move-btn:hover, .close-btn:hover, .refresh-btn:hover {
            cursor: pointer
        }

        .bottom .close-btn {
            width: 20px;
            height: 20px;
            background-position: 0 44.86874%;
        }

        .bottom .refresh-btn {
            width: 20px;
            height: 20px;
            background-position: 0 81.38425%;
        }
        .after {
            color: #88949d;
        }
    </style>
</head>

<body>
<div class="slider">
    <div class="content">
        <div class="bg-img-div">
            <img id="bg-img" src="" alt/>
        </div>
        <div class="slider-img-div">
            <img id="slider-img" src="" alt/>
        </div>
    </div>
    <div class="slider-move">
        <div class="slider-move-track">
            拖动滑块完成拼图
        </div>
        <div class="slider-move-btn"></div>
    </div>
    <div class="bottom">
        <div class="close-btn"></div>
        <div class="refresh-btn"></div>
    </div>
</div>

<script>
    let start = 0;
    let startY = 0;
    let currentCaptchaId = null;
    let movePercent = 0;
    const bgImgWidth = $(".bg-img-div").width();
    let end = 206;
    let startSlidingTime;
    let entSlidingTime;
    const trackArr = [];
    $(function () {
        refreshCaptcha();
    })

    $(".slider-move-btn").mousedown((event) => {
        console.log("bb")
        startSlidingTime = new Date();
        start = event.pageX;
        startY = event.pageY;
        $(".slider-move-btn").css("background-position", "-5px 31.0092%")
        window.addEventListener("mousemove", move);
        window.addEventListener("mouseup", up);
    });

    $(".slider-move-btn").on("touchstart",(event) => {
        console.log("aa")
        startSlidingTime = new Date();
        start = event.pageX;
        startY = event.pageY;
        if (start === undefined) {
            start = event.originalEvent.targetTouches[0].pageX
            startY = event.originalEvent.targetTouches[0].pageY;
        }
        $(".slider-move-btn").css("background-position", "-5px 31.0092%")
        window.addEventListener("touchmove", move);
        window.addEventListener("touchend", up);
    });

    function move(event) {
        if (event instanceof TouchEvent) {
            event = event.touches[0];
        }
        let moveX = event.pageX - start;
        let pageX = event.pageX;
        let pageY = event.pageY;
        console.log("x:", pageX, "y:", pageY, "time:" ,new Date().getTime() - startSlidingTime.getTime());
        trackArr.push({x: pageX - start, y:pageY - startY, t: (new Date().getTime() - startSlidingTime.getTime())});
        if (moveX < 0) {
            moveX = 0;
        } else if (moveX > end) {
            moveX = end;
        }
        // if (moveX > 0 && moveX <= end) {
        $(".slider-move-btn").css("transform", "translate(" + moveX + "px, 0px)")
        $(".slider-img-div").css("transform", "translate(" + moveX + "px, 0px)")
        // }
        movePercent = moveX / bgImgWidth;
    }

    function up(event) {
        entSlidingTime = new Date();
        console.log(currentCaptchaId, movePercent, bgImgWidth);
        window.removeEventListener("mousemove", move);
        window.removeEventListener("mouseup", up);
        valid();
    }


    $(".close").click(() => {

    });

    $(".refresh-btn").click(() => {
        refreshCaptcha();
    });

    function valid() {

        console.log("=======================")
        console.log("startTime", startSlidingTime);
        console.log("endTime", entSlidingTime);
        console.log("track", JSON.stringify(trackArr));


        let data = {
            bgImageWidth: bgImgWidth,
            bgImageHeight: $(".slider-img-div").height(),
            sliderImageWidth: $(".slider-img-div").width(),
            sliderImageHeight: $(".slider-img-div").height(),
            startSlidingTime: startSlidingTime,
            entSlidingTime: entSlidingTime,
            trackList: trackArr
        };

        $.ajax({
            type:"POST",
            url:"/check",
            contentType: "application/json", //必须这样写
            dataType:"json",
            data:JSON.stringify(data),//schoolList是你要提交是json字符串
            success:function (res) {
                console.log(res);
                if (res) {
                    alert("验证成功!!!");
                }
                refreshCaptcha();
            }
        })
    }

    function refreshCaptcha() {
        $.get("/gen", function (data) {
            reset();
            currentCaptchaId = data.id;
            $("#bg-img").attr("src", data.captcha.backgroundImage);
            $("#slider-img").attr("src", data.captcha.sliderImage);
        })
    }

    function reset() {
        $(".slider-move-btn").css("background-position", "-5px 11.79625%")
        $(".slider-move-btn").css("transform", "translate(0px, 0px)")
        $(".slider-img-div").css("transform", "translate(0px, 0px)")
        start = 0;
        startSlidingTime = null;
        entSlidingTime = null;
        trackArr.length = 0;
        movePercent = 0;
        currentCaptchaId = null;
        startY = 0;
    }
</script>
</body>
</html>
