package com.heima.test.domain;

import javax.persistence.*;

@Entity
@Table(name = "testctrl")
public class TestCtrl {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id", unique=true, nullable=false)
    private Integer id;
    private String testId;
    private  String classType;
    private  String className;
    private String stuNumber;
    private String classTestNo;
    private  String testStatus;
    private Integer classId;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTestId() {
        return testId;
    }

    public void setTestId(String testId) {
        this.testId = testId;
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getStuNumber() {
        return stuNumber;
    }

    public void setStuNumber(String stuNumber) {
        this.stuNumber = stuNumber;
    }

    public String getClassTestNo() {
        return classTestNo;
    }

    public void setClassTestNo(String classTestNo) {
        this.classTestNo = classTestNo;
    }

    public String getTestStatus() {
        return testStatus;
    }

    public void setTestStatus(String testStatus) {
        this.testStatus = testStatus;
    }

    public Integer getClassId() {
        return classId;
    }

    public void setClassId(Integer classId) {
        this.classId = classId;
    }

    @Override
    public String toString() {
        return "TestCtrl{" +
                "id=" + id +
                ", testId='" + testId + '\'' +
                ", classType='" + classType + '\'' +
                ", className='" + className + '\'' +
                ", stuNumber='" + stuNumber + '\'' +
                ", classTestNo='" + classTestNo + '\'' +
                ", testStatus='" + testStatus + '\'' +
                '}';
    }
}
