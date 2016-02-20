package com.fpt.study.yticket.service;

import com.fpt.study.yticket.model.User;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Query;

/**
 * Created by Frost on 2/19/2016.
 */
public interface UserService {

    @GET("api/Users/GetAllPaging?")
    Call<List<User>> getAllUser(@Query("page") Integer page, @Query("pageSize") Integer pageSize);

    @GET("api/Users/GetUserDetail?")
    Call<User> getUserById(@Query("id") Integer id);
}
