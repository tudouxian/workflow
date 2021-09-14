package com.workflow.form.center.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.workflow.form.center.domain.entity.DictType;
import com.workflow.form.center.mapper.DictTypeMapper;
import com.workflow.form.center.service.DictTypeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * 字典类型表(DictType)表服务实现类
 *
 * @author 土豆仙
 * @since 2021-08-10 14:34:59
 */
@Slf4j
@Service
public class DictTypeServiceImpl extends ServiceImpl<DictTypeMapper, DictType> implements DictTypeService {

}
