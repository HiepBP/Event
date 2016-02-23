package com.fpt.study.yticket.fragment;

import android.app.Fragment;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Toolbar;
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
import com.fpt.study.yticket.activity.NavDrawerActivity;
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
    Button btnEventEdit;
    Button btnEventDelete;
    EventService eventService;
    UserService userService;

    EventUserStatus eventUserStatus;
    User user;
    User creator;
    Token token;
    Boolean isLogin = false;
    int eventId = 0;

    SharedPreferences sharedPreferences;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d(TAG, "onCreate called");


        Gson gson = new Gson();

        SharedPreferences pref = getActivity().getSharedPreferences(SHAREDPREFERENCES, Context.MODE_PRIVATE);

        String json = pref.getString(PREF_TOKEN, "");

        if (json.equals("")) {
            eventService = ServiceGenerator.createService(EventService.class);
            isLogin = false;
        } else {
            token = gson.fromJson(json, Token.class);
            eventService = ServiceGenerator.createService(EventService.class, token);
            isLogin = true;
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
            isLogin = false;
        } else {
            Log.d(TAG, "co token");
            token = gson.fromJson(json, Token.class);
            eventService = ServiceGenerator.createService(EventService.class, token);
            isLogin = true;
            Intent intent = getActivity().getIntent();
            int eventId = intent.getIntExtra(LoginActivity.EXTRA_EVENT_ID, 0);
            if (eventId != 0) {
                Log.d(TAG, eventId + "");
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
        eventId = intent.getIntExtra(EXTRA_EVENT_ID, 0);

        etxtEventId = (EditText) v.findViewById(R.id.fragment_event_edittext_id);
        etxtEventName = (EditText) v.findViewById(R.id.fragment_event_edittext_name);
        etxtEventTime = (EditText) v.findViewById(R.id.fragment_event_edittext_time);
        etxtEventPlace = (EditText) v.findViewById(R.id.fragment_event_edittext_place);
        eventImage = (ImageView) v.findViewById(R.id.fragment_event_image_image);

        btnEventEdit = (Button) v.findViewById(R.id.fragment_home_button_edit);
        btnEventEdit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.d(TAG, "edit button on click");
                User user = new User();
                user.setUsername(etxtEventName.getText().toString());
                user.setUsername(etxtEventTime.getText().toString());
                user.setUsername(etxtEventPlace.getText().toString());
                updateEvent(eventId, user);
            }
        });
        btnEventDelete = (Button) v.findViewById(R.id.fragment_home_button_delete);
        btnEventDelete.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                deleteEvent(eventId);
            }
        });
        getCurrentUser();


        btnEventJoin = (Button) v.findViewById(R.id.fragment_event_button_join);
        getEventByID(eventId);
        btnEventJoin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (isLogin == false) {
                    Log.d(TAG, "Not yet login");
                    Intent intent = new Intent(getActivity(), LoginActivity.class);
                    //int eventId = Integer.parseInt(etxtEventId.getText().toString());
                    intent.putExtra(EXTRA_EVENT_ID, eventId);
                    Log.d(TAG, "" + eventId);
                    getActivity().startActivity(intent);
                } else {
                    joinEvent(eventId);
                }

            }
        });


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

    public void getCurrentUser() {
        Call<User> call = eventService.getCurrentUser();
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                if (response.isSuccess()) {
                    Log.d(TAG, "getCurrentUser called");
                    user = response.body();
                    getUserByEvent(eventId);
                } else {
                    Log.d(TAG, "getCurrentUser failed");
                }


            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {
                Log.d(TAG, "getCurrentUser onfailure called");
                Toast.makeText(getActivity(), t.getMessage(), Toast.LENGTH_LONG)
                        .show();
            }
        });


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

    public void getUserByEvent(int eventId) {
        Call<User> call = eventService.getUserByEvent(eventId);
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                if (response.isSuccess()) {
                    creator = response.body();
                    Log.d(TAG, user.getUsername());
                    Log.d(TAG, creator.getUsername());
                    if (user.getID() != creator.getID()) {
                        Log.d(TAG, "this event is not created by this user");
                        btnEventEdit.setVisibility(View.GONE);
                        btnEventDelete.setVisibility(View.GONE);
                    }

                } else {
                    Log.d(TAG, "not succ");
                    btnEventEdit.setVisibility(View.GONE);
                    btnEventDelete.setVisibility(View.GONE);
                }
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {
                Toast.makeText(getActivity(), t.getMessage(), Toast.LENGTH_LONG)
                        .show();
            }
        });

    }

    public void updateEvent(int id, User user) {
        Call<Void> call = eventService.updateEvent(eventId, user);
        call.enqueue(new Callback<Void>() {
            @Override
            public void onResponse(Call<Void> call, Response<Void> response) {
                if (response.isSuccess()) {
                    Intent intent = new Intent(getActivity(), EventActivity.class);
                    intent.putExtra(EXTRA_EVENT_ID, eventId);
                    startActivity(intent);
                }
            }

            @Override
            public void onFailure(Call<Void> call, Throwable t) {

            }
        });
    }

    public void deleteEvent(int id) {
        Call<Void> call = eventService.deleteEvent(id);
        call.enqueue(new Callback<Void>() {
            @Override
            public void onResponse(Call<Void> call, Response<Void> response) {
                if (response.isSuccess()) {
                    Log.d(TAG, "Delete successfully");
                }else {
                    Log.d(TAG, "Delete not successfully");
                }
            }

            @Override
            public void onFailure(Call<Void> call, Throwable t) {
                Log.d(TAG, "Delete Failure");
            }
        });
    }


}
