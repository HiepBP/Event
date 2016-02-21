package com.fpt.study.yticket.activity;

import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.ListFragment;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TabHost;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.fragment.HomeFragment;
import com.fpt.study.yticket.fragment.UserFragment;
import com.fpt.study.yticket.util.TabContent;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends FragmentActivity {

    TabHost tabHost;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tabHost = (TabHost) findViewById(android.R.id.tabhost);
        tabHost.setup();

        TabHost.OnTabChangeListener tabChangeListener = new TabHost.OnTabChangeListener() {
            @Override
            public void onTabChanged(String tabId) {
                FragmentManager fm = getFragmentManager();
                HomeFragment homeFragment = (HomeFragment) fm.findFragmentByTag("home");
                UserFragment userFragment = (UserFragment) fm.findFragmentByTag("user");
                FragmentTransaction ft = fm.beginTransaction();

                /** Detaches the androidfragment if exists */
                if(homeFragment!=null)
                    ft.detach(homeFragment);

                /** Detaches the applefragment if exists */
                if(userFragment!=null)
                    ft.detach(userFragment);

                if(tabId.equalsIgnoreCase("home")){

                    if(homeFragment==null){
                        /** Create AndroidFragment and adding to fragmenttransaction */
                        ft.add(R.id.realtabcontent,new HomeFragment(), "home");
                    }else{
                        /** Bring to the front, if already exists in the fragmenttransaction */
                        ft.attach(homeFragment);
                    }

                }else{    /** If current tab is apple */
                    if(userFragment==null){
                        /** Create AppleFragment and adding to fragmenttransaction */
                        ft.add(R.id.realtabcontent,new UserFragment(), "user");
                    }else{
                        /** Bring to the front, if already exists in the fragmenttransaction */
                        ft.attach(userFragment);
                    }
                }

                ft.commit();


            }
        };

        tabHost.setOnTabChangedListener(tabChangeListener);

        /** Defining tab builder for Andriod tab */
        TabHost.TabSpec tSpecAndroid = tabHost.newTabSpec("home");
        tSpecAndroid.setContent(new TabContent(getBaseContext()));
        tSpecAndroid.setIndicator("ALL SHITS", getResources().getDrawable(R.drawable.user_image));
        tabHost.addTab(tSpecAndroid);

        /** Defining tab builder for Apple tab */
        TabHost.TabSpec tSpecApple = tabHost.newTabSpec("user");
        tSpecApple.setContent(new TabContent(getBaseContext()));
        tSpecApple.setIndicator("HOT SHITS", getResources().getDrawable(R.drawable.user_image));
        tabHost.addTab(tSpecApple);

    }
}
