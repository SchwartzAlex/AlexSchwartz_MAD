package com.example.alex.lab6;

/**
 * Created by Alex on 11/30/17.
 */

public class SkatePark {
    private String skatePark;
    private String skateParkURL;
    private String skateParkImage;


    private void setSkateParkInfo(Integer style){
        switch (style){
            case 0: //street
                skatePark="Broomfield Skate Park";
                skateParkURL="https://www.google.com/maps/place/Broomfield+Skate+Park/@39.9166979,-105.0649625,17z/data=!3m1!4b1!4m5!3m4!1s0x876b8a4460fae031:0xaaeb3b810ae71fec!8m2!3d39.9166938!4d-105.0627738";
                skateParkImage = "zero";
                break;
            case 1: //vert
                skatePark="Boulder Skate Park";
                skateParkURL="https://www.google.com/maps/place/Skate+Park+at+Scott+Carpenter+Park,+1505+30th+St,+Boulder,+CO+80303/@40.0133856,-105.2564449,17z/data=!3m1!4b1!4m5!3m4!1s0x876bedc55ea12cc7:0x1162add67f8773a1!8m2!3d40.0133395!4d-105.2543145";
                skateParkImage = "one";
                break;
            case 2: //combined
                skatePark="Northglenn Skate Park";
                skateParkURL="https://www.google.com/maps/place/Don+Anema+Memorial+Skatepark/@39.9081145,-104.9858783,17z/data=!3m1!4b1!4m5!3m4!1s0x876c742d11264ad3:0x8d77d46db58b95f1!8m2!3d39.9081104!4d-104.9836896";
                skateParkImage = "two";
                break;
            case 3: //park
                skatePark="Arvada Skate Park";
                skateParkURL="https://www.google.com/maps/place/Arvada+Skatepark/@39.8261199,-105.1453594,17z/data=!3m1!4b1!4m5!3m4!1s0x876b8f3c821c022d:0xa87dce83971e038c!8m2!3d39.8261158!4d-105.1431707";
                skateParkImage = "three";
                break;
            case 4: //freestyle
                skatePark="Lafayette Skate Park";
                skateParkURL="https://www.google.com/maps/place/Lafayette+Skatepark/@40.0020425,-105.0907405,15z/data=!4m5!3m4!1s0x0:0x79558089869067f3!8m2!3d40.0020425!4d-105.0907405";
                skateParkImage = "four";
                break;
            default:
                skatePark="none";
                skateParkURL="https://www.youtube.com/watch?v=dQw4w9WgXcQ";
        }
    }

    public void setSkatePark(Integer style) {
        setSkateParkInfo(style);
    }
    public void setSkateParkURL(Integer style){
        setSkateParkInfo(style);
    }
    public void setSkateParkImage(Integer style){
        setSkateParkInfo(style);
    }
    public String getSkateParkImage(){
        return skateParkImage;
    }
    public String getSkatePark(){
        return skatePark;
    }
    public String getSkateParkURL(){
        return skateParkURL;
    }

}
