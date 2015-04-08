<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" >
  
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
  <head>
    <meta name="keywords" content="steganography, Steghide, digital images, digital audio, BMP, Bitmap, JPG, Jpeg, AU, WAV, Wave, text editor, encryption" />
    <meta name="description" content="SteGUI homepage" />
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <link type="text/css" rel="stylesheet" title="SteGUI style" href="styles/style.css" />
    <title>SteGUI - Download</title>
  </head>
  
<body>

<h2>Download</h2>

<p class="footer"></p>

<h3><a id="req">System requirements</a></h3>

<p>
This front-end was developed for GNU/Linux systems. In order to run it you 
must have Steghide installed; for audio support it's necessary to have ALSA 
configured and a 2.6 kernel, while for JPEG header interpretation the Libjpeg 
library is used. Since the interface is based on FLTK, you must also have the 
FLTK runtime libraries version 1.1.6 or later installed.
</p>

<p>
To compile from source you will need development headers for the libraries 
mentioned above; the PStreams header file is distributed along with the SteGUI 
source. All that is needed can be found on the corresponding web sites, 
following the links below, or among software packages commonly provided by the 
main Linux distributions.
</p>

<p>
Finally, Steghide depends on the MHash, MCrypt and Zlib libraries to be able to 
use all of its features, in addition to Libjpeg.
</p>

<h3><a id="pkg">Downloadable packages</a></h3>

<p>
SteGUI source code packages are available for download from the 
<a href="http://sourceforge.net/projects/stegui/">SteGUI project page</a> on 
SourceForge. Currently no binary packages are provided. The latest stable 
version of SteGUI is version 0.0.1.
</p>

<p>
Alternatively, you can access the public CVS repository with the commands:
</p>

<div><code>
cvs -d:pserver:anonymous@stegui.cvs.sourceforge.net:/cvsroot/stegui login
</code></div>

<div><code>
cvs -z3 -d:pserver:anonymous@stegui.cvs.sourceforge.net:/cvsroot/stegui co -P stegui
</code></div>

<p>
or browse the 
<a href="http://cvs.sourceforge.net/viewcvs.py/stegui">web-based CVS</a> 
repository, also useful if you don't know what names the modules have.
</p>

<h3><a id="link">Links</a></h3>

<h4><a id="guilib">Libraries used by SteGUI</a></h4>

<p>
Here are links to the web sites that host the libraries used by SteGUI:
</p>

<ul>
	<li><a href="http://www.fltk.org">FLTK toolkit</a></li>
	<li><a href="http://pstreams.sf.net">PStreams</a></li>
	<li><a href="http://www.alsa-project.org">ALSA Project</a></li>
	<li><a href="http://www.ijg.org/">Libjpeg</a></li>
</ul>

<h4><a id="libsteg">Libraries used by Steghide</a></h4>

<p>
Here are links to the web sites that host the libraries used by Steghide:
</p>

<ul>
	<li><a href="http://mhash.sf.net">MHash</a></li>
	<li><a href="http://mcrypt.sf.net">MCrypt</a></li>
	<li><a href="http://www.zlib.net">Zlib</a></li>
	<li><a href="http://www.ijg.org/">Libjpeg</a></li>
</ul>

<h4><a id="steg">Steganography</a></h4>

<p>
In addition, here are some useful references on Steganography, for the most 
interested users:
</p>

<ul>
	<li><a href="http://www.sans.org/rr/papers/index.php?id=677">
	A Detailed Look at Steganographic Techniques and their Use</a>
	- Bret Dunbar, <em>Sans InfoSec Reading Room</em>, Jan 2002</li>
	<li><a href="http://www.sans.org/rr/papers/index.php?id=678">
	A Discussion of Covert Channels and Steganography</a>
	- Mark Owens, <em>Sans InfoSec Reading Room</em>, Mar 2002</li>
	<li><a href="http://www.forensics.nl/steganography">
	Computer forensics, Cybercrime and Steganography resources</a></li>
	<li><a href="http://niels.xtdnet.nl/stego/usenet.php">
	Scanning USENET for Steganography</a> - Niels Provos, 2001</li>
	<li><a href="http://gray-world.net/papers/ahsan02.pdf">
	Covert Channel Analysis and Data Hiding in TCP/IP</a>
	- Kamran Ahsan, <em>Thesis</em>, 2002</li>
	<li><a href="http://en.wikipedia.org/wiki/Steganography">Steganography on Wikipedia</a></li>
	<li><a href="http://www.simonsingh.net/The_Code_Book.html">
	The Code Book</a> - Simon Singh, Anchor Books, 1999</li>
</ul>

<h4><a id="soft">Software</a></h4>

<p>
Finally, here are some links to Steganography utilities mentioned in these 
pages:
</p>

<ul>
	<li><a href="http://linux01.gwdg.de/~alatham/stego.html">JPHide and JSteg</a></li>
	<li><a href="http://www.outguess.org">Outguess</a></li>
	<li><a href="http://steghide.sf.net">Steghide</a></li>
	<li><a href="http://niels.xtdnet.nl/stego/faq.html">Stegdetect and Stegbreak</a></li>
</ul>
	
<p class="footer">
Next - <a href="frontend.html">Previous</a> - <a href="index.html">Home</a>
</p>

<div>
<h5><em>&copy; 2005-2008 Nicola Cocchiaro</em></h5>
</div>

</body>
</html>
