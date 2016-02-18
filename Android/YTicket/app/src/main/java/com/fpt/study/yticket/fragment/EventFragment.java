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

/**
 * Created by ThienPG on 2/19/2016.
 */
public class EventFragment extends Fragment{

    EditText etxtEventId;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View v = inflater.inflate(R.layout.fragment_event, container, false);
        Intent intent = getActivity().getIntent();
        int eventId = intent.getIntExtra(HomeFragment.EXTRA_EVENT_ID, 0);

        etxtEventId = (EditText) v.findViewById(R.id.fragment_event_edittext_id);
        etxtEventId.setText(eventId+"");
        return v;
    }
}
