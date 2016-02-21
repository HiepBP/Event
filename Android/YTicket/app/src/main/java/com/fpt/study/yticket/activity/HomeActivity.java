package com.fpt.study.yticket.activity;


import android.util.Log;
import android.app.Fragment;
import com.fpt.study.yticket.fragment.HomeFragment;
import com.fpt.study.yticket.util.activityfragment.ActivityFragment;

/**
 * Created by ThienPG on 2/18/2016.
 */
public class HomeActivity extends ActivityFragment {

    @Override
    protected Fragment createFragment() {
        return new HomeFragment();
    }
}
