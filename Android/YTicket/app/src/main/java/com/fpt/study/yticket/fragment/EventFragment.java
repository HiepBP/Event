package com.fpt.study.yticket.fragment;

import android.app.Fragment;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.bumptech.glide.Glide;
import com.fpt.study.yticket.R;
import com.fpt.study.yticket.activity.EventActivity;
import com.fpt.study.yticket.activity.LoginActivity;
import com.fpt.study.yticket.model.Event;
import com.fpt.study.yticket.model.EventUserStatus;
import com.fpt.study.yticket.model.Token;
import com.fpt.study.yticket.model.User;
import com.fpt.study.yticket.service.EventService;
import com.fpt.study.yticket.service.UserService;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.google.gson.Gson;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by ThienPG on 2/19/2016.
 */
public class EventFragment extends Fragment {
    public static final String SHAREDPREFERENCES = "YTicketPrefs";
    public static final String PREF_TOKEN = "UserToken";
    public static final String TAG = "EventFragment";
    public static final String EXTRA_EVENT_ID = "EXTRA_EVENT_ID";

    EditText etxtEventName;
    EditText etxtEventTime;
    EditText etxtEventPlace;
    EditText etxtEventId;
    ImageView eventImage;
    Button btnEventJoin;
    EventService eventService;
    UserService userService;

    EventUserStatus eventUserStatus;
    User user;
    Token token;

    SharedPreferences sharedPreferences;


    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        Log.d(TAG, "onCreate called");

        Gson gson = new Gson();

        SharedPreferences pref = getActivity().getPreferences(Context.MODE_PRIVATE);

        String json = pref.getString(PREF_TOKEN, "");

        if (json.equals("")) {
            eventService = ServiceGenerator.createService(EventService.class);
        } else {
            token = gson.fromJson(json, Token.class);
            eventService = ServiceGenerator.createService(EventService.class, token);
        }
    }

    @Override
    public void onResume() {
        super.onResume();
        Log.d(TAG, "onResume called");
        Gson gson = new Gson();
        SharedPreferences pref = getActivity().getSharedPreferences(SHAREDPREFERENCES, Context.MODE_PRIVATE);
        String json = pref.getString(PREF_TOKEN, "");
        Log.d(TAG, json);
        if (json.equals("")) {
            Log.d(TAG, "khong co token");
            eventService = ServiceGenerator.createService(EventService.class);
        } else {
            Log.d(TAG, "co token");
            token = gson.fromJson(json, Token.class);
            eventService = ServiceGenerator.createService(EventService.class, token);
            Intent intent = getActivity().getIntent();
            int eventId = intent.getIntExtra(EXTRA_EVENT_ID, 0);
            if (eventId != 0) {
                joinEvent(eventId);
            }
        }


    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        Log.d(TAG, "onCreateView");
        System.out.println("Chay vao oncreate");
        View v = inflater.inflate(R.layout.fragment_event, container, false);
        Intent intent = getActivity().getIntent();
        int eventId = intent.getIntExtra(EXTRA_EVENT_ID, 0);

        etxtEventId = (EditText) v.findViewById(R.id.fragment_event_edittext_id);
        etxtEventName = (EditText) v.findViewById(R.id.fragment_event_edittext_name);
        etxtEventTime = (EditText) v.findViewById(R.id.fragment_event_edittext_time);
        etxtEventPlace = (EditText) v.findViewById(R.id.fragment_event_edittext_place);
        eventImage = (ImageView) v.findViewById(R.id.fragment_event_image_image);
        btnEventJoin = (Button) v.findViewById(R.id.fragment_event_button_join);

        btnEventJoin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (token == null) {
                    Log.d(TAG, "token is null");
                    Intent intent = new Intent(getActivity(), LoginActivity.class);
                    int eventId = Integer.parseInt(etxtEventId.getText().toString());
                    intent.putExtra(EXTRA_EVENT_ID, eventId);
                    Log.d(TAG, "" + eventId);
                    getActivity().startActivity(intent);
                } else {
                    Log.d(TAG, "btnJoin clicked");
                }

            }
        });

        getEventByID(eventId);


        return v;
    }

    public void getEventByID(int eventId) {

        Call<Event> call = eventService.getEventDetail(eventId);
        call.enqueue(new Callback<Event>() {
            @Override
            public void onResponse(Call<Event> call, Response<Event> response) {
                Event e = response.body();
                etxtEventId.setText(e.getID() + "");
                etxtEventName.setText(e.getName());
                etxtEventTime.setText(e.getTime() + "");
                etxtEventPlace.setText(e.getPlace());
                Glide.with(getActivity()).load(e.getImage()).into(eventImage);

            }

            @Override
            public void onFailure(Call<Event> call, Throwable t) {
                Toast.makeText(getActivity(), t.getMessage(), Toast.LENGTH_LONG)
                        .show();
            }
        });

    }

    public EventUserStatus getEventUserStatus(int eventId) {

        Call<EventUserStatus> call = eventService.getEventUserStatus(eventId);
        call.enqueue(new Callback<EventUserStatus>() {
            @Override
            public void onResponse(Call<EventUserStatus> call, Response<EventUserStatus> response) {
                eventUserStatus = response.body();

            }

            @Override
            public void onFailure(Call<EventUserStatus> call, Throwable t) {
                Toast.makeText(getActivity(), t.getMessage(), Toast.LENGTH_LONG)
                        .show();
            }
        });

        return eventUserStatus;
    }

    public User getCurrentUser() {
        Call<User> call = eventService.getCurrentUser();
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                user = response.body();
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {
                Toast.makeText(getActivity(), t.getMessage(), Toast.LENGTH_LONG)
                        .show();
            }
        });

        return user;
    }

    public void joinEvent(int eventId) {
        Call<Void> call = eventService.joinEvent(eventId);
        call.enqueue(new Callback<Void>() {
            @Override
            public void onResponse(Call<Void> call, Response<Void> response) {
                Toast.makeText(getActivity(), "Join successfully", Toast.LENGTH_SHORT)
                        .show();
            }

            @Override
            public void onFailure(Call<Void> call, Throwable t) {
                Toast.makeText(getActivity(), t.getMessage(), Toast.LENGTH_LONG)
                        .show();
            }
        });
    }

}
