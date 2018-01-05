package com.heima.test.web;

import com.github.abel533.mapper.Mapper;
import com.heima.test.domain.AnswerInfo;
import com.heima.test.domain.TestSource;
import com.heima.test.domain.User;
import com.heima.test.service.AnswerInfoService;
import com.heima.test.service.TestSourceService;
import com.heima.test.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "answer")
public class AnswerInfoController {

    @Autowired
    private AnswerInfoService answerInfoService;

    @Autowired
    private TestSourceService testSourceService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "addAnswerInfo",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addAnswerInfo(@RequestParam(value = "answerInfo",required = false)String answerInfo, HttpSession session) {
        //获取登录用户信息
        User loginUser = (User) session.getAttribute("loginUser");

        Map<String, Object> result = new HashMap<>();
        if (null != loginUser ) {
            //将用户中关联的测试关闭
            //1.修改session中的teststatus
            loginUser.setTestStatus(0);
            session.setAttribute("loginUser", loginUser);
            //修改数据库中的状态
            userService.updateSelectiveById(loginUser);
            Boolean flag =  answerInfoService.addAnswerInfo(answerInfo,loginUser);
            result.put("result", flag);
        }else{
            result.put("result", false);
        }
        return  result;
    }

    @RequestMapping(value = "itemTestAnswerList",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getAnswerInfoList(HttpSession session) {

        Map<String, Object> result = new HashMap<>();
        //根据不同的用户角色 显示不同的答案信息
        User loginUser = (User) session.getAttribute("loginUser");
        List<AnswerInfo> answerInfoList = null;
        if(null != loginUser && 0 == loginUser.getUserType()){
            answerInfoList = answerInfoService.queryAnswerInfoListGroupByClassId();
        }else if (null != loginUser && 1 == loginUser.getUserType()){
            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(loginUser.getClassId());
        }
        result.put("pagesize", 100);
        result.put("results", answerInfoList);
        return  result;
    }


    @RequestMapping(value = "queryAnswerInfoListByClassId",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryAnswerInfoListByClassId(AnswerInfo answerInfo) {
        Map<String, Object> result = new HashMap<>();
        List<AnswerInfo> answerInfoList = null;
        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getClassId())){
            answerInfoList = answerInfoService.queryAnswerInfoListByClassId(answerInfo.getClassId());
        }
        result.put("pagesize", 10);
        result.put("results", answerInfoList);
        return  result;
    }


    /**
     * 根据classId和testId查询这个班级的这套试卷的答案
     * @param answerInfo
     * @return
     */
    @RequestMapping(value = "queryClassAnswerListByClassIdAndTestId",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> queryClassAnswerListByClassIdAndTestId(AnswerInfo answerInfo) {

        Map<String, Object> result = new HashMap<>();
        List<AnswerInfo> answerInfoList = answerInfoService.queryClassAnswerListByClassIdAndTestId(answerInfo);
        //根据testId 查询testSource信息
        if(null != answerInfo && StringUtils.isNotBlank(answerInfo.getTestId())){
            TestSource testSource = testSourceService.getTestSourceById(Integer.valueOf(answerInfo.getTestId()));
            result.put("testSourceInfo",testSource);
        }
        //根据classId和testId 查询testRecord

        result.put("results", answerInfoList);
        result.put("pagesize", 100);
        return  result;
    }


    @RequestMapping(value = "getZipDirs",method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getZipData(String zipPath) {
        Map<String, Object> result = new HashMap<>();
        if (StringUtils.isBlank(zipPath)) {
            result.put("results", false);
            return result;
        }
        try {
            return answerInfoService.getZipDirs(zipPath);
        } catch (Exception e) {
            e.printStackTrace();
            result.put("results", false);
            return result;
        }
    }


    @RequestMapping(value = "getFileContent",method = RequestMethod.POST)
    @ResponseBody
    public String getFileContent(String filePath) {
        if (StringUtils.isNotBlank(filePath)) {
           return answerInfoService.getFileContent(filePath);
        }
        return  null;

    }

}
