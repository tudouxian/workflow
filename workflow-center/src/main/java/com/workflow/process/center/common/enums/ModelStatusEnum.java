package com.workflow.process.center.common.enums;

public enum ModelStatusEnum {
    /**
     * 流程、表单状态
     */
    CG(1, "草稿"), DFB(2, "待发布"), YFB(3, "已发布"), TY(4, "停用");

    private Integer status;
    private String msg;

    ModelStatusEnum(Integer status, String msg) {
        this.status = status;
        this.msg = msg;
    }

    /**
     * 根据status查询msg
     *
     * @param status
     * @return
     */
    public static String getName(Integer status) {
        if (null == status) {
            return null;
        }
        for (ModelStatusEnum item : ModelStatusEnum.values()) {
            if (status == item.getStatus().intValue()) {
                return item.getMsg();
            }
        }
        return null;
    }

    /**
     * 根据status 查询 枚举
     *
     * @param status
     * @return
     */
    public static ModelStatusEnum getEnum(Integer status) {
        if (null == status) {
            return null;
        }
        for (ModelStatusEnum item : ModelStatusEnum.values()) {
            if (status == item.getStatus().intValue()) {
                return item;
            }
        }
        return null;
    }

    public static Boolean checkActive(Integer modelStatus) {
        if (null == modelStatus ) {
           return false;
        }
        if (modelStatus.equals(DFB.status)) {
            //未定义或发布流程模型信息
            return true;
        }
        return false;
    }


    public Integer getStatus() {
        return status;
    }

    public String getMsg() {
        return msg;
    }
}
