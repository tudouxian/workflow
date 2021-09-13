package com.workflow.process.center.controller;

import com.baomidou.mybatisplus.extension.api.R;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.service.FileService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@Api(tags = "文件上传")
@RestController
@RequestMapping("/file")
@Slf4j
public class FileController {

    @Autowired
    private FileService fileService;

    /**
     * 文件上传请求
     */
    @PostMapping("upload")
    @ApiOperation("文件上传")
    public ResultBean<String> upload(MultipartFile file)
    {
        try
        {
            // 上传并返回访问地址
            String url = fileService.uploadFile(file);

            return   ResultBean.ofSuccess(url);
        }
        catch (Exception e)
        {
            log.error("上传文件失败", e);
            return ResultBean.ofError("上传失败！");
        }
    }
}
