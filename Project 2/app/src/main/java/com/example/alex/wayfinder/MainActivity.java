package com.example.alex.wayfinder;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

public class MainActivity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void getBearing(View view){
        //Get location
        //Update target location based on search
        //get relative bearing between two locations

        // xcode logic:

/*            let lat1 = latitude*3.14/180
            let lon1 = longitude*3.14/180

            let lat2 = buildings[builingIndicator].latitude*3.14/180
            let lon2 = buildings[builingIndicator].longitude*3.14/180

            let dLon = lon2 - lon1
            let dLat = lat2 - lat1


            let y = sin(dLon) * cos(lat2)
            let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
            let R = 6371e3; // metres

            let a = sin(dLat/2) * sin(dLat/2) +
                    cos(lat1) * cos(lat2) *
                            sin(dLon/2) * sin(dLon/2);
            let c = 2 * atan2(sqrt(a), sqrt(1-a));

            d = R * c;
            radiansBearing = atan2(y, x)*/

        //Get actual device bearing
        //Update image rotation - Xcode logic:         angleStatus.transform = CGAffineTransform(rotationAngle: CGFloat(radiansBearing-(heading*3.14/180)))
        //Update distance from target string
        //update current elevation string
        //update current latitude longitude strings


    }

}
