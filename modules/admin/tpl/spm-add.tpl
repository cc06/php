{include "header.tpl"}

<style>
    #spm_table td{ border-top: 0px solid #ffffff}
</style>

<div class="form-group form-group-sm">
    <button onclick="location='/admin/spm/index';" id="btn-add-goods" class="btn btn-sm" type="button">返回列表
    </button>
</div>

<form method="post" action="?">
    <table class="table" id="spm_table">
        <thead>
        <tr>
            <td style="width: 100px;"></td>
            <td></td>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="text-right">spm</td>
            <td><input class="form-control" type="text" name="spm" value="{$spmData.spm}"/></td>
        </tr>
        <tr>
            <td class="text-right">跳转地址</td>
            <td><input class="form-control" type="text" name="url" value="{$spmData.url}"/></td>
        </tr>
        <tr>
            <td class="text-right">名称</td>
            <td><input class="form-control" type="text" name="spm_name" value="{$spmData.spm_name}"/></td>
        </tr>
        <tr>
            <td class="text-right"></td>
            <td>
                <input type="hidden" name="id" value="{$spmData.id}"/>
                <button type="submit" class="btn">提交</button>
            </td>
        </tr>
        </tbody>
    </table>
</form>


{include "footer.tpl"}