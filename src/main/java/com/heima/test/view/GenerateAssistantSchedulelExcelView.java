package com.heima.test.view;

import com.heima.test.domain.CourseScheduleDetail;
import com.heima.test.utils.DateUtils;
import org.apache.commons.lang3.StringUtils;
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
public class GenerateAssistantSchedulelExcelView extends AbstractExcelView {
    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 从model对象中获取userList
        @SuppressWarnings("unchecked")
        List<CourseScheduleDetail> proList = (List<CourseScheduleDetail>) model.get("courseScheduleDetailList");
        // 创建Excel的sheet
        HSSFSheet sheet = workbook.createSheet("助教排班表");

        // 创建标题行
        HSSFRow header = sheet.createRow(0);
        header.createCell(0).setCellValue("序号");
        header.createCell(1).setCellValue("日期");
        header.createCell(2).setCellValue("班级");
        header.createCell(3).setCellValue("助教");
        header.createCell(4).setCellValue("班次");
        header.createCell(5).setCellValue("备注");

        String assistant = null;
        // 填充数据
        int rowNum = 1;
        for (CourseScheduleDetail c : proList) {
            assistant =  c.getAssistant();
            HSSFRow row = sheet.createRow(rowNum);
            row.createCell(0).setCellValue(rowNum);
            row.createCell(1).setCellValue(DateUtils.getStringDate(c.getClassDate()));
            row.createCell(2).setCellValue(c.getClassName());
            row.createCell(3).setCellValue(c.getAssistant());
            if(null !=  c.getClassMode() && c.getClassMode() == 1){
                row.createCell(4).setCellValue("早027");
            }else if(null !=  c.getClassMode() && c.getClassMode() == 2){
                row.createCell(4).setCellValue("晚006");
            }else if(null !=c.getHasHonorsDay() && 0==c.getHasHonorsDay()){
                row.createCell(4).setCellValue("PH");
            } else if ("开班典礼".equals(c.getRemark()) || "项目实战".equals(c.getRemark())|| "就业指导".equals(c.getRemark())) {
                row.createCell(4).setCellValue("早002");
            }
            row.createCell(5).setCellValue(c.getRemark());
            rowNum++;
        }
        // 设置相应头信息，以附件形式下载并且指定文件名
        String currentDate = DateUtils.getCurrentDate();
        response.setHeader("Content-Disposition", "attachment;filename="
                + new String((assistant+"-考勤表("+ currentDate+").xls").getBytes(), "ISO-8859-1"));
    }

}
