package com.fpt.study.yticket.util;

import com.fpt.study.yticket.model.Token;
import com.fpt.study.yticket.util.deserializer.DateTypeDeserializer;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.IOException;
import java.util.Date;

import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

/**
 * Created by Hinaka on 2/17/2016.
 */
public class ServiceGenerator {
    public static final String API_BASE_URL = "http://10.0.3.2/YTicket.API2/";

    private static OkHttpClient.Builder sHttpClient = new OkHttpClient.Builder();

    private static HttpLoggingInterceptor sLogging = new HttpLoggingInterceptor()
            .setLevel(HttpLoggingInterceptor.Level.BODY);

    private static Gson sGson = new GsonBuilder()
            .registerTypeAdapter(Date.class, new DateTypeDeserializer())
            .create();

    private static Retrofit.Builder sBuilder =
            new Retrofit.Builder()
                    .baseUrl(API_BASE_URL)
                    .addConverterFactory(GsonConverterFactory.create(sGson));

    private static Retrofit sRetrofit;

    public static <S> S createService(Class<S> serviceClass) {
        return createService(serviceClass, null);
    }

    public static <S> S createService(Class<S> serviceClass, final Token authToken) {
        if (authToken != null) {
            sHttpClient.addInterceptor(new Interceptor() {
                @Override
                public Response intercept(Chain chain) throws IOException {
                    Request original = chain.request();

                    // Request customization: add request headers
                    Request.Builder requestBuilder = original.newBuilder()
                            .header("Accept", "application/json")
                            .header("Authorization",
                                    authToken.getTokenType() + " " + authToken.getAccessToken())
                            .method(original.method(), original.body());

                    Request request = requestBuilder.build();
                    return chain.proceed(request);
                }
            });
        }

        sHttpClient.addInterceptor(sLogging);
        OkHttpClient client = sHttpClient.build();
        sRetrofit = sBuilder.client(client).build();
        return sRetrofit.create(serviceClass);
    }

    public static Retrofit getRetrofit() {
        return sRetrofit;
    }
}
