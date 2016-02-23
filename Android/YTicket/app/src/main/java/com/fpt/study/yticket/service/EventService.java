package com.fpt.study.yticket.service;

import com.fpt.study.yticket.model.Event;
import com.fpt.study.yticket.model.EventUserStatus;
import com.fpt.study.yticket.model.User;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.DELETE;
import retrofit2.http.GET;
import retrofit2.http.PUT;
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

    @GET("api/Events/GetEventUserStatus?")
    Call<EventUserStatus> getEventUserStatus(@Query("id") Integer id);

    @GET("api/Users/GetCurrentUser")
    Call<User> getCurrentUser();

    @PUT("api/Events/JoinEvent?")
    Call<Void> joinEvent(@Query("id") Integer id);

    @GET("api/Users/GetUserByEvent?")
    Call<User> getUserByEvent(@Query("eventId") Integer eventId);


    @PUT("api/Events/UpdateEvent?")
    Call<Void> updateEvent(@Query("id") Integer id, @Body User user);

    @DELETE("api/Events/DeleteEvent?")
    Call<Void> deleteEvent(@Query("id") Integer id);
}
