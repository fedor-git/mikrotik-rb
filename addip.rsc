:if ( [/file get [/file find name=ips.txt] size] > 0 ) do={

:local contents [/file get ips.txt contents]
:set contents ($contents . "\n\n")
/file set ips.txt contents=$contents

# Remove exisiting addresses from the current Address list
/ip firewall address-list remove [/ip firewall address-list find list=b_ips]

:global content [/file get [/file find name=ips.txt] contents];
:global contentLen [ :len $content ];
:global lineEnd 0;
:global line "";
:global lastEnd 0;
:do {
    :set lineEnd [:find $content "\n" $lastEnd ] ;
    :set line [:pick $content $lastEnd $lineEnd] ;
    :set lastEnd ( $lineEnd + 1 ) ;
    :local entry [:pick $line 0 $lineEnd ]

     :if ([:len $entry ] > 1 ) do={
	  :do { /ip firewall address-list add list=b_ips address=$entry;} on-error={ };
      }
    } while ($lastEnd != 1)
}