package com.heima.test.utils;

import javax.swing.plaf.synth.SynthOptionPaneUI;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 * 日期工具类
 */
public class DateUtils {

    public static  String  getCurrentDate() {
        //使用默认时区和语言环境获得一个日历。
        Calendar rightNow    =    Calendar.getInstance();
        /*用Calendar的get(int field)方法返回给定日历字段的值。
        HOUR 用于 12 小时制时钟 (0 - 11)，HOUR_OF_DAY 用于 24 小时制时钟。*/
        Integer year = rightNow.get(Calendar.YEAR);
        Integer month = rightNow.get(Calendar.MONTH)+1; //第一个月从0开始，所以得到月份＋1
        Integer day = rightNow.get(Calendar.DAY_OF_MONTH);
        System.out.println(year+"-"+month+"-"+day);
      return year+"-"+month+"-"+day;
    }


    public static String getStringDate(Date date) {
       return  new SimpleDateFormat("yyyy-MM-dd").format(date);
    }


    public static Date getDateFromStr(String s) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date parse = dateFormat.parse(s);
            return  parse;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return  null;

    }
}
