package com.heima.test.web;

import com.heima.test.domain.TeaReport;
import com.heima.test.service.TeaReportService;
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
@RequestMapping("tea_report")
public class TeaReportController {

    //注入TeaReportService
    @Autowired
    private TeaReportService reportService;

    /**
     * 加载研讨内容
     * @return
     */
    @RequestMapping(value = "getTeaReportList",method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getTeaReportList(Integer reportType) {
        List<TeaReport> reportList = reportService.queryTeaReportByExample(reportType);
        Map<String, Object> result = new HashMap<>();
        result.put("pagesize", 30);
        result.put("results", reportList);
        return result;
    }
}
