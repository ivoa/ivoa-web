---
title: "IVOA NEWSLETTER - November 2010"
date: 2010-11-01T00:01:00+02:00
tags:
- news
---

The International Virtual Observatory Alliance (IVOA) was formed in June 2002
with a mission to facilitate the international coordination and collaboration
necessary for the development and deployment of the tools, systems and
organizational structures necessary to enable the international utilization of
astronomical archives as an integrated and interoperating virtual observatory.
The IVOA now comprises 18 VO programs from Armenia, Australia, Brazil, Canada,
China, Europe, France, Germany, Hungary, India, Italy, Japan, Russia, Spain, the
United Kingdom, and the United States and inter-governmental organizations (ESA
and ESO). Membership is open to other national and international programs
according to the IVOA Guidelines for Participation. You can read more about the
IVOA and what we do at <http://www.ivoa.net/pub/info/>.

### What is the VO?

The Virtual Observatory (VO) aims to provide a research environment that will
open up new possibilities for scientific research based on data discovery,
efficient data access, and interoperability. The vision is of global astronomy
archives connected via the VO to form a multiwavelength digital sky that can be
searched, visualized, and analyzed in new and innovative ways. VO projects
worldwide working toward this vision are already providing science capabilities
with new tools and services. This newsletter, aimed at astronomers, highlights
VO tools and technologies for doing astronomy research, recent papers, and
upcoming events.

---

# IVOA news

{{< side-image image="CenA_Xray_Opt_Radio.jpg" >}}

### IVOA Science Priorities

The IVOA recognizes the importance of placing useful VO services and tools in
the hands of astronomers. The mission of the IVOA Committee on Science
Priorities (CSP) is to identify the research needs of the worldwide astronomy
community that can benefit from VO related tools and services, and to assist in
placing such tools and services into the research community. This committee is
responsible for special science sessions at IVOA meetings, for identifying
essential science capabilities that will affect IVOA activities, for ensuring
coordination among IVOA Working Groups and Interest Groups in quickly
establishing standards for such capabilities, and for fostering
cross-communication among the astronomy communities and participating VO
projects of the IVOA. Further details about the CSP and its activities can be
found on the
[IVOA website](https://wiki.ivoa.net/twiki/bin/view/IVOA/IvoaSciencePriorities).
Comments and suggestions about the CSP are most welcome; please contact the
chair of the CSP (Dave De Young), with your thoughts and ideas. Image
credits.[^1]

[^1]: _Centaurus A. ESO/WFI (Optical); MPIfR/ESO/APEX/A.Weiss et al.
      (Submillimetre); NASA/CXC/CfA/R.Kraft et al. (X-ray)_

{{</ side-image >}}

---

# VO applications highlights

{{< side-image image="cdsportal-logo.png" >}}

### CDS Portal


The newly released CDS Portal provides simultaneous access to the CDS services
SIMBAD, Aladin, and VizieR through a unique web interface. Searching by
astronomical source name or position returns integrated results of object
identifiers, images, and catalogues. Results from SIMBAD or VizieR can be saved
in the personal storage space provided, and lists of sky coordinates may be
uploaded as VOTables (as input to queries).

**More information:** <http://cdsportal.u-strasbg.fr/>

**Experimental mobile version:** <http://cdsportal.u-strasbg.fr/mobile>

{{</ side-image >}}

{{< side-image image="sampy-icon-big.png" >}}

### SAMPy: a Python Module for SAMP Messaging

SAMPy is a Python module developed by the PANDORA group of the Italian VO. SAMPy
allows Python scripts to communicate with existing VO applications (i.e. TOPCAT,
Aladin, VOSpec, DS9) on one side, and with Python libraries on the other side.
With SAMPy, images or tables may be viewed with VO tools via the Python console
(or a Python script) and then analysed using existing Python libraries such as
SciPy or NumPy, or other specific astronomical software from the AstroPython or
AstroPy portals.

**More information:** <http://cosmos.iasf-milano.inaf.it/pandora/sampy.html>

{{</ side-image >}}

{{< side-image image="svo.gif" >}}

### VOSA: VO SED Analyzer

VOSA is a tool developed by the Spanish VO designed to determine physical
parameters of astronomical objects through the comparison of observed photometry
gathered from VO services with synthetic photometry obtained from different
collections of theoretical models.

**More information:** <http://svo.cab.inta-csic.es/theory/vosa>

{{</ side-image >}}

{{< side-image image="websampconnector_arch_big.png" thumbnail="websampconnector_arch.png" >}}

### WebSampConnector - Stay tuned in to the VO!

WebSampConnector is a client toolkit that enables web-based astronomy services
to interoperate and communicate with VO applications: no more save and load, or
cut and paste in the VO world! WebSampConnector allows you to broadcast your
favorite VOTable or spectrum into VO applications connected to a SAMP hub. It
makes it possible to send sky coordinates or a set of table rows from VO
software directly into a Web page.
[Try the demo](http://vo.imcce.fr/webservices/wsc/?demo). WebSampConnector is
open source software which has been designed and developed by the
[VO-Paris team](http://vo.obspm.fr/) and the
[SAI OCL developers team](http://ocl.sai.msu.ru/). WebSampConnector is fully
functional with Firefox and Internet Explorer on Linux and Windows platforms.  

**More information:** <http://vo.imcce.fr/webservices/wsc>

{{</ side-image >}}

{{< side-image image="aladin.png" thumbnail="aladin_small.png" >}}

### Aladin 7 Goes "All Sky"

Aladin version 7 is a major new release featuring "All Sky" capabilities for
zooming and panning through sky surveys, catalogues, and  density maps; with
support for HEALPix FITS maps such as PLANCK results. New display options are
available for polarisation images and for scatter plots, along with new
interface configuration options, and
[tutorials](http://aladin.u-strasbg.fr/java/Demo/AladinDemo.gml). In order to
facilitate the various VO collaborations, Aladin 7 is distributed with its java
sources under a GPL 3 licence.

**More information:** <http://aladin.u-strasbg.fr/aladin.gml>

{{</ side-image >}}

---

# Some recent papers about VO-enabled science

### Featured Paper

[Revisiting the Scale Length-μ0 Plane and the Freeman Law in the Local Universe](http://adsabs.harvard.edu/abs/2010arXiv1009.2692F), K. Fathi, ApJ, 722, 120 (2010)

This paper explores the Freeman Law for an unprecedented large sample of 30000
disk galaxies, selected and retrieved using VO technologies. Up to now, all
observational statements related to the Freeman Law were based on a few tens of
galaxies. The present study is the first based on a sample large enough to yield
a statistically conclusive result out to z=0.3. This robust result is a leap
forward in establishing the Freeman Law, and provides a test bed for numerical
simulations for galaxy formation and evolution, challenging theoretical galaxy
formation models to explain it. The confirmation of the Freeman Law led to a
press release that was picked up by more than 20 news agencies world-wide in 10
different languages. This paper is a sequel to a first paper calculating the
scale length of the same 30000 galaxies, a result of the first EuroVO-AIDA
Research Initiative [Fathi et al., MNRAS, 406, 1595, (2010)].

### Refereed Publications

* [Virtual Observatory based identification of AX J194939+2631 as a new cataclysmic variable](http://adsabs.harvard.edu/abs/2010arXiv1010.3440Z), Zolotukhin I., Chilingarian I., A&A, in press
* [Sample of LMXBs in the Galactic bulge. I. Optical and near-infrared constraints from the Virtual Observatory](http://adsabs.harvard.edu/abs/2010arXiv1009.2454Z), Zolotukhin I., Revnivtsev M., MNRAS, in press
* [Identification of blue high proper motion objects in Tycho-2 and 2MASS catalogues using Virtual Observatory tools](http://adsabs.harvard.edu/abs/2010arXiv1009.3466J), Jimenez-Esteban F.M., Caballero J.A., Solano E., A&A, in press
* [The international outer planets watch atmospheres node database of giant-planet images](http://adsabs.harvard.edu/abs/2010P%26SS...58.1152H), Hueso R., Legarreta J., Perez-Hoyos S., Rojas J.F., Sanchez-Lavega A., Morgado A., 2010, P&SS, 58, 1152
* [The GalMer database: Galaxy Mergers in the Virtual Observatory](http://adsabs.harvard.edu/abs/2010arXiv1003.3243C), Chilingarian I., Di Matteo P., Combes F., Melchior A.-L., Semelin B., 2010. A&A, 518, 61 +
* [POLLUX: a database of synthetic stellar spectra](http://adsabs.harvard.edu/abs/2010A%26A...516A..13P), Palacios A., Gebran M., Josselin E., Martins F., Plez B., Belmas M., Lebre A., 2010, A&A, 516, 13
* [Scalelength of disk galaxies](http://adsabs.harvard.edu/abs/2010MNRAS.406.1595F), Fathi K., Allen M., Boch Th., Hatziminaoglou E., Peletier R., 2010, MNRAS, 406, 1595
* [SDSSJ150634.27+013331.6: the second compact elliptical galaxy in the NGC5846 group](http://adsabs.harvard.edu/abs/2010arXiv1003.1663C), Chilingarian I & Bergond G., 2010, MNRAS Letters, 405, L11
* [The SPECFIND V2.0 catalogue of radio cross-identifications and spectra. SPECFIND meets the Virtual Observatory](http://adsabs.harvard.edu/abs/2010A%26A...511A..53V), Vollmer et al., 2010, A&A, 511, 53
* [Data Mining and Machine Learning in Astronomy](http://adsabs.harvard.edu/abs/2009arXiv0906.2173B), Ball M., Brunner R.J., 2010, IJMPD, 19, 1049

### More Ways to Find VO-related Publications

* [All ADS links](http://adsabs.harvard.edu/cgi-bin/nph-abs_connect?db_key=AST&db_key=PRE&qform=AST&arxiv_sel=astro-ph&arxiv_sel=cond-mat&arxiv_sel=cs&arxiv_sel=gr-qc&arxiv_sel=hep-ex&arxiv_sel=hep-lat&arxiv_sel=hep-ph&arxiv_sel=hep-th&arxiv_sel=math&arxiv_sel=math-ph&arxiv_sel=nlin&arxiv_sel=nucl-ex&arxiv_sel=nucl-th&arxiv_sel=physics&arxiv_sel=quant-ph&arxiv_sel=q-bio&sim_query=YES&ned_query=YES&aut_logic=OR&obj_logic=OR&author=&object=&start_mon=&start_year=&end_mon=&end_year=&ttl_logic=OR&title=&txt_logic=OR&text=%22virtual+observatory%22&nr_to_return=200&start_nr=1&jou_pick=ALL&ref_stems=&data_and=ALL&group_and=ALL&start_entry_day=&start_entry_mon=&start_entry_year=&end_entry_day=&end_entry_mon=&end_entry_year=&min_score=&sort=SCORE&data_type=SHORT&aut_syn=YES&ttl_syn=YES&txt_syn=YES&aut_wt=1.0&obj_wt=1.0&ttl_wt=0.3&txt_wt=3.0&aut_wgt=YES&obj_wgt=YES&ttl_wgt=YES&txt_wgt=YES&ttl_sco=YES&txt_sco=YES&version=1) mentioning the "virtual observatory" in the abstract
* [All refereed publications](http://adsabs.harvard.edu/cgi-bin/nph-abs_connect?db_key=AST&qform=AST&arxiv_sel=astro-ph&arxiv_sel=cond-mat&arxiv_sel=cs&arxiv_sel=gr-qc&arxiv_sel=hep-ex&arxiv_sel=hep-lat&arxiv_sel=hep-ph&arxiv_sel=hep-th&arxiv_sel=math&arxiv_sel=math-ph&arxiv_sel=nlin&arxiv_sel=nucl-ex&arxiv_sel=nucl-th&arxiv_sel=physics&arxiv_sel=quant-ph&arxiv_sel=q-bio&sim_query=YES&ned_query=YES&aut_logic=OR&obj_logic=OR&author=&object=&start_mon=&start_year=&end_mon=&end_year=&ttl_logic=OR&title=&txt_logic=OR&text=%22virtual+observatory%22&nr_to_return=200&start_nr=1&jou_pick=NO&ref_stems=&data_and=ALL&group_and=ALL&start_entry_day=&start_entry_mon=&start_entry_year=&end_entry_day=&end_entry_mon=&end_entry_year=&min_score=&sort=SCORE&data_type=SHORT&aut_syn=YES&ttl_syn=YES&txt_syn=YES&aut_wt=1.0&obj_wt=1.0&ttl_wt=0.3&txt_wt=3.0&aut_wgt=YES&obj_wgt=YES&ttl_wgt=YES&txt_wgt=YES&ttl_sco=YES&txt_sco=YES&version=1) mentioning the "virtual observatory" in the abstract

---

# VO calendar

* **December 7-11, 2010** - [IVOA Interoperability Meeting](http://www.ivoa.net/cgi-bin/twiki/bin/view/IVOA/InterOpDec2010)
  
  (Nara, Japan)
  
  The IVOA Interop Meetings are aimed at making significant progress in defining
  standards and sharing best practices in the development of the world wide
  Virtual Observatory initiatives.

* **16-18th February, 2011** - [The International Centre for Radio Astronomy Research Astroinformatics School](http://www.icrar.org/news/astroinformatics)
  
  (Perth, Western Australia)
  
  This Astroinformatics School for postgraduate students and other interested
  astronomers includes a broad program of lectures and tutorials to serve as an
  introduction to a selection of common tools for enhancing astronomy research.

* **March 2011** - [Euro-VO School](http://www.euro-vo.org/)

  Exact date & location TBD, more information will appear soon on the EuroVO
  website.

* **May 16-20, 2011** - [IVOA Interoperability Meeting](http://www.ivoa.net/cgi-bin/twiki/bin/view/IVOA/IvoaEvents)
  
  (Naples, Italy)
  
  The IVOA Interop Meetings are aimed at making significant progress in defining
  standards and sharing best practices in the development of the world wide
  Virtual Observatory initiatives.

* **September 19-23, 2010** - [IAU Symposium 285: New Horizons in Time Domain Astronomy](http://www.physics.ox.ac.uk/IAUS285)
  
  (Oxford, United Kingdom)
  
  This symposium will will cover all aspects of time-domain astronomy, describe
  the status of relevant data and analysis tools including the VO and explore
  ways to harness technology and collaboration so as to meet newly-identified
  challenges in time-domain astronomical research.

----

**IVOA Newsletter Editors:**

- Evanthia Hatziminaoglou
- Mark G. Allen
- Sarah Emery Bunn
- Thomas. A. McGlynn
- Christopher J. Miller
- Jonathan Tedds

[write to the editors](mailto:ivoa-news-editors@ivoa.net)

[Subscribe to email notifications of the IVOA Newsletter](http://www.eso.org/lists/listinfo/ivoa-news)

[newsletter archives](http://www.ivoa.net/newsletter/archives.html)