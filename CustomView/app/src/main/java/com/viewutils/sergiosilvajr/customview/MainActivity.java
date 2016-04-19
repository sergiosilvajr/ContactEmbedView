package com.viewutils.sergiosilvajr.customview;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;

import com.viewutils.sergiosilvajr.views.view.ContactPicker;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        final ContactPicker contactPicker = (ContactPicker) findViewById(R.id.contact_picker);
        findViewById(R.id.b1).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.v("MainActivity","is: "+contactPicker.getText());
            }
        });
    }
}
