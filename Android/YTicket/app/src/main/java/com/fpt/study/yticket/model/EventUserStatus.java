package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by ThienPG on 2/22/2016.
 */
public class EventUserStatus {
    @SerializedName("Status")
    @Expose
    private String Status;

    @SerializedName("Action")
    @Expose
    private String Action;

    public String getStatus() {
        return Status;
    }

    public void setStatus(String status) {
        Status = status;
    }

    public String getAction() {
        return Action;
    }

    public void setAction(String action) {
        Action = action;
    }
}
