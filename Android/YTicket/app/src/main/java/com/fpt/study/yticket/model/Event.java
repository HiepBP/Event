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

    @SerializedName("Info")
    @Expose
    private String Info;

    @SerializedName("Time")
    @Expose
    private String Time;

    @SerializedName("Place")
    @Expose
    private String Place;

    @SerializedName("Image")
    @Expose
    private String Image;

    @SerializedName("MaxAttendance")
    @Expose
    private Integer MaxAttendance;

    @SerializedName("RequireAttendance")
    @Expose
    private Integer RequireAttendance;

    @SerializedName("Vote")
    @Expose
    private Integer Vote;

    @SerializedName("Price")
    @Expose
    private Double Price;

    @SerializedName("Category")
    @Expose
    private Category Category;

    public com.fpt.study.yticket.model.Category getCategory() {
        return Category;
    }

    public void setCategory(com.fpt.study.yticket.model.Category category) {
        Category = category;
    }


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

    public String getInfo() {
        return Info;
    }

    public void setInfo(String info) {
        Info = info;
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

    public Integer getMaxAttendance() {
        return MaxAttendance;
    }

    public void setMaxAttendance(Integer maxAttendance) {
        MaxAttendance = maxAttendance;
    }

    public Integer getRequireAttendance() {
        return RequireAttendance;
    }

    public void setRequireAttendance(Integer requireAttendance) {
        RequireAttendance = requireAttendance;
    }

    public Integer getVote() {
        return Vote;
    }

    public void setVote(Integer vote) {
        Vote = vote;
    }

    public Double getPrice() {
        return Price;
    }

    public void setPrice(Double price) {
        Price = price;
    }

    @Override
    public String toString() {
        return this.getName();
    }
}