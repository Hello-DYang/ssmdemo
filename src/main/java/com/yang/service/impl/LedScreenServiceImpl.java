package com.yang.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.yang.dao.LedScreenMapper;
import com.yang.pojo.LedScreen;
import com.yang.service.LedScreenService;
import org.springframework.stereotype.Service;

@Service
public class LedScreenServiceImpl extends ServiceImpl<LedScreenMapper, LedScreen> implements LedScreenService {
}
