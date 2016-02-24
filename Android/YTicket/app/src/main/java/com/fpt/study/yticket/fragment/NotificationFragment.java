package com.fpt.study.yticket.fragment;

import android.app.ListFragment;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.Notification;
import com.fpt.study.yticket.model.Token;
import com.fpt.study.yticket.service.UserService;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by Frost on 2/24/2016.
 */
public class NotificationFragment extends ListFragment {

    public static final String TAG = "NotiFragment";
    public static final String SHAREDPREFERENCES = "YTicketPrefs";
    public static final String PREF_TOKEN = "UserToken";
    UserService service;
    Boolean isLogin;
    Token token;
    TextView noti_info;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        Log.d(TAG, "onCreated");

        Gson gson = new Gson();
        SharedPreferences pref = getActivity().getSharedPreferences(SHAREDPREFERENCES, Context.MODE_PRIVATE);
        String json = pref.getString(PREF_TOKEN, "");
        if (json.equals("")) {
            service = ServiceGenerator.createService(UserService.class);
            isLogin = false;
        } else {
            token = gson.fromJson(json, Token.class);
            service = ServiceGenerator.createService(UserService.class, token);
            isLogin = true;
        }

        getNoti();
    }

    private class NotificationAdapter extends ArrayAdapter<Notification> {

        public NotificationAdapter(List<Notification> notiList) {
            super(getActivity(), 0, new ArrayList<Notification>(notiList));
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;
            if(v == null){
                v = getActivity().getLayoutInflater().inflate(R.layout.notification_layout, null);
            }
            noti_info = (TextView) v.findViewById(R.id.noti_info);
            Notification noti = getItem(position);
            noti_info.setText(noti.getInformation());

            return v;
        }
    }

    public void getNoti(){

        Log.d(TAG, "Called GetNoti()");

        Call<List<Notification>> call = service.getNotification();
        call.enqueue(new Callback<List<Notification>>() {
            @Override
            public void onResponse(Call<List<Notification>> call, Response<List<Notification>> response) {
                List<Notification> notificationList;
                notificationList = response.body();
                NotificationAdapter adapter = new NotificationAdapter(notificationList);
                setListAdapter(adapter);
            }

            @Override
            public void onFailure(Call<List<Notification>> call, Throwable t) {

            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();

        Log.d(TAG, "onResumed");

        Gson gson = new Gson();
        SharedPreferences pref = getActivity().getSharedPreferences(SHAREDPREFERENCES, Context.MODE_PRIVATE);
        String json = pref.getString(PREF_TOKEN, "");
        if (json.equals("")) {
            service = ServiceGenerator.createService(UserService.class);
            isLogin = false;
        } else {
            token = gson.fromJson(json, Token.class);
            service = ServiceGenerator.createService(UserService.class, token);
            isLogin = true;
        }

        getNoti();
    }
}
