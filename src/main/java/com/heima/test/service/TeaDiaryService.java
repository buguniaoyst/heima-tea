package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.TeaDiary;
import com.heima.test.domain.User;
import com.heima.test.utils.DateUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class TeaDiaryService extends BaseService<TeaDiary>{
    public List<TeaDiary> queryListByUserName(User user) {
        Example example = new Example(TeaDiary.class);
        example.createCriteria().andEqualTo("creater", user.getUserName());
        return this.getMapper().selectByExample(example);
    }

    public List<TeaDiary> queryTeaDiaryByNow() {
        Example example = new Example(TeaDiary.class);
        example.createCriteria().andEqualTo("date", DateUtils.getCurrentDate());
        return this.getMapper().selectByExample(example);
    }

    public List<TeaDiary> queryTeaDiaryByExample(Integer courseModuleId, Integer createrId, String fromDate, String endDate) {
        Example example = new Example(TeaDiary.class);
        Example.Criteria criteria = example.createCriteria();
        if(null!= courseModuleId && courseModuleId!=0){
            criteria.andEqualTo("courseModuleId",courseModuleId);
        }
        if(null != createrId && createrId != 0){
            criteria.andEqualTo("createrId", createrId);
        }

        if(StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(endDate)){
            criteria.andBetween("date", fromDate, endDate);
        }else if(StringUtils.isBlank(fromDate) && StringUtils.isNotBlank(endDate)){
            criteria.andLessThanOrEqualTo("date", endDate);
        }else if(StringUtils.isNotBlank(fromDate) && StringUtils.isBlank(endDate)){
            criteria.andGreaterThanOrEqualTo("date", fromDate);
        }


        return  this.getMapper().selectByExample(example);
    }
}
