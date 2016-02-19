package com.fpt.study.yticket.fragment;

import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.Event;
import com.fpt.study.yticket.service.EventService;
import com.fpt.study.yticket.util.ServiceGenerator;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by ThienPG on 2/19/2016.
 */
public class EventFragment extends Fragment {
    EditText etxtEventName;
    EditText etxtEventTime;
    EditText etxtEventPlace;
    // EditText etxtEventImage;
    EventService service;

    EditText etxtEventId;

    @Override
    public void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        service = ServiceGenerator.createService(EventService.class);
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_event, container, false);
        Intent intent = getActivity().getIntent();
        int eventId = intent.getIntExtra(HomeFragment.EXTRA_EVENT_ID, 0);
        etxtEventId = (EditText) v.findViewById(R.id.fragment_event_edittext_id);
        etxtEventName = (EditText) v.findViewById(R.id.fragment_event_edittext_name);
        etxtEventTime = (EditText) v.findViewById(R.id.fragment_event_edittext_time);
        etxtEventPlace = (EditText) v.findViewById(R.id.fragment_event_edittext_place);

        Call<Event> call = service.getEventDetail(eventId);
        call.enqueue(new Callback<Event>() {
            @Override
            public void onResponse(Call<Event> call, Response<Event> response) {
                Event e = response.body();
                etxtEventId.setText(e.getID() + "");
                etxtEventName.setText(e.getName());
                etxtEventTime.setText(e.getTime() + "");
                etxtEventPlace.setText(e.getPlace());
            }

            @Override
            public void onFailure(Call<Event> call, Throwable t) {

            }
        });

        etxtEventId = (EditText) v.findViewById(R.id.fragment_event_edittext_id);
        etxtEventId.setText(eventId + "");

        return v;
    }
}
