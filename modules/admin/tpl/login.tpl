<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=2.0" />
    <title>秋千后台</title>
    <meta name="msapplication-TileColor" content="#5bc0de" />
    <meta name="msapplication-TileImage" content="admin/img/metis-tile.png" />

    <!-- Bootstrap -->
    <link rel="stylesheet" href="/admin/css/bootstrap.min.css">
    <link rel="stylesheet" href="/admin/css/animate.min.css">

    <!-- Metis core stylesheet -->
    <link rel="stylesheet" href="/admin/css/main.min.css">
</head>
<body class="login">
<div class="form-signin">
    <div class="text-center">
        <p class="text-muted text-center" style="font-size: 24px">
            秋千管理后台
        </p>
    </div>
    <hr>
    <div class="tab-content">
        <div id="login" class="tab-pane active">
            <form class="form-signin" role="form" action="/admin/auth/login" method="post" id="form-login">

                <input name="username" type="text" placeholder="Username" class="form-control top">
                <input name="password" type="password" placeholder="Password" class="form-control bottom">
                <div class="checkbox" style="display: none;">
                    <label>
                        <input type="checkbox"> Remember Me
                    </label>
                </div>
                <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
            </form>
        </div>
    </div>
    <hr>
</div>

<!--jQuery -->
<script src="/admin/js/jquery.min.js"></script>

<!--Bootstrap -->
<script src="/admin/js/bootstrap.min.js"></script>
<script type="text/javascript">
    $(function () {
        $('#form-login').submit(function () {

            $('#form-login').ajaxSubmit({
                        dataType: 'json',
                        data: { in_ajax: 1 },
                        success: function (retData) {
                            $('#result-count').html(retData.count);
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
</body>
</html>