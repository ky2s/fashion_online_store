<?php
if (!function_exists('cleanString')) {
    function cleanString($text) {
        $utf8 = array(
            '/[áàâãªä]/u'   =>   'a',
            '/[ÁÀÂÃÄ]/u'    =>   'A',
            '/[ÍÌÎÏ]/u'     =>   'I',
            '/[íìîï]/u'     =>   'i',
            '/[éèêë]/u'     =>   'e',
            '/[ÉÈÊË]/u'     =>   'E',
            '/[óòôõºö]/u'   =>   'o',
            '/[ÓÒÔÕÖ]/u'    =>   'O',
            '/[úùûü]/u'     =>   'u',
            '/[ÚÙÛÜ]/u'     =>   'U',
            '/ç/'           =>   'c',
            '/Ç/'           =>   'C',
            '/ñ/'           =>   'n',
            '/Ñ/'           =>   'N',
            '/–/'           =>   '-', // UTF-8 hyphen to "normal" hyphen
            '/[’‘‹›‚]/u'    =>   ' ', // Literally a single quote
            '/[“”«»„]/u'    =>   ' ', // Double quote
            '/ /'           =>   ' ', // nonbreaking space (equiv. to 0x160)
        );
        return preg_replace(array_keys($utf8), array_values($utf8), $text);
    }
}

if (!function_exists('hyphenize')) {
    function hyphenize($string) {
        return 
        strtolower(
              preg_replace(
                array('#[\\s-]+#', '#[^A-Za-z0-9\. -]+#'),
                array('-', ''),
                 cleanString(
                  urldecode($string)
                 )
            )
        )
        ;
    }
}

if (!function_exists('format_me')) {
    function format_me($number) {
        return number_format( $number , 0 , '.' , ',' );
    }
}

if (!function_exists('hideWithStar')) {
    function hideWithStar($str) {      
      $strLen = strlen($str);
      $twoDigitFront = $str[0].$str[1];
      $twoDigitBack = $str[$strLen-2].$str[$strLen-1];      
      return $twoDigitFront.str_repeat('*', ($strLen-4)).$twoDigitBack;
    }
 }

if (!function_exists('pre')) {
    function pre($array) {      
      echo "<pre>"; print_r($array); exit;
    }
 }


