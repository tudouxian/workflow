package com.workflow.process.center.controller;

import com.workflow.process.center.api.domain.LoginDTO;
import com.workflow.process.center.domain.LoginUser;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.AuthService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/23 14:41
 * @Description: 登录管理
 */
@Api(tags = "登录管理")
@RestController
@RequestMapping("/auth")
public class AuthController {

    @Autowired
    private AuthService authService;


    /**
     * 登录
     *
     * @param loginDTO 登录实体-只需要账号密码
     * @return 登录-token相关信息
     */
  /*  @ApiOperation("查询所有用户数据")
    @PostMapping("/login")
    public ResultBean login(@RequestBody @Valid LoginDTO loginDTO) {

        Map<String, Object> token = authService.createToken(loginDTO);

        if (ObjectUtils.isEmpty(token.get("access_token"))){
         return    ResultBean.ofError(token.get("msg").toString());
        }
        return ResultBean.ofSuccess(token);

    }*/

    @GetMapping("/currentLoginUser")
    public ResultBean<LoginUser> currentLoginUser() {
        LoginUser loginUser = authService.getLoginUser();

        return ResultBean.ofSuccess(loginUser);

    }

}
