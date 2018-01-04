package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.CourseModule;
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
public class CourseModuleService extends  BaseService<CourseModule>{
    public List<CourseModule> queryCourseByClassType(Integer classType) {
        Example example = new Example(CourseModule.class);
        example.createCriteria().andEqualTo("classType", classType);
        return this.getMapper().selectByExample(example);
    }
}
