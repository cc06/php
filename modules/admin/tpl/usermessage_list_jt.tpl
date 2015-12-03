{include 'header_jd.tpl'}

<style>

</style>
<script type="text/javascript" src="/js/jquery.cityselect.js?20150615.js"></script>

<link rel="stylesheet" href="/css/skins/square/blue.css"/>

<table class="table" id="show_table" style="font-size: 12px;margin-top: 20px;">

    {foreach from=$user_messages item=item name=foo}
          {if $uid==$item.from}
              <tr class="t_c"  style="vertical-align: middle">
            <td width="100%" style="float: left;"><div style="line-height: 30px; width: 50%;float: left; text-align: left;">{$item.tm}<br>{if $item.content->img neq ""}<img width="100" style="margin: 5px" height="100" src="{$item.content->img}"  class="img-rounded"/>{/if}
                {if $item.content->content neq ""}{$item.content->content}{/if}</div></td>
              </tr>
          {else}
    <tr class="t_c"  style="vertical-align: middle">
              <td  width="100%" style="float: right;"><div style="line-height: 30px; width: 50%; float: right; text-align: right;">{$item.tm}<br>{if $item.content->img neq ""}<img width="100" style="margin: 5px" height="100" src="{$item.content->img}"  class="img-rounded"/>{/if}
                      {if $item.content->content neq ""}{$item.content->content}{/if}</div></td>
    </tr>
          {/if}
    {/foreach}
</table>

{include "pager.tpl"}
{include 'footer.tpl'}
