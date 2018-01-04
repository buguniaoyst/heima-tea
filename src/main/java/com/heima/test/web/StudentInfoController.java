package com.heima.test.web;

import com.heima.test.domain.StudentInfo;
import com.heima.test.service.StudentInfoService;
import com.heima.test.utils.ImportExcelUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
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
@RequestMapping("student")
public class StudentInfoController {

    @Autowired
    private StudentInfoService studentInfoService;

    @RequestMapping(value = "queryStudentByClassId",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryStudentByClassId(@RequestParam("classId") Integer classId) {
        //根据calssId查询学生信息
        Map<String, Object> result = new HashMap<>();
        List<StudentInfo> studentInfoList = studentInfoService.queryStudentInfoListByClassId(classId);
        result.put("pagesize", 50);
        result.put("results", studentInfoList);
        return result;
    }


    @RequestMapping(value = "addStudentInfo",method = RequestMethod.POST)
    public String addStudentInfo(StudentInfo studentInfo) {
        studentInfoService.save(studentInfo);
        return "redirect:/rest/stu_info/stuinfo_list?classId="+studentInfo.getClassId();
    }


    @RequestMapping(value = "queryStudentInfoById",method = RequestMethod.POST)
    @ResponseBody
    public StudentInfo queryStudentInfoById(@RequestParam("id") Integer id) {
        StudentInfo studentInfo = studentInfoService.queryStudentInfoById(id);
        return studentInfo;
    }


    @RequestMapping(value = "editStudent",method = RequestMethod.POST)
    public String editStudent(StudentInfo studentInfo) {
        studentInfoService.updateSelectiveById(studentInfo);
        return "redirect:/rest/stu_info/stuinfo_list?classId="+studentInfo.getClassId();
    }


    @RequestMapping(value = "importStudentInfo",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> importStudentInfo(MultipartFile excelFile, HttpServletRequest request, Integer classId) {
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
            studentInfoService.importStudentInfoExcel(listob,classId);
        }

        result.put("result", true);
        result.put("data",listob);
        return  result;
    }



}
