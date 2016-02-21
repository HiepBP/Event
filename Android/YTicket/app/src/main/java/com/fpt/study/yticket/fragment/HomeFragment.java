package com.fpt.study.yticket.fragment;


import android.app.ListFragment;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.fpt.study.yticket.R;
import com.fpt.study.yticket.activity.EventActivity;
import com.fpt.study.yticket.model.Event;
import com.fpt.study.yticket.service.HomeService;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.fpt.study.yticket.util.infinitescroll.InfiniteScrollListener;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

/**
 * Created by ThienPG on 2/18/2016.
 */

public class HomeFragment extends ListFragment {
    private static final String TAG = "HomeFragment";
    public static final String EXTRA_EVENT_ID = "EXTRA_EVENT_ID";

    private static final int PAGE_SIZE = 20;

    HomeService service;
    List<Event> events = new ArrayList<>();
    TextView txtEventName;
    ImageView eventImage;
    ListView listView;
    EditText mEditTextSearch;
    EventAdapter adapter;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("HomeFragment", "onCreate called");
        service = ServiceGenerator.createService(HomeService.class);
        getAll(1, PAGE_SIZE);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_home, container, false);

        mEditTextSearch = (EditText) v.findViewById(R.id.fragment_home_search);

        mEditTextSearch.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {

                v.requestFocusFromTouch();
                return false;
            }
        });

        mEditTextSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                Log.d(TAG, "edit");
                getEventsByName(s.toString(), 1, 10);
                if (s.toString().trim().equals("")) {
                    getAll(1, PAGE_SIZE);
                }

            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        return v;
    }

    @Override
    public void onViewCreated(View view, Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        listView = getListView();
        //listView.addHeaderView(getActivity().getLayoutInflater().inflate(R.layout.header, null));
        listView.addFooterView(getActivity().getLayoutInflater().inflate(R.layout.footer, null));
        listView.setOnScrollListener(new InfiniteScrollListener(0) {
            @Override
            public void loadMore(final int page, int totalItemsCount) {
                //delay 3s then load more
                final Handler handler = new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        getAll(page, PAGE_SIZE);
                    }
                }, 1000);

            }
        });


    }

    public void getEventsByName(String name, int page, int pageSize) {
        Call<List<Event>> call = service.getEventsByName(name, page, pageSize);
        call.enqueue(new Callback<List<Event>>() {
            @Override
            public void onResponse(Call<List<Event>> call, Response<List<Event>> response) {
                if (response.isSuccess()) {
                    events.clear();
                    events.addAll(response.body());
                    adapter = new EventAdapter(events);
                    setListAdapter(adapter);

                }
            }

            @Override
            public void onFailure(Call<List<Event>> call, Throwable t) {

            }
        });
    }

    public void getAll(int page, int pageSize) {
        Call<List<Event>> call = service.getAllEvents(page, pageSize);
        call.enqueue(new Callback<List<Event>>() {
            @Override
            public void onResponse(Call<List<Event>> call, Response<List<Event>> response) {
                if (response.isSuccess()) {
                    events.addAll(response.body());
                    adapter = new EventAdapter(events);
                    setListAdapter(adapter);
                    //set list view to a position
                    listView.setSelection(adapter.getCount() - 33);
                }
            }

            @Override
            public void onFailure(Call<List<Event>> call, Throwable t) {

            }
        });
    }


    /*
     * Custom adapter for home page list view
     */
    private class EventAdapter extends ArrayAdapter<Event> {
        public EventAdapter(List<Event> events) {
            super(getActivity(), 0, new ArrayList<Event>(events));
        }

        @Override
        public View getView(int position, View convertView, ViewGroup parent) {
            if (convertView == null) {
                convertView = getActivity().getLayoutInflater().inflate(R.layout.list_event_item, null);
            }

            Event e = getItem(position);

            txtEventName = (TextView) convertView.findViewById(R.id.list_event_item_Name);
            txtEventName.setText(e.getName());
            eventImage = (ImageView) convertView.findViewById(R.id.list_event_item_Image);
            Glide.with(getActivity()).load(e.getImage()).into(eventImage);
            return convertView;
        }
    }


    @Override
    public void onListItemClick(ListView l, View v, int position, long id) {
        Event e = ((EventAdapter) getListAdapter()).getItem(position);
        Log.d(TAG, e.getName() + "was clicked");
        Intent intent = new Intent(getActivity(), EventActivity.class);
        intent.putExtra(EXTRA_EVENT_ID, e.getID());
        getActivity().startActivity(intent);
    }


}

