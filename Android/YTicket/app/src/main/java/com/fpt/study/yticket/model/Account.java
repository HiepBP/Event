package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by Hinaka on 2/17/2016.
 */
public class Account {

    @SerializedName("Email")
    @Expose
    private String mEmail;
    @SerializedName("Password")
    @Expose
    private String mPassword;
    @SerializedName("ConfirmPassword")
    @Expose
    private String mConfirmPassword;

    /**
     * @return The Email
     */
    public String getEmail() {
        return mEmail;
    }

    /**
     * @param Email The Email
     */
    public void setEmail(String Email) {
        this.mEmail = Email;
    }

    /**
     * @return The Password
     */
    public String getPassword() {
        return mPassword;
    }

    /**
     * @param Password The Password
     */
    public void setPassword(String Password) {
        this.mPassword = Password;
    }

    /**
     * @return The ConfirmPassword
     */
    public String getConfirmPassword() {
        return mConfirmPassword;
    }

    /**
     * @param ConfirmPassword The ConfirmPassword
     */
    public void setConfirmPassword(String ConfirmPassword) {
        this.mConfirmPassword = ConfirmPassword;
    }

}
