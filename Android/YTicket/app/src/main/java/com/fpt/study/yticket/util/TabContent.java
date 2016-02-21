package com.fpt.study.yticket.util;

import android.content.Context;
import android.view.View;
import android.widget.TabHost;

/**
 * Created by Frost on 2/21/2016.
 */
public class TabContent implements TabHost.TabContentFactory {
    private Context context;

    public TabContent(Context context){
        this.context = context;
    }

    @Override
    public View createTabContent(String tag) {
        View v = new View(context);
        return v;
    }
}
