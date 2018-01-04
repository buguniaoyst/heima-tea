package com.heima.test.domain;

import javax.persistence.*;
import java.util.Date;

/**
 * 助教带班日记
 */
@Entity
@Table(name = "tea_diary")
public class TeaDiary {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  Integer id;
    /**
     * 日记编号：由助教id+日期+课程模块id组合而成
     */
    private String diaryNo;
    private Date date;
    private String creater;//助教姓名
    private String courseModule;//课程模块名
    private  Integer courseModuleId;//课程模块编号
    private  String courseDifficultPoint;//课程难点
    private  String indigestibilityPoint;//难理解，难笑话的点
    private  String  problemPoints;//问题比较多的地方
    private String unresolvedPoints;//没能解决的问题
    private  String goodPoints;//做得好的地方
    private  String remark;//备注信息
    private Integer courseNo;
    private  Integer createrId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDiaryNo() {
        return diaryNo;
    }

    public void setDiaryNo(String diaryNo) {
        this.diaryNo = diaryNo;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public String getCourseModule() {
        return courseModule;
    }

    public void setCourseModule(String courseModule) {
        this.courseModule = courseModule;
    }

    public Integer getCourseModuleId() {
        return courseModuleId;
    }

    public void setCourseModuleId(Integer courseModuleId) {
        this.courseModuleId = courseModuleId;
    }

    public String getCourseDifficultPoint() {
        return courseDifficultPoint;
    }

    public void setCourseDifficultPoint(String courseDifficultPoint) {
        this.courseDifficultPoint = courseDifficultPoint;
    }

    public String getIndigestibilityPoint() {
        return indigestibilityPoint;
    }

    public void setIndigestibilityPoint(String indigestibilityPoint) {
        this.indigestibilityPoint = indigestibilityPoint;
    }

    public String getProblemPoints() {
        return problemPoints;
    }

    public void setProblemPoints(String problemPoints) {
        this.problemPoints = problemPoints;
    }

    public String getUnresolvedPoints() {
        return unresolvedPoints;
    }

    public void setUnresolvedPoints(String unresolvedPoints) {
        this.unresolvedPoints = unresolvedPoints;
    }

    public String getGoodPoints() {
        return goodPoints;
    }

    public void setGoodPoints(String goodPoints) {
        this.goodPoints = goodPoints;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getCourseNo() {
        return courseNo;
    }

    public void setCourseNo(Integer courseNo) {
        this.courseNo = courseNo;
    }

    public Integer getCreaterId() {
        return createrId;
    }

    public void setCreaterId(Integer createrId) {
        this.createrId = createrId;
    }

    @Override
    public String toString() {
        return "TeaDiary{" +
                "id=" + id +
                ", diaryNo='" + diaryNo + '\'' +
                ", date=" + date +
                ", creater='" + creater + '\'' +
                ", courseModule='" + courseModule + '\'' +
                ", courseModuleId=" + courseModuleId +
                ", courseDifficultPoint='" + courseDifficultPoint + '\'' +
                ", indigestibilityPoint='" + indigestibilityPoint + '\'' +
                ", problemPoints='" + problemPoints + '\'' +
                ", unresolvedPoints='" + unresolvedPoints + '\'' +
                ", goodPoints='" + goodPoints + '\'' +
                ", remark='" + remark + '\'' +
                ", courseNo=" + courseNo +
                ", createrId=" + createrId +
                '}';
    }
}
