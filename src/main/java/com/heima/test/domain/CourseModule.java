package com.heima.test.domain;

import javax.persistence.*;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 * 课程模块
 */
@Entity
@Table(name = "course_module")
public class CourseModule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String moduleName;//模块名称
    private String classTypeName;//班级类型
    private Integer classType;//班级类型 0-基础班 1-就业班
    private String version;
    private String subjectName;//所属学科名称
    private String subjectId;//所属学科id
    private Integer status;//是否启用   0-关闭 1-启用
    private String remark;//备注

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getModuleName() {
        return moduleName;
    }

    public void setModuleName(String moduleName) {
        this.moduleName = moduleName;
    }

    public String getClassTypeName() {
        return classTypeName;
    }

    public void setClassTypeName(String classTypeName) {
        this.classTypeName = classTypeName;
    }

    public Integer getClassType() {
        return classType;
    }

    public void setClassType(Integer classType) {
        this.classType = classType;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "CourseModule{" +
                "id=" + id +
                ", moduleName='" + moduleName + '\'' +
                ", classTypeName='" + classTypeName + '\'' +
                ", classType=" + classType +
                ", version='" + version + '\'' +
                ", subjectName='" + subjectName + '\'' +
                ", subjectId='" + subjectId + '\'' +
                ", status=" + status +
                ", remark='" + remark + '\'' +
                '}';
    }
}
