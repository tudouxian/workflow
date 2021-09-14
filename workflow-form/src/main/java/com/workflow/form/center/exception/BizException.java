package com.workflow.form.center.exception;


import com.workflow.process.center.common.enums.BaseExceptionEnum;

public class BizException extends RuntimeException {

    private String code;

    private String msg;

    public BizException() {
        super();
    }

    public BizException(Throwable cause) {
        super(cause);
    }

    public BizException(String msg) {
        super(msg);
        this.msg = msg;
    }

    public BizException(String code, String msg) {
        super(msg);
        this.code = code;
        this.msg = msg;
    }

    public BizException(BaseExceptionEnum exEnum) {
        this.code = exEnum.getCode();
        this.msg = exEnum.getMessage();
    }

    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

}
