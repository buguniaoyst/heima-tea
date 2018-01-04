package com.heima.test.domain;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "class_info")
public class ClassInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Integer id;
    private  String classId;
    private  String testId;
    private  String className;
    private  Integer classType;//班级类型  0-基础班  1-就业班
    private String assistant;//助教姓名
    private  String masterName;//班主任姓名
    private  Integer studentCount;
    private Date startDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getClassId() {
        return classId;
    }

    public void setClassId(String classId) {
        this.classId = classId;
    }

    public String getTestId() {
        return testId;
    }

    public void setTestId(String testId) {
        this.testId = testId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public Integer getClassType() {
        return classType;
    }

    public void setClassType(Integer classType) {
        this.classType = classType;
    }

    public String getAssistant() {
        return assistant;
    }

    public void setAssistant(String assistant) {
        this.assistant = assistant;
    }

    public String getMasterName() {
        return masterName;
    }

    public void setMasterName(String masterName) {
        this.masterName = masterName;
    }

    public Integer getStudentCount() {
        return studentCount;
    }

    public void setStudentCount(Integer studentCount) {
        this.studentCount = studentCount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    @Override
    public String toString() {
        return "ClassInfo{" +
                "id=" + id +
                ", classId='" + classId + '\'' +
                ", testId='" + testId + '\'' +
                ", className='" + className + '\'' +
                ", classType=" + classType +
                ", assistant='" + assistant + '\'' +
                ", masterName='" + masterName + '\'' +
                ", studentCount=" + studentCount +
                ", startDate=" + startDate +
                '}';
    }
}
