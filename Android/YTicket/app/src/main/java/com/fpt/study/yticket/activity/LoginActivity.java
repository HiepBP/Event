package com.fpt.study.yticket.activity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.fpt.study.yticket.R;
import com.fpt.study.yticket.fragment.EventFragment;
import com.fpt.study.yticket.model.Event;
import com.fpt.study.yticket.model.Token;
import com.fpt.study.yticket.model.TokenError;
import com.fpt.study.yticket.service.LoginService;
import com.fpt.study.yticket.util.ErrorUtils;
import com.fpt.study.yticket.util.ServiceGenerator;
import com.google.gson.Gson;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class LoginActivity extends AppCompatActivity {

    public static final String SHAREDPREFERENCES = "YTicketPrefs";
    public static final String PREF_TOKEN = "UserToken";
    public static final String TAG = "LoginActivity";
    public static final String EXTRA_EVENT_ID = "LOGIN_EXTRA_EVENT_ID";
    EditText editUsername, editPassword;
    Button buttonSignup, buttonLogin;
    LoginService service;
    SharedPreferences sharedPreferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });

        service = ServiceGenerator.createService(LoginService.class);
        sharedPreferences = getSharedPreferences(SHAREDPREFERENCES, Context.MODE_PRIVATE);

        buttonLogin = (Button) findViewById(R.id.button_login);
        buttonSignup = (Button) findViewById(R.id.button_signup);

        editUsername = (EditText) findViewById(R.id.edit_username);
        editPassword = (EditText) findViewById(R.id.edit_password);

        buttonLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClickButtonLogin(v);
            }
        });

        buttonSignup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClickButtonSignup(v);
            }
        });
    }

    private void onClickButtonLogin(View v) {
        String username = editUsername.getText().toString();
        String password = editPassword.getText().toString();
        Call<Token> call = service.getAccessToken("password", username, password);
        call.enqueue(new Callback<Token>() {
            @Override
            public void onResponse(Call<Token> call, Response<Token> response) {
                if (response.isSuccess()) {
                    Intent intent = getIntent();
                    int eventId = intent.getIntExtra(EventFragment.EXTRA_EVENT_ID, 0);
                    Log.d(TAG, "" + eventId);
                    if (eventId == 0) {
                        intent = new Intent(getApplication(), MainActivity.class);
                    } else {
                        intent = new Intent(getApplication(), EventActivity.class);
                        intent.putExtra(EXTRA_EVENT_ID, eventId);
                    }


                    startActivity(intent);
                    // Store Token obj in Shared Preferences as json string using Gson
                    Token token = response.body();
                    SharedPreferences.Editor editor = sharedPreferences.edit();
                    Gson gson = new Gson();
                    String json = gson.toJson(token);

                    editor.putString(PREF_TOKEN, json);
                    System.out.println(token.getAccessToken());
                    editor.apply();
                    Log.d(TAG, token.getAccessToken());
                    Log.d(TAG, token.getTokenType());
                    Log.d(TAG, token.getUserName());
                    Log.d(TAG, PREF_TOKEN);


                } else {
                    // Parse error from response
                    TokenError error = ErrorUtils.parseError(response, TokenError.class);
                    Toast.makeText(LoginActivity.this, error.getErrorDescription(), Toast
                            .LENGTH_LONG)
                            .show();
                }
            }

            @Override
            public void onFailure(Call<Token> call, Throwable t) {
                Toast.makeText(LoginActivity.this, t.getMessage(), Toast.LENGTH_LONG)
                        .show();
            }
        });
        finish();
    }

    private void onClickButtonSignup(View v) {
//        // Get Token obj from Shared Preferences
//        Gson gson = new Gson();
//        String json = sharedPreferences.getString(PREF_TOKEN, "");
//        Token token = gson.fromJson(json, Token.class);
//
//        String authToken = token.getTokenType() + " " + token.getAccessToken();
//        Toast.makeText(LoginActivity.this, authToken, Toast.LENGTH_LONG).show();

        Intent intent = new Intent(this, SignupActivity.class);
        startActivity(intent);
    }

}
