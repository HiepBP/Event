package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Hinaka on 2/17/2016.
 */
public class AccountError {
    @SerializedName("Message")
    @Expose
    private String Message;
    @SerializedName("AccountErrorModel")
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

class AccountErrorModel {

    @SerializedName("model.Email")
    @Expose
    private List<String> modelEmail = new ArrayList<String>();
    @SerializedName("model.Password")
    @Expose
    private List<String> modelPassword = new ArrayList<String>();
    @SerializedName("model.ConfirmPassword")
    @Expose
    private List<String> modelConfirmPassword = new ArrayList<String>();

    /**
     *
     * @return
     * The modelEmail
     */
    public List<String> getModelEmail() {
        return modelEmail;
    }

    /**
     *
     * @param modelEmail
     * The model.Email
     */
    public void setModelEmail(List<String> modelEmail) {
        this.modelEmail = modelEmail;
    }

    /**
     *
     * @return
     * The modelPassword
     */
    public List<String> getModelPassword() {
        return modelPassword;
    }

    /**
     *
     * @param modelPassword
     * The model.Password
     */
    public void setModelPassword(List<String> modelPassword) {
        this.modelPassword = modelPassword;
    }

    /**
     *
     * @return
     * The modelConfirmPassword
     */
    public List<String> getModelConfirmPassword() {
        return modelConfirmPassword;
    }

    /**
     *
     * @param modelConfirmPassword
     * The model.ConfirmPassword
     */
    public void setModelConfirmPassword(List<String> modelConfirmPassword) {
        this.modelConfirmPassword = modelConfirmPassword;
    }

}
