package com.example.alex.final_alexschwartz;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.Spinner;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    private String entre;
    private String veggieValue;
    private String locationValue;
    private String toppings;
    private String nameValue = "un-named dish ";
    CheckBox cheese, salsa, sour, guac;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        //get button
        final Button button = (Button) findViewById(R.id.button);
        final Button go = (Button) findViewById(R.id.button2);

        //create listener
        View.OnClickListener onclick = new View.OnClickListener() {
            public void onClick(View view) {
                createBurrito(view);
            }
        };

        //create listener
        View.OnClickListener onclick2 = new View.OnClickListener() {
            public void onClick(View view) {
                sendIt(view);
            }
        };

        //add listener to the button
        button.setOnClickListener(onclick);
        go.setOnClickListener(onclick);

    }

    public void createBurrito(View view) {
        cheese = (CheckBox) findViewById(R.id.checkBoxCheese);
        salsa = (CheckBox) findViewById(R.id.checkBoxSalsa);
        sour = (CheckBox) findViewById(R.id.checkBoxSour);
        guac = (CheckBox) findViewById(R.id.checkBoxGauc);

        Spinner locationSpinner = (Spinner) findViewById(R.id.spinner); //get spinner item array postion
        Integer locations = locationSpinner.getSelectedItemPosition();

        //toggle button
        ToggleButton toggle = (ToggleButton) findViewById(R.id.toggleButton);
        boolean veggie = toggle.isChecked();
        Switch glutenSwitch = (Switch) findViewById(R.id.switch1);
        boolean gluten = glutenSwitch.isChecked();

        //radio buttons
        RadioGroup entreSelection = (RadioGroup) findViewById(R.id.radioGroup);
        int entre_id = entreSelection.getCheckedRadioButtonId();
        ImageView mealPic = (ImageView) findViewById(R.id.imageView);

        //Get Burrito Name
        EditText name = (EditText) findViewById(R.id.editText);
        String nameValue = name.getText().toString();

        //check radio buttons and gluten free option
        if (entre_id == -1) {
            //toast
            Context context = getApplicationContext();
            CharSequence text = "Please select an entre";
            int duration = Toast.LENGTH_SHORT;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        } else {
            if (gluten) {

                if (entre_id == R.id.radioButtonBurrito) { //spring meals
                    entre = "corn burrito ";
                    mealPic.setImageResource(R.drawable.burrito);

                }
                if (entre_id == R.id.radioButtonTaco) { //spring meals
                    entre = "corn taco ";
                    mealPic.setImageResource(R.drawable.taco);
                }
            } else {
                if (entre_id == R.id.radioButtonBurrito) { //spring meals
                    entre = "burrito ";
                    mealPic.setImageResource(R.drawable.burrito);

                }
                if (entre_id == R.id.radioButtonTaco) { //spring meals
                    entre = "taco ";
                    mealPic.setImageResource(R.drawable.taco);
                }
            }
        }
        //Check Veggie
        if (veggie) {
            veggieValue = "veggies ";
        } else {
            veggieValue = "meat ";

        }

        //check toppings
        StringBuilder toppings = new StringBuilder();
        if (cheese.isChecked()) {
            toppings.append("cheese ");
        }
        if (salsa.isChecked()) {
            toppings.append("salsa ");
        }
        if (sour.isChecked()) {
            toppings.append("sour cream ");
        }
        if (guac.isChecked()) {
            toppings.append("guacamole ");
        }

        //check locations
        switch (locations) {
            case 0:
                locationValue = "The Hill";
                break;
            case 1:
                locationValue = "29th Street";
                break;
            case 2:
                locationValue = "Pearl Street";
                break;
            default:
                locationValue = "The Hill";
        }
        //text view
        TextView mealSelection = (TextView) findViewById(R.id.textDescription);
        mealSelection.setText("The " + nameValue + " is a " + entre + "with " + veggieValue + "with " + toppings + "you\'d like to eat on " + locationValue + ".");

    }

    public void sendIt(View view) {
        Spinner locationSpinner = (Spinner) findViewById(R.id.spinner); //get spinner item array postion
        Integer locations = locationSpinner.getSelectedItemPosition();
        switch (locations) {
            case 0:
                startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("http://illegalpetes.com/")));
                break;
            case 1:
                startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://www.chipotle.com/")));
                break;
            case 2:
                startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("https://bartaco.com/")));
                break;
            default:
                startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse("http://illegalpetes.com/")));
        }
    }
}