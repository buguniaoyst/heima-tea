package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.CourseScheduleDetail;
import com.heima.test.utils.DateUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Service
@Transactional
public class CourseScheduleDetailService extends  BaseService<CourseScheduleDetail>{
    public List<CourseScheduleDetail> queryListByBaseIdOrderByClassDate(Integer baseId) {
        Example example = new Example(CourseScheduleDetail.class);
        example.setOrderByClause("class_date asc");
        example.createCriteria().andEqualTo("baseId", baseId);
        return this.getMapper().selectByExample(example);
    }

    public void importCourseScheduleExcel(List<List<Object>> listob, Integer baseId, String className) {

        //先清除所有的课表数据再更新
        Example example = new Example(CourseScheduleDetail.class);
        example.createCriteria().andEqualTo("baseId", baseId);
        getMapper().deleteByExample(example);



        //将list中的数据封装到 CourseScheduleDetail中
        //基数 根据课程内容计算课程天数
        Integer daySort=1;
       for (int i = 0; i < listob.size(); i++) {
            List<Object> lo = listob.get(i);
            CourseScheduleDetail c= new CourseScheduleDetail();
            if(null != lo.get(0)){
                //开班日期
                Date classDate = DateUtils.getDateFromStr(String.valueOf(lo.get(0)));
                c.setClassDate(classDate);
                System.out.println(classDate);
                c.setWeekSort(Integer.valueOf(classDate.getDay()));
            }
            if(null != lo.get(1) && !"".equals(lo.get(1))){
                //课程内容
                c.setContent(String.valueOf(lo.get(1)));
                //如果有课程内容 则将hasHonorsDay赋值为1
                c.setHasHonorsDay(1);
            }else{
                c.setHasHonorsDay(0);
            }
            if(null != lo.get(2) && !"".equals(lo.get(2))){
                //是否大纲课程
               Integer isOutline = 0;
                if ("是".equals(String.valueOf(lo.get(2)))) {
                 isOutline = 1;
                 c.setDaySort(daySort++);
                 }else {
                 isOutline = 0;
                }
                c.setIsOutline(isOutline);
           }else{
                c.setIsOutline(0);
            }

           if(null != lo.get(3) && !"".equals(lo.get(3))){
                //授课模式
               String classMode = String.valueOf(lo.get(3));
               if("传统全天".equals(classMode)){
                   c.setClassMode(0);
               } else if ("AB上午".equals(classMode)) {
                   c.setClassMode(1);
               }else if("AB下午".equals(classMode)){
                   c.setClassMode(2);
               }else {
                   c.setClassMode(3);
               }
            }else {
               c.setClassMode(3);
           }

           if (null != lo.get(4) && !"".equals(lo.get(4))) {
               //教室名
               c.setClassRoomName(String.valueOf(lo.get(4)));
           }
           if (null != lo.get(5) && !"".equals(lo.get(5))) {
               //讲师名
               c.setTeacherName(String.valueOf(lo.get(5)));
           }
           if (null != lo.get(6) && !"".equals(lo.get(6))) {
               //讲师工号
               c.setJobNumber(String.valueOf(lo.get(6)));
           }
           if (null != lo.get(7) && !"".equals(lo.get(7))) {
               c.setAssistant(String.valueOf(lo.get(7)));
           }
           if(lo.size()>=9){
               if (null != lo.get(8) && !"".equals(lo.get(8))) {
                   c.setRemark(String.valueOf(lo.get(8)));
               }
           }
           c.setBaseId(baseId);
           c.setClassName(className);
           //保存数据
           save(c);
       }



    }


    /**
     * 组合条件查询
     * @param assistant
     * @param teacherName
     * @param fromDate
     * @param endDate
     * @return
     */
    public List<CourseScheduleDetail> queryListByExample( String assistant, String teacherName, String fromDate, String endDate) {
        Example example = new Example(CourseScheduleDetail.class);
        example.setOrderByClause("class_date asc");
        Example.Criteria criteria = example.createCriteria();

        if (StringUtils.isNotBlank(assistant)) {
            criteria.andLike("assistant", "%" + assistant + "%");
        }
        if (StringUtils.isNotBlank(teacherName)) {
            criteria.andLike("teacherName", "%" + teacherName + "%");
        }
        if(StringUtils.isNotBlank(fromDate) && StringUtils.isNotBlank(endDate)){
            criteria.andBetween("classDate", fromDate, endDate);
        }else if(StringUtils.isBlank(fromDate) && StringUtils.isNotBlank(endDate)){
            criteria.andLessThanOrEqualTo("classDate", endDate);
        }else if(StringUtils.isNotBlank(fromDate) && StringUtils.isBlank(endDate)){
            criteria.andGreaterThanOrEqualTo("classDate", fromDate);
        }

        return getMapper().selectByExample(example);

    }
}
