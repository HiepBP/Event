package com.fpt.study.yticket.Adapter;

import android.annotation.SuppressLint;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.NavItem;

import java.util.List;

/**
 * Created by Frost on 2/22/2016.
 */
public class NavListAdapter extends ArrayAdapter<NavItem> {

    Context context;
    int resLayout;
    List<NavItem> navItemList;

    public NavListAdapter(Context context, int resLayout, List<NavItem> navItemList) {
        super(context, resLayout, navItemList);

        this.context = context;
        this.navItemList = navItemList;
        this.resLayout = resLayout;
    }

    @SuppressLint("ViewHolder")
    @Override
    public View getView(int position, View convertView, ViewGroup parrent){
        View v = View.inflate(context, resLayout, null);

        TextView title = (TextView) v.findViewById(R.id.title);
        TextView subTitle = (TextView) v.findViewById(R.id.subtitle);
        ImageView userIcon = (ImageView) v.findViewById(R.id.home_icon);

        NavItem navItem = navItemList.get(position);

        title.setText(navItem.getTitle());
        subTitle.setText(navItem.getSubTitle());
        userIcon.setImageResource(navItem.getResIcon());

        return v;

    }


}
