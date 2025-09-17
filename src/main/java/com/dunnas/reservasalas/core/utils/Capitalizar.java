package com.dunnas.reservasalas.core.utils;

public class Capitalizar {
    public static String capitalizar(String str) {
        if (str == null || str.isEmpty()) {
            return str;
        }
        return str.substring(0, 1).toUpperCase() + str.substring(1).toLowerCase();
    }
}
