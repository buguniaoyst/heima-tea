package com.heima.test.view;

import com.heima.test.domain.CourseScheduleDetail;
import com.heima.test.domain.TeaDiary;
import com.heima.test.utils.DateUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
public class CourseSchedulDetailExcelView  extends AbstractExcelView {
    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 从model对象中获取userList
        @SuppressWarnings("unchecked")
        List<CourseScheduleDetail> proList = (List<CourseScheduleDetail>) model.get("courseScheduleDetailList");
        // 创建Excel的sheet
        HSSFSheet sheet = workbook.createSheet("教学课程统计");

        // 创建标题行
        HSSFRow header = sheet.createRow(0);
        header.createCell(0).setCellValue("序号");
        header.createCell(1).setCellValue("上课日期");
        header.createCell(2).setCellValue("班级");
        header.createCell(3).setCellValue("课程（内容为空代表放假）");
        header.createCell(4).setCellValue("上课模式");
        header.createCell(5).setCellValue("助教");
        header.createCell(6).setCellValue("讲师");
        header.createCell(7).setCellValue("备注");


        // 填充数据
        int rowNum = 1;
        for (CourseScheduleDetail c : proList) {
            HSSFRow row = sheet.createRow(rowNum);
            row.createCell(0).setCellValue(rowNum);
            row.createCell(1).setCellValue(DateUtils.getStringDate(c.getClassDate()));
            row.createCell(2).setCellValue(c.getClassName());
            row.createCell(3).setCellValue(c.getContent());
            if (null != c.getClassMode() && 0==c.getClassMode()) {
                row.createCell(4).setCellValue("传统全天");
            } else if (null != c.getClassMode() && 1==c.getClassMode()) {
                row.createCell(4).setCellValue("AB上午");

            }else if (null != c.getClassMode() && 2==c.getClassMode()) {
                row.createCell(4).setCellValue("AB下午");
            }else{
                row.createCell(4).setCellValue("");
            }

            row.createCell(5).setCellValue(c.getAssistant());
            row.createCell(6).setCellValue(c.getTeacherName());
            row.createCell(7).setCellValue(c.getRemark());
            rowNum++;
        }
        // 设置相应头信息，以附件形式下载并且指定文件名
        String currentDate = DateUtils.getCurrentDate();
        response.setHeader("Content-Disposition", "attachment;filename="
                + new String(("课程统计("+ currentDate+").xls").getBytes(), "ISO-8859-1"));
    }
}
