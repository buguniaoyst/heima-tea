package com.heima.test.service;

import com.github.abel533.entity.Example;
import com.heima.test.domain.ClassInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ClassInfoService extends  BaseService<ClassInfo>{

    public ClassInfo queryClassInfoByClassId(ClassInfo classInfo) {
        Example example = new Example(ClassInfo.class);
        example.createCriteria().andEqualTo("id", classInfo.getId());
        List<ClassInfo> classInfoList = this.getMapper().selectByExample(example);
        if(null != classInfoList && classInfoList.size()>0){
            return classInfoList.get(0);
        }
        return null;
    }


    public void updatClassInfoByClassId(ClassInfo classInfo) {
        Example example = new Example(ClassInfo.class);
        example.createCriteria().andEqualTo("id", classInfo.getId());
        this.getMapper().updateByExampleSelective(classInfo, example);
    }

    public ClassInfo queryClassInfoById(Integer id) {
        return this.getMapper().selectByPrimaryKey(id);
    }

    /**
     * 查询所有安排了考试的班级
     * @return
     */
    public List<ClassInfo> queryClassHasTest() {
        Example example = new Example(ClassInfo.class);
        example.createCriteria().andIsNotNull("testId");
        return getMapper().selectByExample(example);
    }

    /**
     * 根据classid和classType查询class
     * @param classType
     * @param classId
     * @return
     */
    public List<ClassInfo> queryClassInfoByClassTypeAndClassId(Integer classType, Integer classId) {

        Example example = new Example(ClassInfo.class);
        example.createCriteria().andEqualTo("id", classId)
                .andEqualTo("classType", classType);
        return getMapper().selectByExample(example);
    }
}
