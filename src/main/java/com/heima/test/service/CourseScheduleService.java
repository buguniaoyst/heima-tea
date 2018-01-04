package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.CourseSchedule;
import com.heima.test.domain.CourseScheduleDetail;
import org.apache.commons.lang3.StringUtils;
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
public class CourseScheduleService extends  BaseService<CourseSchedule>{
    public List<CourseSchedule> queryCourseScheduleByExample(String className) {
        Example example = new Example(CourseSchedule.class);
        Example.Criteria criteria = example.createCriteria();
        if(StringUtils.isNotBlank(className)){
            criteria.andLike("className", "%"+className+"%");
        }
        return this.getMapper().selectByExample(example);
    }


}
