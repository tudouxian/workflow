package com.workflow.process.center.controller;

import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.vo.ProcessDefinitionVO;
import com.workflow.process.center.domain.dto.ServiceReProcessDefinitionDTO;
import com.workflow.process.center.exception.BizException;
import com.workflow.process.center.service.FlowableService;
import com.workflow.process.center.utils.file.FileTypeUtils;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

/**
 * @Author: 土豆仙
 * @Date: 2021/6/20 15:38
 * @Description: 流程定义相关
 */
@Api(tags = "流程定义相关")
@RestController
@RequestMapping("/flowable/definition")
public class FlowableDefinitionController {

    @Autowired
    private FlowableService flowableService;

    @GetMapping("/list")
    public ResultBean<List<ProcessDefinitionVO>> list(
            @RequestParam(value = "pageIndex", defaultValue = "1") Integer pageIndex,
            @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) {
        ResultBean<List<ProcessDefinitionVO>> resultBean = flowableService.listDefinitions(pageIndex, pageSize);

        return resultBean;
    }

    //1.查询流程定义分类 list<Object(分类id、分类名称) >
    @ApiOperation("查询流程定义分类")
    @GetMapping("/listDefinitionsCategory")
    public ResultBean<List<Map<String,Object>>> listDefinitionsCategory() {
        ResultBean<List<Map<String,Object>>> resultBean = flowableService.listDefinitionsCategory();
        return resultBean;
    }
    //2.查询流程分类下key、name list<Object(key、name)>
    @ApiOperation("查询流程分类下key、name")
    @GetMapping("/listDefinitionsKeyAndName")
    public ResultBean<List<Map<String,Object>>> listDefinitionsKeyAndName( @RequestParam(value = "categoryId",required = false) String categoryId) {
        ResultBean<List<Map<String,Object>>> resultBean = flowableService.listDefinitionsKeyAndName(categoryId);
        return resultBean;
    }
    //3.查询key、name下所有流程版本
    @ApiOperation("查询流程定义信息")
    @GetMapping("/listDefinitionsAll")
    public ResultBean<List<ServiceReProcessDefinitionDTO>> listDefinitionsAll(ServiceReProcessDefinitionDTO serviceReProcessDefinitionDTO) {
        ResultBean<List<ServiceReProcessDefinitionDTO>> resultBean = flowableService.listDefinitionsAll(serviceReProcessDefinitionDTO);
        return resultBean;
    }


    //TODO 6.6版本上传不了BUG,以及bpmn上传不更新版本
    @PostMapping("/upload")
    @ResponseBody
    public ResultBean uploadAndDeployment(MultipartFile file,
                                          @RequestParam("category") String category,
                                          @RequestParam("processName") String processName,
                                          @RequestParam(value = "tenantIds", defaultValue = "流程中心") String[] tenantIds) {

        //校验
        if (!file.isEmpty() && StringUtils.isNotEmpty(file.getOriginalFilename())) {
            String extensionName = FileTypeUtils.getFileType(file.getOriginalFilename());
            if (!"bpmn".equalsIgnoreCase(extensionName)
                    && !"xml".equalsIgnoreCase(extensionName)
                    && !"zip".equalsIgnoreCase(extensionName)
                    && !"bar".equalsIgnoreCase(extensionName)) {
                throw new BizException("流程定义文件仅支持 bpmn, zip 和 bar 格式！");
            }

            flowableService.uploadAndDeployment(file, processName, category, tenantIds);

        } else {
            throw new BizException("上传空文件！或者文件名称为空！");
        }

        return ResultBean.ofSuccess();

    }

    @ApiOperation(value = "读取xml文件")
    @GetMapping("/readXml/{deployId}")
    public ResultBean readXml(@ApiParam(value = "流程部署id") @PathVariable(value = "deployId") String deployId) {
        try {
            return flowableService.readXml(deployId);
        } catch (Exception e) {
            return ResultBean.ofError("加载xml文件异常");
        }

    }

    @ApiOperation(value = "读取图片文件")
    @GetMapping("/readImage/{deployId}")
    public void readImage(@ApiParam(value = "流程部署id") @PathVariable(value = "deployId") String deployId, HttpServletResponse response) {
        OutputStream os = null;
        try {
            BufferedImage image = ImageIO.read(flowableService.readImage(deployId));
            response.setContentType("image/png");
            os = response.getOutputStream();
            if (image != null) {
                ImageIO.write(image, "png", os);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new BizException("图片流读取异常！");
        } finally {
            try {
                if (os != null) {
                    os.flush();
                    os.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }

  /*  @ApiOperation(value = "根据流程定义id启动流程实例")
    @PostMapping("/start/{procDefId}")
    public ResultBean start(@ApiParam(value = "流程定义id") @PathVariable(value = "procDefId") String procDefId,
                            @ApiParam(value = "变量集合,json对象") @RequestBody Map<String, Object> variables) {
        return flowableService.startProcessInstanceById(procDefId, variables);

    }*/

    @ApiOperation(value = "激活或挂起流程定义")
    @PutMapping(value = "/updateState")
    public ResultBean updateState(@ApiParam(value = "1:激活,2:挂起", required = true) @RequestParam Integer state,
                                  @ApiParam(value = "流程部署ID", required = true) @RequestParam String deployId) {
        flowableService.updateState(state, deployId);
        return ResultBean.ofSuccess();
    }


    @ApiOperation(value = "删除流程")
    @DeleteMapping(value = "/delete")
    public ResultBean delete(@ApiParam(value = "流程部署ID", required = true) @RequestParam String deployId) {
        flowableService.delete(deployId);
        return ResultBean.ofSuccess();
    }
}
