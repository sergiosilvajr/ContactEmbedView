package com.viewutils.sergiosilvajr.views.utils;

import android.graphics.Color;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * Created by luissergiodasilvajunior on 19/02/16.
 */
public class ColorUtils {
    public static int getRandomColor(){
        List<Integer> colors = new ArrayList<>();
        colors.add(Color.BLACK);
        colors.add(Color.RED);
        colors.add(Color.GREEN);
        colors.add(Color.BLUE);
        colors.add(Color.YELLOW);
        colors.add(Color.GRAY);
        colors.add(Color.MAGENTA);
        colors.add(Color.CYAN);
        colors.add(Color.LTGRAY);
        return colors.get(new Random().nextInt(colors.size()));
    }
}
