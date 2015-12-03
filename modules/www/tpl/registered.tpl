<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>秋千－注册账号</title>
    <link href="/css/www/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="/js/jquery.form.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.member_sign_btn').click(function () {
                var username = $('#username').val();
                if (!username || username == '给自己起个响亮的秋千账号') {
                    alert('给自己起个响亮的秋千账号');
                    $('#username').val('');
                    $('#username').focus();
                    return false;
                }

                var userpwd = $('#password').val();
                if (!userpwd || userpwd == '长度6-20') {
                    alert('用户密码不能为空,长度6-20');
                    $('#password').val('');
                    $('#password').focus();
                    return false;
                }

                var userpwd2 = $('#password2').val();
                if (!userpwd2 || userpwd2 == '长度6-20') {
                    alert('再次输入密码不能为空,长度6-20');
                    $('#password2').val('');
                    $('#password2').focus();
                    return false;
                }

                if (userpwd != userpwd2) {
                    alert('再次输入密码不正确！');
                    $('#password2').val('');
                    $('#password2').focus();
                    return false;
                }

                var cb_box = $('#checkbox');
                if (cb_box.attr("checked") == false) {
                    alert('请阅读并同意秋千的《用户协议》');
                    cb_box.focus();
                    return false;
                }

                $('#myForm').ajaxSubmit({
                            dataType: 'json',
                            data: { in_ajax: 1 },
                            success: function (retData) {
                                if (retData.result == 'success') {
                                    alert('注册成功，请登录！')
                                    location = '/public/login';
                                }
                                else {
                                    alert(retData.content);
                                }
                            },
                            error: function () {
                                alert('发生错误。');
                            }
                        }
                );
                return false;
            });
        });
        function change_gender(gender) {
            if (gender == 1) {
                $('#male').removeClass().addClass('man_current');
                $('#female').removeClass().addClass('woman');
            } else {
                $('#male').removeClass().addClass('man');
                $('#female').removeClass().addClass('woman_current');
            }
            $('#gender').val(gender);
        }
    </script>
</head>

<body>
<!--网站头部-->

<div class="login_top"><a href="/"><img src="/images/www/images/logo2.jpg" width="95" height="87"/></a></div>
<div class="login_top_text">注册秋千账号</div>
<form action="/public/reg" id="myForm" method="post">
    <div class="login_main">
        <div class="number">
            <div class="number_left">秋千账号</div>
            <div class="number_right">
                <input name="username" type="text" class="frame" id="username" value="给自己起个响亮的秋千账号"
                       onclick="if(this.value=='给自己起个响亮的秋千账号'){ this.value='' }"
                       onblur="if(this.value==''){ this.value='给自己起个响亮的秋千账号' }"/>
            </div>
        </div>
        <div class="tips">秋千账号：4-12个任意英文字母、数字、中文</div>


        <div class="number">
            <div class="number_left">登录密码</div>
            <div class="number_right">
                <input name="password" type="password" class="frame" id="password" value="长度6-20"
                       onclick="if(this.value=='长度6-20'){ this.value='' }"
                       onblur="if(this.value==''){ this.value='长度6-20' }"/>
            </div>
        </div>
        <div class="tips"></div>

        <div class="number">
            <div class="number_left">确认密码</div>
            <div class="number_right">
                <input name="password2" type="password" class="frame" id="password2" value="长度6-20"
                       onclick="if(this.value=='长度6-20'){ this.value='' }"
                       onblur="if(this.value==''){ this.value='长度6-20' }"/>
            </div>
        </div>
        <div class="tips2">性别选择后不可修改</div>


        <div class="sex">
            <a href="javascript:;" class="man_current" onclick="change_gender(1);" id="male">男</a>
            <a href="javascript:;" class="woman" onclick="change_gender(2);" id="female">女</a>
            <input name="gender" id="gender" value="1" type="hidden"/>
        </div>
        <div class="tips2"></div>

        <div class="xy"><input name="checkbox" type="checkbox" id="checkbox" checked="checked"/>我已阅读并同意秋千的<a
                    href="/Public/protocol" target="_blank" class="red">《用户协议》</a></div>

        <div class="sign"><a href="#" class="member_sign_btn">立即注册</a></div>

        <div class="xy">已有秋千账号？<a href="/public/login" class="red">立即登录</a></div>
    </div>
</form>



{include 'footer2.tpl'}
<div class="clear"></div>

<!--网站尾部-->

</body>
</html>
