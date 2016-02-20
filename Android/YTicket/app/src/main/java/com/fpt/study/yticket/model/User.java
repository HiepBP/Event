package com.fpt.study.yticket.model;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

/**
 * Created by Frost on 2/19/2016.
 */
public class User {

    @SerializedName("ID")
    @Expose
    private int ID;

    @SerializedName("Email")
    @Expose
    private String Email;

    @SerializedName("Username")
    @Expose
    private String Username;

    @SerializedName("Address")
    @Expose
    private String Address;

    @SerializedName("Phone")
    @Expose
    private String Phone;

    @SerializedName("Image")
    @Expose
    private String Image;

    public int getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String email) {
        Email = email;
    }

    public String getUsername() {
        return Username;
    }

    public void setUsername(String username) {
        Username = username;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String address) {
        Address = address;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String phone) {
        Phone = phone;
    }

    public String getImage() {
        return Image;
    }

    public void setImage(String image) {
        Image = image;
    }
}
