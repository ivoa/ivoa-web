---
title: "VO Applications"
draft: false
tags:
- applications
---

In this section, scientists can find available VO-compatible applications for their immediate use to do science. The level of maturity of the applications depends on a high degree on the level of maturity of the corresponding IVOA protocols and standards.. As a consequence of the flexibility of the standards, several of the applications might overlap in functionality. **The IVOA does not manage or guarantee these services/tools.**
{{<my-table>}}
| Applications | Publisher | Short Description |
| --- | --- | --- |
| [Aladin](http://aladin.u-strasbg.fr/aladin.gml) | CDS | Aladin is an interactive sky atlas allowing the user to visualize digitized astronomical images or full surveys, superimpose entries from astronomical catalogues or databases, and interactively access related data and information from the Simbad database, the VizieR service and other archives for all known astronomical objects in the field. |
| [APERICubes](https://voparis-apericubes.obspm.fr/) | VOFrance | APERICubes is a web-based tool to preview spectral cubes and facilitate their exploration with existing spectrum analysis programs. It is part of VESPA, an integrated system connecting many data services related to Planetary Sciences and Heliophysics. After being prepared on the server, the cube image planes are browsable through JS9, and the user has access to various plugins for image analysis. When a pixel or a region of interest is selected, the corresponding (average) spectrum, computed by a servlet in real time, is plotted. Thanks to the VO SAMP protocol, the generated spectra can be sent to dedicated clients such as CASSIS to be analyzed and compared. |
| [Astroquery](https://astroquery.readthedocs.io/en/latest/) | | Astroquery is a set of tools for querying astronomical web forms and databases. |
| [CASSIS](http://cassis.irap.omp.eu) | VOGSO | Cassis is a Web or standalone client for spectrum support of multiple spectrum formats. It uses line list databases for line identification from VAMDC, use SSA, EPN-TAP,  SAMP. Cassis has also an Aladin Plugin to handle data from Lofar, Alma, XMM and, in preparation, SKA.|
| [CDS Xmatch Service](http://cdsxmatch.u-strasbg.fr/xmatch) | CDS | A Crossmatch Service |
| [Filter Profile Service](http://svo2.cab.inta-csic.es/theory/fps/) | SVO | Filter Profile Service is a repository of Filter information for the VO |
| [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) | |  |
| [Montage](http://montage.ipac.caltech.edu/docs/index.html) | IRSA | Astronomical Image mosaic engine |
| [PyVO](https://pyvo.readthedocs.io/en/latest/) | | PyVO is a package providing access to remote data and services of the Virtual observatory (VO) using Python. |
| [SkyView](http://skyview.gsfc.nasa.gov/) | NASA/HEASARC | A Virtual Observatory on the Net application for generating images of any part of the sky at wavelengths in all regimes from Radio to Gamma-Ray. |
| [SPLAT](http://star-www.dur.ac.uk/%7Epdraper/splat/splat-vo/) | GAVO | SPLAT is a graphical tool for displaying, comparing, modifying and analysing astronomical spectra stored in several file formats. Spectra can be read from local files or retrieved through VO protocols. |
| [SVO Discovery Tool](http://sdc.cab.inta-csic.es/SVODiscoveryTool) | SVO | A Spanish VO (SVO) service to look for images, spectra, physical parameters of photometry in the VO. |
| [TAPHandle](http://saada.u-strasbg.fr/taphandle/) | GAVO | Search your TAP service and explore database content |
| [TESELA](http://sdc.cab.inta-csic.es/tesela/index.jsp) | SVO | A service developed to provide access to a catalogue of blank regions, based on the application of the Delaunay triangulation of the sky. The present implementation of TESELA uses as source for the star coordinates the Tycho-2 Catalogue (Hog et al. 2000), or the USNO_B Catalgue (Moret et al. 2003). |
| [TOPCAT](http://www.star.bris.ac.uk/%7Embt/topcat/) | | TOPCAT is an interactive graphical viewer and editor for tabular data. Its aim is to provide most of the facilities that astronomers need for analysis and manipulation of source catalogues and other tables, though it can be used for non-astronomical data as well. It understands a number of different astronomically important formats (including FITS, VOTable and CDF) and more formats can be added. It is especially good at interactive exploration of large (multi-million row, lots of columns) tables. |
| [STILTS](http://www.star.bris.ac.uk/%7Embt/stilts/) | | The STIL Tool Set is a set of command-line tools based on STIL, the Starlink Tables Infrastructure Library. It deals with the processing of tabular data; the package has been designed for, but is not restricted to, astronomical tables such as source catalogues. Some of the tools are generic and can work with multiple formats (including FITS, VOTable, CDF, ECSV, CSV, PDS4, Parquet, MRT, Feather, GBIN, SQL and ASCII), and others are specific to the VOTable format. STILTS is the command-line counterpart of the GUI table analysis tool TOPCAT. The package is robust, fully documented, and designed for efficiency, especially with very large datasets. |
| [VESPA](http://vespa.obspm.fr) | | VESPA (Virtual European Solar and Planetary Access) is a web-based data search interface for Planetary Science and Heliophysics data. VESPA is a project of the Europlanet-2024 programme funded by European Community. |
| [VOSA](http://svo2.cab.inta-csic.es/theory/vosa/) | | VO SED Analyzer |
{{</my-table>}}

{{<my-table>}}
| Functionality |
| --- |
| **Search for Images:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml), [Datascope](http://heasarc.gsfc.nasa.gov/cgi-bin/vo/datascope/init.pl), [SkyView](http://skyview.gsfc.nasa.gov/), [SVO Discovery Tool](http://sdc.cab.inta-csic.es/SVODiscoveryTool), [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) |
| **Search for Spectra:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml), [CASSIS](http://cassis.irap.omp.eu), [Datascope](http://heasarc.gsfc.nasa.gov/cgi-bin/vo/datascope/init.pl), [SPLAT](http://star-www.dur.ac.uk/%7Epdraper/splat/splat-vo/), [SVO Discovery Tool](http://sdc.cab.inta-csic.es/SVODiscoveryTool), [VOServices](http://voservices.net/spectrum/) |
| **Search for Catalogues:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml), [Datascope](http://heasarc.gsfc.nasa.gov/cgi-bin/vo/datascope/init.pl), [SVO Discovery Tool](http://sdc.cab.inta-csic.es/SVODiscoveryTool), [TOPCAT](http://www.star.bris.ac.uk/~mbt/topcat/), [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) |
| **Search for Time Series Data:** [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) |
| **Image visualisation:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml), [SkyView](http://skyview.gsfc.nasa.gov/), [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) |
| **Spectra visualisation:** [CASSIS](http://cassis.irap.omp.eu), [SPLAT](http://star-www.dur.ac.uk/%7Epdraper/splat/splat-vo/), [VOServices](http://voservices.net/spectrum/), [VOSpec](http://www.sciops.esa.int/index.php?project=SAT&page=vospec) |
| **Catalogues visualisation:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml), [TOPCAT](http://www.star.bris.ac.uk/%7Embt/topcat/), [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) |
| **Cross-correlation:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml), [STILTs](http://www.star.bris.ac.uk/%7Embt/stilts/),[TOPCAT](http://www.star.bris.ac.uk/%7Embt/topcat/), [CDS Xmatch Service](http://cdsxmatch.u-strasbg.fr/xmatch) |
| **Scatter, 3D plots and histograms:** [TOPCAT](http://www.star.bris.ac.uk/%7Embt/topcat/), [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) |
| **Statistics:** [AstroStat](http://voi.iucaa.in/voi/AstroStat.html) |
| **Footprint Service:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml), [VOServices](http://voservices.net/footprint/) |
| **Table format conversion:** [TOPCAT](http://www.star.bris.ac.uk/%7Embt/topcat/), [STILTS](http://www.star.bris.ac.uk/%7Embt/stilts/) |
| **Filter curves:** [VOServices](http://voservices.net/filter/), [Filter Profile Service](http://svo2.cab.inta-csic.es/theory/fps/) |
| **SED building:** [VOSA](http://svo2.cab.inta-csic.es/theory/vosa/), [VOSpec](http://www.sciops.esa.int/index.php?project=SAT&page=vospec) |
| **Fixing WCS:** [Aladin](http://aladin.u-strasbg.fr/aladin.gml) |
| **Query Databases** [TOPCAT](http://www.star.bris.ac.uk/%7Embt/topcat/), [TAPHandle](http://saada.u-strasbg.fr/taphandle/), [IPAC Firefly](https://github.com/Caltech-IPAC/firefly) |
{{</my-table>}}
{{<my-table>}}
| VO-compliant Tools & Services |
| --- |
| [DS9](http://hea-www.harvard.edu/RD/ds9/): Image visualisation |
| [VirGO: Search for Images and Spectra](http://archive.eso.org/cms/tools-documentation/visual-archive-browser.html) |
| [World Wide Telescope](http://www.worldwidetelescope.org/) |
| [Gaia](http://star-www.dur.ac.uk/~pdraper/gaia/gaia.html) - Graphical Astronomy and Image Analysis |
| [SIMBAD](http://simbad.u-strasbg.fr/simbad/) |
| [TESELA](http://sdc.cab.inta-csic.es/tesela/index.jsp) |
| [VizieR](http://vizier.u-strasbg.fr/viz-bin/VizieR) |
|     |
| Browse the Registries |
| [WIRR - Web Interface to the Relational Registry](http://dc.zah.uni-heidelberg.de/wirr/q/ui/fixed) |
| [RSS Feed of New & Updated Services in the VO](http://dc.zah.uni-heidelberg.de/registryrss/q/rss/info) |
| [AppLauncher](http://www.jmmc.fr/applauncher) |
| [EURO-VO Registry](https://registry.euro-vo.org/evor/) |
{{</my-table>}}

_If you are interested in having your own project linked here, please [contact us](mailto:ivoadoc@ivoa.net)._

### IVOA Applications Working Group

Also visit the [Applications Working Group](http://wiki.ivoa.net/twiki/bin/view/IVOA/IvoaApplications) pages on the [IVOA twiki](https://wiki.ivoa.net/twiki/bin/view/IVOA), where you can find more [VO applications](http://wiki.ivoa.net/twiki/bin/view/IVOA/IvoaApplications#Links) in different levels of maturity.
