package com.fpt.study.yticket.activity;

import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.widget.TabHost;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.fragment.HomeFragment;
import com.fpt.study.yticket.util.TabContent;


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
                HomeFragment allEvent = (HomeFragment) fm.findFragmentByTag("all");
                HomeFragment hotEvent= (HomeFragment) fm.findFragmentByTag("hot");
                FragmentTransaction ft = fm.beginTransaction();

                /** Detaches the androidfragment if exists */
                if(allEvent!=null)
                    ft.detach(allEvent);

                /** Detaches the applefragment if exists */
                if(hotEvent!=null)
                    ft.detach(hotEvent);

                if(tabId.equalsIgnoreCase("all")){

                    if(allEvent==null){
                        /** Create AndroidFragment and adding to fragmenttransaction */
                        ft.add(R.id.realtabcontent,new HomeFragment(), "all");
                    }else{
                        /** Bring to the front, if already exists in the fragmenttransaction */
                        ft.attach(allEvent);
                    }

                }else{    /** If current tab is apple */
                    if(hotEvent==null){
                        /** Create AppleFragment and adding to fragmenttransaction */
                        ft.add(R.id.realtabcontent,new HomeFragment(), "hot");
                    }else{
                        /** Bring to the front, if already exists in the fragmenttransaction */
                        ft.attach(hotEvent);
                    }
                }

                ft.commit();


            }
        };

        tabHost.setOnTabChangedListener(tabChangeListener);

        /** Defining tab builder for Andriod tab */
        TabHost.TabSpec tSpecHotEvent = tabHost.newTabSpec("hot");
        tSpecHotEvent.setContent(new TabContent(getBaseContext()));
        tSpecHotEvent.setIndicator("HOT EVENTS");
        tabHost.addTab(tSpecHotEvent);

        /** Defining tab builder for Apple tab */
        TabHost.TabSpec tSpecApple = tabHost.newTabSpec("all");
        tSpecApple.setContent(new TabContent(getBaseContext()));
        tSpecApple.setIndicator("ALL EVENTS");
        tabHost.addTab(tSpecApple);

    }
}
