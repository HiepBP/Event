package com.fpt.study.yticket.activity;

import android.app.Fragment;
import android.app.FragmentManager;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarActivity;
import android.support.v7.app.ActionBarDrawerToggle;
import android.util.Log;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.fpt.study.yticket.Adapter.NavListAdapter;
import com.fpt.study.yticket.R;
import com.fpt.study.yticket.model.NavItem;
import com.fpt.study.yticket.model.Token;
import com.fpt.study.yticket.model.User;
import com.fpt.study.yticket.service.UserService;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.google.gson.Gson;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;
import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class NavDrawerActivity extends ActionBarActivity {

    public static final String SHAREDPREFERENCES = "YTicketPrefs";
    public static final String PREF_TOKEN = "UserToken";
    public static final String TAG = "NavFragment";
    DrawerLayout drawerLayout;
    RelativeLayout drawerPane;
    ListView listNav;
    ImageView profile_image;
    TextView profile_username;
    Button btn_profile_login;
    Button btn_profile_signup;
    User user;
    List<NavItem> navItemList;
    List<Fragment> fragmentList;
    UserService userService;
    boolean isLogin;
    Token token;
    ActionBarDrawerToggle actionBarDrawerToggle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        Log.d(TAG, "onCreate");
        super.onCreate(savedInstanceState);
        setContentView(R.layout.slide_menu_layout);
        getSupportActionBar().setDisplayHomeAsUpEnabled(true);


        Gson gson = new Gson();

        SharedPreferences pref = getSharedPreferences(SHAREDPREFERENCES, Context.MODE_PRIVATE);

        String json = pref.getString(PREF_TOKEN, "");

        if (json.equals("")) {
            userService = ServiceGenerator.createService(UserService.class);
            isLogin = false;
        } else {
            token = gson.fromJson(json, Token.class);
            userService = ServiceGenerator.createService(UserService.class, token);
            isLogin = true;
        }

        drawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        drawerPane = (RelativeLayout) findViewById(R.id.drawer_pane);
        profile_image = (ImageView) findViewById(R.id.profile_image);
        profile_username = (TextView) findViewById(R.id.textview_profile_username);
        btn_profile_login = (Button) findViewById(R.id.btn_profile_login);
        btn_profile_signup = (Button) findViewById(R.id.btn_profile_signup);


        btn_profile_login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClickProfileButtonLogin(v);
            }
        });

        btn_profile_signup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClickProfileBButtonSignUp(v);
            }
        });

        listNav = (ListView) findViewById(R.id.nav_list);
        fragmentList = new ArrayList<Fragment>();
        navItemList = new ArrayList<NavItem>();
        final NavListAdapter navListAdapter =
                new NavListAdapter(getApplicationContext(), R.layout.item_nav_list, navItemList);
        listNav.setAdapter(navListAdapter);

        //add Home to nav bar
        navItemList.add(new NavItem("Home", "Home page", R.drawable.home_icon));
        fragmentList.add(new HomeActivity().createFragment());

        //add noti to nav bar
        navItemList.add(new NavItem("Notification", "", R.drawable.noti));
        fragmentList.add(new NotificationActivity().createFragment());

        //add about us to nav bar
        navItemList.add(new NavItem("About Us", "", R.drawable.about_us));
        //add logout to nav bar
        navItemList.add(new NavItem("Logout", "", R.drawable.logout));


        //load HomeFragment as default
        FragmentManager fragmentManager = getFragmentManager();
        fragmentManager.beginTransaction()
                .replace(R.id.main_contain, fragmentList.get(0))
                .commit();
        setTitle(navItemList.get(0).getTitle());
        listNav.setItemChecked(0, true);
        drawerLayout.closeDrawer(drawerPane);

        //set OnClickListener for each items in nav bar
        listNav.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view,
                                    int position, long id) {
                String itemName = navItemList.get(position).getTitle().toLowerCase();
                switch (itemName) {
                    case "logout": {
                        Call<Void> call = userService.logout();
                        call.enqueue(new Callback<Void>() {
                            @Override
                            public void onResponse(Call<Void> call, Response<Void> response) {
                                btn_profile_login.setVisibility(View.VISIBLE);
                                btn_profile_signup.setVisibility(View.VISIBLE);
                                profile_image.setVisibility(View.GONE);
                                profile_username.setVisibility(View.GONE);
                                SharedPreferences pref = getSharedPreferences(LoginActivity
                                                .SHAREDPREFERENCES,
                                        MODE_PRIVATE);
                                SharedPreferences.Editor editor = pref.edit();
                                editor.remove(LoginActivity.PREF_TOKEN);
                                editor.apply();
                                Intent intent = new Intent(getApplication(), LoginActivity.class);
                                startActivity(intent);
                            }

                            @Override
                            public void onFailure(Call<Void> call, Throwable t) {

                            }
                        });
                        break;
                    }
                    case "about us": {
                        Intent intent = new Intent(getApplication(), AboutUsActivity.class);
                        startActivity(intent);
                        break;
                    }
                    default: {
                        FragmentManager fragmentManager = getFragmentManager();
                        fragmentManager.beginTransaction()
                                .replace(R.id.main_contain, fragmentList.get(position))
                                .commit();

                        setTitle(navItemList.get(position).getTitle());
                        listNav.setItemChecked(position, true);
                        drawerLayout.closeDrawer(drawerPane);
                        break;
                    }
                }
            }
        });


        //create listener for DrawerLayout
        actionBarDrawerToggle = new ActionBarDrawerToggle(this, drawerLayout,
                R.string.drawer_opened, R.string.drawer_closed) {

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
                getCurrentUser();
            }
        });
        profile_username.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                getCurrentUser();
            }
        });

        getProfile();

    }

    public void getCurrentUser() {
        Call<User> call = userService.getCurrentUser();
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                if (response.isSuccess()) {
                    Log.d(TAG, "getCurrentUser called");
                    user = response.body();
                    Intent intent = new Intent(getApplication(), UserDetailActivity.class);
                    intent.putExtra("userID", user.getID());

                    startActivity(intent);

                } else {
                    Log.d(TAG, "getCurrentUser failed");
                }
            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {
                Log.d(TAG, "getCurrentUser onfailure called");
                Toast.makeText(getParent(), t.getMessage(), Toast.LENGTH_LONG).show();
            }
        });
    }

    private void onClickProfileButtonLogin(View v) {
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
    }

    private void onClickProfileBButtonSignUp(View v) {
        Intent intent = new Intent(this, SignupActivity.class);
        startActivity(intent);
    }

    private void getProfile() {
        Log.d(TAG, "getProfile started");
        Call<User> call = userService.getCurrentUser();
        call.enqueue(new Callback<User>() {
            @Override
            public void onResponse(Call<User> call, Response<User> response) {
                if (response.isSuccess()) {
                    User user = response.body();
                    if (user.getImage() == null) {
                        profile_image.setImageResource(R.drawable.default_user);
                    } else {
                        Picasso.with(getApplication())
                                .load(user.getImage())
                                .into(profile_image);
                    }
                    profile_username.setText(user.getUsername());
                } else {
                    Log.d(TAG, "Get Profile failed");
                }

            }

            @Override
            public void onFailure(Call<User> call, Throwable t) {

            }
        });
    }

    @Override
    public void onPostCreate(Bundle savedInstanceState, PersistableBundle persistentState) {
        super.onPostCreate(savedInstanceState, persistentState);
        actionBarDrawerToggle.syncState();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        if (actionBarDrawerToggle.onOptionsItemSelected(item)) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    protected void onResume() {
        super.onResume();
        Log.d(TAG, "onResume");
        Gson gson = new Gson();

        SharedPreferences pref = getSharedPreferences(SHAREDPREFERENCES, Context.MODE_PRIVATE);

        String json = pref.getString(PREF_TOKEN, "");

        if (json.equals("")) {
            userService = ServiceGenerator.createService(UserService.class);
            isLogin = false;
        } else {
            token = gson.fromJson(json, Token.class);
            userService = ServiceGenerator.createService(UserService.class, token);
            isLogin = true;
        }
    }
}
