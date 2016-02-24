package com.fpt.study.yticket.fragment;

import android.app.Fragment;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.Image;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.activity.EventActivity;
import com.fpt.study.yticket.activity.LoginActivity;
import com.fpt.study.yticket.activity.UserDetailActivity;
import com.fpt.study.yticket.model.Token;
import com.fpt.study.yticket.model.User;
import com.fpt.study.yticket.service.EventService;
import com.fpt.study.yticket.service.UserService;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.google.gson.Gson;
import com.squareup.picasso.Picasso;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by Frost on 2/20/2016.
 */
public class UserDetailFragment extends Fragment {

    public static final String TAG = "UserDetail";
    public static final String SHAREDPREFERENCES = "YTicketPrefs";
    public static final String PREF_TOKEN = "UserToken";
    Token token;
    Boolean isLogin = false;
    int userid = 0;

    EditText userID;
    EditText username;
    EditText email;
    EditText address;
    EditText phone;
    ImageView userAvatar;
    Button btnUpdate;

    UserService service;
    User user;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        service = ServiceGenerator.createService(UserService.class);

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
            Intent intent = getActivity().getIntent();
            userid = intent.getIntExtra("userID", 0);
        }
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_user_detail, container, false);
        userAvatar = (ImageView) v.findViewById(R.id.user_avatar);
        userID = (EditText) v.findViewById(R.id.edittext_user_id);
        username = (EditText) v.findViewById(R.id.edittext_user_username);
        email = (EditText) v.findViewById(R.id.edittext_user_email);
        address = (EditText) v.findViewById(R.id.edittext_user_address);
        phone = (EditText) v.findViewById(R.id.edittext_user_phone);
        btnUpdate = (Button) v.findViewById(R.id.btn_user_update);

        Intent intent = getActivity().getIntent();
        userid = intent.getIntExtra("userID", 0);

        Call<User> call = service.getUserById(userid);
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                user = response.body();
                userID.setText(user.getID() + "");
                username.setText(user.getUsername() + "");
                email.setText(user.getEmail() + "");
                address.setText(user.getAddress() + "");
                phone.setText(user.getPhone() + "");
                Picasso.with(getActivity())
                        .load("http://sm.uploads.im/t/SwLa6.png")
                        .into(userAvatar);
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {

            }
        });

        btnUpdate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                btnUpdateOnClickedListener();
            }
        });

        return v;
    }

    private void btnUpdateOnClickedListener() {
        user.setEmail(email.getText().toString());
        user.setAddress(address.getText().toString());
        user.setPhone(phone.getText().toString());
        updateUser(userid, user);
    }

    private void updateUser(int ID, User user) {
        Call<Void> call = service.updateUser(ID, user);
        call.enqueue(new Callback<Void>() {
            @Override
            public void onResponse(Call<Void> call, Response<Void> response) {
                if(response.isSuccess()) {
                    Log.d(TAG, "update success");
                    Intent intent = new Intent(getActivity(), UserDetailActivity.class);
                    intent.putExtra("userID", userid);
                    startActivity(intent);
                }
            }

            @Override
            public void onFailure(Call<Void> call, Throwable t) {

            }
        });
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
            service = ServiceGenerator.createService(UserService.class);
            isLogin = false;
        } else {
            Log.d(TAG, "co token");
            token = gson.fromJson(json, Token.class);
            service = ServiceGenerator.createService(UserService.class, token);
            isLogin = true;
            Intent intent = getActivity().getIntent();
            userid = intent.getIntExtra("userID", 0);
        }
    }
}
