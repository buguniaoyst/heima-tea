package com.heima.test.web;

import com.github.abel533.entity.Example;
import com.heima.test.domain.*;
import com.heima.test.service.*;
import com.heima.test.utils.CommonUtils;
import com.heima.test.utils.ScoreUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import sun.misc.Request;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("test")
public class TestController {


    //注入service
    @Autowired
    private TestService testService;

    @Autowired
    private TestInfoService testInfoService;

    @Autowired
    private UserService userService;

    @Autowired
    private AnswerInfoService answerInfoService;

    @Autowired
    private ItemInfoService itemInfoService;

    @Autowired
    private TestSourceService testSourceService;


    @Autowired
    private StudentInfoService studentInfoService;

    @Autowired
    private ClassInfoService classInfoService;






    @RequestMapping("addTest")
    public ModelAndView addTest(TestCtrl testInfo, HttpServletRequest request) {
        System.out.println("test testAdd");
        testInfo.setTestId("");
        ModelAndView md = new ModelAndView("test_info");
        String ipAddr = CommonUtils.getIpAddress(request);
        md.addObject("testinfo",ipAddr+"/rest/register.jsp?classid=");
        //保存之前根据testid做幂等
        TestCtrl exitTestCtrl = testService.queryListByExample(testInfo);
        if(null != exitTestCtrl){
            //将试卷开启
            exitTestCtrl.setTestStatus("开启");
           testService.updateSelectiveById(exitTestCtrl);
            return md;
        }
        testInfo.setTestStatus("开启");
        testService.saveTestInfo(testInfo);
        return md;
    }


    @RequestMapping("listTest")
    @ResponseBody
    public Map<String, Object> listTest() {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        List<TestCtrl> testCtrls = testService.queryOrderByTestStatus();
        resultMap.put("pagesize", 10);
        resultMap.put("results", testCtrls);
        return  resultMap;
    }


    @RequestMapping("submit")
    public ModelAndView  submitTest(HttpSession session, TestInfo testInfo){
        //先判断是否登录
        StudentInfo studentInfo = (StudentInfo) session.getAttribute("loginUser");
        if(null == studentInfo){
            return new ModelAndView("login","message","请输入正确的用户名和密码");
        }
        //获取testid
        String testid = studentInfo.getClassId()+"";
        Double score = null;
        if(StringUtils.isNotBlank(testid)){
            if(testid.endsWith("0")){
                 score = ScoreUtils.getPrimaryScore(testInfo);
            }else{
                score = ScoreUtils.getSeniorScore(testInfo);
            }
        }
        testInfo.setTotalScore(score);
        testInfo.setUsername(studentInfo.getStudentName());
        testInfo.setTestid(studentInfo.getTestId()+"");
        testInfo.setClassId(studentInfo.getClassId());
        //防止重复提交
        TestInfo testInfoParam = new TestInfo();
        testInfoParam.setUsername(studentInfo.getStudentName());
        testInfoParam.setTestid(studentInfo.getTestId()+"");
        List<TestInfo> testInfos = testInfoService.queryListByWhere(testInfoParam);
        ModelAndView mv = new ModelAndView("score_info");
        mv.addObject("user", studentInfo);
        mv.addObject("testinfo", testInfo);
        if(null != testInfos && testInfos.size()>0){
            return mv;
        }
        testInfoService.save(testInfo);
        return  mv;
    }


    @RequestMapping("stopTest")
    public String stopTest(TestCtrl testCtrl) {
        //根据testid查询对应的试卷
        TestCtrl testCtrl1 = testService.queryTestCtrlByClassIdAndTestId(testCtrl.getTestId(),testCtrl.getClassId());
        if(null != testCtrl1){
            testCtrl.setId(testCtrl1.getId());
            testCtrl.setTestStatus("已关闭");
            testService.updateSelectiveById(testCtrl);
        }
        return "redirect:/rest/testctrl_list";
    }

    @RequestMapping("startTest")
    public String startTest(TestCtrl testCtrl) {
        //根据testid查询对应的试卷
        TestCtrl testCtrl1 = testService.queryOne(testCtrl);
        if(null != testCtrl1){
            testCtrl.setId(testCtrl1.getId());
            testCtrl.setTestStatus("开启");
            testService.updateSelectiveById(testCtrl);
        }
        return "redirect:/rest/testctrl_list";
    }


    @RequestMapping(value = "scoreList")
    @ResponseBody
    public Map<String, Object> getFinishedTest(){
        TestCtrl testCtrl = new TestCtrl();
        testCtrl.setTestStatus("已关闭");
        List<TestCtrl> testCtrlList = testService.queryFinishedTestByExample(testCtrl);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("pagesize", 10);
        resultMap.put("results", testCtrlList);
        return resultMap;
    }

    @RequestMapping(value = "showScoreDetail")
    @ResponseBody
    public Map<String, Object> showScoreDetail(TestCtrl testCtrl){
        TestInfo testInfo = new TestInfo();
        testInfo.setTestid(testCtrl.getTestId());
        List<TestInfo> testInfoList = testInfoService.queryListByExample(testInfo);
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("pagesize", 50);
        resultMap.put("results", testInfoList);
        return resultMap;
    }


    @RequestMapping(value = "exportScoreList",method = RequestMethod.POST)
    public ModelAndView exportScoreListByTestid(TestCtrl testCtrl) {
        TestInfo testInfo = new TestInfo();
        testInfo.setTestid(testCtrl.getTestId());
        ModelAndView mv = new ModelAndView("excelView");
        mv.addObject("scoreList",testInfoService.queryListByExample(testInfo));
        return mv;
    }


    @RequestMapping(value = "piyueTest",method = RequestMethod.GET)
    @ResponseBody
    public Map<Object,Object> piyueTest(@RequestParam("classId") Integer classId, @RequestParam("testId")Integer testId, @RequestParam("stuId")Integer stuId){
        System.out.println(classId+","+testId+","+stuId);
        //根据stuId和classId 查询学员信息
        StudentInfo studentInfo = studentInfoService.getMapper().selectByPrimaryKey(stuId);
        //根据testId 查询testSource信息
        TestSource testSource = testSourceService.queryTestSoueceByTestId(testId);

        //根据classId,testId,stuId查询答案信息
        List<AnswerInfo> answerInfoList = answerInfoService.queryAnswerInfoListByClassIdAndTestIdAndStuId(classId, testId, stuId);
        Map<Object, Object> result = new HashMap<>();
        if (null != answerInfoList && answerInfoList.size() > 0) {
            result.put("answerInfoList", answerInfoList);
        }
        result.put("testSourceInfo", testSource);
        result.put("student", studentInfo);
        return result;
    }


    @RequestMapping(value = "createFirstTest",method = RequestMethod.POST)
    @ResponseBody
    public Boolean createFirstTest(Integer classType,Integer classId,String className) {
        //根据classType和classId查询班级信息
        List<ClassInfo> classInfoList = classInfoService.queryClassInfoByClassTypeAndClassId(classType, classId);
        TestCtrl testCtrl = new TestCtrl();
        if (null != classInfoList && classInfoList.size() > 0) {
            ClassInfo classInfo = classInfoList.get(0);
            StudentInfo studentInfo = new StudentInfo();
            if(classInfo.getClassType() == 0){
                //安排基础班开班考试
                classInfo.setTestId("1000");
                classInfoService.getMapper().updateByPrimaryKeySelective(classInfo);
                studentInfo.setTestStatus(1);
                studentInfo.setTestId(1000);
                testCtrl.setClassTestNo("0");
            }else if(classInfo.getClassType() == 1) {
                //安排就业班开班考试
                classInfo.setTestId("1001");
                classInfoService.getMapper().updateByPrimaryKeySelective(classInfo);
                studentInfo.setTestStatus(1);
                studentInfo.setTestId(1001);
                testCtrl.setClassTestNo("1");
            }

            Example example = new Example(StudentInfo.class);
            example.createCriteria().andEqualTo("classId", classId);
            studentInfoService.getMapper().updateByExampleSelective(studentInfo, example);

            //testCtrl中插入考试记录

            testCtrl.setTestStatus("开启");
            testCtrl.setTestId(studentInfo.getTestId() + "");
            testCtrl.setClassType(classType+"");
            testCtrl.setClassName(className);
            testCtrl.setClassId(classId);
            testService.save(testCtrl);

        }

        return true;
    }



}
