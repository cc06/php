<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <title>秋千－登录</title>
    <link href="/css/www/css.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="/js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="/js/jquery.form.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.member_sign_btn').click(function () {
                var username = $('#username').val();
                if (!username || username == '秋千账号／手机号') {
                    alert('用户名不能为空');
                    $('#username').val('');
                    $('#username').focus();
                    return false;
                }

                var userpwd = $('#password').val();
                if (!userpwd || userpwd == '输入密码') {
                    alert('用户密码不能为空');
                    $('#password').val('');
                    $('#password').focus();
                    return false;
                }

                $('#myForm').ajaxSubmit({
                            dataType: 'json',
                            data: { in_ajax: 1 },
                            success: function (retData) {
                                if (retData.result == 'success') {
                                    alert('登录成功')
                                    location = '/';
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

    </script>
</head>

<body>
<!--网站头部-->

<div class="login_top"><a href="/"><img src="/images/www/images/logo2.jpg" width="95" height="87"/></a></div>
<div class="login_top_text">登录秋千</div>
<form action="/public/login" id="myForm" method="post">
    <div class="login_main">

        <div class="number">
            <div class="number_left">秋千账号</div>
            <div class="number_right">
                <input name="username" type="text" class="frame" id="username" value="秋千账号／手机号"
                       onclick="if(this.value=='秋千账号／手机号'){ this.value='' }"
                       onblur="if(this.value==''){ this.value='秋千账号／手机号' }"/>
            </div>
        </div>
        <div class="tips"></div>


        <div class="number">
            <div class="number_left">登录密码</div>
            <div class="number_right">
                <input name="password" type="password" class="frame" id="password" value="输入密码"
                       onclick="if(this.value=='输入密码'){ this.value='' }"
                       onblur="if(this.value==''){ this.value='输入密码' }"/>
            </div>
        </div>
        <div class="tips"></div>
        <div class="sign"><a href="#" class="member_sign_btn">登录</a></div>
    </div>

</form>

{include 'footer2.tpl'}
<div class="clear"></div>

<!--网站尾部-->

</body>
</html>
