package com.fpt.study.yticket.service;

import com.fpt.study.yticket.model.Event;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;
import retrofit2.http.Query;

/**
 * Created by ThienPG on 2/19/2016.
 */
public interface EventService {

    /**
     * GET api/Events/GetEventDetail?id={id}
     *
     * @param id
     * @return Returns an individual Event.
     * Event contains detail DTO: ID, Name, Info, Time, Place, MaxAttendance, RequiredAttendance, Vote, Price, Image, Categories.
     */
    @GET("api/Events/GetEventDetail?")
    Call<Event> getEventDetail(@Query("id") Integer id);


}
