package com.heima.test.web;

import com.heima.test.domain.ClassInfo;
import com.heima.test.domain.ItemInfo;
import com.heima.test.domain.TestSource;
import com.heima.test.domain.User;
import com.heima.test.service.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("test_source")
public class TestSourceController {

    //注入TestSourceService
    @Autowired
    private TestSourceService testSourceService;

    @Autowired
    private ItemInfoService itemInfoService;

    @Autowired
    private UserService userService;


    @Autowired
    private StudentInfoService studentInfoService;


    @Autowired
    private ClassInfoService classInfoService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getTestSourceList() {
        List<TestSource> testSourceList = testSourceService.queryAvailableTestSources();
        Map<String, Object> results = new HashMap<>();
        results.put("pagesize",20);
        results.put("results", testSourceList);
        return results;
    }


    @RequestMapping(value = "createTestForStudent",method = RequestMethod.POST)
    public String createTestForStudent(ClassInfo classInfo) {
        System.out.println(classInfo);
        //根据classid和testid做幂等
        ClassInfo exitClassInfo = this.classInfoService.queryClassInfoByClassId(classInfo);
        //根据classId将userinfo中的testId和testStatus
        User user = new User();
        user.setClassId(classInfo.getId()+"");
        user.setTestId(classInfo.getTestId());
        user.setTestStatus(1);
        userService.updateTeststatusByClassId(user);
        if (exitClassInfo == null) {
            //新增
            classInfoService.save(classInfo);
        }else{
            //根据classId更新
            classInfoService.updatClassInfoByClassId(classInfo);
        }
        return "redirect:/rest/show_test_source?id=" + classInfo.getId();
    }


    @RequestMapping(value = "queryTestSourceByClassId",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> queryTestSourceByClassNo(ClassInfo classInfo) {
        //获取classinfo
        ClassInfo classInfo1 = this.classInfoService.queryClassInfoByClassId(classInfo);

        TestSource testSource = testSourceService.queryByTestId(classInfo1.getTestId());
        Map<String, Object> result = new HashMap<>();
        result.put("classinfo", classInfo1);
        result.put("testinfo", testSource);
        //将试卷和学员关联（根据classid更新testid）
        studentInfoService.associateTestWithSutdent(classInfo1, testSource);
        return result;
    }



    //根据登录学员的testid,将学员和试卷关联
    @RequestMapping(value = "showStuTest",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> showStuTest(HttpSession session){
        User user = (User) session.getAttribute("loginUser");

        //判断跟这个学员关联的试卷是否已经结束
        if(null != user && user.getTestStatus() == 0){
            return null;
        }

        //根据user中的testid查询试卷信息
        TestSource testSource = testSourceService.selectTestSourceByTestId(user);

        List<Object> itemsIds = new ArrayList<>();
        //根据testSource中的testItems查询出试卷中具体的题目
        if(null != testSource && StringUtils.isNotBlank(testSource.getTestItems())){
            String[] strs = testSource.getTestItems().split(",");
            for (int i = 0; i < strs.length; i++) {
                itemsIds.add(strs[i]);
            }

        }
        List<ItemInfo> itemInfoList = itemInfoService.queryByIds(ItemInfo.class, itemsIds);
        //封装数据
        Map<String, Object> result = new HashMap<>();
        result.put("testSource", testSource);
        result.put("itemInfoList", itemInfoList);
        return result;
    }


    @RequestMapping(value = "getTestSourceById",method = RequestMethod.GET)
    @ResponseBody
    public TestSource getTestSourceById(TestSource testSource) {
        return testSourceService.getTestSourceById(testSource.getId());
    }

}
