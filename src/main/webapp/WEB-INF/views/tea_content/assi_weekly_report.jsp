<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>助教周报</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
    <%--列表面板--%>
    <div  class="layui-form layui-form-pane" style="margin-left: 5px">
        <!-- 列表操作按钮组 -->
        <div class="layui-form-item" style="margin-top: 5px;margin-bottom: -5px;">
            <div class="layui-inline">
                <button class="layui-btn layui-btn-radius" id="addWeeklyReport">
                    <i class="layui-icon">&#xe608;</i>创建周报
                </button>
            </div>
            <div class="layui-inline" style="margin-left: 500px">
                <label class="layui-form-label">日期（From）</label>
                <div class="layui-input-inline">
                    <input type="text" id="fromDate" name="startDate" class="layui-input" id="test1" >
                </div>
                <label class="layui-form-label">至（To）</label>
                <div class="layui-input-inline">
                    <input type="text" id="endDate" name="endDate" class="layui-input" id="test2" >
                </div>
            </div>
            <div class="layui-inline">
                <button class="layui-btn layui-btn-radius" id="diaryQueryBtn">查询</button>
                <button class="layui-btn layui-btn-radius" id="diaryQueryExport">导出数据</button>
            </div>
        </div>
        <div>
            <table class="layui-table" lay-even="" lay-skin="row">
                <colgroup>
                    <col width="50" >
                    <col width="150">
                    <col width="150">
                    <col width="200">
                    <col width="400">
                    <col width="200">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr >
                    <th style="text-align: center">序号</th>
                    <th style="text-align: center">创建人</th>
                    <th style="text-align: center">创建日期</th>
                    <th style="text-align: center">主题</th>
                    <th style="text-align: center">内容概要</th>
                    <th style="text-align: center">标签</th>
                    <th style="text-align: center">备注</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>1989-10-14</td>
                        <td>布谷鸟</td>
                        <td>开班典礼优化</td>
                        <td>通过与学工部，就业部讨论共同约定开班典礼流程</td>
                        <td>开班，优化</td>
                        <td>开班，优化</td>
                        <td>查看详情</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>1989-10-14</td>
                        <td>布谷鸟</td>
                        <td>开班典礼优化</td>
                        <td>通过与学工部，就业部讨论共同约定开班典礼流程</td>
                        <td>开班，优化</td>
                        <td>开班，优化</td>
                        <td>查看详情</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>1989-10-14</td>
                        <td>布谷鸟</td>
                        <td>开班典礼优化</td>
                        <td>通过与学工部，就业部讨论共同约定开班典礼流程</td>
                        <td>开班，优化</td>
                        <td>开班，优化</td>
                        <td>查看详情</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>1989-10-14</td>
                        <td>布谷鸟</td>
                        <td>开班典礼优化</td>
                        <td>通过与学工部，就业部讨论共同约定开班典礼流程</td>
                        <td>开班，优化</td>
                        <td>开班，优化</td>
                        <td>查看详情</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>1989-10-14</td>
                        <td>布谷鸟</td>
                        <td>开班典礼优化</td>
                        <td>通过与学工部，就业部讨论共同约定开班典礼流程</td>
                        <td>开班，优化</td>
                        <td>开班，优化</td>
                        <td>查看详情</td>
                    </tr>
                    <tr>
                        <td>1</td>
                        <td>1989-10-14</td>
                        <td>布谷鸟</td>
                        <td>开班典礼优化</td>
                        <td>通过与学工部，就业部讨论共同约定开班典礼流程</td>
                        <td>开班，优化</td>
                        <td>开班，优化</td>
                        <td>查看详情</td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>
</body>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="/lib/jquery-1.8.3.js"></script>
<script>
    layui.use(['laypage', 'layer','laydate','jquery','form'],function() {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;
        //初始化日期控件
        laydate.render({
            elem: '#fromDate'
        });
        laydate.render({
            elem: '#endDate'
        });


    });

</script>
</body>
</html>
