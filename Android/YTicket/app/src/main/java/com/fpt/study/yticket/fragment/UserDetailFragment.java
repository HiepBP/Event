package com.fpt.study.yticket.fragment;

import android.app.Fragment;
import android.content.Intent;
import android.media.Image;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.User;
import com.fpt.study.yticket.service.UserService;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.squareup.picasso.Picasso;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by Frost on 2/20/2016.
 */
public class UserDetailFragment extends Fragment {

    EditText userID;
    EditText username;
    EditText email;
    EditText address;
    EditText phone;
    ImageView userAvatar;

    UserService service;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        service = ServiceGenerator.createService(UserService.class);
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

        Intent intent = getActivity().getIntent();
        final int userid = intent.getIntExtra("userID", 0);

        Call<User> call = service.getUserById(userid);
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                User user = response.body();
                userID.setText(user.getID()+"");
                username.setText(user.getUsername()+"");
                email.setText(user.getEmail()+"");
                address.setText(user.getAddress()+"");
                phone.setText(user.getPhone()+"");
                Picasso.with(getActivity())
                        .load("http://sm.uploads.im/t/SwLa6.png")
                        .into(userAvatar);
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {

            }
        });

        return v;
    }
}
