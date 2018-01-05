package com.heima.test.test;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
public class JavaTest {
//    public static void main(String[] args) {
//        String path = "F://test//1515042558306pro-info.zip";
//        System.out.println(path.lastIndexOf("//"));
//        System.out.println(path.length());
//        System.out.println(path.substring(10,35));
//    }


    public static void main(String[] args) throws Exception {
        String str = "F://test//5\\1515157844635\\pro-info.zip";
        byte[] bytes = str.getBytes("UTF-8");
        System.out.println(bytes);
        System.out.println(new String(str.getBytes(),"UTF-8"));
    }
}
