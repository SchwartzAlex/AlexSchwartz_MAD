package com.example.alex.wayfinder;

/**
 * Created by Alex on 12/12/17.
 */

public class Locations {
    String place;
    double latitude;
    double longitude;

    public Locations(String place, double latitude, double longitude) {
        this.place = place;
        this.latitude = latitude;
        this.longitude = longitude;

}
    @Override
    public String toString() {
        return place;
    }

    public String getPlace(){
        return place;
    }
    public double getLat(){
        return latitude;
    }
    public double getLong(){
        return longitude;
    }
}
