package com.heima.test.web;

import com.heima.test.domain.TeaDiary;
import com.heima.test.domain.User;
import com.heima.test.service.TeaDiaryService;
import com.sun.org.apache.regexp.internal.RE;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("diary")
public class TeaDiaryController {


    //注入TeaDiaryService
    @Autowired
    private TeaDiaryService teaDiaryService;



    @RequestMapping(value = "addTeaDiary",method = RequestMethod.POST)
    public String addTeaDiary(TeaDiary teaDiary, HttpSession session) {

        //从session中获取登录信息
        User user = (User) session.getAttribute("loginUser");
        if(null == user){
            return "redirect:/rest/login";
        }

        teaDiary.setDate(new Date());
        teaDiary.setDiaryNo("000");
        teaDiary.setCreater(user.getUserName());
        teaDiary.setCreaterId(user.getId());
        teaDiaryService.save(teaDiary);
        return  "redirect:/rest/tea_diary/tea_diary_list";
    }


    @RequestMapping(value = "queryDiaryList",method = RequestMethod.GET)
    @ResponseBody
    public List<TeaDiary> queryDiaryList(HttpSession session) {
        User user = (User) session.getAttribute("loginUser");
        if (null == user) {
            return null;
        }else if(null != user && 1 ==user.getUserType()){
            //根据助教id查询
            return teaDiaryService.queryListByUserName(user);
        }
        return  teaDiaryService.queryAll();
    }


    @RequestMapping(value = "queryTeaDiaryByNow",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryTeaDiaryByNow() {
        List<TeaDiary> teaDiaryList = teaDiaryService.queryTeaDiaryByNow();
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize",20);
        result.put("results", teaDiaryList);
        return  result;
    }


    @RequestMapping(value = "getDiaryListByExample",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getDiaryListByExample(@RequestParam(value = "courseModuleId",required = false,defaultValue = "0") Integer courseModuleId,
                                                     @RequestParam(value = "createrId",required = false,defaultValue = "0") Integer createrId,
                                                     @RequestParam(value = "fromDate",required = false,defaultValue = "") String fromDate,
                                                     @RequestParam(value = "endDate",required = false,defaultValue = "") String endDate) {
        List<TeaDiary> teaDiaryList = teaDiaryService.queryTeaDiaryByExample(courseModuleId, createrId, fromDate, endDate);
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize",50);
        result.put("results", teaDiaryList);

        return result;
    }


    @RequestMapping(value = "exportDiaryList",method = RequestMethod.POST)
    public ModelAndView exportDiaryList(@RequestParam(value = "courseModuleId",required = false,defaultValue = "0") Integer courseModuleId,
                                        @RequestParam(value = "createrId",required = false,defaultValue = "0") Integer createrId,
                                        @RequestParam(value = "fromDate",required = false,defaultValue = "") String fromDate,
                                        @RequestParam(value = "endDate",required = false,defaultValue = "") String endDate) {

        List<TeaDiary> teaDiaryList = teaDiaryService.queryTeaDiaryByExample(courseModuleId, createrId, fromDate, endDate);
        ModelAndView mv = new ModelAndView("teaDiaryExcelView");
        mv.addObject("teaDiaryList",teaDiaryList);
        return mv;
    }



    @RequestMapping(value = "getDiaryById",method = RequestMethod.GET)
    @ResponseBody
    public TeaDiary getDiaryById(@RequestParam("id") Integer diaryId){
        TeaDiary teaDiary = teaDiaryService.getMapper().selectByPrimaryKey(diaryId);
        return  teaDiary;
    }


    @RequestMapping(value = "editDiaryById",method = RequestMethod.POST)
    public String editDiaryById(TeaDiary teaDiary) {
        System.out.println(teaDiary);
        teaDiaryService.getMapper().updateByPrimaryKeySelective(teaDiary);
        return "redirect:/rest/tea_diary/tea_diary_list";
    }



}
