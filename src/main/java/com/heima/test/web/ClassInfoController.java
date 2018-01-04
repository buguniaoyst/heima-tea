package com.heima.test.web;

import com.heima.test.domain.ClassInfo;
import com.heima.test.service.ClassInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("class")
public class ClassInfoController {

    //注入classInfoService
    @Autowired
    private ClassInfoService classInfoService;

    @RequestMapping("classList")
    @ResponseBody
    public Map<String,Object> classinfoList(){
        //封装数据
        Map<String, Object> results = new HashMap<>();
        List<ClassInfo> classInfoList = classInfoService.queryAll();
        results.put("pagesize", 100);
        results.put("results", classInfoList);
        return  results;
    }


    @RequestMapping(value = "addClass",method = RequestMethod.POST)
    public String addClass(ClassInfo classInfo) {
        classInfoService.save(classInfo);
        return "redirect:/rest/class_info/classinfo_list";
    }


    @RequestMapping(value = "queryClassById",method = RequestMethod.POST)
    @ResponseBody
    public ClassInfo queryClassById(ClassInfo classInfo) {
        ClassInfo classInfo1 = classInfoService.queryClassInfoById(classInfo.getId());
        return  classInfo1;
    }


    @RequestMapping(value = "editClass",method = RequestMethod.POST)
    public String editClassById(ClassInfo classInfo){
        classInfoService.updateSelectiveById(classInfo);
        return "redirect:/rest/class_info/classinfo_list";
    }


    @RequestMapping(value = "queryClassHasTest",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> queryClassHasTest() {
        Map<String, Object> result = new HashMap<>();
        List<ClassInfo> classInfoList = classInfoService.queryClassHasTest();
        result.put("pagesize", 30);
        result.put("results", classInfoList);
        return result;
    }




}
