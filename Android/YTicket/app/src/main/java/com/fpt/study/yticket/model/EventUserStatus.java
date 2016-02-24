package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by ThienPG on 2/22/2016.
 */
public class EventUserStatus {
    @SerializedName("Status")
    @Expose
    private Boolean Status;

    @SerializedName("Action")
    @Expose
    private String Action;

    public Boolean getStatus() {
        return Status;
    }

    public void setStatus(Boolean status) {
        Status = status;
    }

    public String getAction() {
        return Action;
    }

    public void setAction(String action) {
        Action = action;
    }
}
