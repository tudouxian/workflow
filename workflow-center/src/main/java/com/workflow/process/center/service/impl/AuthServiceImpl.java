package com.workflow.process.center.service.impl;

import com.workflow.process.center.api.LoginInfoService;
import com.workflow.process.center.api.domain.LoginDTO;
import com.workflow.process.center.domain.LoginUser;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.AuthService;
import com.workflow.process.center.utils.SecurityUtils;
import com.workflow.process.center.utils.ServletUtils;
import com.workflow.process.center.utils.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

import static com.workflow.process.center.common.enums.BaseExceptionEnum.NOT_LOGIN;

@Service
public class AuthServiceImpl implements AuthService {

  /*  @DubboReference
    private LoginInfoService loginInfoService;*/

    @Autowired
    private LoginInfoService loginInfoService;

/*    @Override
    public Map<String, Object> createToken(LoginDTO loginDTO) {
        return loginInfoService.createToken(loginDTO);
    }*/

    @Override
    public LoginUser getLoginUser() {

        LoginUser loginUser = getLoginUser(ServletUtils.getRequest());
        if (loginUser == null) {
            throw new BizException(NOT_LOGIN);
        }
        return loginUser;
    }

    private LoginUser getLoginUser(HttpServletRequest request) {
        // 获取请求携带的令牌
        String token = SecurityUtils.getToken(request);
        if (StringUtils.isNotEmpty(token)) {
            LoginUser loginUser = loginInfoService.getLoginUser(token);
            return loginUser;
        }

        return null;
    }
}
