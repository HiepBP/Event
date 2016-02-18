package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by ThienPG on 2/18/2016.
 */
public class Event {

    @SerializedName("ID")
    @Expose
    private Integer ID;

    @SerializedName("Name")
    @Expose
    private String Name;

    @SerializedName("Time")
    @Expose
    private String Time;

    @SerializedName("Place")
    @Expose
    private String Place;

    @SerializedName("Image")
    @Expose
    private String Image;

    /**
     * @return ID
     */
    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public String getTime() {
        return Time;
    }

    public void setTime(String time) {
        Time = time;
    }

    public String getPlace() {
        return Place;
    }

    public void setPlace(String place) {
        Place = place;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String image) {
        Image = image;
    }
}