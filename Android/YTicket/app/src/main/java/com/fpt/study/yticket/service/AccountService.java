package com.fpt.study.yticket.service;

import com.fpt.study.yticket.model.Account;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;

/**
 * Created by Hinaka on 2/18/2016.
 */
public interface AccountService {

    @POST("API/Account/Register")
    Call<Void> postRegister(@Body Account account);

}
