package com.example.ex6_4;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CalendarView;
import android.widget.Chronometer;
import android.widget.RadioButton;
import android.widget.TextView;
import android.widget.TimePicker;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Chronometer chro = findViewById(R.id.chrono);
        Button startBtn = findViewById(R.id.startBtn);
        RadioButton calRadio = findViewById(R.id.dateRadio);
        RadioButton timeRadio = findViewById(R.id.timeRadio);
        CalendarView cv = findViewById(R.id.cv);
        TimePicker tp = findViewById(R.id.tp);
        Button stopBtn = findViewById(R.id.stopBtn);
        TextView resultTv = findViewById(R.id.resultTv);
        startBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                chro.start();
            }
        });

    }
}