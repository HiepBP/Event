package com.fpt.study.yticket.activity;

import android.app.Fragment;

import com.fpt.study.yticket.fragment.UserFragment;
import com.fpt.study.yticket.util.activityfragment.ActivityFragment;

public class UserActivity extends ActivityFragment {

    @Override
    protected Fragment createFragment() {
        return new UserFragment();
    }
}
