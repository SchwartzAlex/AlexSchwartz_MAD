package com.example.alex.wayfinder;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SearchView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import static java.lang.Math.atan2;

public class MainActivity extends AppCompatActivity implements SensorEventListener {

    static final int REQUEST_LOCATION = 1;
    LocationManager locationManager;
    ImageView compass;
    TextView dist;
    int mAzimuth;
    private SensorManager mSensorManager;
    private Sensor mRotationV, mAccelerometer, mMagnetometer;
    boolean haveSensor = false, haveSensor2 = false;
    float[] rMat = new float[9];
    float[] orientation = new float[3];
    private float[] mLastAccelerometer = new float[3];
    private float[] mLastMagnetometer = new float[3];
    private boolean mLastAccelerometerSet = false;
    private boolean mLastMagnetometerSet = false;
    double lat2=90.00;
    double lon2=0.00;
    float brng;




    ArrayList<Locations> locs = new ArrayList<>();
    ArrayAdapter<Locations> adapter;
    ListView lv;
    SearchView sv;




    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setDisplayShowHomeEnabled(true);
        getSupportActionBar().setLogo(R.drawable.ic_wayfinderlogo);
        getSupportActionBar().setDisplayUseLogoEnabled(true);

        mSensorManager = (SensorManager) getSystemService(SENSOR_SERVICE);
        compass = (ImageView) findViewById(R.id.imageViewDial);
        dist = (TextView) findViewById(R.id.textViewDist);
        bearing();

        lv = (ListView)findViewById(R.id.listView);
        sv = (SearchView)findViewById(R.id.searchView);

        filldata();

        class locsComparator implements Comparator<Locations> {
            public int compare(Locations left, Locations right) {
                return left.getPlace().compareTo(right.getPlace());
            }
        }
        Collections.sort(locs, new locsComparator());


        //Adapter
        adapter=new ArrayAdapter<>(this,android.R.layout.simple_list_item_1,locs);
        lv.setAdapter(adapter);
        lv.setVisibility(View.INVISIBLE);




        sv.setOnClickListener(new SearchView.OnClickListener() {
                                  @Override
                                  public void onClick(View v) {
                                      Log.d("CLICK","CLICK");
                                      lv.setVisibility(View.VISIBLE);

                                      switch (v.getId()) {
                                          case R.id.searchView:
                                              sv.onActionViewExpanded();
                                              lv.setVisibility(View.VISIBLE);
                                              break;
                                      }
                                  }
                                  });

                sv.setOnQueryTextListener(new SearchView.OnQueryTextListener() {

                    @Override
                    public boolean onQueryTextSubmit(String query) {

                        return false;
                    }

                    @Override
                    public boolean onQueryTextChange(String newText) {
                        adapter.getFilter().filter(newText);
                        return false;
                    }
                });
                lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                    @Override
                    public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                        lv.setVisibility(View.INVISIBLE);
                        sv.setIconified(true);
                        lat2=adapter.getItem(i).getLat();
                        lon2=adapter.getItem(i).getLong();
                        Log.i("latitude", Double.toString(lat2));
                        Log.i("longitude", Double.toString(lon2));
                        TextView messageView = (TextView) findViewById(R.id.textViewTarget);
                        messageView.setText(adapter.getItem(i).getPlace());
                                Toast.makeText(MainActivity.this, adapter.getItem(i).getPlace(), Toast.LENGTH_SHORT).show();
                    }
                });




        locationManager = (LocationManager)getSystemService(Context.LOCATION_SERVICE);
    }

    private void filldata(){
        locs.add(new Locations("The North Pole", 90.0, 0.0));
        locs.add(new Locations("The South Pole", -90.0, 0.0));
        locs.add(new Locations("ATLAS Building", 40.007726, -105.269676));
        locs.add(new Locations("Norlin Library", 40.008653, -105.270860));
        locs.add(new Locations("Engineering Center", 40.007073, -105.262997));
        locs.add(new Locations("Center For Community", 40.004532, -105.264986));
        locs.add(new Locations("University Memorial Center", 40.006850, -105.271806));
        locs.add(new Locations("Student Rec Center", 40.010115, -105.269403));
        locs.add(new Locations("Leeds School of Business", 40.005685, -105.263516));
        locs.add(new Locations("Farrand Field", 40.006004, -105.267595));
        locs.add(new Locations("Norlin Quad", 40.008642, -105.272827));
        locs.add(new Locations("Hale Sciences", 40.009195, -105.275205));
        locs.add(new Locations("Macky Auditorium", 40.010039, -105.272695));
        locs.add(new Locations("Eaton Humanities", 40.009224, -105.271733));
        locs.add(new Locations("Eckley Sciences", 40.008132, -105.271763));
        locs.add(new Locations("Hellems Arts & Sciences", 40.007542, -105.272742));
        locs.add(new Locations("CHEM 140", 40.007377, -105.271238));
        locs.add(new Locations("Visual Arts Complex", 40.007500, -105.270547));
        locs.add(new Locations("Environmental Design", 40.006956, -105.269237));
        locs.add(new Locations("Imig Music Building", 40.006019, -105.269294));
        locs.add(new Locations("Flemming / Idea Forge", 40.001916, -105.263333));
        locs.add(new Locations("Wolf Law", 40.001419, -105.262167));
        locs.add(new Locations("Munzinger Auditorium", 40.008680, -105.269018));
        locs.add(new Locations("Duane Physics", 40.007990, -105.267143));
        locs.add(new Locations("Benson Earth Sciences", 40.007912, -105.265694));
        locs.add(new Locations("Math / Genmill Library", 40.007906, -105.264312));
        locs.add(new Locations("Coors Event Center", 40.004738, -105.260534));
        locs.add(new Locations("Fiske Planetarium", 40.003564, -105.263444));
        locs.add(new Locations("Sewall Hall", 40.010385, -105.271150));
        locs.add(new Locations("Baker Hall", 40.006770, -105.267828));
        locs.add(new Locations("Cheyenne Arapahoe Hall", 40.005265, -105.267841));
        locs.add(new Locations("Willard Hall", 40.005272, -105.266260));
        locs.add(new Locations("Farrand Hall", 40.006000, -105.265946));
        locs.add(new Locations("Aden Hall", 40.006886, -105.265387));
        locs.add(new Locations("Brackett Hall", 40.007128, -105.265143));
        locs.add(new Locations("Cockerell Hall", 40.006691, -105.264535));
        locs.add(new Locations("Crosman Hall", 40.006217, -105.264782));
        locs.add(new Locations("Reed Hall", 40.005832, -105.264769));
        locs.add(new Locations("Hallett Hall", 40.005025, -105.264979));
        locs.add(new Locations("Kittredge West Hall", 40.002991, -105.264273));
        locs.add(new Locations("Andrews Hall", 40.003250, -105.262171));
        locs.add(new Locations("Arnett Hall", 40.003339, -105.261108));
        locs.add(new Locations("Smith Hall", 40.002436, -105.261832));
        locs.add(new Locations("Buckingham Hall", 440.002376, -105.260813));
        locs.add(new Locations("Williams Village Campus", 39.998865, -105.250427));

    }

    @Override
    public void onSensorChanged(SensorEvent event) {
        if (event.sensor.getType() == Sensor.TYPE_ROTATION_VECTOR) {
            SensorManager.getRotationMatrixFromVector(rMat, event.values);
            mAzimuth = (int) (Math.toDegrees(SensorManager.getOrientation(rMat, orientation)[0]) + 360) % 360;
        }

        if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
            System.arraycopy(event.values, 0, mLastAccelerometer, 0, event.values.length);
            mLastAccelerometerSet = true;
        } else if (event.sensor.getType() == Sensor.TYPE_MAGNETIC_FIELD) {
            System.arraycopy(event.values, 0, mLastMagnetometer, 0, event.values.length);
            mLastMagnetometerSet = true;
        }
        if (mLastAccelerometerSet && mLastMagnetometerSet) {
            SensorManager.getRotationMatrix(rMat, null, mLastAccelerometer, mLastMagnetometer);
            SensorManager.getOrientation(rMat, orientation);
            mAzimuth = (int) (Math.toDegrees(SensorManager.getOrientation(rMat, orientation)[0]) + 360) % 360;
        }

        mAzimuth = Math.round(mAzimuth);
        compass.setRotation(brng-mAzimuth);

        if( ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION)
                != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION)
                != PackageManager.PERMISSION_GRANTED) {

            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION}, REQUEST_LOCATION);

        } else {
            Location location = locationManager.getLastKnownLocation(LocationManager.NETWORK_PROVIDER);

            if (location != null){
                double lat1 = location.getLatitude();
                double lon1 = location.getLongitude();
                double elev = location.getAltitude()*3.28084;

              //  Log.i("la", Double.toString(lat2));
            //    Log.i("lo", Double.toString(lon2));
                ((TextView)findViewById(R.id.textViewLat)).setText(""+lat1);
                ((TextView)findViewById(R.id.textViewLong)).setText(""+lon1);
                ((TextView)findViewById(R.id.textViewElev)).setText(String.format("%.0f", elev) +" feet");
               // double dLon = lon2 - lon1;
             //   double dLat = lat2 - lat1;
                double R = 6371e3; // metres
                double φ1 = lat1*3.14159/180;
                double φ2 = lat2*3.14159/180;
                double λ1 = lon1*3.14159/180;
                double λ2 = lon2*3.14159/180;
                double Δφ = (lat2-lat1)*3.14159/180;
                double Δλ = (lon2-lon1)*3.14159/180;
                double a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
                        Math.cos(φ1) * Math.cos(φ2) *
                                Math.sin(Δλ/2) * Math.sin(Δλ/2);
                double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

                double d = R * c;

                //bearing

                double y = Math.sin(λ2-λ1) * Math.cos(φ2);
                double x = Math.cos(φ1)*Math.sin(φ2) -
                        Math.sin(φ1)*Math.cos(φ2)*Math.cos(λ2-λ1);
                brng = (float) (Math.atan2(y, x)*180/3.14159);




                Log.i("lo", Double.toString(brng));

                if (d>1000){
                    d=d/1000;
                    double radiansBearing = atan2(y, x);
                    dist.setText(String.format("%.2f", d)+" Kilometers Away");

                }
                else {
                    double radiansBearing = atan2(y, x);
                    dist.setText(String.format("%.2f", d) + " Meters Away");
                }


            } else {
                ((TextView)findViewById(R.id.textViewLat)).setText("error");
                ((TextView)findViewById(R.id.textViewLong)).setText("error");
                ((TextView)findViewById(R.id.textViewElev)).setText("error");

            }
        }



    }


    public void bearing() {
        if (mSensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR) == null) {
            if ((mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER) == null) || (mSensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD) == null)) {
                noSensorsAlert();
            }
            else {
                mAccelerometer = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
                mMagnetometer = mSensorManager.getDefaultSensor(Sensor.TYPE_MAGNETIC_FIELD);
                haveSensor = mSensorManager.registerListener(this, mAccelerometer, SensorManager.SENSOR_DELAY_UI);
                haveSensor2 = mSensorManager.registerListener(this, mMagnetometer, SensorManager.SENSOR_DELAY_UI);
            }
        }
        else{
            mRotationV = mSensorManager.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR);
            haveSensor = mSensorManager.registerListener(this, mRotationV, SensorManager.SENSOR_DELAY_UI);
        }
    }

    public void noSensorsAlert(){
//        AlertDialog.Builder alertDialog = new AlertDialog.Builder(this);
//        alertDialog.setMessage("Your device doesn't support the Compass.")
//                .setCancelable(false)
//                .setNegativeButton("Close",new DialogInterface.OnClickListener() {
//                    public void onClick(DialogInterface dialog, int id) {
//                        finish();
//                    }
//                });
//        alertDialog.show();
    }

    public void stop() {
        if(haveSensor && haveSensor2){
            mSensorManager.unregisterListener(this,mAccelerometer);
            mSensorManager.unregisterListener(this,mMagnetometer);
        }
        else{
            if(haveSensor)
                mSensorManager.unregisterListener(this,mRotationV);
        }
    }

    @Override
    protected void onPause() {
        super.onPause();
        stop();
    }

    @Override
    protected void onResume() {
        super.onResume();
        bearing();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);

        switch (requestCode) {
            case REQUEST_LOCATION:
                bearing();
                break;
        }
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {

    }


    }

