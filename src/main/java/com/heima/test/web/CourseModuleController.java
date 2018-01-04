package com.heima.test.web;

import com.heima.test.domain.CourseModule;
import com.heima.test.service.CourseModuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequestMapping("course")
public class CourseModuleController {

    //注入courseModuleService
    @Autowired
    private CourseModuleService courseModuleService;

    /**
     * 列表查询课程模块
     * @return
     */
    @RequestMapping(value = "getCourseModuleList",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getCourseModuleList() {
        Map<String, Object> result = new HashMap<>();
        List<CourseModule> courseModules = courseModuleService.queryAll();
        result.put("pagesize", 50);
        result.put("results", courseModules);
        return result;
    }


    @RequestMapping(value = "addCourseModule",method = RequestMethod.POST)
    public String addCourseModule(CourseModule courseModule) {
        if(null != courseModule && courseModule.getClassType()==0){
            courseModule.setClassTypeName("基础班");
        }else{
            courseModule.setClassTypeName("就业班");
        }

        courseModuleService.save(courseModule);
        return  "redirect:/rest/course_info/courseinfo_list";
    }


    @RequestMapping(value = "getCourseModuleByClassType",method = RequestMethod.GET)
    @ResponseBody
    public List<CourseModule> getCourseModuleByClassType(@RequestParam("classType") Integer classType) {
        return courseModuleService.queryCourseByClassType(classType);
    }








}
