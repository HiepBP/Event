package com.fpt.study.yticket.fragment;


import android.app.ListFragment;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import com.fpt.study.yticket.R;
import com.fpt.study.yticket.activity.EventActivity;
import com.fpt.study.yticket.model.Event;
import com.fpt.study.yticket.service.HomeService;
import com.fpt.study.yticket.util.ServiceGenerator;
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
    public static final String EXTRA_EVENT_NAME = "EXTRA_EVENT_NAME";
    public static final String EXTRA_EVENT_TIME = "EXTRA_EVENT_TIME";
    public static final String EXTRA_EVENT_PLACE = "EXTRA_EVENT_PLACE";
    public static final String EXTRA_EVENT_IMAGE = "EXTRA_EVENT_IMAGE";
    private static final int PAGE_SIZE = 10;

    HomeService service;
    List<Event> events = new ArrayList<>();
    TextView txtEventName;
    Button btn_NextPage;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d("HomeFragment", "onCreate called");
        service = ServiceGenerator.createService(HomeService.class);
        
        getAll(1,9);
    }

    public void getAll(int page, int pageSize){
        Call<List<Event>> call = service.getAllEvents(page, pageSize);
        call.enqueue(new Callback<List<Event>>() {
            @Override
            public void onResponse(Call<List<Event>> call, Response<List<Event>> response) {
                Log.d("HomeFragment", response.body().get(0).getName());
//                events = response.body();
                events.addAll(response.body());
                System.out.println(response.body());
                EventAdapter adapter = new EventAdapter(events);
                setListAdapter(adapter);
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