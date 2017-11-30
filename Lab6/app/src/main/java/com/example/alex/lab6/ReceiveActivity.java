package com.example.alex.lab6;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

public class ReceiveActivity extends AppCompatActivity {

    private String skatePark;
    private String skateParkURL;
    private String skateParkImage;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_receive);
        //get intent
        Intent intent = getIntent();
        skatePark = intent.getStringExtra("skateParkName");
        skateParkURL = intent.getStringExtra("skateParkURL");
        skateParkImage = intent.getStringExtra("skateParkImage");
        Log.i("image received", skateParkImage);
        Log.i("park received", skatePark);
        Log.i("url received", skateParkURL);
//update text view
        TextView messageView = (TextView) findViewById(R.id.skateParkTextView);
        messageView.setText("You should skate at " + skatePark);
        final ImageButton imageButton = (ImageButton) findViewById(R.id.imageButton); //create listener

        switch (skateParkImage){
            case "zero": //street
                imageButton.setImageResource(R.drawable.broomfield);
                break;
            case "one": //vert
                imageButton.setImageResource(R.drawable.boulder);
                break;
            case "two": //combined
                imageButton.setImageResource(R.drawable.north);
                break;
            case "three": //park
                imageButton.setImageResource(R.drawable.arvada);
                break;
            case "four": //freestyle
                imageButton.setImageResource(R.drawable.lafayette);

                break;
            default:
                ;
        }

        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){ loadWebSite(view);
            }
        };
//add listener to the button
        imageButton.setOnClickListener(onclick);
    }

    public void loadWebSite(View view){
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse(skateParkURL));
        startActivity(intent);
    }


}
