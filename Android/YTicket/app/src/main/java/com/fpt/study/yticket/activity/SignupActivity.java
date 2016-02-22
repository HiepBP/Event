package com.fpt.study.yticket.activity;

import android.content.Intent;
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
import com.fpt.study.yticket.model.Account;
import com.fpt.study.yticket.model.AccountError;
import com.fpt.study.yticket.model.AccountErrorModel;
import com.fpt.study.yticket.service.AccountService;
import com.fpt.study.yticket.util.ErrorUtils;
import com.fpt.study.yticket.util.ServiceGenerator;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class SignupActivity extends AppCompatActivity {

    EditText editEmail, editPassword, editConfirmPassword;
    Button buttonSignup;

    AccountService service;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_signup);
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

        editEmail = (EditText) findViewById(R.id.edit_email);
        editPassword = (EditText) findViewById(R.id.edit_password);
        editConfirmPassword = (EditText) findViewById(R.id.edit_confirm_password);

        buttonSignup = (Button) findViewById(R.id.button_signup);

        service = ServiceGenerator.createService(AccountService.class);

        buttonSignup.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onClickButtonSignup(v);
            }
        });
    }

    private void onClickButtonSignup(View v) {
        String email = editEmail.getText().toString();
        final String password = editPassword.getText().toString();
        final String confirmPassword = editConfirmPassword.getText().toString();

        Account account = new Account();
        account.setEmail(email);
        account.setPassword(password);
        account.setConfirmPassword(confirmPassword);

        Call<Void> call = service.postRegister(account);
        call.enqueue(new Callback<Void>() {
            @Override
            public void onResponse(Call<Void> call, Response<Void> response) {
                if (response.isSuccess()) {
                    Log.v("signup" , "success");

                    Toast.makeText(SignupActivity.this, "Sign up successful!!!", Toast.LENGTH_LONG)
                            .show();

                    Intent intent = new Intent(SignupActivity.this, LoginActivity.class);
                    startActivity(intent);
                } else {
                    AccountError error = ErrorUtils.parseError(response, AccountError.class);
                    AccountErrorModel modelState = error.getModelState();

                    String emailError = "",
                            passwordError = "",
                            confirmPasswordError = "",
                            blankError = "";

                    if (!modelState.getModelEmail().isEmpty()) {
                        emailError = error.getModelState().getModelEmail().get(0);
                    }

                    if (!modelState.getModelPassword().isEmpty()) {
                        passwordError = error.getModelState().getModelPassword().get(0);
                    }

                    if (!modelState.getModelConfirmPassword().isEmpty()) {
                        confirmPasswordError = error.getModelState()
                                .getModelConfirmPassword().get(0);
                    }

                    if (!modelState.getModelBlank().isEmpty()) {
                        blankError = error.getModelState()
                                .getModelBlank().get(0);
                    }

                    if (!emailError.isEmpty()) {
                        editEmail.setText("");
                        editEmail.setHint(emailError);
                        editEmail.setHintTextColor(getResources().getColor(R.color.colorRed));
                    }

                    if (!blankError.isEmpty()) {
                        if (blankError.contains("Email"))
                        {
                            editEmail.setText("");
                            editEmail.setHint(blankError);
                            editEmail.setHintTextColor(getResources().getColor(R.color.colorRed));
                        }
                        if (blankError.contains("password") || blankError.contains("Password"))
                        {
                            editPassword.setText("");
                            editConfirmPassword.setText("");
                            editPassword.setHint(blankError);
                            editPassword.setHintTextColor(getResources().getColor(R.color.colorRed));
                        }
                    }

                    if (!passwordError.isEmpty()) {
                        editPassword.setText("");
                        editPassword.setHint(passwordError);
                        editPassword.setHintTextColor(getResources().getColor(R.color.colorRed));
                    }

                    if (!confirmPasswordError.isEmpty()) {
                        editConfirmPassword.setText("");
                        editConfirmPassword.setHint(confirmPasswordError);
                        editConfirmPassword.setHintTextColor(getResources().getColor(R.color
                                .colorRed));
                    }
                }
            }

            @Override
            public void onFailure(Call<Void> call, Throwable t) {
                Log.v("signup" , "failure");
                Toast.makeText(SignupActivity.this, t.getMessage(), Toast.LENGTH_LONG).show();
            }
        });
    }

}
