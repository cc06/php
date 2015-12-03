{if $page_info.total}
    <ul class="pagination">
        <li><span>共 {$page_info.total} 条</span></li>
        {if $page_info.current eq 1}
            <li class="disabled"><span>&laquo;</span></li>
        {else}
            <li><a href="{$page_info.url_pre}{$page_info.prev}">&laquo;</a></li>
        {/if}


        {*<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>*}
        {for $current_page=$page_info.start; $current_page <= $page_info.end; $current_page++}
            {if $page_info.current eq $current_page}
                <li class="active"><span>{$current_page}<span class="sr-only">(current)</span></span></li>
            {else}
                <li><a href="{$page_info.url_pre}{$current_page}">{$current_page}</a></li>
            {/if}
        {/for}

        {if $page_info.end lt $page_info.last}
            <li class="active"><span>...<span class="sr-only">(current)</span></span></li>
        {/if}

        {if $page_info.current eq $page_info.last}
            <li class="disabled"><span>&raquo;</span></li>
        {else}
            <li><a href="{$page_info.url_pre}{$page_info.next}">&raquo;</a></li>
        {/if}
    </ul>
{/if}


{*分页*}
{*<div class="page-panel cl" style="margin-top: 20px;">*}
{*<div class="page-ctrl">*}
{*<span class="floatLeft">共 {$page_info.total} 条</span>*}
{*<span class="floatLeft">显示</span>*}
{*<dl>*}
{*<dt onclick="AjaxSelectBoxPage(this)">20</dt>*}
{*<dd style="display:none">*}
{*<ul>*}
{*<li value="5">5</li>*}
{*<li value="10">10</li>*}
{*<li value="15">15</li>*}
{*<li value="20">20</li>*}
{*<li value="25">25</li>*}
{*<li value="30">30</li>*}
{*</ul>*}
{*<input type="hidden" value="20" name="pageCount" id="pageCount">*}
{*</dd>*}
{*</dl>*}
{*</div>*}
{*<div class="page">*}
{*<a href="{$page_info.url_pre}{$page_info.first}" class="first"></a>*}
{*<a href="{$page_info.url_pre}{$page_info.prev}" class="prev"></a>*}

{*{for $current_page=$page_info.start; $current_page <= $page_info.end; $current_page++}*}
{*<a href="{$page_info.url_pre}{$current_page}" class="{if $page_info.current eq $current_page}current{/if}">{$current_page}</a>*}
{*{/for}*}

{*<a href="{$page_info.url_pre}{$page_info.next}" class="next"></a>*}
{*<a href="{$page_info.url_pre}{$page_info.last}" class="last"></a>*}
{*</div>*}
{*</div>*}