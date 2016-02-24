package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by Frost on 2/24/2016.
 */
public class Notification {
    @SerializedName("ID")
    @Expose
    private int ID;

    @SerializedName("Information")
    @Expose
    private String Information;

    @SerializedName("New")
    @Expose
    private boolean New;

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getInformation() {
        return Information;
    }

    public void setInformation(String information) {
        Information = information;
    }

    public boolean isNew() {
        return New;
    }

    public void setNew(boolean aNew) {
        New = aNew;
    }
}
