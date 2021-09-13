package com.workflow.process.center.service;

import com.workflow.process.center.api.domain.LoginDTO;
import com.workflow.process.center.domain.LoginUser;

import java.util.Map;

public interface AuthService {

   // Map<String, Object> createToken(LoginDTO loginDTO);

    //获取登录用户信息
    LoginUser getLoginUser();

}
