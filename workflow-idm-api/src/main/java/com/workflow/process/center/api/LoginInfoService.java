package com.workflow.process.center.api;

import com.workflow.process.center.api.domain.LoginDTO;
import com.workflow.process.center.domain.LoginUser;

import java.util.Map;

public interface LoginInfoService {

    //授权token放在变量access_token中
    //Map<String, Object> createToken(LoginDTO loginDTO);

    public LoginUser getLoginUser(String  token);
}
