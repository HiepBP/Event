package com.fpt.study.yticket.service;

import com.fpt.study.yticket.model.Account;
import com.fpt.study.yticket.model.Category;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.POST;
import retrofit2.http.Query;

/**
 * Created by ThienPG on 2/24/2016.
 */
public interface CategoryService {

    @POST("api/Categories/GetByNamePaging?")
    Call<List<Category>> getCategoryByName(@Query("name") String name, @Query("page") Integer page, @Query("pageSize") Integer pageSize);
}
