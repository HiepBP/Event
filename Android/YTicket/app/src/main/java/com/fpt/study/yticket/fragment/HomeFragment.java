package com.fpt.study.yticket.fragment;

import android.app.Fragment;
import android.app.ListFragment;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.Event;
import com.fpt.study.yticket.service.HomeService;
import com.fpt.study.yticket.util.ServiceGenerator;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by ThienPG on 2/18/2016.
 */

public class HomeFragment extends Fragment{
    private static final String TAG = "HomeFragment";

    HomeService service;
    List<Event> events;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("HomeFragment", "onCreate called");
        service = ServiceGenerator.createService(HomeService.class);

        Call<List<Event>> call = service.getAllEvents(1, 9);
        call.enqueue(new Callback<List<Event>>() {
            @Override
            public void onResponse(Call<List<Event>> call, Response<List<Event>> response) {
                Log.d("HomeFragment", response.body().get(0).getName());
                events = response.body();
            }

            @Override
            public void onFailure(Call<List<Event>> call, Throwable t) {

            }
        });


    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        Log.d(TAG, "onCreateView called");
        View v = inflater.inflate(R.layout.list_event_item, container, false);

        return v;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        TextView txtEventName = (TextView) view.findViewById(R.id.list_event_item_Name);
        txtEventName.setText(events.get(1).getName());
    }
}