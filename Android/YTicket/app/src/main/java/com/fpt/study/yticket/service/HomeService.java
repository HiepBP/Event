package com.fpt.study.yticket.service;


import com.fpt.study.yticket.model.Event;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.POST;
import retrofit2.http.Path;
import retrofit2.http.Query;

/**
 * Created by ThienPG on 2/19/2016.
 */
public interface HomeService {

    @GET("api/Events/GetAllPaging?")
    Call<List<Event>> getAllEvents(@Query("page") Integer page, @Query("pageSize") Integer pageSize);

    @GET("api/Events/GetEventDetail?")
    Call<List<Event>> getEventDetail(@Query("id") Integer id);

    @GET("api/Events/GetByNamePaging?")
    Call<List<Event>> getEventsByName(@Query("name") String name, @Query("page") Integer page, @Query("pageSize") Integer pageSize);


}
