<b> Sabyon stock kernel is quite fine for most users </b>

<p> However a Spike edtion could be needed, secoundly 
<blockquote>I'm sick of mylatop being in a fucked up state over 
ISCSI </blockquote> YE ELDEN sabayon 3.9.x is my only unaffected kernel. 
the package that applies the kernel modeule is dated hsnt been updated to build km's
<cite>sys-block/iscsitarget 3.6 linux last. </cite>, 
and every update sabayon makes breaks the kernel at boot, and infinite loop becuase systemD will force the service to loand and not give up. https://bugs.gentoo.org/show_bug.cgi?id=507288
secoundly SyatemD dosent have a delayed start, ISCSI i wound not care if it was a background service load iscsi-km + services  if it fails its a trivial issue insted of a bootup blocker. 
https://www.blackhat.com/presentations/bh-usa-05/bh-us-05-Dwivedi-update.pdf
as well ISCSI can be a nasty little RISK vector. 

<p> in time more security patches or sabayon-spike-Tinfoil (ie an especially GRSEC patched) 
and <b> wifi from wireless comapt pentesting. </b> for now i've swiped wireless compat ebuilds form pentoo and version bumped. in time Intergrating them into a mainline sabayon-spike kernel 

I dont claim to be a kernel Foo expert, but least i'll give anything a shot. 
for now works in progress. 
