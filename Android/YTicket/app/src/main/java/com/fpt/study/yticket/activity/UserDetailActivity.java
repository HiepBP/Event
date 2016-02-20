package com.fpt.study.yticket.activity;

import android.app.Fragment;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.fpt.study.yticket.fragment.UserDetailFragment;
import com.fpt.study.yticket.util.activityfragment.ActivityFragment;

public class UserDetailActivity extends ActivityFragment {

    @Override
    protected Fragment createFragment() {
        return new UserDetailFragment();
    }
}
