package com.fpt.study.yticket.fragment;


import android.app.ListFragment;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.fpt.study.yticket.R;
import com.fpt.study.yticket.activity.UserDetailActivity;
import com.fpt.study.yticket.model.User;
import com.fpt.study.yticket.service.UserService;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;


/**
 * Created by Frost on 2/19/2016.
 */
public class UserFragment extends ListFragment {

    TextView txtUserName;
    ImageView userImage;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        service = ServiceGenerator.createService(UserService.class);
        getAllUser(1, 9);
    }

    UserService service;
    List<User> users = new ArrayList();

    public void getAllUser(int page, int pageSize) {
        Call<List<User>> call = service.getAllUser(page, pageSize);
        call.enqueue(new Callback<List<User>>() {
            @Override
            public void onResponse(Call<List<User>> call, Response<List<User>> response) {
                users.addAll(response.body());
                setListAdapter(new UserCustomAdapter(users));
            }

            @Override
            public void onFailure(Call<List<User>> call, Throwable t) {

            }
        });
    }

    private class UserCustomAdapter extends ArrayAdapter<User> {

        public UserCustomAdapter(List<User> users) {
            super(getActivity(), 0, new ArrayList<User>(users));
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            View v = convertView;

            if (v == null) {
                v = getActivity().getLayoutInflater().inflate(R.layout.list_user_item, null);
            }

            User user = getItem(position);
            txtUserName = (TextView) v.findViewById(R.id.list_user_item_Name);

            txtUserName.setText(user.getUsername());
            userImage = (ImageView) v.findViewById(R.id.user_image);
//            Glide.with(getActivity())
//                    .load("http://sm.uploads.im/t/SwLa6.png")
//                    .into(userImage);

            Picasso.with(getActivity())
                    .load("http://sm.uploads.im/t/SwLa6.png")
                    .into(userImage);

            return v;
        }
    }

    @Override
    public void onListItemClick(ListView l, View v, int position, long id) {
        User user = ((UserCustomAdapter) getListAdapter()).getItem(position);

        Intent intent = new Intent(getActivity(), UserDetailActivity.class);
        intent.putExtra("userID", user.getID());

        getActivity().startActivity(intent);
    }
}
