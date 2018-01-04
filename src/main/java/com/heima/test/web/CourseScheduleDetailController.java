package com.heima.test.web;

import com.heima.test.domain.CourseScheduleDetail;
import com.heima.test.domain.InfoVo;
import com.heima.test.service.CourseScheduleDetailService;
import com.heima.test.service.CourseScheduleService;
import com.heima.test.utils.ImportExcelUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Controller
@RequestMapping("course_schedule_detail")
public class CourseScheduleDetailController {

    //注入courseScheduleDetailService
    @Autowired
    private CourseScheduleDetailService courseScheduleDetailService;


    @RequestMapping(value = "getCourseScheduleDetailByBaseId",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getCourseScheduleDetailByBaseId(@RequestParam("baseId") Integer baseId) {
        //根据baseID查询课程表详情  按照日期排序
        List<CourseScheduleDetail> courseScheduleDetailList = courseScheduleDetailService.queryListByBaseIdOrderByClassDate(baseId);
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize", 100);
        result.put("results", courseScheduleDetailList);
        return result;
    }


    @RequestMapping(value = "getCourseScheduleDetailList",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getCourseScheduleDetailList() {
        //根据baseID查询课程表详情  按照日期排序
        List<CourseScheduleDetail> courseScheduleDetailList = courseScheduleDetailService.queryAll();
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize", 100);
        result.put("results", courseScheduleDetailList);
        return result;
    }



    @RequestMapping(value = "importCourseSchedule",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> importCourseScheduleDetail(MultipartFile excelFile, HttpServletRequest request, Integer baseId,String className) {
        Map<String, Object> result = new HashMap<>();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;

        System.out.println("通过 jquery.form.js 提供的ajax方式上传文件！");

        InputStream in =null;
        List<List<Object>> listob = null;
        MultipartFile file = excelFile;
        if(file.isEmpty()){
            result.put("result", "文件不存在");
            return  result;
        }

        try {
            in = file.getInputStream();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            listob = new ImportExcelUtils().getBankListByExcel(in,file.getOriginalFilename());
            System.out.println(listob);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        if (null != listob && listob.size() > 0) {
            //封装数据
            courseScheduleDetailService.importCourseScheduleExcel(listob,baseId,className);
        }



        result.put("result", true);
        result.put("data",listob);
        return  result;
    }


    @RequestMapping(value = "getScheduleByExample",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getScheduleByExample(@RequestParam(value = "assistant",required = false,defaultValue = "") String assistant,
                                                    @RequestParam(value = "teacherName",required = false,defaultValue = "") String teacherName,
                                                    @RequestParam(value = "fromDate",required = false,defaultValue = "") String fromDate,
                                                    @RequestParam(value = "endDate",required = false,defaultValue = "") String endDate) {
        List<CourseScheduleDetail> scheduleDetails = courseScheduleDetailService.queryListByExample(assistant, teacherName, fromDate, endDate);
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize", 50);
        result.put("results", scheduleDetails);
        return result;
    }


    /**
     * @RequestParam(value = "assistant",required = false,defaultValue = "") String assistant,
     @RequestParam(value = "teacherName",required = false,defaultValue = "") String teacherName,
     @RequestParam(value = "fromDate",required = false,defaultValue = "") String fromDate,
     @RequestParam(value = "endDate",required = false,defaultValue = "") String endDate
     * @return
     */
    @RequestMapping(value = "exportCourseScheduleList",method = RequestMethod.POST)
    public ModelAndView exportCourseScheduleList(HttpServletRequest request) {
        String assistant = request.getParameter("assistant");
        String teacherName = request.getParameter("teacherName");
        String fromDate = request.getParameter("fromDate");
        String endDate = request.getParameter("endDate");
        try {
            if (StringUtils.isNotBlank(assistant)) {
                assistant = new String(assistant.getBytes("ISO-8859-1"), "UTF-8");
            }
            if (StringUtils.isNotBlank(teacherName)) {
                teacherName = new String(teacherName.getBytes("ISO-8859-1"), "UTF-8");
            }
            if (StringUtils.isNotBlank(fromDate)) {
                fromDate = new String(fromDate.getBytes("ISO-8859-1"), "UTF-8");
            }
            if (StringUtils.isNotBlank(endDate)) {
                endDate = new String(endDate.getBytes("ISO-8859-1"), "UTF-8");
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        List<CourseScheduleDetail> courseScheduleDetailList = courseScheduleDetailService.queryListByExample(assistant, teacherName, fromDate, endDate);
        ModelAndView mv = new ModelAndView("courseSchedulDetailExcelView");
        mv.addObject("courseScheduleDetailList",courseScheduleDetailList);
        return mv;

    }


    @RequestMapping(value = "generateAssistantSchedule", method = RequestMethod.POST)
    public ModelAndView generateAssistantSchedule(HttpServletRequest request) {

        String assistant = request.getParameter("assistant");
        String teacherName = request.getParameter("teacherName");
        String fromDate = request.getParameter("fromDate");
        String endDate = request.getParameter("endDate");
        try {
            if (StringUtils.isNotBlank(assistant)) {
                assistant = new String(assistant.getBytes("ISO-8859-1"), "UTF-8");
            }
            if (StringUtils.isNotBlank(teacherName)) {
                teacherName = new String(teacherName.getBytes("ISO-8859-1"), "UTF-8");
            }
            if (StringUtils.isNotBlank(fromDate)) {
                fromDate = new String(fromDate.getBytes("ISO-8859-1"), "UTF-8");
            }
            if (StringUtils.isNotBlank(endDate)) {
                endDate = new String(endDate.getBytes("ISO-8859-1"), "UTF-8");
            }
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        List<CourseScheduleDetail> courseScheduleDetailList = courseScheduleDetailService.queryListByExample(assistant, teacherName, fromDate, endDate);
        ModelAndView mv = new ModelAndView("generateAssistantSchedulelExcelView");
        mv.addObject("courseScheduleDetailList",courseScheduleDetailList);
        return mv;
    }







}
