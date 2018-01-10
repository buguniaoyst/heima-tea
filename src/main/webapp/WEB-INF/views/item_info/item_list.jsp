<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
    <title>试卷管理列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css" media="all">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/layui.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/layui/lay/modules/laypage.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
<!-- 列表面板 -->
<div class="layui-form layui-form-pane" style="margin-top: 15px;">
    <div class="layui-form-item" style="margin-top: 5px;margin-bottom: -5px;">

        <label class="layui-form-label">课程模块</label>
        <div class="layui-input-inline">
            <select name="classType" lay-filter="getClassType">
                <option value="">班级类型</option>
                <option value="0" selected="">基础班</option>
                <option value="1">就业班</option>
            </select>
        </div>
        <div class="layui-input-inline">
            <select name="courseModuleId" lay-filter="getModuleName" id="courseModuleId">
                <option class="courcesModule" value="">请选课程模块</option>
            </select>
            <input type="hidden" name="courseModule" id="courseModule">
        </div>

        <div class="layui-inline">
            <button class="layui-btn layui-btn-radius" id="diaryQueryBtn">查询</button>
        </div>
        <div class="layui-inline">
            <button class="layui-btn layui-btn-radius" onclick="addItem();">
                <i class="layui-icon">&#xe608;</i>新增题目
            </button>
        </div>
    </div>
    <div class="layui-form">
        <table class="layui-table" style="height: 58px;" lay-even="" lay-skin="row" id="personTable">
            <colgroup>
                <col width="40">
                <col width="200">
                <col width="200">
                <col width="400">
                <col width="600">
                <col width="400">
            </colgroup>
            <thead>
            <tr>
                <th align="center" style="padding: 0;text-align: center">序号</th>
                <th align="center">班级类型</th>
                <th align="center">题目类型</th>
                <th align="center">关联课程</th>
                <th align="center">题干</th>
                <th align="center">题目状态</th>
            </tr>
            </thead>
            <tbody id="tbody">
            </tbody>
        </table>
    </div>
    <div id="demo5" align="center"></div>
</div>
</body>

<div id="codeItemContent" style="display: none">
    <div class="layui-form-pane" style="margin-top: 15px;">
        <form id="jvForm" class="layui-form layui-form-pane" action="${pageContext.request.contextPath}/rest/item/addItem" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">适用范围</label>
                <div class="layui-input-inline">
                    <select name="classType" lay-filter="aihao">
                        <option value=""></option>
                        <option value="0" selected="">基础班</option>
                        <option value="1">就业班</option>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">题目类型</label>
                <div class="layui-input-inline">
                    <select name="itemType" lay-filter="itemType">
                        <option value=""></option>
                        <option value="0" selected="">编程题</option>
                        <option value="1" >单选题</option>
                        <option value="2">多选题</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">课程模块</label>
                <div class="layui-input-inline">
                    <select name="quiz1">
                        <option value="">请选择课程模块</option>
                        <option value="11" selected="">JavaSE初级</option>
                        <option value="12" >JavaSE高级</option>
                        <option value="13" >MySQL+JDBC</option>
                        <option value="14" >前端</option>
                        <option value="15" >JavaWeb核心</option>
                        <option value="16" >Estore</option>
                        <option value="17" >Linux</option>
                    </select>
                </div>
                <div class="layui-input-inline">
                    <select name="itemSourceId">
                        <option value="">请选择课程</option>
                        <option value="1101" selected="">day01-搭建环境、数据类型</option>
                        <option value="1102">day02-Eclipse-运算符-键盘录入</option>
                        <option value="1103">day03-选择、循环语句</option>
                        <option value="1104">day04-Random-数组</option>
                        <option value="1105">day05-方法</option>
                        <option value="1106">day06-断点调试-练习</option>
                        <option value="1107">day07-面向对象-private-this-构造方法</option>
                        <option value="1108">day08-String-StringBuilder</option>
                        <option value="1109">day09-对象数组-ArrayList-学生管理案例</option>
                        <option value="1110">day10-字符流-字符缓冲流</option>
                        <option value="1111">day11-学生管理案例IO流版本</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item" pane="">
                <label class="layui-form-label">题目状态</label>
                <div class="layui-input-block">
                    <input type="radio" name="itemStatus" value="1" title="启用" checked="">
                    <input type="radio" name="itemStatus" value="0" title="禁用" >
                </div>
            </div>

            <div class="layui-form-item layui-input-inline" pane="">
                <label class="layui-form-label">分值</label>
                <div class="layui-input-block">
                    <input type="number" name="itemScore" class="layui-input">
                </div>
            </div>
            <!-- 视频上传 -->
            <div class="layui-form-item layui-input-inline" pane="">
                <label class="layui-form-label">视频上传 </label>
                <div class="layui-input-block">
                    <button class="layui-upload-button">
                        <input type="file" class="layui-btn layui-btn-primary" name="mf" onchange="uploadVideo()" />
                    </button>
                    <input type="hidden" name="videoPath" id="videoPath"/>
                </div>
            </div>
            <div id="videoDiv" class="layui-form-item layui-input-inline " style="display:none">
                <label class="layui-form-label">
                    <a id="showVideo" target="_blank" href="#">播放视频文件</a>
                </label>
                <div class="layui-input-block">

                </div>
            </div>
            <div class="layui-form-item layui-input-inline">
                <label class="layui-form-label">答案解析</label>
                <div class="layui-input-block ">
                    <button class="layui-upload-button">
                        <input type="file" class="layui-btn layui-btn-primary" name="mp" onchange="uploadPic()" />
                    </button>
                    <input type="hidden" name="picPath" id="picPath"/>
                </div>
                <div id="picDiv" class="layui-input-block layui-inline" style="display:none">
                    <img src="#" id="showPic" style="height: 200px;width: 200px">
                </div>
            </div>
            <div id="itemAnswerContent">

            </div>

            <div class="layui-form-item">
                <button class="layui-btn" lay-submit="" lay-filter="demo2">新增</button>
                <button class="layui-btn "   type="reset" >重置</button>
            </div>
        </form>

    </div>
</div>




<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script src="${pageContext.request.contextPath }/lib/jquery.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.ext.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath }/lib/jquery.form.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/datas/answerContentTemplate.js"></script>
<script>
    layui.use(['laypage', 'layer', 'laydate', 'jquery', 'form'], function () {
        var laydate = layui.laydate;
        var laypage = layui.laypage;
        var form = layui.form;
        var $ = layui.jquery;
        var start = {
            max: '2099-06-16 23:59:59',
            istoday: false,
            choose: function (datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };

        var end = {
            max: '2099-06-16 23:59:59',
            istoday: false,
            choose: function (datas) {
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };
        //监听班级类型  根据不同的班级类型 加载不同的课程模块
        form.on('select(getClassType)', function(data){
            console.log(data.elem); //得到select原始DOM对象
            console.log(data.value); //得到被选中的值
            console.log(data.othis); //得到美化后的DOM对象
            var classType = data.value;
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/course/getCourseModuleByClassType",
                data: {classType:classType},
                dataType: "json",
                success: function(result){
                    var courceModuleOpt = "";
                    $.each(result, function(i,item){
                        courceModuleOpt += "<option value=\"" + item.id + "\" >" + item.moduleName + "</option>";
                    });
                    $("#courseModuleId").html('<option value=""></option>' + courceModuleOpt);
                    form.render(); //这个很重要
                    //console.log(result);
                }
            });
        });//监听班级类型  根据不同的班级类型 加载不同的课程模块
        form.on('select(getModuleName)', function(data){
            console.log(data.elem); //得到select原始DOM对象
            console.log(data.value); //得到被选中的值
            console.log(data.othis); //得到美化后的DOM对象
            $("#courseModule").val(data.elem.selectedOptions[0].innerText);

        });


        //页面初始化的时候加载分页数据
        $(function () {

            //初始化课程模块信息
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/course/getCourseModuleByClassType",
                data: {classType:0},
                dataType: "json",
                success: function(result){
                    var courceModuleOpt = "";
                    $.each(result, function(i,item){
                        courceModuleOpt += "<option value=\"" + item.id + "\" >" + item.moduleName + "</option>";
                    });
                    $("#courseModuleId").html('<option value=""></option>' + courceModuleOpt);
                    layui.use(['form'],function() {
                        var form = layui.form;
                        form.render();
                    });


                }
            });




            //alert("页面初始化了.......");
            $.ajax({
                type: "GET",
                url: "${pageContext.request.contextPath}/rest/item/itemList",
                //记得加双引号  T_T
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    nums = data.pagesize; //每页出现的数量
                    pageData = data;
                    var pages = Math.ceil(data.results.length / nums); //得到总页数
                    //调用分页
                    laypage({
                        cont: 'demo5',
                        pages: pages,
                        jump: function (obj) {
                            thisDate(obj.curr)
                            console.log(thisDate(obj.curr));
                            form.render();
                        }
                    })
                    return;
                },
                error: function (err) {
                    alert(err + "err");
                }
            });


        })

        //分页数据
        var pageData;
        var nums = 1; //每页出现的数量
        var pages = 1;
        var thisDate = function (curr) {
            //此处只是演示，实际场景通常是返回已经当前页已经分组好的数据
            data = pageData.results;
            var str = '', last = curr * nums - 1;
            last = last >= data.length ? (data.length - 1) : last;
            var table = $("#tbody");
            $("#tbody tr").empty();//每次进来先清空table
            for (var i = (curr * nums - nums); i <= last; i++) {
                // str += '<li>' + data[i] + '</li>';
                var tr = $("<tr></tr>");
                var classType;
                var itemContent;
                var itemSourceId;
                var itemStatus;
                var itemType;
                if (data[i].classType == '0') {
                    classType = "基础班";

                } else {
                    classType = "就业班";
                }

                if (data[i].itemStatus == '0') {
                    itemStatus = "禁用";

                } else {
                    itemStatus = "启用";
                }

                if (data[i].itemType == '0') {
                    itemType = "编程题";

                } else if (data[i].itemType == '1') {
                    itemType = "单选题";
                } else if (data[i].itemType == '2') {
                    itemType = "多选题";
                }

                var td0 = $("<td align='center'>" + i + "</td>")
                var td1 = $("<td align='center'>" + classType + "</td>")
                var td2 = $("<td align='center'>" + itemType + "</td>");
                var td3 = $("<td align='center'>" + data[i].itemSourceId + "</td>");
                var td4 = $("<td align='center' >" + data[i].itemContent + "</td>");
                var td5 = $("<td align='center' ><button  class='layui-btn  layui-btn-radius' >" + itemStatus + "</button></td>");
                td0.appendTo(tr);
                td1.appendTo(tr);
                td2.appendTo(tr);
                td3.appendTo(tr);
                td4.appendTo(tr);
                td5.appendTo(tr);
                tr.appendTo(table);
            }
            return table;
        };



    });


    function addItem() {
        layer.open({
            title: '新增题目',
            type: 1,
            skin: 'layui-layer-demo', //样式类名
            area: ['720px', '800px'],
            closeBtn: 1, //不显示关闭按钮
            anim: 2,
            shadeClose: true, //开启遮罩关闭
            content: $('#codeItemContent'),
            success: function (layero, index) {
                //初始化课程模块信息
                $.ajax({
                    type: "GET",
                    url: "${pageContext.request.contextPath}/rest/course/getCourseModuleByClassType",
                    data: {classType:0},
                    dataType: "json",
                    success: function(result){
                        var courceModuleOpt = "";
                        $.each(result, function(i,item){
                            courceModuleOpt += "<option value=\"" + item.id + "\" >" + item.moduleName + "</option>";
                        });
                        $("#courseModuleId").html('<option value=""></option>' + courceModuleOpt);
                    }

                });
                layui.use(['form'],function() {
                    var form = layui.form;
                    $("#itemAnswerContent").append($(codeItemTemplate));
                    form.render();
                    form.on('select(itemType)',function (data) {

                        console.log("弹窗重新加载................")
                        if(data.value == 1) {
                            $("#itemAnswerContent").empty();
                            $("#itemAnswerContent").append(singleItemTemplate);
                            form.render();
                        }else  if(data.value == 2) {
                            $("#itemAnswerContent").empty();
                            $("#itemAnswerContent").append(multipartItemTemplate);
                            form.render();
                        }else if(data.value == 0) {
                            $("#itemAnswerContent").empty();
                            $("#itemAnswerContent").append(codeItemTemplate);
                            form.render();
                        }
                    })
                });
            },
            cancel:function (index, layero) {
                $("#itemAnswerContent").empty();
                $("#codeItemContent").css("display", "none");

            }

        });
    }
    function uploadVideo() {
        var options = {
            url: "/rest/uploadVideo.do",
            type: "post",
            dataType: "json",
            success: function (data) {
                //设置图片的在表单提交后的值
                $("#videoPath").val(data.videoPath);
                $("#showVideo").attr("href", data.videoPath);
                $("#videoDiv")[0].style.display = "block";
                console.log("上传的视频地址：" + data.videoPath);
            }
        }
        $("#jvForm").ajaxSubmit(options);
    }

    function uploadPic() {
        var options = {
            url: "/rest/uploadPic.do",
            type: "post",
            dataType: "json",
            success: function (data) {
                //设置图片的在表单提交后的值
                $("#picPath").val(data.picPath);
                $("#showPic").attr("src", data.picPath);
                $("#picDiv")[0].style.display = "block";
            }
        }
        $("#jvForm").ajaxSubmit(options);
    }

</script>

</html>
