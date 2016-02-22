package com.fpt.study.yticket.activity;

import android.app.Fragment;
import android.os.PersistableBundle;
import android.app.FragmentManager;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBarDrawerToggle;
import android.os.Bundle;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.fpt.study.yticket.Adapter.NavListAdapter;
import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.NavItem;


import java.util.ArrayList;
import java.util.List;

public class NavDrawerActivity extends ActionBarActivity {

    DrawerLayout drawerLayout;
    RelativeLayout drawerPane;
    ListView listNav;
    ImageView profile_image;
    TextView profile_username;

    List<NavItem> navItemList;
    List<Fragment> fragmentList;

    ActionBarDrawerToggle actionBarDrawerToggle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.slide_menu_layout);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);


        drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerPane = (RelativeLayout) findViewById(R.id.drawer_pane);
        profile_image = (ImageView) findViewById(R.id.profile_image);
        profile_username = (TextView) findViewById(R.id.textview_profile_username);

        listNav = (ListView) findViewById(R.id.nav_list);

        navItemList = new ArrayList<NavItem>();
        navItemList.add(new NavItem("Home", "Home page", R.drawable.home_icon));
        navItemList.add(new NavItem("User for DEMO", "List of user", R.drawable.home_icon));
        navItemList.add(new NavItem("AboutUs", "Setting page", R.drawable.about_us));

        NavListAdapter navListAdapter =
                new NavListAdapter(getApplicationContext(), R.layout.item_nav_list, navItemList);

        listNav.setAdapter(navListAdapter);

        fragmentList = new ArrayList<Fragment>();
        fragmentList.add(new HomeActivity().createFragment());
        fragmentList.add(new UserActivity().createFragment());


        //load HomeFragment as default
        FragmentManager fragmentManager = getFragmentManager();
        fragmentManager.beginTransaction()
                .replace(R.id.main_contain, fragmentList.get(0))
                .commit();

        setTitle(navItemList.get(0).getTitle());
        listNav.setItemChecked(0, true);
        drawerLayout.closeDrawer(drawerPane);


        //set OnClickListener for each items
        listNav.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view,
                                    int position, long id) {
                FragmentManager fragmentManager = getFragmentManager();
                fragmentManager.beginTransaction()
                        .replace(R.id.main_contain, fragmentList.get(position))
                        .commit();

                setTitle(navItemList.get(position).getTitle());
                listNav.setItemChecked(position, true);
                drawerLayout.closeDrawer(drawerPane);
            }
        });


        //create listener for DrawerLayout
        actionBarDrawerToggle = new ActionBarDrawerToggle(this, drawerLayout,
                R.string.drawer_opened, R.string.drawer_closed){

            @Override
            public void onDrawerOpened(View drawerView) {
                invalidateOptionsMenu();
                super.onDrawerOpened(drawerView);
            }

            @Override
            public void onDrawerClosed(View drawerView) {
                invalidateOptionsMenu();
                super.onDrawerClosed(drawerView);
            }
        };

        drawerLayout.setDrawerListener(actionBarDrawerToggle);
        actionBarDrawerToggle.syncState();

        //set listener for User Profile Image and Username
        profile_image.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getCurrentUserDetail();
            }
        });
        profile_username.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getCurrentUserDetail();
            }
        });
    }

    private void getCurrentUserDetail(){
        //TODO GET CURRENT USER DETAILS
    }

    @Override
    public void onPostCreate(Bundle savedInstanceState, PersistableBundle persistentState) {
        super.onPostCreate(savedInstanceState, persistentState);
        actionBarDrawerToggle.syncState();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {

        if(actionBarDrawerToggle.onOptionsItemSelected(item)){
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
