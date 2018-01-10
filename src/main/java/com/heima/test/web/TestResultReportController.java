package com.heima.test.web;

import com.github.abel533.mapper.Mapper;
import com.heima.test.domain.TestResultReport;
import com.heima.test.service.TestResultReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
@RequestMapping("test_result_report")
public class TestResultReportController {

    @Autowired
    private TestResultReportService testResultReportService;

    @RequestMapping(value = "list",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getTestResultReportList() {
        List<TestResultReport> testResultReportList = testResultReportService.queryAll();
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize", "30");
        result.put("results", testResultReportList);
        return result;
    }
}
