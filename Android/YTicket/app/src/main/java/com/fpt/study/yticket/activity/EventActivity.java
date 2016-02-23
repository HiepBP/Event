package com.fpt.study.yticket.activity;

import android.app.Fragment;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.fragment.EventFragment;
import com.fpt.study.yticket.fragment.HomeFragment;
import com.fpt.study.yticket.util.activityfragment.ActivityFragment;

/**
 * Created by ThienPG on 2/19/2016.
 */
public class EventActivity extends ActivityFragment {
    @Override
    protected Fragment createFragment() {
        return new EventFragment();
    }

}
