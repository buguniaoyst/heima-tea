var navs = [{
	"title": "系统管理",
	"icon": "&#xe614;",
	"spread": false,
	"children": [ {
        "title": "班级管理",
        "icon": "&#xe68e;",
        "href": "/rest/class_info/classinfo_list"
    }/*, {
        "title": "学员管理",
        "icon": "&#xe613;",
        "href": "/rest/userctrl_List"
    }*/, {
        "title": "用户管理",
        "icon": "&#xe612;",
        "href": "/rest/user_info/user_list"
    }, {
        "title": "课程模块",
        "icon": "&#xe637;",
        "href": "/rest/course_info/courseinfo_list"
    }]
},{
	"title": "开班考试",
	"icon": "&#xe60a;",
	"spread": false,
	"children": [ {
        "title": "安排考试",
        "icon": "&#xe654;",
        "href": "/rest/test_control"
    }, {
        "title": "考试列表",
        "icon": "&#xe615;",
        "href": "/rest/testctrl_list"
    }]
}, {
    "title": "课后测试",
    "icon": "&#xe629;",
    "href": "",
    "spread": false,
    "children": [  {
        "title": "新增题目",
        "icon": "&#xe60a;",
        "href": "/rest/item_add"
    }, {
        "title": "题库列表",
        "icon": "&#xe60a;",
        "href": "/rest/item_list"
    }, {
        "title": "组卷管理",
        "icon": "&#xe60a;",
        "href": "/rest/item_test_add"
    }, {
        "title": "随堂试卷列表",
        "icon": "&#xe60a;",
        "href": "/rest/test_source_list"
    }, {
        "title": "安排测试",
        "icon": "&#xe60a;",
        "href": "/rest/item_test_create"
    }, {
        "title": "测试结果",
        "icon": "&#xe60a;",
        "href": "/rest/item_test_answer_list"
    }]
}, {
	"title": "成绩管理",
	"icon": "&#xe629;",
	"href": "",
	"spread": false,
	"children": [  {
		"title": "开班考试成绩",
		"icon": "&#xe60a;",
		"href": "/rest/testctrl_scoreList"
	},{
        "title": "课后测试成绩",
        "icon": "&#xe60a;",
        "href": "/rest/item_test_score_list"
    }]
}, {
    "title": "带班日记",
    "icon": "&#xe705;",
    "href": "",
    "spread": false,
    "children": [  {
        "title": "记录日记",
        "icon": "&#xe642;",
        "href": "/rest/tea_diary/diary_add"
    }, {
        "title": "我的日记",
        "icon": "&#xe60a;",
        "href": "/rest/tea_diary/tea_diary_list"
    }, {
        "title": "日记报表",
        "icon": "&#xe62c;",
        "href": "/rest/tea_diary/tea_diary_info_list"
    }]
}, {
    "title": "教学研讨",
    "icon": "&#xe613;",
    "href": "",
    "spread": false,
    "children": [  {
        "title": "助教周报",
        "icon": "&#xe60a;",
        "href": "/rest/tea_content/assi_weekly_report"
    }, {
        "title": "学员班会",
        "icon": "&#xe613;",
        "href": "/rest/tea_content/stu_monthly_report"
    }, {
        "title": "助教例会",
        "icon": "&#xe60a;",
        "href": "/rest/tea_content/assi_monthy_meeting"
    }, {
        "title": "讲师例会",
        "icon": "&#xe62c;",
        "href": "/rest/tea_content/tea_monthy_meeting"
    }, {
        "title": "部门成果",
        "icon": "&#xe62c;",
        "href": "/rest/tea_diary/tea_diary_list"
    }]
}, {
    "title": "助教排班",
    "icon": "&#xe637;",
    "href": "",
    "spread": false,
    "children": [  {
        "title": "课表管理",
        "icon": "&#xe642;",
        "href": "/rest/course_schedule/course_schedule"
    }, {
        "title": "排班管理",
        "icon": "&#xe60a;",
        "href": "/rest/course_schedule/tea_scheduling"
    }, {
        "title": "我的排班",
        "icon": "&#xe62c;",
        "href": "/rest/course_schedule/course_schedule"
    }]
}, {
	"title": "其他",
	"icon": "&#xe650;",
	"href": "#",
	"spread": false,
	"children": [{
		"title": "通讯录",
		"icon": "&#xe613;",
		"href": "/rest/score_list"
	}]
}];