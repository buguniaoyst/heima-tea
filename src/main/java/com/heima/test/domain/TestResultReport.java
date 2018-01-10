package com.heima.test.domain;

import javax.persistence.*;
import java.util.Date;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
@Entity
@Table(name = "test_result_report")
public class TestResultReport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    /**
     * 考试类型：0-阶段考试   1-课后测试
     */
    private Integer testType;
    /**
     * 创建人
     */
    private String creater;
    /**
     * 创建日期
     */
    private Date createDate;
    /**
     * 考试时间
     */
    private Date testDate;
    /**
     * 试卷名
     */
    private String testName;
    /**
     * 班级名称
     */
    private String className;

    /**
     * 讲师名称
     */
    private String  teacherName;

    /**
     * 平均分
     */
    private Double avgScore;

    /**
     * 末位平均分
     */
    private Double moweiAvgScore;

    /**
     * 考试结果分析
     */
    private String testResultAnalyse;

    /**
     * 对策
     */
    private String  counterMeasure;

    /**
     * 备注
     */
    private String remark;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTestType() {
        return testType;
    }

    public void setTestType(Integer testType) {
        this.testType = testType;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getTestDate() {
        return testDate;
    }

    public void setTestDate(Date testDate) {
        this.testDate = testDate;
    }

    public String getTestName() {
        return testName;
    }

    public void setTestName(String testName) {
        this.testName = testName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public Double getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(Double avgScore) {
        this.avgScore = avgScore;
    }

    public Double getMoweiAvgScore() {
        return moweiAvgScore;
    }

    public void setMoweiAvgScore(Double moweiAvgScore) {
        this.moweiAvgScore = moweiAvgScore;
    }

    public String getTestResultAnalyse() {
        return testResultAnalyse;
    }

    public void setTestResultAnalyse(String testResultAnalyse) {
        this.testResultAnalyse = testResultAnalyse;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    public String toString() {
        return "TestResultReport{" +
                "id=" + id +
                ", testType=" + testType +
                ", creater='" + creater + '\'' +
                ", createDate=" + createDate +
                ", testDate=" + testDate +
                ", testName='" + testName + '\'' +
                ", className='" + className + '\'' +
                ", teacherName='" + teacherName + '\'' +
                ", avgScore=" + avgScore +
                ", moweiAvgScore=" + moweiAvgScore +
                ", testResultAnalyse='" + testResultAnalyse + '\'' +
                ", counterMeasure='" + counterMeasure + '\'' +
                ", remark='" + remark + '\'' +
                '}';
    }
}
