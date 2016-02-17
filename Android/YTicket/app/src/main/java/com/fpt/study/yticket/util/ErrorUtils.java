package com.fpt.study.yticket.util;

import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Type;

import okhttp3.ResponseBody;
import retrofit2.Converter;
import retrofit2.Response;

/**
 * Created by Hinaka on 2/17/2016.
 */
public class ErrorUtils {
    public static <T> T parseError(Response<?> response, Type type) {
        Converter<ResponseBody, T> converter =
                ServiceGenerator.getRetrofit().responseBodyConverter(type, new Annotation[0]);

        T error;

        try {
            error = converter.convert(response.errorBody());
        } catch (IOException e) {
            return null;
        }

        return error;
    }
}
