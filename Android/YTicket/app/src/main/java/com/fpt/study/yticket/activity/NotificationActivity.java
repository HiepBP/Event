package com.fpt.study.yticket.activity;

import android.app.Fragment;

import com.fpt.study.yticket.fragment.NotificationFragment;
import com.fpt.study.yticket.util.activityfragment.ActivityFragment;

public class NotificationActivity extends ActivityFragment {

    @Override
    protected Fragment createFragment() {
        return new NotificationFragment();
    }

}
