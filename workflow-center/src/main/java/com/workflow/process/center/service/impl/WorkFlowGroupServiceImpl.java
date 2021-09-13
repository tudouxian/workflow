package com.workflow.process.center.service.impl;

import com.google.common.base.Splitter;
import com.google.common.collect.Lists;
import com.workflow.process.center.api.DeptService;
import com.workflow.process.center.api.RoleService;
import com.workflow.process.center.api.UserService;
import com.workflow.process.center.api.domain.WorkFlowDeptDTO;
import com.workflow.process.center.api.domain.WorkFlowRoleDTO;
import com.workflow.process.center.api.domain.WorkFlowUserDTO;
import com.workflow.process.center.common.ResultBean;
import com.workflow.process.center.domain.dto.WorkFlowGroupPageUserDTO;
import com.workflow.process.center.domain.dto.WorkFlowGroupUserDTO;
import com.workflow.process.center.service.WorkFlowGroupService;
import com.workflow.process.center.utils.StringUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static com.workflow.process.center.common.contant.CommonContant.SEPARATOR;


/**
 * @Author: 土豆仙
 * @Date: 2021/6/23 15:26
 * @Description: RPC调用查询觉得信息
 */
@Slf4j
@Service
public class WorkFlowGroupServiceImpl implements WorkFlowGroupService {

    @Autowired
    private RoleService roleService;

    @Autowired
    private DeptService deptService;

    @Autowired
    private UserService userService;

   /* @Autowired
    private RemoteDeptService deptService;

    @Autowired
    private RemoteRoleService roleService;

    @Autowired
    private RemoteUserService userService;*/


    /**
     * 获取候选组key对应
     *
     * @param groupKeys 候选组key
     * @return
     */
    public Set<WorkFlowUserDTO> queryUsersByGroupKeys(List<String> groupKeys) {

        if (CollectionUtils.isNotEmpty(groupKeys)) {
            Set<WorkFlowUserDTO> workFlowUserDTOS = new HashSet<>();
            groupKeys.stream().forEach(_groupKey -> {
                WorkFlowGroupUserDTO workFlowGroupUserDTO = queryUsersByGroupKey(_groupKey);
                workFlowUserDTOS.addAll(workFlowGroupUserDTO.getWorkFlowUserDTOS());
            });

            return workFlowUserDTOS;
        }

        return null;
    }

    /**
     * 获取候选组key对应用户集合=>(建议使用find_in_set()函数)
     * 【注意】=》区域、部门有层级，由用户体系方实现获取层级下所有用户，
     * 例如配置的顶级部门（城云科技），是否下属所有部门均对该任务可见。区域同理】
     *
     * @param groupKey 候选组key
     * @return
     */
    public WorkFlowGroupUserDTO queryUsersByGroupKey(String groupKey) {
        if (StringUtils.isNotEmpty(groupKey)) {
            ArrayList<String> keys = Lists.newArrayList(Splitter.on(SEPARATOR).split(groupKey));
            //1.区域  2.部门  3.角色
            if (keys.size() == 3) {
                String area = keys.get(0);
                String dept = keys.get(1);
                String role = keys.get(2);

                StringBuilder groupName = new StringBuilder();

                if (StringUtils.isNotEmpty(area)) {
                    // 1.根据key拿区域信息
                }

                if (StringUtils.isNotEmpty(dept)) {
                    // 1.根据key拿部门信息
                    ResultBean<WorkFlowDeptDTO> deptResultBean = deptService.queryGroupByKey(dept);
                    if (deptResultBean != null && deptResultBean.getData() != null) {
                        groupName.append(deptResultBean.getData().getDeptName()).append("|");
                    }
                }

                if (StringUtils.isNotEmpty(role)) {
                    // 1.根据key拿角色信息
                    ResultBean<WorkFlowRoleDTO> roleResultBean = roleService.queryGroupByKey(role);

                    if (roleResultBean != null && roleResultBean.getData() != null) {
                        groupName.append(roleResultBean.getData().getRoleName());
                    }
                }
                WorkFlowGroupUserDTO workFlowGroupUserDTO = new WorkFlowGroupUserDTO();
                workFlowGroupUserDTO.setGroupKey(groupKey);
                workFlowGroupUserDTO.setGroupName(groupName.toString());

                ResultBean<List<WorkFlowUserDTO>> users = userService.selectUserByAreaDeptRoleKeys(area, dept, role);
                workFlowGroupUserDTO.setWorkFlowUserDTOS(users.getData());

                return workFlowGroupUserDTO;
            }

        }
        return null;
    }

    @Override
    public WorkFlowGroupPageUserDTO queryPageUsersByGroupKey(String groupKey, Integer pageIndex, Integer pageSize) {
        if (StringUtils.isNotEmpty(groupKey)) {
            ArrayList<String> keys = Lists.newArrayList(Splitter.on(SEPARATOR).split(groupKey));
            //1.区域  2.部门  3.角色
            if (keys.size() == 3) {
                String area = keys.get(0);
                String dept = keys.get(1);
                String role = keys.get(2);

                StringBuilder groupName = new StringBuilder();

                if (StringUtils.isNotEmpty(area)) {
                    // 1.根据key拿区域信息
                }

                if (StringUtils.isNotEmpty(dept)) {
                    // 1.根据key拿部门信息
                    ResultBean<WorkFlowDeptDTO> deptResultBean = deptService.queryGroupByKey(dept);
                    if (deptResultBean != null && deptResultBean.getData() != null) {
                        groupName.append(deptResultBean.getData().getDeptName()).append("|");
                    }
                }

                if (StringUtils.isNotEmpty(role)) {
                    // 1.根据key拿角色信息
                    ResultBean<WorkFlowRoleDTO> roleResultBean = roleService.queryGroupByKey(role);

                    if (roleResultBean != null && roleResultBean.getData() != null) {
                        groupName.append(roleResultBean.getData().getRoleName());
                    }
                }
                WorkFlowGroupPageUserDTO workFlowGroupPageUserDTO = new WorkFlowGroupPageUserDTO();
                workFlowGroupPageUserDTO.setGroupKey(groupKey);
                workFlowGroupPageUserDTO.setGroupName(groupName.toString());

                ResultBean<List<WorkFlowUserDTO>> users = userService.selectPageUserByAreaDeptRoleKeys(area, dept, role, pageIndex, pageSize);
                workFlowGroupPageUserDTO.setResultBean(users);

                return workFlowGroupPageUserDTO;
            }

        }
        return null;
    }


    /**
     * @Description 生成groupKey
     * @Author 土豆仙
     * @Date 2021/8/24 21:34
     * @Param areaKeys、deptKeys、roles
     * @Return Set<String>
     * @Exception
     */
    public Set<String> generatorGroupKeys(Set<String> areaKeys, Set<String> deptKeys, Set<String> roles) {
        //用户组集合
        Set<String> groupKeys = new HashSet<>();
        //区域  a
        Set<String> areaGroups = joinGroupKeys(groupKeys, areaKeys);
        //部门  a_d
        Set<String> areaDeptGroups = joinGroupKeys(areaGroups, deptKeys);
        //角色  a_d_r
        Set<String> areaDeptRoleGroups = joinGroupKeys(areaDeptGroups, roles);

        return areaDeptRoleGroups;

    }

    @Override
    public String generatorGroupKey(String areaKey, String deptKey, String roleKey) {
        StringBuilder key = new StringBuilder();
        if (StringUtils.isNotEmpty(areaKey)) {
            key.append(areaKey);
        }
        key.append(SEPARATOR);

        if (StringUtils.isNotEmpty(deptKey)) {
            key.append(deptKey);
        }
        key.append(SEPARATOR);

        if (StringUtils.isNotEmpty(roleKey)) {
            key.append(roleKey);
        }
        return key.toString();
    }

    /**
     * @Author: 土豆仙
     * @Date: 2021/7/28 14:24
     * @Description: 拼接groupKey 集合
     */

    private Set<String> joinGroupKeys(Set<String> sourceGroupKeys, Set<String> keys) {
        Set<String> targetGroupKeys = new HashSet<>();
        if (CollectionUtils.isNotEmpty(keys)) {
            keys.stream()
                    .forEach(_key -> {

                                if (CollectionUtils.isNotEmpty(sourceGroupKeys)) {
                                    sourceGroupKeys.stream()
                                            .forEach(_groupKey -> {
                                                StringBuilder key = new StringBuilder();
                                                key.append(_groupKey).append(SEPARATOR).append(_key);
                                                targetGroupKeys.add(key.toString());
                                            });
                                } else {
                                    targetGroupKeys.add(_key);
                                }

                            }
                    );
        } else {
            StringBuilder key = new StringBuilder();
            key.append(SEPARATOR);
            targetGroupKeys.add(key.toString());
        }

        return targetGroupKeys;
    }


    /**
     * 获取候选组key对应用户集合
     *
     * @param groupKey 候选组key
     * @return
     */
    /*@Override
    public WorkFlowGroupUserDTO queryUsersByGroupKey(String groupKey) {
        if (StringUtils.isNotEmpty(groupKey)) {
            String prefix = substringBefore(groupKey, SEPARATOR);
            GroupTypeEnum groupType = getGroupType(prefix);
            String Key = substringAfter(groupKey, SEPARATOR);
            if (groupType != null && StringUtils.isNotEmpty(Key)) {
                switch (groupType) {
                    case ROLE_GROUP:
                        // 1.根据key拿角色信息
                        ResultBean<WorkFlowRoleDTO> roleResultBean = roleService.queryGroupByKey(Key);
                        // 2.根据key拿拥有该角色用户
                        ResultBean<List<WorkFlowUserDTO>> listByRoleKey = remoteUserService.selectUserByRoleKeys(Arrays.asList(Key));

                        if (roleResultBean !=null && listByRoleKey!=null){
                            WorkFlowGroupUserDTO workFlowGroupUserDTO = new WorkFlowGroupUserDTO();
                            workFlowGroupUserDTO.setGroupType(ROLE_GROUP.getType());
                            workFlowGroupUserDTO.setGroupKey(groupKey);
                            workFlowGroupUserDTO.setGroupName(roleResultBean.getData().getRoleName());
                            workFlowGroupUserDTO.setWorkFlowUserDTOS(listByRoleKey.getData());

                            return workFlowGroupUserDTO;
                        }
                        return null;

                    case DEPT_GROUP:
                        // 1.根据key拿部门信息
                        ResultBean<WorkFlowDeptDTO> deptResultBean = remoteDeptService.queryGroupByKey(Key);
                        // 2.根据key拿拥有该部门用户
                        ResultBean<List<WorkFlowUserDTO>> listByDeptKey = remoteUserService.selectUserByDeptKeys(Arrays.asList(Key));

                        if (deptResultBean !=null && deptResultBean.getData()!=null && listByDeptKey!=null){
                            WorkFlowGroupUserDTO workFlowGroupUserDTO = new WorkFlowGroupUserDTO();
                            workFlowGroupUserDTO.setGroupType(DEPT_GROUP.getType());
                            workFlowGroupUserDTO.setGroupKey(groupKey);
                            workFlowGroupUserDTO.setGroupName(deptResultBean.getData().getDeptName());
                            workFlowGroupUserDTO.setWorkFlowUserDTOS(listByDeptKey.getData());

                            return workFlowGroupUserDTO;
                        }
                        return null;

                    case AREA_GROUP:

                        return null;
                }
            }


        }
        return null;
    }*/


}
