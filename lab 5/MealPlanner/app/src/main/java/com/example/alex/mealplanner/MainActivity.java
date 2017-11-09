package com.example.alex.mealplanner;

import android.content.Context;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void reset(View view) {
        //radio buttons
        RadioGroup season = (RadioGroup) findViewById(R.id.radioGroup);
        season.clearCheck();
        ImageView mealPic = (ImageView) findViewById(R.id.imageView);
        //toast
        Context context = getApplicationContext();
        CharSequence text = "Please select a Season";
        int duration = Toast.LENGTH_SHORT;

        Toast toast = Toast.makeText(context, text, duration);
        toast.show();
    }

    public void planMeal(View view) {
        //toggle button
        ToggleButton toggle = (ToggleButton) findViewById(R.id.toggleButton);
        boolean horse = toggle.isChecked();

        Switch veggieSwitch = (Switch) findViewById(R.id.switch1);
        boolean veggie = veggieSwitch.isChecked();

        //radio buttons
        RadioGroup season = (RadioGroup) findViewById(R.id.radioGroup);
        int season_id = season.getCheckedRadioButtonId();

        //pick sport
        String perfectMeal = "What's your ideal meal?";

        ImageView mealPic = (ImageView) findViewById(R.id.imageView);

        //check radio buttons
        if (season_id == -1) {
            //toast
            Context context = getApplicationContext();
            CharSequence text = "Please select a Season";
            int duration = Toast.LENGTH_SHORT;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        } else {
            if (season_id == R.id.radioButtonSpring) { //spring meals
                if (horse) {
                    if (veggie) {
                        perfectMeal = "a big 'ol slice of broccoli polenta lasagna";
                        mealPic.setImageResource(R.drawable.broccoli);

                    } else {
                        perfectMeal = "a big 'ol fillet of smoked salmon";
                        mealPic.setImageResource(R.drawable.salmon);

                    }
                } else {
                    if (veggie) {
                        perfectMeal = "some fried pickles";
                        mealPic.setImageResource(R.drawable.pickles);

                    } else {
                        perfectMeal = "some bacon jalepeno poppers";
                        mealPic.setImageResource(R.drawable.bacon);

                    }
                }
            }
            if (season_id == R.id.radioButtonSummer) { //spring meals
                if (horse) {
                    if (veggie) {
                        perfectMeal = "a heaping serving of spaghetti squash";
                        mealPic.setImageResource(R.drawable.squash);

                    } else {
                        perfectMeal = "a heaping serving of chicken alfredo";
                        mealPic.setImageResource(R.drawable.alfredo);

                    }
                } else {
                    if (veggie) {
                        perfectMeal = "some ants on some logs";
                        mealPic.setImageResource(R.drawable.ants);

                    } else {
                        perfectMeal = "a spicy tuna roll";
                        mealPic.setImageResource(R.drawable.sushi);

                    }
                }
            }
            if (season_id == R.id.radioButtonFall) { //spring meals
                if (horse) {
                    if (veggie) {
                        perfectMeal = "an entire spinach artichoke pizza";
                        mealPic.setImageResource(R.drawable.pizza);

                    } else {
                        perfectMeal = "a big 'ol plate of carne asada fajitas";
                        mealPic.setImageResource(R.drawable.carne);

                    }
                } else {
                    if (veggie) {
                        perfectMeal = "chips with guac and salsa";
                        mealPic.setImageResource(R.drawable.salsa);

                    } else {
                        perfectMeal = "a pork tamale";
                        mealPic.setImageResource(R.drawable.tamale);

                    }
                }
            }
            if (season_id == R.id.radioButtonWinter) { //spring meals
                if (horse) {
                    if (veggie) {
                        perfectMeal = "a heaping serving of eggplant lasagna";
                        mealPic.setImageResource(R.drawable.eggplant);

                    } else {
                        perfectMeal = "an entire crockpot of chicken chilli";
                        mealPic.setImageResource(R.drawable.chilli);

                    }
                } else {
                    if (veggie) {
                        perfectMeal = "some stuffed baby portabella mushrooms";
                        mealPic.setImageResource(R.drawable.shrooms);

                    } else {
                        perfectMeal = "some Korean meatballs";
                        mealPic.setImageResource(R.drawable.meatballs);

                    }
                }
            }
        }
            //text view
            TextView mealSelection = (TextView) findViewById(R.id.MealSuggestion);
            mealSelection.setText("You should eat " + perfectMeal);
        }

    }
