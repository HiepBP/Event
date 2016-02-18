package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by Hinaka on 2/17/2016.
 */
public class AccountError {
    @SerializedName("Message")
    @Expose
    private String Message;
    @SerializedName("ModelState")
    @Expose
    private AccountErrorModel ModelState;

    /**
     *
     * @return
     * The Message
     */
    public String getMessage() {
        return Message;
    }

    /**
     *
     * @param Message
     * The Message
     */
    public void setMessage(String Message) {
        this.Message = Message;
    }

    /**
     *
     * @return
     * The AccountErrorModel
     */
    public AccountErrorModel getModelState() {
        return ModelState;
    }

    /**
     *
     * @param ModelState
     * The AccountErrorModel
     */
    public void setModelState(AccountErrorModel ModelState) {
        this.ModelState = ModelState;
    }

}

