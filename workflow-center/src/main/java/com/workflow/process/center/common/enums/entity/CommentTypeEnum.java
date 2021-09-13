package com.workflow.process.center.common.enums.entity;

import com.baomidou.mybatisplus.annotation.EnumValue;
import com.workflow.process.center.utils.StringUtils;
import com.fasterxml.jackson.annotation.JsonValue;

/**
*   @Author: 土豆仙
*   @Date: 2021/6/28 21:56
*   @Description: 审批意见的类型
*/
public enum CommentTypeEnum {
    FQLC("发起流程","FQLC"),
    SQ("申请","SQ"),
    SP("审批","SP"),
    BH("驳回","BH"),
    CH("撤回","CH"),
    CX("撤销","CX"),
    ZC("暂存","ZC"),
    QS("签收","QS"),
    GH("归还任务","GH"),
    WP("委派","WP"),
    ZH("知会","ZH"),
    ZY("转阅","ZY"),
    YY("已阅","YY"),
    ZB("转办","ZB"),
    QJQ("前加签","QJQ"),
    HJQ("后加签","HJQ"),
    XTZX("系统执行","XTZX"),
    BJ("办结","BJ"),
    LCZZ("流程中止","LCZZ"),
    QZJS("强制结束","QZJS"),
    XT("协同","XT"),
    PS("评审","PS");

    @JsonValue
    private String name;//名称

    @EnumValue
    private String type;

    /**
     * 通过type获取Msg
     *
     * @param type
     * @return
     * @Description:
     */
    public static CommentTypeEnum getCommentEnumMsgByType(String type) {
        if (StringUtils.isEmpty(type)) {
            return null;
        }
        for (CommentTypeEnum item : CommentTypeEnum.values()) {
            if (type.equals(item.getType()) ) {
                return item;
            }
        }
        return null;
    }
    private CommentTypeEnum(String name) {
        this.name = name;
    }

    CommentTypeEnum(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
