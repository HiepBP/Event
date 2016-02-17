package com.fpt.study.yticket.service;

import com.fpt.study.yticket.model.Token;

import retrofit2.Call;
import retrofit2.http.Field;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.POST;

/**
 * Created by Hinaka on 2/17/2016.
 */
public interface LoginService {

    @FormUrlEncoded
    @POST("token")
    Call<Token> getAccessToken(
            @Field("grant_type") String grantType,
            @Field("username") String username,
            @Field("password") String password
    );
}
