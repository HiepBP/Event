package com.fpt.study.yticket.fragment;

import android.app.ListFragment;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.Event;

import java.util.ArrayList;

/**
 * Created by ThienPG on 2/18/2016.
 */
public class HomeFragment extends ListFragment {
    private ArrayList<Event>  events;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
     View v =   inflater.inflate(R.layout.fragment_home, container ,false);

        return v;
    }
}
