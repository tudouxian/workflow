package com.workflow.process.center.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileService {

    /**
     * 文件上传接口
     *
     * @param file 上传的文件
     * @return 访问地址
     * @throws Exception
     */
    public String uploadFile(MultipartFile file) throws Exception;
}
