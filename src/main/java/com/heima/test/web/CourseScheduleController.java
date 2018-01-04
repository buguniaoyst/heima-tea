package com.heima.test.web;

import com.heima.test.domain.CourseSchedule;
import com.heima.test.domain.User;
import com.heima.test.service.CourseScheduleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 * 课程表
 */
@Controller
@RequestMapping("course_schedule")
public class CourseScheduleController {

    //注入courseScheduleService
    @Autowired
    private CourseScheduleService courseScheduleService;

    @RequestMapping(value = "queryCourseScheduleList",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryCourseScheduleList() {
        Map<String, Object> result = new HashMap<>();
        List<CourseSchedule> scheduleList = courseScheduleService.queryAll();
        result.put("pagesize", 20);
        result.put("results", scheduleList);
        return result;
    }


    @RequestMapping(value = "addCourseSchedule",method = RequestMethod.POST)
    public String addCourseSchedule(@RequestParam("className") String className,
                                    @RequestParam("endDate") Date endDate,
                                    @RequestParam("masterName") String masterName,
                                    HttpSession session) {

        User user = (User) session.getAttribute("loginUser");
        if (null == user) {
            return "redirect:/rest/login";
        }

        Integer classId = 0;
        String cName = "";
        if (StringUtils.isNotBlank(className)) {
            String[] strs = className.split(",");
            classId = Integer.valueOf(strs[0]);
            cName = strs[1];
        }

        //封装数据
        CourseSchedule courseSchedule = new CourseSchedule();
        courseSchedule.setEndDate(endDate);
        courseSchedule.setClassId(classId);
        courseSchedule.setClassName(cName);
        courseSchedule.setState(1);
        courseSchedule.setHasHonorsDay(1);
        courseSchedule.setMasterName(masterName);
        courseSchedule.setLastUpdateTime(new Date());
        courseSchedule.setLastUpdater(user.getUserName());

        courseScheduleService.save(courseSchedule);


        return "redirect:/rest/course_schedule/course_schedule";
    }


    @RequestMapping(value = "getCourseScheduleByExample",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getCourseScheduleByExample(@RequestParam("className") String className) {
        Map<String, Object> result = new HashMap<>();
        List<CourseSchedule> courseScheduleList = courseScheduleService.queryCourseScheduleByExample(className);
        result.put("pagesize", 20);
        result.put("results", courseScheduleList);
        return result;
    }




}
