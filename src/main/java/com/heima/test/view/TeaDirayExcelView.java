package com.heima.test.view;

import com.heima.test.domain.TeaDiary;
import com.heima.test.domain.TestInfo;
import com.heima.test.utils.DateUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author 布谷鸟
 * @version V1.0
 * @Package ${package_name}
 * @date ${date} ${time}
 */
public class TeaDirayExcelView extends AbstractExcelView {
    @Override
    protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook workbook, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 从model对象中获取userList
        @SuppressWarnings("unchecked")
        List<TeaDiary> proList = (List<TeaDiary>) model.get("teaDiaryList");
        // 创建Excel的sheet
        HSSFSheet sheet = workbook.createSheet("助教日志报表");

        // 创建标题行
        HSSFRow header = sheet.createRow(0);
        header.createCell(0).setCellValue("序号");
        header.createCell(1).setCellValue("日期");
        header.createCell(2).setCellValue("助教姓名");
        header.createCell(3).setCellValue("课程模块");
        header.createCell(4).setCellValue("课程中的难点");
        header.createCell(5).setCellValue("课程中难理解的点");
        header.createCell(6).setCellValue("问题比较多的点");
        header.createCell(7).setCellValue("没解决的问题");
        header.createCell(8).setCellValue("做得好的地方");
        header.createCell(9).setCellValue("其他信息");


        // 填充数据
        int rowNum = 1;
        for (TeaDiary teaDiary : proList) {
            HSSFRow row = sheet.createRow(rowNum);
            row.createCell(0).setCellValue(rowNum);
            row.createCell(1).setCellValue(DateUtils.getStringDate(teaDiary.getDate()));
            row.createCell(2).setCellValue(teaDiary.getCreater());
            row.createCell(3).setCellValue(teaDiary.getCourseModule());
            row.createCell(4).setCellValue(teaDiary.getCourseDifficultPoint());
            row.createCell(5).setCellValue(teaDiary.getIndigestibilityPoint());
            row.createCell(6).setCellValue(teaDiary.getProblemPoints());
            row.createCell(7).setCellValue(teaDiary.getUnresolvedPoints());
            row.createCell(8).setCellValue(teaDiary.getGoodPoints());
            row.createCell(9).setCellValue(teaDiary.getRemark());
            rowNum++;
        }
        // 设置相应头信息，以附件形式下载并且指定文件名
        String currentDate = DateUtils.getCurrentDate();
        response.setHeader("Content-Disposition", "attachment;filename="
                + new String(("助教日志("+ currentDate+").xls").getBytes(), "ISO-8859-1"));
    }
}
