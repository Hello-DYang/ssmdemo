package com.yang.common;

import com.tencentcloudapi.captcha.v20190722.CaptchaClient;
import com.tencentcloudapi.captcha.v20190722.models.DescribeCaptchaResultRequest;
import com.tencentcloudapi.captcha.v20190722.models.DescribeCaptchaResultResponse;
import com.tencentcloudapi.common.Credential;
import com.tencentcloudapi.common.exception.TencentCloudSDKException;
import com.tencentcloudapi.common.profile.ClientProfile;
import com.tencentcloudapi.common.profile.HttpProfile;

public class DescribeCaptchaResult {


    public boolean codeResponse(String ticket, String randstr) {
        String str = "";
        try {

            Credential cred = new Credential("你的secretId", "你的secretKey");

            HttpProfile httpProfile = new HttpProfile();
            httpProfile.setEndpoint("captcha.tencentcloudapi.com");

            ClientProfile clientProfile = new ClientProfile();
            clientProfile.setHttpProfile(httpProfile);

            CaptchaClient client = new CaptchaClient(cred, "ap-beijing", clientProfile);

            DescribeCaptchaResultRequest request= new DescribeCaptchaResultRequest();
            request.setAppSecretKey("你的AppSecretKey");
            //你的CaptchaAppId
            request.setCaptchaAppId(1L);
            request.setCaptchaType(9l);
            request.setTicket(ticket);
            request.setUserIp("127.0.0.1");
            request.setRandstr(randstr);

            DescribeCaptchaResultResponse resp = client.DescribeCaptchaResult(request);

            str = DescribeCaptchaResultRequest.toJsonString(resp);

        } catch (TencentCloudSDKException e) {
            e.printStackTrace();
            System.out.println(e);
        }
        System.out.println(str);
        if (str.contains("OK")) {
            return true;
        } else {
            return false;
        }


    }

}
