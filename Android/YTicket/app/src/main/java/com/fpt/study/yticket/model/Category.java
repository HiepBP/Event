package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by ThienPG on 2/24/2016.
 */
public class Category {
    @SerializedName("ID")
    @Expose
    private Integer ID;

    @SerializedName("Name")
    @Expose
    private Integer Name;

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public Integer getName() {
        return Name;
    }

    public void setName(Integer name) {
        Name = name;
    }
}
