package com.example.alex.lab6;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Spinner;

public class SendSkatePark extends AppCompatActivity {

    private SkatePark mySkatePark = new SkatePark();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_send_skate_park);
        //get button
        final Button button = (Button) findViewById(R.id.button);
        //create listener
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){
                findSkatePark(view);
            }
        };
//add listener to the button
        button.setOnClickListener(onclick);
    }

    public void findSkatePark(View view){
//get spinner
        Spinner styleSpinner = (Spinner)findViewById(R.id.spinner); //get spinner item array postion
        Integer style = styleSpinner.getSelectedItemPosition();
//set the skate park
        mySkatePark.setSkatePark(style);
//get suggested skate park
        String suggestedSkatePark = mySkatePark.getSkatePark();
        String suggestedSkateParkImage = mySkatePark.getSkateParkImage();
        //get maps url of the skate park
        String suggestedSkateParkURL = mySkatePark.getSkateParkURL();
        Log.i("park", suggestedSkatePark);
        Log.i("url", suggestedSkateParkURL);
        Log.i("image", suggestedSkateParkImage);


        //create an intent
        Intent intent = new Intent(this, ReceiveActivity.class);
        //pass data
        intent.putExtra("skateParkName", suggestedSkatePark);
        intent.putExtra("skateParkURL", suggestedSkateParkURL);
        intent.putExtra("skateParkImage", suggestedSkateParkImage);
//start the intent
        startActivity(intent);
    }
}