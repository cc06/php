<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */

/**
 * Smarty {for}{/for} block plugin
 *
 * Type:     block function<br>
 * Name:     for<br>
 * Purpose:  循环指定次数的内容
 *
 * @param array
 * <pre>
 * Params:   from: integer (0)
 *           to: integer (0)
 *           step: integer (1)
 * </pre>
 * @param string: contents of the block
 * @param Smarty: clever simulation of a method
 * @return string: string $content : Repeated formatted
 */
function smarty_block_for($params, $content, &$smarty)
{
    if (is_null($content)) {
        return;
    }

    $from = 0;
    $to = 0;
    $step = 1;

    foreach ($params as $_key => $_val) {
        switch ($_key) {
            case 'from':
            case 'to':
            case 'step':
                $$_key = (int)$_val;
                break;

            default:
                $smarty->trigger_error("textformat: unknown attribute '$_key'");
        }
    }

    $_output = '';

    for($_x = $from; $_x <= $to; $_x += $step) {
        $_output .= $content."\n\r";
    }

    return $_output;

}

?>
