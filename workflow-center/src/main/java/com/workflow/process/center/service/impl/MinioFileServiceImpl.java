package com.workflow.process.center.service.impl;

import com.workflow.process.center.config.file.minio.MinioConfig;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.FileService;
import com.workflow.process.center.utils.file.FileUploadUtils;
import io.minio.MinioClient;
import io.minio.PutObjectArgs;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
*   @Author: 土豆仙
*   @Date: 2021/7/19 17:36
*   @Description:  Minio 文件存储
*/
@Service
public class MinioFileServiceImpl  implements FileService {

    @Autowired
    private MinioConfig minioConfig;

    @Autowired
    private MinioClient client;

    @Override
    public String uploadFile(MultipartFile file) throws Exception {
        if (file ==null){
            throw new BizException("上传文件不能为空！");
        }
        String fileName = FileUploadUtils.extractFilename(file);
        PutObjectArgs args = PutObjectArgs.builder()
                .bucket(minioConfig.getBucketName())
                .object(fileName)
                .stream(file.getInputStream(), file.getSize(), -1)
                .contentType(file.getContentType())
                .build();
        client.putObject(args);
        return minioConfig.getUrl() + "/" + minioConfig.getBucketName() + "/" + fileName;
    }
}
