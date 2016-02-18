package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Hinaka on 2/18/2016.
 */
public class AccountErrorModel {

    @SerializedName("model.Email")
    @Expose
    private List<String> modelEmail = new ArrayList<String>();
    @SerializedName("")
    @Expose
    private List<String> modelBlank = new ArrayList<String>();
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
     * The modelEmail
     */
    public List<String> getModelBlank() {
        return modelBlank;
    }

    /**
     *
     * @param modelBlank
     * The model.Email
     */
    public void setModelBlank(List<String> modelBlank) {
        this.modelBlank = modelBlank;
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
