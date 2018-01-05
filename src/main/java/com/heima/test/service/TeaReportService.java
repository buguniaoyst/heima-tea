package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.TeaReport;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Service
@Transactional
public class TeaReportService extends  BaseService<TeaReport>{
    public List<TeaReport> queryTeaReportByExample(Integer reportType) {
        Example example = new Example(TeaReport.class);
        example.createCriteria().andEqualTo("reportType", reportType);
        return getMapper().selectByExample(example);
    }
}
