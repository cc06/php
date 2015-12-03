{include "header.tpl"}

<div class="form-group form-group-sm">
    <button onclick="location='/admin/spm/add';" id="btn-add-goods" class="btn btn-sm" type="button">增加
    </button>
</div>

<table class="table table-hover table-report">
    <thead>
    <tr>
        <td style="width: 80px;"></td>
        <th style="width: 200px;">渠道号</th>
        <th>跳转URL</th>
        <th>渠道名称</th>
        <th style="width: 200px;">操作</th>
    </tr>
    </thead>
    <tbody>
    {foreach from=$spmList item=item}
        <tr>
            <td>
                <a spm="{$item.spm}" class="btn-copy-spm-link" href="">生成链接</a>
            </td>
            <td>{$item.spm}</td>
            <td>{$item.url}</td>
            <td>{$item.spm_name}</td>
            <td>
                <a href="/admin/spm/add?id={$item.id}">修改</a>
                <a onclick="return confirm('是否真的删除此渠道？');" href="/admin/spm/delete?id={$item.id}">删除</a>
            </td>
        </tr>
    {/foreach}
    </tbody>
</table>

{include "pager.tpl"}


<script type="text/javascript">
    var init_spam_html = "";
    var spm="";

    $(function () {
        $("#gen-box-init").hide();
        $('.btn-copy-spm-link').click(function () {
            spm = $(this).attr('spm');
            $("#gen-box-init").html("http://www.51caijia.com/spm-"+spm);
            init_spam_html = $('#gen-box-init').html();

            F.showDialog(init_spam_html);

            return false;
        });
    });

    function gen_spm_link() {
        var link = $('#input-link').val();

        if (!/^http:/.test(link)) {
            alert('请以 http 开头！');
            return false;
        }

        if (/\?/.test(link)) {
            link += "&spm="+ spm;
        } else {
            link += "?spm=" + spm;
        }

        $("#gen_input_link").val(link);
    }
</script>


<div id="gen-box-init">

</div>

{include "footer.tpl"}