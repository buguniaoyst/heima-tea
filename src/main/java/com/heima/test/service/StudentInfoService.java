package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.ClassInfo;
import com.heima.test.domain.CourseScheduleDetail;
import com.heima.test.domain.StudentInfo;
import com.heima.test.domain.TestSource;
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
public class StudentInfoService extends BaseService<StudentInfo>{


    public List<StudentInfo> queryStudentInfoListByClassId(Integer classId) {
        Example example = new Example(StudentInfo.class);
        example.createCriteria().andEqualTo("classId", classId);
        return this.getMapper().selectByExample(example);
    }

    public StudentInfo queryStudentInfoById(Integer id) {
        return this.getMapper().selectByPrimaryKey(id);
    }

    public void importStudentInfoExcel(List<List<Object>> listob, Integer classId) {
        //先清除所有的课表数据再更新
        Example example = new Example(StudentInfo.class);
        example.createCriteria().andEqualTo("classId", classId);
        getMapper().deleteByExample(example);

        //封装数据
        for (int i = 0; i < listob.size(); i++) {
            List<Object> lo = listob.get(i);
            StudentInfo s = new StudentInfo();
            s.setClassId(classId);
            s.setTestId(0);
            if (null != lo.get(0)) {
                s.setStudentName(String.valueOf(lo.get(0)));
            }

            if (null != lo.get(1)) {
                //性别
                String sexStr = String.valueOf(lo.get(1));
                if ("男".equals(sexStr)) {
                    s.setSex(1);
                }else {
                    s.setSex(2);
                }
            }

            //学号
            if (null != lo.get(2)) {
                s.setStudentNo(String.valueOf(lo.get(2)));
            }

            //学科
            if (null != lo.get(3)) {
                String subjectStr = String.valueOf(lo.get(3));
                if ("Java".equals(subjectStr)) {
                    s.setSubjectNo(1);
                }else {
                    s.setSubjectNo(2);
                }
            }
            s.setPassword("123456");
            save(s);
        }

    }

    /**
     * 将试卷信息和学生关联
     * @param classInfo1
     * @param testSource
     */
    public void associateTestWithSutdent(ClassInfo classInfo1, TestSource testSource) {
        //根据classInfo中的id查询 该班级的学生
        Example example = new Example(StudentInfo.class);
        example.createCriteria().andEqualTo("classId", classInfo1.getId());
        StudentInfo studentInfo = new StudentInfo();
        studentInfo.setTestId(testSource.getId());
        studentInfo.setTestStatus(1);
        getMapper().updateByExampleSelective(studentInfo, example);

    }
}
