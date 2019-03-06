:foreach i in=[/ip dns cache all find where (name~"ok.ru" ||  name~"odnoklassniki.ru" || name~"vk.com" || name~"mail.ru" || name~"yandex.ru" || name ~"mts.ru" || name ~"vkontakte.ru") && (type="A") ] do={
     :local tmpAddress [/ip dns cache get $i address];
delay delay-time=10ms
#prevent script from using all cpu time
     :if ( [/ip firewall address-list find where address=$tmpAddress] = "") do={         
     :local cacheName [/ip dns cache get $i name] ;
#:log info ("added entry: $cacheName  $tmpAddress");
     /ip firewall address-list add address=$tmpAddress list=unlocked comment=$cacheName;
 }
}